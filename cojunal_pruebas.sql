# SQL Manager 2010 for MySQL 4.5.0.9
# ---------------------------------------
# Host     : 45.33.14.204
# Port     : 3306
# Database : cojunal_pruebas


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

#
# Structure for the `action` table : 
#

DROP TABLE IF EXISTS `action`;

CREATE TABLE `action` (
  `idAction` int(11) NOT NULL AUTO_INCREMENT,
  `actionName` varchar(155) DEFAULT NULL,
  PRIMARY KEY (`idAction`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

#
# Structure for the `actions_has_effects` table : 
#

DROP TABLE IF EXISTS `actions_has_effects`;

CREATE TABLE `actions_has_effects` (
  `idActionsHasEffects` bigint(20) NOT NULL AUTO_INCREMENT,
  `idAction` int(11) NOT NULL,
  `idEffect` int(11) NOT NULL,
  PRIMARY KEY (`idActionsHasEffects`),
  UNIQUE KEY `unique_action_effect` (`idAction`,`idEffect`) USING BTREE,
  KEY `fk_idEffect_idx` (`idEffect`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

#
# Structure for the `authitem` table : 
#

DROP TABLE IF EXISTS `authitem`;

CREATE TABLE `authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `authassignment` table : 
#

DROP TABLE IF EXISTS `authassignment`;

CREATE TABLE `authassignment` (
  `idAuthAssignment` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  `itemname` varchar(64) NOT NULL,
  PRIMARY KEY (`idAuthAssignment`),
  UNIQUE KEY `userid_UNIQUE` (`userid`),
  KEY `fk_AuthAssignment_AuthItem1` (`itemname`),
  CONSTRAINT `fk_AuthAssignment_AuthItem1` FOREIGN KEY (`itemname`) REFERENCES `authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;

#
# Structure for the `advisers` table : 
#

DROP TABLE IF EXISTS `advisers`;

CREATE TABLE `advisers` (
  `idAdviser` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentAdviser` int(11) NOT NULL DEFAULT '0',
  `name` varchar(155) NOT NULL,
  `email` varchar(55) NOT NULL,
  `passwd` varchar(45) NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `idAuthAssignment` bigint(20) NOT NULL,
  `weeklyGoal` float NOT NULL,
  `monthlyGoal` float NOT NULL,
  `status_idStatus` bigint(20) NOT NULL,
  PRIMARY KEY (`idAdviser`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_advisers_AuthAssignment1` (`idAuthAssignment`),
  KEY `fk_advisers_status1` (`status_idStatus`),
  CONSTRAINT `fk_advisers_AuthAssignment1` FOREIGN KEY (`idAuthAssignment`) REFERENCES `authassignment` (`idAuthAssignment`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

#
# Structure for the `departaments` table : 
#

DROP TABLE IF EXISTS `departaments`;

CREATE TABLE `departaments` (
  `idDepartament` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idDepartament`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

#
# Structure for the `cities` table : 
#

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `idCity` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `idDepartament` bigint(20) NOT NULL,
  PRIMARY KEY (`idCity`),
  KEY `fk_ciudad_departamento1` (`idDepartament`),
  CONSTRAINT `fk_ciudad_departamento1` FOREIGN KEY (`idDepartament`) REFERENCES `departaments` (`idDepartament`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

#
# Structure for the `districts` table : 
#

DROP TABLE IF EXISTS `districts`;

CREATE TABLE `districts` (
  `idDistrict` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `idCity` bigint(20) NOT NULL,
  PRIMARY KEY (`idDistrict`),
  KEY `fk_barrios_ciudades1` (`idCity`),
  CONSTRAINT `fk_barrios_ciudades1` FOREIGN KEY (`idCity`) REFERENCES `cities` (`idCity`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;

#
# Structure for the `campaigns` table : 
#

DROP TABLE IF EXISTS `campaigns`;

CREATE TABLE `campaigns` (
  `idCampaign` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `companyName` varchar(55) NOT NULL,
  `idNumber` varchar(45) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contactName` varchar(45) NOT NULL,
  `contactEmail` varchar(155) NOT NULL,
  `percentageCommission` float DEFAULT '0',
  `interest` float DEFAULT '0',
  `fees` float DEFAULT '0',
  `valueService1` float DEFAULT '0',
  `valueService2` float DEFAULT '0',
  `comments` text,
  `fCreacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `passwd` varchar(45) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `idDistrict` bigint(20) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `phone` varchar(12) DEFAULT '014620116',
  PRIMARY KEY (`idCampaign`),
  KEY `fk_campaigns_advisers1` (`idAdviser`),
  KEY `fk_campaigns_districts1` (`idDistrict`),
  CONSTRAINT `fk_campaigns_advisers1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_campaigns_districts1` FOREIGN KEY (`idDistrict`) REFERENCES `districts` (`idDistrict`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

#
# Structure for the `advisers_campaigns` table : 
#

DROP TABLE IF EXISTS `advisers_campaigns`;

CREATE TABLE `advisers_campaigns` (
  `idAvidsersCampaign` bigint(20) NOT NULL AUTO_INCREMENT,
  `idAdvisers` bigint(20) DEFAULT NULL,
  `idCampaign` bigint(20) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`idAvidsersCampaign`),
  UNIQUE KEY `unique_advisers_campaigns` (`idAdvisers`,`idCampaign`),
  KEY `fk_campaigns` (`idCampaign`),
  CONSTRAINT `fk_advisers` FOREIGN KEY (`idAdvisers`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_campaigns` FOREIGN KEY (`idCampaign`) REFERENCES `campaigns` (`idCampaign`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

#
# Structure for the `effects` table : 
#

DROP TABLE IF EXISTS `effects`;

CREATE TABLE `effects` (
  `idEffect` int(11) NOT NULL AUTO_INCREMENT,
  `effectName` varchar(155) NOT NULL,
  PRIMARY KEY (`idEffect`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

#
# Structure for the `wallets` table : 
#

DROP TABLE IF EXISTS `wallets`;

CREATE TABLE `wallets` (
  `idWallet` bigint(20) NOT NULL AUTO_INCREMENT,
  `idNumber` varchar(45) NOT NULL,
  `capitalValue` double NOT NULL,
  `feeValue` double NOT NULL,
  `interestsValue` double NOT NULL,
  `dAssigment` date NOT NULL,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `legalName` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(55) NOT NULL,
  `idDistrict` bigint(20) NOT NULL,
  `idStatus` bigint(20) NOT NULL DEFAULT '1',
  `product` varchar(155) NOT NULL,
  `idAdviser` bigint(20) NOT NULL DEFAULT '1',
  `currentDebt` double DEFAULT NULL,
  `titleValue` double DEFAULT NULL,
  `validThrough` date NOT NULL,
  `prescription` date NOT NULL DEFAULT '0000-00-00',
  `accountNumber` varchar(55) NOT NULL,
  `negotiation` varchar(255) DEFAULT NULL,
  `vendorEmail` varchar(155) DEFAULT NULL,
  `vendorName` varchar(155) DEFAULT NULL,
  `vendorPhone` varchar(45) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1.- Rojo, 2.- Azul, 3.- Amarillo, 4.- Verde',
  PRIMARY KEY (`idWallet`),
  KEY `fk_carteras_barrios1` (`idDistrict`),
  KEY `fk_carteras_estados1` (`idStatus`),
  KEY `fk_wallets_advisers1` (`idAdviser`),
  CONSTRAINT `fk_carteras_barrios1` FOREIGN KEY (`idDistrict`) REFERENCES `districts` (`idDistrict`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wallets_advisers1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6288 DEFAULT CHARSET=latin1;

CREATE DEFINER = 'root'@'localhost' TRIGGER `prescripcion_deuda` BEFORE INSERT ON `wallets`
  FOR EACH ROW
BEGIN
  SET NEW.prescription = DATE_ADD(NEW.validThrough, INTERVAL 2 YEAR) ;
END;

#
# Structure for the `agendas` table : 
#

DROP TABLE IF EXISTS `agendas`;

CREATE TABLE `agendas` (
  `idAgenda` bigint(20) NOT NULL AUTO_INCREMENT,
  `idAction` int(11) NOT NULL,
  `dAction` date NOT NULL,
  `dCreation` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idWallet` bigint(20) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `idEffect` int(11) NOT NULL,
  `comment` text,
  `timer` varchar(8) NOT NULL DEFAULT '00:10:00',
  PRIMARY KEY (`idAgenda`),
  KEY `fk_agendas_carteras1` (`idWallet`),
  KEY `fk_agendas_asesores1` (`idAdviser`),
  KEY `fkAction_idx` (`idAction`),
  KEY `fk_IdEffect_idx` (`idEffect`),
  CONSTRAINT `fkAction` FOREIGN KEY (`idAction`) REFERENCES `action` (`idAction`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkAdviser` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkWallet` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdEffect` FOREIGN KEY (`idEffect`) REFERENCES `effects` (`idEffect`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=latin1;

#
# Structure for the `assettypes` table : 
#

DROP TABLE IF EXISTS `assettypes`;

CREATE TABLE `assettypes` (
  `idAssetType` int(11) NOT NULL AUTO_INCREMENT,
  `assetTypeName` varchar(155) NOT NULL,
  PRIMARY KEY (`idAssetType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Structure for the `assets` table : 
#

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `idAsset` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idWallet` bigint(20) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `idType` int(11) NOT NULL,
  `assetName` varchar(155) NOT NULL,
  PRIMARY KEY (`idAsset`),
  KEY `fk_bienes_carteras1` (`idWallet`),
  KEY `fk_bienes_asesores1` (`idAdviser`),
  KEY `fk_bienes_tipos1` (`idType`),
  CONSTRAINT `fk_assets_type` FOREIGN KEY (`idType`) REFERENCES `assettypes` (`idAssetType`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bienes_asesores1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bienes_carteras1` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

#
# Structure for the `authitemchild` table : 
#

DROP TABLE IF EXISTS `authitemchild`;

CREATE TABLE `authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  `idAuthItemChild` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAuthItemChild`),
  KEY `fk_AuthItemChild_AuthItem` (`parent`),
  KEY `fk_AuthItemChild_AuthItem1` (`child`),
  CONSTRAINT `fk_AuthItemChild_AuthItem` FOREIGN KEY (`parent`) REFERENCES `authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_AuthItemChild_AuthItem1` FOREIGN KEY (`child`) REFERENCES `authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Structure for the `notificationType` table : 
#

DROP TABLE IF EXISTS `notificationType`;

CREATE TABLE `notificationType` (
  `idNotificationType` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `crerateAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idNotificationType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Structure for the `wallets_by_campaign` table : 
#

DROP TABLE IF EXISTS `wallets_by_campaign`;

CREATE TABLE `wallets_by_campaign` (
  `idWalletByCampaign` bigint(20) NOT NULL AUTO_INCREMENT,
  `IdCampaign` bigint(20) NOT NULL,
  `campaignName` varchar(250) NOT NULL,
  `serviceType` varchar(100) NOT NULL,
  `notificationType` int(11) NOT NULL,
  `fee` float NOT NULL DEFAULT '0',
  `interests` float DEFAULT '0',
  `comisions` float NOT NULL DEFAULT '0',
  `createAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idWalletByCampaign`),
  KEY `IdCampaign` (`IdCampaign`),
  KEY `notificationType` (`notificationType`),
  CONSTRAINT `wallets_by_campaign_ibfk_1` FOREIGN KEY (`IdCampaign`) REFERENCES `campaigns` (`idCampaign`),
  CONSTRAINT `wallets_by_campaign_ibfk_2` FOREIGN KEY (`notificationType`) REFERENCES `notificationType` (`idNotificationType`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=latin1;

CREATE DEFINER = 'root'@'localhost' TRIGGER `crear_estados_default` AFTER INSERT ON `wallets_by_campaign`
  FOR EACH ROW
INSERT INTO campaigns_status (id, idCampaign, modified_at) 
VALUES (NULL, NEW.idWalletByCampaign, CURRENT_TIMESTAMP), (NULL, NEW.idWalletByCampaign, 'JURÍDICO', CURRENT_TIMESTAMP);

#
# Structure for the `campaigns_coordinator` table : 
#

DROP TABLE IF EXISTS `campaigns_coordinator`;

CREATE TABLE `campaigns_coordinator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCampaign` bigint(20) NOT NULL,
  `idCoordinator` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idCampaign` (`idCampaign`,`idCoordinator`) USING BTREE,
  KEY `idCoordinator` (`idCoordinator`),
  CONSTRAINT `campaigns_coordinator_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`),
  CONSTRAINT `campaigns_coordinator_ibfk_2` FOREIGN KEY (`idCoordinator`) REFERENCES `advisers` (`idAdviser`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

#
# Structure for the `campaigns_emails_notifications` table : 
#

DROP TABLE IF EXISTS `campaigns_emails_notifications`;

CREATE TABLE `campaigns_emails_notifications` (
  `idCampaign` bigint(20) NOT NULL,
  `emailNotification` varchar(250) NOT NULL,
  UNIQUE KEY `idCampaign` (`idCampaign`,`emailNotification`),
  CONSTRAINT `campaigns_emails_notifications_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `status` table : 
#

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `idStatus` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `dCreation` date DEFAULT NULL,
  PRIMARY KEY (`idStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

#
# Structure for the `campaigns_status` table : 
#

DROP TABLE IF EXISTS `campaigns_status`;

CREATE TABLE `campaigns_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCampaign` bigint(20) NOT NULL COMMENT 'este es el id de la campaña, no del cliente',
  `idStatus` bigint(20) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni` (`idStatus`,`idCampaign`),
  KEY `idCampaign` (`idCampaign`),
  CONSTRAINT `campaigns_status_ibfk_2` FOREIGN KEY (`idStatus`) REFERENCES `status` (`idStatus`),
  CONSTRAINT `campaigns_status_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_configuracion` table : 
#

DROP TABLE IF EXISTS `cms_configuracion`;

CREATE TABLE `cms_configuracion` (
  `idcmsconfiguracion` int(11) NOT NULL AUTO_INCREMENT,
  `empresa` varchar(255) DEFAULT NULL COMMENT 'name:Empresa',
  `host` varchar(60) NOT NULL COMMENT 'name:host',
  `encryption` varchar(20) DEFAULT NULL COMMENT 'name:Encryption',
  `nombre_correo` varchar(255) NOT NULL COMMENT 'name:Nombre Correo',
  `username` varchar(70) NOT NULL COMMENT 'name:Username',
  `password` varchar(100) NOT NULL COMMENT 'name:password|type:password',
  `apiKey` text NOT NULL,
  `port` varchar(10) NOT NULL COMMENT 'name:Port',
  `plantilla` text NOT NULL COMMENT 'name:plantilla|type:wysiwyg',
  `fecha_actualizacion` datetime NOT NULL COMMENT 'name:Fecha de Actualización',
  `usuario_actualiza` int(11) NOT NULL DEFAULT '1' COMMENT 'Name:Usuario Actualiza',
  `user_restful` varchar(255) DEFAULT NULL,
  `password_restful` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idcmsconfiguracion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_contact` table : 
#

DROP TABLE IF EXISTS `cms_contact`;

CREATE TABLE `cms_contact` (
  `idContact` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla ',
  `address` varchar(255) NOT NULL COMMENT 'Dirección de comunal',
  `nationalPhone` varchar(20) NOT NULL COMMENT 'Teléfono nacional',
  `localPhone` varchar(10) NOT NULL COMMENT 'Teléfono local',
  `email` varchar(45) NOT NULL COMMENT 'Correo electrónico',
  PRIMARY KEY (`idContact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que permite guardar los contactos de comunal	';

#
# Structure for the `cms_coverage` table : 
#

DROP TABLE IF EXISTS `cms_coverage`;

CREATE TABLE `cms_coverage` (
  `idCoverage` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla',
  `googleDirection` varchar(45) NOT NULL COMMENT 'Dirección de google con la geolocalización del negocio',
  PRIMARY KEY (`idCoverage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla donde se guarda la cobertura de Cojunal	';

#
# Structure for the `cms_generic_text` table : 
#

DROP TABLE IF EXISTS `cms_generic_text`;

CREATE TABLE `cms_generic_text` (
  `idGenericText` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla	',
  `text` varchar(255) NOT NULL COMMENT 'Texto con la descripción',
  `image` varchar(255) DEFAULT NULL COMMENT 'Imagen descriptiva puede ser null',
  `subtitle` varchar(255) DEFAULT NULL COMMENT 'Subtitulo de la página en caso de ser necesario',
  PRIMARY KEY (`idGenericText`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla donde se guardan los textos generales del sitio. En esta tabla se encuentra los textos descriptivos de cada página del sitio para poderlos modifica y agregar imágenes en caso de ser necesario\n';

#
# Structure for the `cms_help` table : 
#

DROP TABLE IF EXISTS `cms_help`;

CREATE TABLE `cms_help` (
  `idcmshelp` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL COMMENT 'name:Título|type:text',
  `contenido` text COMMENT 'name:Contenido|type:wysiwyg',
  `link` text COMMENT 'name:Url|type:url',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'name:Fecha de creación|type:text',
  PRIMARY KEY (`idcmshelp`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_icono` table : 
#

DROP TABLE IF EXISTS `cms_icono`;

CREATE TABLE `cms_icono` (
  `idcmsicono` int(11) NOT NULL AUTO_INCREMENT,
  `icono_class` varchar(40) NOT NULL,
  PRIMARY KEY (`idcmsicono`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_infomation` table : 
#

DROP TABLE IF EXISTS `cms_infomation`;

CREATE TABLE `cms_infomation` (
  `idInformation` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla',
  `image` varchar(255) NOT NULL COMMENT 'Imagen descriptiva del proceso',
  `title` varchar(100) NOT NULL COMMENT 'Titulo del proceso	',
  `description` varchar(255) NOT NULL COMMENT 'Descripción del proceso',
  PRIMARY KEY (`idInformation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla donde se guarda la información de la empresa	';

#
# Structure for the `cms_menu` table : 
#

DROP TABLE IF EXISTS `cms_menu`;

CREATE TABLE `cms_menu` (
  `idcmsmenu` int(11) NOT NULL AUTO_INCREMENT,
  `cms_menu_id` int(11) DEFAULT NULL COMMENT 'name:Menú Dependiente',
  `titulo` varchar(40) NOT NULL COMMENT 'name:Título del Menú',
  `url` varchar(80) NOT NULL COMMENT 'name:Controlador / Acción menú',
  `icono` varchar(20) NOT NULL COMMENT 'name:Icono del menú',
  `visible_header` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'name:Encabezado visible para menú padre|type:switch',
  `visible` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'name:Menú Visible|type:switch',
  `orden` smallint(3) NOT NULL DEFAULT '0' COMMENT 'name:Posición del Menú',
  PRIMARY KEY (`idcmsmenu`),
  KEY `recursive_menu` (`cms_menu_id`),
  CONSTRAINT `recursive_menu` FOREIGN KEY (`cms_menu_id`) REFERENCES `cms_menu` (`idcmsmenu`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_message_contact` table : 
#

DROP TABLE IF EXISTS `cms_message_contact`;

CREATE TABLE `cms_message_contact` (
  `idMessageContact` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id unico de la tabla',
  `name` varchar(100) NOT NULL COMMENT 'Nombre de quien envía el correo\n',
  `email` varchar(45) NOT NULL COMMENT 'Correo electrónico desde donde se envía el mensaje',
  `subject` varchar(100) NOT NULL COMMENT 'Asunto del mensaje',
  `message` text NOT NULL COMMENT 'Mensaje enviado a través del formulario de contacto.',
  PRIMARY KEY (`idMessageContact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que permite guardar todos los mensajes enviados a través del formulario de contactos';

#
# Structure for the `cms_rol` table : 
#

DROP TABLE IF EXISTS `cms_rol`;

CREATE TABLE `cms_rol` (
  `idcmsrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(255) NOT NULL,
  PRIMARY KEY (`idcmsrol`),
  UNIQUE KEY `unico_rol` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

#
# Structure for the `cms_permission_rol` table : 
#

DROP TABLE IF EXISTS `cms_permission_rol`;

CREATE TABLE `cms_permission_rol` (
  `idcmspermissionrol` int(11) NOT NULL AUTO_INCREMENT,
  `cms_rol_id` int(11) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  PRIMARY KEY (`idcmspermissionrol`),
  KEY `cms_permission_rol_cms_rol` (`cms_rol_id`),
  CONSTRAINT `cms_permission_rol_cms_rol` FOREIGN KEY (`cms_rol_id`) REFERENCES `cms_rol` (`idcmsrol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `cms_plans` table : 
#

DROP TABLE IF EXISTS `cms_plans`;

CREATE TABLE `cms_plans` (
  `idPlans` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla	',
  `title` varchar(100) NOT NULL COMMENT 'Titulo del plan',
  `description` text NOT NULL COMMENT 'Descripción del plan',
  `items` varchar(255) NOT NULL COMMENT 'Items del plan',
  PRIMARY KEY (`idPlans`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla con los planes que ofrece la empresa	';

#
# Structure for the `cms_service` table : 
#

DROP TABLE IF EXISTS `cms_service`;

CREATE TABLE `cms_service` (
  `idService` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la tabla de servicios',
  `title` varchar(100) NOT NULL COMMENT 'Título del servicio que se presta',
  `description` text NOT NULL COMMENT 'Texto descriptivo del servicio\n',
  `image` varchar(255) NOT NULL COMMENT 'Imagen representativa del servicio\n',
  PRIMARY KEY (`idService`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que permite guardar los servicios que presta la empresa Cojunal	';

#
# Structure for the `cms_testimonial` table : 
#

DROP TABLE IF EXISTS `cms_testimonial`;

CREATE TABLE `cms_testimonial` (
  `idTestimonial` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único auto incremente con los testimonios de los clientes',
  `position` varchar(50) NOT NULL COMMENT 'Cargo que ocupa la persona dentro de la organización\n',
  `description` varchar(500) NOT NULL COMMENT 'Texto descriptivo con el testimonio',
  `name` varchar(100) NOT NULL COMMENT 'Nombre de la persona que hace el testimonio',
  `image` varchar(255) NOT NULL COMMENT 'Imagen con el logo de la empresa del testimonio',
  PRIMARY KEY (`idTestimonial`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que permite guardar los testimonios de los clientes de Cojunal';

#
# Structure for the `cms_usuario` table : 
#

DROP TABLE IF EXISTS `cms_usuario`;

CREATE TABLE `cms_usuario` (
  `idcmsusuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(70) NOT NULL COMMENT 'name:Usuario',
  `contrasena` varchar(100) NOT NULL COMMENT 'name:Contraseña|type:password',
  `nombres` varchar(50) NOT NULL COMMENT 'name:Nombres|type:text',
  `apellidos` varchar(50) NOT NULL COMMENT 'name:Apellidos',
  `email` varchar(50) NOT NULL COMMENT 'name:Email|type:email',
  `empresa` varchar(80) NOT NULL COMMENT 'name:Empresa',
  `telefono` varchar(150) DEFAULT NULL COMMENT 'name:Teléfono|type:phone',
  `descripcion` text COMMENT 'name:Descripción|type:textlarge',
  `ciudad` varchar(30) DEFAULT NULL COMMENT 'name:Ciudad',
  `cms_rol_id` int(11) NOT NULL COMMENT 'name:Rol',
  `token_chage` varchar(255) DEFAULT NULL COMMENT 'name:Token de cambio',
  `activo` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'name:Activo|type:switch',
  PRIMARY KEY (`idcmsusuario`),
  KEY `cms_usuario_cms_rol` (`cms_rol_id`),
  CONSTRAINT `cms_usuario_cms_rol` FOREIGN KEY (`cms_rol_id`) REFERENCES `cms_rol` (`idcmsrol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_aboutus` table : 
#

DROP TABLE IF EXISTS `coj_aboutus`;

CREATE TABLE `coj_aboutus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla auto incrementable',
  `img_en` text NOT NULL COMMENT 'Imagen Principal en Ingles',
  `img_es` text NOT NULL COMMENT 'Imagen Principal en Español',
  `des_en` varchar(100) NOT NULL COMMENT 'Descripcion de la Imagen en Ingles',
  `des_es` varchar(100) NOT NULL COMMENT 'Descripcion de Imagen en Español',
  `title_en` varchar(50) DEFAULT NULL COMMENT 'Titulo Ingles',
  `title_es` varchar(50) DEFAULT NULL COMMENT 'Titulo en Español',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_company` table : 
#

DROP TABLE IF EXISTS `coj_company`;

CREATE TABLE `coj_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único autoincremental',
  `title_es` varchar(50) DEFAULT NULL COMMENT 'Título en Español',
  `title_en` varchar(50) DEFAULT NULL COMMENT 'Título en Ingles',
  `img_es` text NOT NULL COMMENT 'Imagen en Español',
  `img_en` text NOT NULL COMMENT 'Imagen en Ingles',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_contact` table : 
#

DROP TABLE IF EXISTS `coj_contact`;

CREATE TABLE `coj_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único autoincremental',
  `hotlines_es` varchar(45) NOT NULL COMMENT 'Lineas de Atencion en Español',
  `hotlines_en` varchar(45) NOT NULL COMMENT 'Lineas de Atenvcion en Ingles',
  `addres_es` varchar(150) NOT NULL COMMENT 'Direccion en Español',
  `addres_en` varchar(150) NOT NULL COMMENT 'Direccion en Ingles',
  `email_es` varchar(45) NOT NULL COMMENT 'Direccion de Correo en Español',
  `email_en` varchar(45) NOT NULL COMMENT 'Direccion de correo en Ingles',
  `contact_email` varchar(50) NOT NULL COMMENT 'Correo Electronico de Contacto',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_email_placeholder` table : 
#

DROP TABLE IF EXISTS `coj_email_placeholder`;

CREATE TABLE `coj_email_placeholder` (
  `idEmailPlaceholder` int(11) NOT NULL AUTO_INCREMENT,
  `regiaterClientNotification` text,
  `termsConditions` text,
  `updateAt` date NOT NULL,
  PRIMARY KEY (`idEmailPlaceholder`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_generictext` table : 
#

DROP TABLE IF EXISTS `coj_generictext`;

CREATE TABLE `coj_generictext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único autoincremental',
  `text_es` text NOT NULL COMMENT 'texto en español',
  `text_en` text NOT NULL COMMENT 'Texto en ingles\n',
  `dCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_home` table : 
#

DROP TABLE IF EXISTS `coj_home`;

CREATE TABLE `coj_home` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla auto incrementable',
  `img_es` text NOT NULL COMMENT 'Imagen en Español',
  `img_en` text NOT NULL COMMENT 'Imagen en Ingles',
  `title_es` varchar(50) NOT NULL COMMENT 'Título en Español',
  `title_en` varchar(50) NOT NULL COMMENT 'Título en Ingles',
  `des_es` varchar(50) NOT NULL,
  `des_en` varchar(50) NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_map` table : 
#

DROP TABLE IF EXISTS `coj_map`;

CREATE TABLE `coj_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla auto incrementable',
  `latitude` float NOT NULL COMMENT 'Latitud',
  `lgn` float NOT NULL COMMENT 'Longitud',
  `title_en` varchar(50) NOT NULL COMMENT 'Título en Ingles',
  `title_es` varchar(50) NOT NULL COMMENT 'Título en Español',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_message` table : 
#

DROP TABLE IF EXISTS `coj_message`;

CREATE TABLE `coj_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único autoincremental',
  `name` varchar(100) NOT NULL COMMENT 'Nombre en Español',
  `email` varchar(50) NOT NULL COMMENT 'Correo Electronico en Español',
  `affair` varchar(60) NOT NULL COMMENT 'Asunto en Español',
  `mess` varchar(300) NOT NULL COMMENT 'Mensaje en Español',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `coj_services` table : 
#

DROP TABLE IF EXISTS `coj_services`;

CREATE TABLE `coj_services` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla auto incrementable',
  `img_es` text NOT NULL COMMENT 'Imagen Español',
  `img_en` text NOT NULL COMMENT 'Imagen Ingles',
  `title_es` varchar(50) NOT NULL COMMENT 'Título en Español',
  `title_en` varchar(50) NOT NULL COMMENT 'Título en Ingles',
  `subtitle_es` varchar(50) NOT NULL COMMENT 'Subtítulo en Español',
  `subtitle_en` varchar(50) NOT NULL COMMENT 'Subtítulo en Ingles',
  `des_es` varchar(700) NOT NULL COMMENT 'Descripión en Español',
  `des_en` varchar(700) NOT NULL COMMENT 'Descripción en Ingles',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

#
# Structure for the `coj_testimony` table : 
#

DROP TABLE IF EXISTS `coj_testimony`;

CREATE TABLE `coj_testimony` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla auto incrementable',
  `img_es` text NOT NULL COMMENT 'Imagen en Español',
  `img_en` text NOT NULL COMMENT 'Imagen en Ingles',
  `testi_es` varchar(200) NOT NULL COMMENT 'Testimonio en Español',
  `testi_en` varchar(200) NOT NULL COMMENT 'Testimonio en Ingles',
  `name_company_es` varchar(50) NOT NULL COMMENT 'Nombre de Compañia en Español',
  `name_company_en` varchar(50) NOT NULL COMMENT 'Nombre de Compañia en Español',
  `name_person_es` varchar(50) NOT NULL COMMENT 'Nombre Encargado en Español',
  `name_person_en` varchar(50) NOT NULL COMMENT 'Nombre Encargado en Español',
  `charge_person_es` varchar(80) NOT NULL COMMENT 'Cargo de la Persona en Español',
  `charge_person_en` varchar(80) NOT NULL COMMENT 'Cargo de la Persona en Ingles',
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

#
# Structure for the `comments` table : 
#

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `idComment` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `idWallet` bigint(20) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idComment`),
  KEY `fk_comentarios_carteras1` (`idWallet`),
  KEY `fk_comentarios_asesores1` (`idAdviser`),
  CONSTRAINT `fk_comentarios_asesores1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_carteras1` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `types` table : 
#

DROP TABLE IF EXISTS `types`;

CREATE TABLE `types` (
  `idType` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idAdviser` bigint(20) NOT NULL,
  PRIMARY KEY (`idType`),
  KEY `fk_tipos_asesores1` (`idAdviser`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

#
# Structure for the `demographics` table : 
#

DROP TABLE IF EXISTS `demographics`;

CREATE TABLE `demographics` (
  `idDemographic` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` varchar(45) NOT NULL,
  `idCity` bigint(20) DEFAULT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `idType` bigint(20) NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idWallet` bigint(20) NOT NULL,
  `comment` text,
  `relationshipType` varchar(155) DEFAULT NULL,
  `phoneType` varchar(155) DEFAULT NULL,
  `contactName` varchar(155) DEFAULT NULL,
  `addressType` varchar(155) DEFAULT NULL,
  PRIMARY KEY (`idDemographic`),
  KEY `fk_demografiaTelefonos_barrios1` (`idCity`),
  KEY `fk_demografiaTelefonos_asesores1` (`idAdviser`),
  KEY `fk_demografiaTelefonos_tipos1` (`idType`),
  KEY `fk_demografiaTelefonos_carteras1` (`idWallet`),
  CONSTRAINT `fk_demografiaTelefonos_asesores1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_demografiaTelefonos_carteras1` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_demografiaTelefonos_tipos1` FOREIGN KEY (`idType`) REFERENCES `types` (`idType`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_demographics_city` FOREIGN KEY (`idCity`) REFERENCES `cities` (`idCity`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1308 DEFAULT CHARSET=latin1;

#
# Structure for the `paymentypes` table : 
#

DROP TABLE IF EXISTS `paymentypes`;

CREATE TABLE `paymentypes` (
  `idPaymentType` int(11) NOT NULL AUTO_INCREMENT,
  `paymentTypeName` varchar(45) NOT NULL,
  PRIMARY KEY (`idPaymentType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Structure for the `wallets_tempo` table : 
#

DROP TABLE IF EXISTS `wallets_tempo`;

CREATE TABLE `wallets_tempo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idNumber` varchar(45) NOT NULL,
  `capitalValue` double NOT NULL,
  `legalName` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(55) NOT NULL,
  `ciudad` varchar(255) NOT NULL,
  `idStatus` bigint(20) NOT NULL DEFAULT '1',
  `product` varchar(155) NOT NULL,
  `idAdviser` bigint(20) NOT NULL DEFAULT '1',
  `validThrough` date NOT NULL,
  `accountNumber` varchar(55) NOT NULL,
  `idCampaign` bigint(20) NOT NULL,
  `migrate` tinyint(1) NOT NULL DEFAULT '0',
  `lote` varchar(100) DEFAULT 'NOW',
  `titleValue` double DEFAULT NULL,
  `typePhone1` varchar(100) NOT NULL,
  `countryPhone1` varchar(200) NOT NULL,
  `cityPhone1` varchar(200) NOT NULL,
  `phone1` varchar(200) NOT NULL,
  `typePhone2` varchar(100) NOT NULL,
  `countryPhone2` varchar(200) NOT NULL,
  `cityPhone2` varchar(200) NOT NULL,
  `phone2` varchar(200) NOT NULL,
  `typePhone3` varchar(100) NOT NULL,
  `countryPhone3` varchar(200) NOT NULL,
  `cityPhone3` varchar(200) NOT NULL,
  `phone3` varchar(200) NOT NULL,
  `nameReference1` varchar(255) NOT NULL,
  `relationshipReferenc1` varchar(255) NOT NULL,
  `countryReference1` varchar(200) NOT NULL,
  `cityReference1` varchar(200) NOT NULL,
  `commentReference1` text NOT NULL,
  `nameReference2` varchar(255) NOT NULL,
  `relationshipReference2` varchar(255) NOT NULL,
  `countryReference2` varchar(200) NOT NULL,
  `cityReference2` varchar(200) NOT NULL,
  `commentReference2` text NOT NULL,
  `nameReference3` varchar(255) NOT NULL,
  `relationshipReference3` varchar(255) NOT NULL,
  `countryReference3` varchar(200) NOT NULL,
  `cityReference3` varchar(200) NOT NULL,
  `commentReference3` text NOT NULL,
  `nameEmail1` varchar(255) NOT NULL,
  `email1` varchar(255) NOT NULL,
  `nameEmail2` varchar(255) NOT NULL,
  `email2` varchar(255) NOT NULL,
  `nameEmail3` varchar(255) NOT NULL,
  `email3` varchar(255) NOT NULL,
  `typeAddress1` varchar(255) NOT NULL,
  `address1` text NOT NULL,
  `countryAdrress1` varchar(200) NOT NULL,
  `cityAddress1` varchar(200) NOT NULL,
  `typeAddress2` varchar(255) NOT NULL,
  `address2` text NOT NULL,
  `countryAddress2` varchar(200) NOT NULL,
  `cityAddress2` varchar(200) NOT NULL,
  `typeAddress3` varchar(255) NOT NULL,
  `address3` text NOT NULL,
  `countryAddress3` varchar(200) NOT NULL,
  `cityAddress3` varchar(200) NOT NULL,
  `typeAsset1` varchar(255) NOT NULL,
  `nameAsset1` varchar(255) NOT NULL,
  `commentAsset1` text NOT NULL,
  `typeAsset2` varchar(255) NOT NULL,
  `nameAsset2` varchar(255) NOT NULL,
  `commentAsset2` text NOT NULL,
  `typeAsset3` varchar(255) NOT NULL,
  `nameAsset3` varchar(255) NOT NULL,
  `commentAsset3` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_wallet` (`idNumber`,`capitalValue`,`legalName`,`email`,`idCampaign`) USING BTREE,
  KEY `fk_carteras_estados1` (`idStatus`),
  KEY `fk_wallets_advisers1` (`idAdviser`),
  KEY `idCampaign` (`idCampaign`),
  CONSTRAINT `wallets_tempo_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`)
) ENGINE=InnoDB AUTO_INCREMENT=1096 DEFAULT CHARSET=latin1;

CREATE DEFINER = 'root'@'localhost' TRIGGER `wallets_tempo_BEFORE_INSERT` BEFORE INSERT ON `wallets_tempo`
  FOR EACH ROW
BEGIN
	IF((select count(idDistrict) from districts where name = NEW.ciudad)<1) THEN
	 Set NEW.ciudad = "Bogota";
	END IF;
END;

CREATE DEFINER = 'root'@'localhost' TRIGGER `wallets_tempo_AFTER_UPDATE` AFTER UPDATE ON `wallets_tempo`
  FOR EACH ROW
BEGIN
    INSERT INTO `wallets` 
        (`idNumber`, `capitalValue`, `feeValue`, `interestsValue`, 
        `dAssigment`, `dUpdate`, `legalName`, `address`, `phone`, 
        `email`, `idDistrict`, `idStatus`, `product`, 
        `idAdviser`, `validThrough`, `accountNumber`,  `titleValue`) 
    VALUES  (OLD.idNumber, OLD.capitalValue, (OLD.capitalValue*(select feeRate from sysparams where appName = "Cojunal" LIMIT 1))/100, ((OLD.capitalValue*(select interestRate from sysparams where appName = "Cojunal" LIMIT 1))/100)
        ,NOW(), NOW(), OLD.legalName, OLD.address, OLD.phone, OLD.email, (select MIN(idDistrict) from districts where UPPER(name) = UPPER(OLD.ciudad)), OLD.idStatus, OLD.product,
        (SELECT MIN(idAdviser) from advisers), OLD.validThrough, OLD.accountNumber, OLD.titleValue);
        
    IF((Select COUNT(idNumber) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email)>0) THEN 
        BEGIN
            INSERT INTO wallets_has_campaigns (idCampaign, idWallet) 
            VALUES (OLD.idCampaign, (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email));
            IF(OLD.typePhone1 <> '' AND OLD.countryPhone1 <> '' AND OLD.cityPhone1 <> '' AND OLD.phone1 <> '') THEN
                INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, phoneType) 
                VALUES (OLD.phone1, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityPhone1)), (SELECT MIN(idAdviser) from advisers), 1, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typePhone1);
            END IF;                
            IF(OLD.typePhone2 <> '' AND OLD.countryPhone2 <> '' AND OLD.cityPhone2 <> '' AND OLD.phone2 <> '') THEN
                INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, phoneType) 
                VALUES (OLD.phone2, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityPhone2)), (SELECT MIN(idAdviser) from advisers), 1, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typePhone2);
            END IF;
            IF(OLD.typePhone3 <> '' AND OLD.countryPhone3 <> '' AND OLD.cityPhone3 <> '' AND OLD.phone3 <> '') THEN
                INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, phoneType) 
                VALUES (OLD.phone3, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityPhone3)), (SELECT MIN(idAdviser) from advisers), 1, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typePhone3);
            END IF;
            IF(OLD.nameReference1 <> '' AND OLD.relationshipReferenc1 <> '' AND OLD.countryReference1 <> '' AND OLD.cityReference1 <> '' AND OLD.commentReference1 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, comment, relationshipType) 
                    VALUES (OLD.nameReference1, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityReference1)), (SELECT MIN(idAdviser) from advisers), 2, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.commentReference1, OLD.relationshipReferenc1);    
            END IF;    
            IF(OLD.nameReference2 <> '' AND OLD.relationshipReference2 <> '' AND OLD.countryReference2 <> '' AND OLD.cityReference2 <> '' AND OLD.commentReference2 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, comment, relationshipType) 
                    VALUES (OLD.nameReference2, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityReference2)), (SELECT MIN(idAdviser) from advisers), 2, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.commentReference2, OLD.relationshipReference2);    
            END IF;
            IF(OLD.nameReference3 <> '' AND OLD.relationshipReference3 <> '' AND OLD.countryReference3 <> '' AND OLD.cityReference3 <> '' AND OLD.commentReference3 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, comment, relationshipType) 
                    VALUES (OLD.nameReference3, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityReference3)), (SELECT MIN(idAdviser) from advisers), 2, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.commentReference3, OLD.relationshipReference3);    
            END IF;
            IF(OLD.nameEmail1 <> '' AND OLD.email1 <> '') THEN
                    INSERT INTO demographics (value, idAdviser, idType, dCreation, idWallet, contactName) 
                    VALUES (OLD.email1, (SELECT MIN(idAdviser) from advisers), 3, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.nameEmail1);    
            END IF;
            IF(OLD.nameEmail2 <> '' AND OLD.email2 <> '') THEN
                    INSERT INTO demographics (value, idAdviser, idType, dCreation, idWallet, contactName) 
                    VALUES (OLD.email2, (SELECT MIN(idAdviser) from advisers), 3, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.nameEmail2);    
            END IF;
            IF(OLD.nameEmail3 <> '' AND OLD.email3 <> '') THEN
                    INSERT INTO demographics (value, idAdviser, idType, dCreation, idWallet, contactName) 
                    VALUES (OLD.email3, (SELECT MIN(idAdviser) from advisers), 3, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.nameEmail3);    
            END IF;
            IF(OLD.typeAddress1 <> '' AND OLD.address1 <> '' AND OLD.countryAdrress1 <> '' AND OLD.cityAddress1 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, addressType) 
                    VALUES (OLD.address1, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityAddress1)), (SELECT MIN(idAdviser) from advisers), 4, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typeAddress1);    
            END IF;
            IF(OLD.typeAddress2 <> '' AND OLD.address2 <> '' AND OLD.countryAddress2 <> '' AND OLD.cityAddress2 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, addressType) 
                    VALUES (OLD.address2, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityAddress2)), (SELECT MIN(idAdviser) from advisers), 4, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typeAddress2);    
            END IF;
            IF(OLD.typeAddress3 <> '' AND OLD.address3 <> '' AND OLD.countryAddress3 <> '' AND OLD.cityAddress3 <> '') THEN
                    INSERT INTO demographics (value,idCity, idAdviser, idType, dCreation, idWallet, addressType) 
                    VALUES (OLD.address3, (SELECT MIN(idCity) FROM cities WHERE name LIKE CONCAT("%",OLD.cityAddress3)), (SELECT MIN(idAdviser) from advisers), 4, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), OLD.typeAddress3);    
            END IF;
            IF(OLD.typeAsset1 <> '' AND OLD.nameAsset1 <> '' AND OLD.commentAsset1 <> '' ) THEN
                    INSERT INTO assets (description,dCreation, idWallet, idAdviser, idType, assetName) 
                    VALUES (OLD.commentAsset1, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), (SELECT MIN(idAdviser) from advisers), (SELECT MIN(idAssetType) from `assettypes` where assetTypeName like CONCAT("%", TRIM(OLD.typeAsset1))), OLD.nameAsset1); 
            END IF;
            IF(OLD.typeAsset2 <> '' AND OLD.nameAsset2 <> '' AND OLD.commentAsset2 <> '' ) THEN
                    INSERT INTO assets (description,dCreation, idWallet, idAdviser, idType, assetName) 
                    VALUES (OLD.commentAsset2, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), (SELECT MIN(idAdviser) from advisers), (SELECT MIN(idAssetType) from `assettypes` where assetTypeName like CONCAT("%", TRIM(OLD.typeAsset2))), OLD.nameAsset2); 
            END IF;
            IF(OLD.typeAsset3 <> '' AND OLD.nameAsset3 <> '' AND OLD.commentAsset3 <> '' ) THEN
                    INSERT INTO assets (description,dCreation, idWallet, idAdviser, idType, assetName) 
                    VALUES (OLD.commentAsset3, NOW(), (Select MAX(idWallet) from wallets where idNumber=OLD.idNumber and capitalValue=OLD.capitalValue and email = OLD.email), (SELECT MIN(idAdviser) from advisers), (SELECT MIN(idAssetType) from `assettypes` where assetTypeName like CONCAT("%", TRIM(OLD.typeAsset3))), OLD.nameAsset3); 
            END IF;

        END; 
    END IF;
END;

#
# Structure for the `payments` table : 
#

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `idPayment` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `dPayment` date NOT NULL,
  `dCreation` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idWallet` int(11) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `idPaymentType` int(11) NOT NULL,
  `timer` varchar(8) NOT NULL DEFAULT '00:10:00',
  PRIMARY KEY (`idPayment`),
  KEY `fk_pagos_carteras1` (`idWallet`),
  KEY `fk_pagos_asesores1` (`idAdviser`),
  KEY `fk_payment_type_idx` (`idPaymentType`),
  CONSTRAINT `fk_pagos_asesores1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_carteras1` FOREIGN KEY (`idWallet`) REFERENCES `wallets_tempo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_type` FOREIGN KEY (`idPaymentType`) REFERENCES `paymentypes` (`idPaymentType`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

#
# Structure for the `promises` table : 
#

DROP TABLE IF EXISTS `promises`;

CREATE TABLE `promises` (
  `idPromise` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `dPromise` date NOT NULL,
  `dCreation` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idWallet` bigint(20) NOT NULL,
  `idAdviser` bigint(20) NOT NULL,
  `timer` varchar(8) NOT NULL DEFAULT '00:10:00',
  PRIMARY KEY (`idPromise`),
  KEY `fk_promesas_carteras1` (`idWallet`),
  KEY `fk_promesas_asesores1` (`idAdviser`),
  CONSTRAINT `fk_promesas_asesores1` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_promesas_carteras1` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

#
# Structure for the `remisiones` table : 
#

DROP TABLE IF EXISTS `remisiones`;

CREATE TABLE `remisiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `idWalletByCampaign` bigint(20) NOT NULL,
  `idPayments` varchar(250) NOT NULL,
  `intereses` float NOT NULL,
  `honorarios` float NOT NULL,
  `comision` float NOT NULL,
  `monto` float NOT NULL,
  `recaudo` float NOT NULL,
  `idCliente` bigint(20) NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idWalletByCampaign` (`idWalletByCampaign`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `remisiones_ibfk_1` FOREIGN KEY (`idWalletByCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`),
  CONSTRAINT `remisiones_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `campaigns` (`idCampaign`)
) ENGINE=InnoDB AUTO_INCREMENT=1023 DEFAULT CHARSET=latin1;

#
# Structure for the `serializeCampaign` table : 
#

DROP TABLE IF EXISTS `serializeCampaign`;

CREATE TABLE `serializeCampaign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCampaign` bigint(20) NOT NULL,
  `name` varchar(250) NOT NULL,
  `data` text NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `aprovedAt` timestamp NULL DEFAULT NULL,
  `estatus` int(11) NOT NULL COMMENT '0 = eliminada, 1 = en espera,  2 = migrada',
  PRIMARY KEY (`id`),
  KEY `idCampaign` (`idCampaign`),
  CONSTRAINT `serializeCampaign_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `campaigns` (`idCampaign`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;

#
# Structure for the `supports` table : 
#

DROP TABLE IF EXISTS `supports`;

CREATE TABLE `supports` (
  `idsupports` int(11) NOT NULL AUTO_INCREMENT,
  `idWallet` bigint(20) NOT NULL,
  `fileName` varchar(155) NOT NULL,
  `fileType` varchar(55) NOT NULL,
  `dFile` date NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idsupports`),
  KEY `fk_support_wallet_idx` (`idWallet`),
  CONSTRAINT `fk_support_wallet` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

#
# Structure for the `sysparams` table : 
#

DROP TABLE IF EXISTS `sysparams`;

CREATE TABLE `sysparams` (
  `idSysparam` int(11) NOT NULL AUTO_INCREMENT,
  `feeRate` float(18,2) DEFAULT NULL,
  `interestRate` float(18,2) DEFAULT NULL,
  `appName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSysparam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

#
# Structure for the `tasks` table : 
#

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `idTasks` int(11) NOT NULL AUTO_INCREMENT,
  `idWallet` bigint(20) NOT NULL,
  `idAction` int(11) NOT NULL,
  `dTask` date NOT NULL,
  `dCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idAdviser` bigint(20) NOT NULL,
  `timer` varchar(8) NOT NULL DEFAULT '00:10:00',
  PRIMARY KEY (`idTasks`),
  KEY `fk_wallets_tasks` (`idWallet`),
  KEY `fk_actions_tasks` (`idAction`),
  KEY `fk_advisers_tasks` (`idAdviser`),
  CONSTRAINT `fk_actions_tasks` FOREIGN KEY (`idAction`) REFERENCES `action` (`idAction`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_advisers_tasks` FOREIGN KEY (`idAdviser`) REFERENCES `advisers` (`idAdviser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wallets_tasks` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8;

#
# Structure for the `tempo_campaigns` table : 
#

DROP TABLE IF EXISTS `tempo_campaigns`;

CREATE TABLE `tempo_campaigns` (
  `isTempo` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `companyName` varchar(55) NOT NULL,
  `idNumber` varchar(45) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contactName` varchar(45) NOT NULL,
  `contactEmail` varchar(155) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(12) DEFAULT '014620116',
  `lote` varchar(255) NOT NULL,
  `distric` varchar(100) NOT NULL,
  PRIMARY KEY (`isTempo`),
  UNIQUE KEY `companyName` (`companyName`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE DEFINER = 'root'@'localhost' TRIGGER `tempo_campaigns_AFTER_UPDATE` AFTER UPDATE ON `tempo_campaigns`
  FOR EACH ROW
BEGIN
    INSERT INTO `campaigns` 
        (`idNumber`, `name`, `companyName`, `address`, 
        `contactName`, `contactEmail`, `fCreacion`, `dUpdate`, `idAdviser`, 
        `idDistrict`, `active`, `phone`) 
    VALUES  (NEW.idNumber, NEW.name, NEW.companyName, NEW.address, NEW.contactName, NEW.contactEmail, NOW(), NOW(),
            1, (SELECT MIN(idDistrict) from treedistricts where fullDistrict like CONCAT("%- ",NEW.distric)), 0, NEW.phone);
END;

#
# Structure for the `token` table : 
#

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `idToken` bigint(20) NOT NULL AUTO_INCREMENT,
  `permision_key` varchar(32) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idToken`),
  KEY `permisin_key_index` (`permision_key`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=latin1;

#
# Structure for the `wallets_has_campaigns` table : 
#

DROP TABLE IF EXISTS `wallets_has_campaigns`;

CREATE TABLE `wallets_has_campaigns` (
  `idWallet` bigint(20) NOT NULL,
  `idCampaign` bigint(20) NOT NULL,
  `idWalletsHasCampaigns` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idWalletsHasCampaigns`),
  UNIQUE KEY `wallet_campaign` (`idWallet`,`idCampaign`),
  KEY `fk_carteras_has_campanas_carteras1` (`idWallet`),
  KEY `fk_carteras_has_campanas_campanas1` (`idCampaign`),
  CONSTRAINT `wallets_has_campaigns_ibfk_1` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`),
  CONSTRAINT `wallet_fk` FOREIGN KEY (`idWallet`) REFERENCES `wallets` (`idWallet`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

#
# Structure for the `wallets_of_coordinators_juridic` table : 
#

DROP TABLE IF EXISTS `wallets_of_coordinators_juridic`;

CREATE TABLE `wallets_of_coordinators_juridic` (
  `idCampaign` bigint(20) NOT NULL,
  `idWalletTempo` int(11) NOT NULL,
  `idCoordinatorJuridic` bigint(20) NOT NULL,
  UNIQUE KEY `idWalletTempo` (`idWalletTempo`,`idCampaign`) USING BTREE,
  KEY `idCoordinatorJuridic` (`idCoordinatorJuridic`),
  KEY `idCampaign` (`idCampaign`),
  CONSTRAINT `wallets_of_coordinators_juridic_ibfk_1` FOREIGN KEY (`idWalletTempo`) REFERENCES `wallets_tempo` (`id`),
  CONSTRAINT `wallets_of_coordinators_juridic_ibfk_2` FOREIGN KEY (`idCoordinatorJuridic`) REFERENCES `advisers` (`idAdviser`),
  CONSTRAINT `wallets_of_coordinators_juridic_ibfk_3` FOREIGN KEY (`idCampaign`) REFERENCES `wallets_by_campaign` (`idWalletByCampaign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Definition for the `campanas_asignadas` view : 
#

DROP VIEW IF EXISTS `campanas_asignadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`report`@`%` SQL SECURITY DEFINER VIEW campanas_asignadas AS 
  select 
    `w`.`idWallet` AS `idWallet`,
    `c`.`idCampaign` AS `idCampaign`,
    `c`.`name` AS `name`,
    `w`.`type` AS `type`,
    ((((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) + (((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate())))) + `w`.`capitalValue`) AS `valueAssigment`,(((((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) + (((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate())))) + `w`.`capitalValue`) - `w`.`currentDebt`) AS `debt`,`w`.`currentDebt` AS `currentDebt`,((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) AS `feeValue`,`w`.`dAssigment` AS `dAssigment`,`w`.`dUpdate` AS `dUpdate`,`s`.`idStatus` AS `idStatus`,`s`.`description` AS `description`,((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) AS `interestMonth`,(((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate()))) AS `interest`,(
  select 
    (to_days(curdate()) - to_days(`w`.`dUpdate`))) AS `gestion` 
  from 
    (((`wallets_has_campaigns` `whc` join `wallets` `w` on((`whc`.`idWallet` = `w`.`idWallet`))) join `campaigns` `c` on((`c`.`idCampaign` = `whc`.`idCampaign`))) join `status` `s` on((`s`.`idStatus` = `w`.`idStatus`)));

#
# Definition for the `lastpayments` view : 
#

DROP VIEW IF EXISTS `lastpayments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW lastpayments AS 
  select 
    `payments`.`idWallet` AS `idWallet`,
    max(`payments`.`dPayment`) AS `dPayment` 
  from 
    `payments` 
  group by 
    `payments`.`idWallet`;

#
# Definition for the `management` view : 
#

DROP VIEW IF EXISTS `management`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW management AS 
  select 
    `ag`.`idWallet` AS `idWallet`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `ag`.`dCreation` AS `fecha`,
    `ac`.`actionName` AS `action`,
    `ef`.`effectName` AS `effect`,
    `ag`.`comment` AS `comment`,
    `ag`.`timer` AS `timer` 
  from 
    (((`agendas` `ag` join `action` `ac` on((`ag`.`idAction` = `ac`.`idAction`))) join `effects` `ef` on((`ag`.`idEffect` = `ef`.`idEffect`))) join `advisers` `ad` on((`ag`.`idAdviser` = `ad`.`idAdviser`))) union 
  select 
    `tk`.`idWallet` AS `idWallet`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `tk`.`dCreation` AS `fecha`,
    `ac`.`actionName` AS `action`,
    '' AS `effect`,
    '' AS `comment`,
    `tk`.`timer` AS `timer` 
  from 
    ((`tasks` `tk` join `action` `ac` on((`tk`.`idAction` = `ac`.`idAction`))) join `advisers` `ad` on((`tk`.`idAdviser` = `ad`.`idAdviser`))) union 
  select 
    `pr`.`idWallet` AS `idWallet`,
    `ad`.`idAdviser` AS `idAdviser`,
    `ad`.`name` AS `name`,
    `pr`.`dCreation` AS `dCreation`,
    'Promesa' AS `action`,
    '' AS `effect`,
    `pr`.`value` AS `comment`,
    `pr`.`timer` AS `timer` 
  from 
    (`promises` `pr` join `advisers` `ad` on((`pr`.`idAdviser` = `ad`.`idAdviser`))) union 
  select 
    `pr`.`idWallet` AS `idWallet`,
    `ad`.`idAdviser` AS `idAdviser`,
    `ad`.`name` AS `name`,
    `pr`.`dCreation` AS `dCreation`,
    'Pago' AS `action`,
    `pt`.`paymentTypeName` AS `effect`,
    `pr`.`value` AS `commet`,
    `pr`.`timer` AS `timer` 
  from 
    ((`payments` `pr` join `advisers` `ad` on((`pr`.`idAdviser` = `ad`.`idAdviser`))) join `paymentypes` `pt` on((`pr`.`idPaymentType` = `pt`.`idPaymentType`)));

#
# Definition for the `profileassignments` view : 
#

DROP VIEW IF EXISTS `profileassignments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW profileassignments AS 
  select 
    `ac`.`idAdvisers` AS `idAdvisers`,
    sum(`w`.`capitalValue`) AS `assigned` 
  from 
    ((`advisers_campaigns` `ac` join `wallets_has_campaigns` `wc` on((`ac`.`idCampaign` = `wc`.`idCampaign`))) join `wallets` `w` on((`wc`.`idWallet` = `w`.`idWallet`))) 
  group by 
    `ac`.`idAdvisers`;

#
# Definition for the `profilecampaigns` view : 
#

DROP VIEW IF EXISTS `profilecampaigns`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW profilecampaigns AS 
  select 
    `ac`.`idAdvisers` AS `idAdvisers`,
    count(0) AS `campaigns` 
  from 
    `advisers_campaigns` `ac` 
  group by 
    `ac`.`idAdvisers`;

#
# Definition for the `profilepayments` view : 
#

DROP VIEW IF EXISTS `profilepayments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW profilepayments AS 
  select 
    `ac`.`idAdvisers` AS `idAdvisers`,
    sum(`p`.`value`) AS `payments` 
  from 
    (((`advisers_campaigns` `ac` join `wallets_has_campaigns` `wc` on((`ac`.`idCampaign` = `wc`.`idCampaign`))) join `wallets` `w` on((`wc`.`idWallet` = `w`.`idWallet`))) join `payments` `p` on((`w`.`idWallet` = `p`.`idWallet`))) 
  group by 
    `ac`.`idAdvisers`;

#
# Definition for the `profilewallets` view : 
#

DROP VIEW IF EXISTS `profilewallets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW profilewallets AS 
  select 
    `ac`.`idAdvisers` AS `idAdvisers`,
    count(`wc`.`idWallet`) AS `wallets` 
  from 
    (`advisers_campaigns` `ac` join `wallets_has_campaigns` `wc` on((`ac`.`idCampaign` = `wc`.`idCampaign`))) 
  group by 
    `ac`.`idAdvisers`,`ac`.`idCampaign`;

#
# Definition for the `profilesummary` view : 
#

DROP VIEW IF EXISTS `profilesummary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW profilesummary AS 
  select 
    `pc`.`idAdvisers` AS `idAdvisers`,
    coalesce(`pc`.`campaigns`,0) AS `campaigns`,
    coalesce(`pw`.`wallets`,0) AS `wallets`,
    coalesce(`pa`.`assigned`,0) AS `assigned`,
    coalesce(`pp`.`payments`,0) AS `payments` 
  from 
    (((`profilecampaigns` `pc` left join `profilewallets` `pw` on((`pc`.`idAdvisers` = `pw`.`idAdvisers`))) left join `profileassignments` `pa` on((`pc`.`idAdvisers` = `pa`.`idAdvisers`))) left join `profilepayments` `pp` on((`pc`.`idAdvisers` = `pp`.`idAdvisers`)));

#
# Definition for the `viewlistdebtors` view : 
#

DROP VIEW IF EXISTS `viewlistdebtors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW viewlistdebtors AS 
  select 
    `w`.`idWallet` AS `idWallet`,
    `c`.`idCampaign` AS `idCampaign`,
    `c`.`name` AS `name`,
    `w`.`idNumber` AS `idNumber`,
    `w`.`legalName` AS `legalName`,
    `w`.`capitalValue` AS `capitalValue`,
    `w`.`validThrough` AS `validThrough`,
    `w`.`type` AS `type`,
    ((((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) + (((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate())))) + `w`.`capitalValue`) AS `valueAssigment`,(((((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) + (((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate())))) + `w`.`capitalValue`) - `w`.`currentDebt`) AS `debt`,`w`.`currentDebt` AS `currentDebt`,((`w`.`capitalValue` * (
  select 
    `sysparams`.`feeRate` 
  from 
    `sysparams`)) / 100) AS `feeValue`,`w`.`dAssigment` AS `dAssigment`,`w`.`dUpdate` AS `dUpdate`,`s`.`idStatus` AS `idStatus`,`s`.`description` AS `description`,((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) AS `interestMonth`,(((`w`.`capitalValue` * (
  select 
    `sysparams`.`interestRate` 
  from 
    `sysparams`)) / 100) * (
  select 
    timestampdiff(MONTH,`w`.`dAssigment`,curdate()))) AS `interest`,(
  select 
    (to_days(curdate()) - to_days(`w`.`dUpdate`))) AS `gestion` 
  from 
    (((`wallets_has_campaigns` `whc` join `wallets` `w` on((`whc`.`idWallet` = `w`.`idWallet`))) join `campaigns` `c` on((`c`.`idCampaign` = `whc`.`idCampaign`))) join `status` `s` on((`s`.`idStatus` = `w`.`idStatus`)));

#
# Definition for the `q1` view : 
#

DROP VIEW IF EXISTS `q1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW q1 AS 
  select 
    `viewlistdebtors`.`idWallet` AS `idWallet`,
    `viewlistdebtors`.`idCampaign` AS `idCampaign`,
    `viewlistdebtors`.`name` AS `name`,
    `viewlistdebtors`.`idNumber` AS `idNumber`,
    `viewlistdebtors`.`legalName` AS `legalName`,
    `viewlistdebtors`.`capitalValue` AS `capitalValue`,
    `viewlistdebtors`.`validThrough` AS `validThrough`,
    `viewlistdebtors`.`type` AS `type`,
    `viewlistdebtors`.`valueAssigment` AS `valueAssigment`,
    `viewlistdebtors`.`debt` AS `debt`,
    `viewlistdebtors`.`currentDebt` AS `currentDebt`,
    `viewlistdebtors`.`feeValue` AS `feeValue`,
    `viewlistdebtors`.`dAssigment` AS `dAssigment`,
    `viewlistdebtors`.`dUpdate` AS `dUpdate`,
    `viewlistdebtors`.`idStatus` AS `idStatus`,
    `viewlistdebtors`.`description` AS `description`,
    `viewlistdebtors`.`interestMonth` AS `interestMonth`,
    `viewlistdebtors`.`interest` AS `interest`,
    `viewlistdebtors`.`gestion` AS `gestion` 
  from 
    `viewlistdebtors` 
  where 
    (((to_days(curdate()) - to_days(`viewlistdebtors`.`validThrough`)) < 360) and (`viewlistdebtors`.`capitalValue` >= 50000000));

#
# Definition for the `q2` view : 
#

DROP VIEW IF EXISTS `q2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW q2 AS 
  select 
    `viewlistdebtors`.`idWallet` AS `idWallet`,
    `viewlistdebtors`.`idCampaign` AS `idCampaign`,
    `viewlistdebtors`.`name` AS `name`,
    `viewlistdebtors`.`idNumber` AS `idNumber`,
    `viewlistdebtors`.`legalName` AS `legalName`,
    `viewlistdebtors`.`capitalValue` AS `capitalValue`,
    `viewlistdebtors`.`validThrough` AS `validThrough`,
    `viewlistdebtors`.`type` AS `type`,
    `viewlistdebtors`.`valueAssigment` AS `valueAssigment`,
    `viewlistdebtors`.`debt` AS `debt`,
    `viewlistdebtors`.`currentDebt` AS `currentDebt`,
    `viewlistdebtors`.`feeValue` AS `feeValue`,
    `viewlistdebtors`.`dAssigment` AS `dAssigment`,
    `viewlistdebtors`.`dUpdate` AS `dUpdate`,
    `viewlistdebtors`.`idStatus` AS `idStatus`,
    `viewlistdebtors`.`description` AS `description`,
    `viewlistdebtors`.`interestMonth` AS `interestMonth`,
    `viewlistdebtors`.`interest` AS `interest`,
    `viewlistdebtors`.`gestion` AS `gestion` 
  from 
    `viewlistdebtors` 
  where 
    (((to_days(curdate()) - to_days(`viewlistdebtors`.`validThrough`)) > 360) and (`viewlistdebtors`.`capitalValue` >= 50000000));

#
# Definition for the `q3` view : 
#

DROP VIEW IF EXISTS `q3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW q3 AS 
  select 
    `viewlistdebtors`.`idWallet` AS `idWallet`,
    `viewlistdebtors`.`idCampaign` AS `idCampaign`,
    `viewlistdebtors`.`name` AS `name`,
    `viewlistdebtors`.`idNumber` AS `idNumber`,
    `viewlistdebtors`.`legalName` AS `legalName`,
    `viewlistdebtors`.`capitalValue` AS `capitalValue`,
    `viewlistdebtors`.`validThrough` AS `validThrough`,
    `viewlistdebtors`.`type` AS `type`,
    `viewlistdebtors`.`valueAssigment` AS `valueAssigment`,
    `viewlistdebtors`.`debt` AS `debt`,
    `viewlistdebtors`.`currentDebt` AS `currentDebt`,
    `viewlistdebtors`.`feeValue` AS `feeValue`,
    `viewlistdebtors`.`dAssigment` AS `dAssigment`,
    `viewlistdebtors`.`dUpdate` AS `dUpdate`,
    `viewlistdebtors`.`idStatus` AS `idStatus`,
    `viewlistdebtors`.`description` AS `description`,
    `viewlistdebtors`.`interestMonth` AS `interestMonth`,
    `viewlistdebtors`.`interest` AS `interest`,
    `viewlistdebtors`.`gestion` AS `gestion` 
  from 
    `viewlistdebtors` 
  where 
    (((to_days(curdate()) - to_days(`viewlistdebtors`.`validThrough`)) <= 360) and (`viewlistdebtors`.`capitalValue` < 50000000));

#
# Definition for the `q4` view : 
#

DROP VIEW IF EXISTS `q4`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW q4 AS 
  select 
    `viewlistdebtors`.`idWallet` AS `idWallet`,
    `viewlistdebtors`.`idCampaign` AS `idCampaign`,
    `viewlistdebtors`.`name` AS `name`,
    `viewlistdebtors`.`idNumber` AS `idNumber`,
    `viewlistdebtors`.`legalName` AS `legalName`,
    `viewlistdebtors`.`capitalValue` AS `capitalValue`,
    `viewlistdebtors`.`validThrough` AS `validThrough`,
    `viewlistdebtors`.`type` AS `type`,
    `viewlistdebtors`.`valueAssigment` AS `valueAssigment`,
    `viewlistdebtors`.`debt` AS `debt`,
    `viewlistdebtors`.`currentDebt` AS `currentDebt`,
    `viewlistdebtors`.`feeValue` AS `feeValue`,
    `viewlistdebtors`.`dAssigment` AS `dAssigment`,
    `viewlistdebtors`.`dUpdate` AS `dUpdate`,
    `viewlistdebtors`.`idStatus` AS `idStatus`,
    `viewlistdebtors`.`description` AS `description`,
    `viewlistdebtors`.`interestMonth` AS `interestMonth`,
    `viewlistdebtors`.`interest` AS `interest`,
    `viewlistdebtors`.`gestion` AS `gestion` 
  from 
    `viewlistdebtors` 
  where 
    (((to_days(curdate()) - to_days(`viewlistdebtors`.`validThrough`)) > 360) and (`viewlistdebtors`.`capitalValue` < 50000000));

#
# Definition for the `restmanagement` view : 
#

DROP VIEW IF EXISTS `restmanagement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW restmanagement AS 
  select 
    `ag`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `ag`.`dAction` AS `fecha`,
    `ac`.`actionName` AS `action`,
    `ef`.`effectName` AS `effect`,
    `ag`.`comment` AS `comment` 
  from 
    ((((`agendas` `ag` join `action` `ac` on((`ag`.`idAction` = `ac`.`idAction`))) join `effects` `ef` on((`ag`.`idEffect` = `ef`.`idEffect`))) join `advisers` `ad` on((`ag`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`ag`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`ag`.`dAction` > date_format(now(),'%Y-%m-%d')) union 
  select 
    `tk`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `tk`.`dTask` AS `fecha`,
    `ac`.`actionName` AS `action`,
    '' AS `effect`,
    '' AS `comment` 
  from 
    (((`tasks` `tk` join `action` `ac` on((`tk`.`idAction` = `ac`.`idAction`))) join `advisers` `ad` on((`tk`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`tk`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`tk`.`dTask` > date_format(now(),'%Y-%m-%d')) union 
  select 
    `pr`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAdviser`,
    `ad`.`name` AS `name`,
    `pr`.`dPromise` AS `dCreation`,
    'Promesa' AS `action`,
    '' AS `effect`,
    `pr`.`value` AS `comment` 
  from 
    ((`promises` `pr` join `advisers` `ad` on((`pr`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`pr`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`pr`.`dPromise` > date_format(now(),'%Y-%m-%d'));

#
# Definition for the `restmanagement2` view : 
#

DROP VIEW IF EXISTS `restmanagement2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW restmanagement2 AS 
  select 
    `wallets`.`idWallet` AS `idWallet2`,
    `wallets`.`legalName` AS `legalName`,
    `wallets`.`phone` AS `phone`,
    `management`.`idAsesor` AS `idAsesor`,
    `management`.`asesor` AS `asesor`,
    date_format(`management`.`fecha`,'%d %M %Y') AS `fecha`,
    `management`.`action` AS `action`,
    `management`.`effect` AS `effect`,
    `management`.`comment` AS `comment` 
  from 
    (`management` join `wallets` on((`wallets`.`idWallet` = `management`.`idWallet`))) 
  where 
    (`management`.`action` <> 'Pago');

#
# Definition for the `todaysmanagement` view : 
#

DROP VIEW IF EXISTS `todaysmanagement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW todaysmanagement AS 
  select 
    `ag`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `ag`.`dAction` AS `fecha`,
    `ac`.`actionName` AS `action`,
    `ef`.`effectName` AS `effect`,
    `ag`.`comment` AS `comment` 
  from 
    ((((`agendas` `ag` join `action` `ac` on((`ag`.`idAction` = `ac`.`idAction`))) join `effects` `ef` on((`ag`.`idEffect` = `ef`.`idEffect`))) join `advisers` `ad` on((`ag`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`ag`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`ag`.`dAction` = date_format(now(),'%Y-%m-%d')) union 
  select 
    `tk`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAsesor`,
    `ad`.`name` AS `asesor`,
    `tk`.`dTask` AS `fecha`,
    `ac`.`actionName` AS `action`,
    '' AS `effect`,
    '' AS `comment` 
  from 
    (((`tasks` `tk` join `action` `ac` on((`tk`.`idAction` = `ac`.`idAction`))) join `advisers` `ad` on((`tk`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`tk`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`tk`.`dTask` = date_format(now(),'%Y-%m-%d')) union 
  select 
    `pr`.`idWallet` AS `idWallet`,
    `wl`.`legalName` AS `legalName`,
    `wl`.`phone` AS `phone`,
    `ad`.`idAdviser` AS `idAdviser`,
    `ad`.`name` AS `name`,
    `pr`.`dPromise` AS `dCreation`,
    'Promesa' AS `action`,
    '' AS `effect`,
    `pr`.`value` AS `comment` 
  from 
    ((`promises` `pr` join `advisers` `ad` on((`pr`.`idAdviser` = `ad`.`idAdviser`))) join `wallets` `wl` on((`pr`.`idWallet` = `wl`.`idWallet`))) 
  where 
    (`pr`.`dPromise` = date_format(now(),'%Y-%m-%d'));

#
# Definition for the `treedistricts` view : 
#

DROP VIEW IF EXISTS `treedistricts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW treedistricts AS 
  select 
    `districts`.`idDistrict` AS `idDistrict`,
    concat(`departaments`.`name`,' - ',`cities`.`name`,' - ',`districts`.`name`) AS `fullDistrict` 
  from 
    ((`districts` join `cities` on((`districts`.`idCity` = `cities`.`idCity`))) join `departaments` on((`departaments`.`idDepartament` = `cities`.`idDepartament`)));

#
# Definition for the `viewadvisersstatus` view : 
#

DROP VIEW IF EXISTS `viewadvisersstatus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW viewadvisersstatus AS 
  select 
    `a`.`idAdviser` AS `idAdviser`,
    concat(`b`.`description`,' - ',`a`.`name`,' - ',`a`.`email`) AS `fullAdviser` 
  from 
    (`advisers` `a` join `status` `b`) 
  where 
    (`a`.`status_idStatus` = `b`.`idStatus`);

#
# Definition for the `viewdebtorscampaigns` view : 
#

DROP VIEW IF EXISTS `viewdebtorscampaigns`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW viewdebtorscampaigns AS 
  select 
    `whc`.`idWalletsHasCampaigns` AS `idWalletsHasCampaigns`,
    `c`.`name` AS `name`,
    concat(`w`.`idNumber`,' - ',`w`.`legalName`) AS `walletPeople` 
  from 
    ((`wallets_has_campaigns` `whc` join `campaigns` `c` on((`c`.`idCampaign` = `whc`.`idCampaign`))) join `wallets` `w` on((`w`.`idWallet` = `whc`.`idWallet`))) 
  group by 
    `w`.`idWallet`;

#
# Definition for the `viewwaletsidentification` view : 
#

DROP VIEW IF EXISTS `viewwaletsidentification`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW viewwaletsidentification AS 
  select 
    `wallets`.`idWallet` AS `idWallet`,
    concat(`wallets`.`idNumber`,' - ',`wallets`.`legalName`) AS `identificationsWallet` 
  from 
    `wallets`;

#
# Data for the `action` table  (LIMIT 0,500)
#

INSERT INTO `action` (`idAction`, `actionName`) VALUES 
  (1,'Llamada'),
  (2,'Notificación correo electrónico - SMS'),
  (3,'Notificacion correo directo'),
  (4,'Visita Domiciliaria'),
  (6,'Visita Laboral'),
  (7,'Devolución');
COMMIT;

#
# Data for the `actions_has_effects` table  (LIMIT 0,500)
#

INSERT INTO `actions_has_effects` (`idActionsHasEffects`, `idAction`, `idEffect`) VALUES 
  (1,1,1),
  (2,1,2),
  (3,1,3),
  (4,1,4),
  (5,1,5),
  (6,1,6),
  (7,1,7),
  (8,1,8),
  (9,1,9),
  (10,1,10),
  (11,2,1),
  (12,2,2),
  (13,2,4),
  (14,2,7),
  (15,2,8),
  (16,2,9),
  (17,2,11),
  (18,3,12),
  (19,3,13),
  (20,3,14),
  (21,3,15),
  (22,3,16),
  (23,4,1),
  (24,4,2),
  (25,4,3),
  (26,4,4),
  (27,4,5),
  (28,4,7),
  (29,4,8),
  (30,4,9),
  (31,4,17),
  (32,4,18),
  (33,5,2),
  (34,5,3),
  (35,5,4),
  (36,5,9),
  (37,5,19),
  (38,5,20),
  (39,5,21),
  (40,7,4);
COMMIT;

#
# Data for the `authitem` table  (LIMIT 0,500)
#

INSERT INTO `authitem` (`name`, `type`, `description`, `bizrule`, `data`) VALUES 
  ('Asesor',1,'Rol de asesor','Role de aseso','Data de asesor'),
  ('Asesor jurídico',1,'Rol de asesor jurídico','Rol de asesor jurídico','Data de asesor jurídico'),
  ('Asesor pre jurídico',1,'Rol de asesor pre jurídico','Rol de asesor pre jurídico','Data de asesor pre jurídico'),
  ('Coordinador',3,'Rol Coordinador','Coordinador','Data del coordinador'),
  ('Coordinador jurídico',3,'Rol de coordinador jurídico','Rol de coordinador jurídico','Data de coordinador jurídico'),
  ('Coordinador pre jurídico',3,'Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Data de coordinador pre jurídico'),
  ('Empresa',2,'Rol empresa','Rol empresa','Data Empresa');
COMMIT;

#
# Data for the `authassignment` table  (LIMIT 0,500)
#

INSERT INTO `authassignment` (`idAuthAssignment`, `userid`, `bizrule`, `data`, `itemname`) VALUES 
  (84,'ANDRIS','Rol asesor','Rol asesor','Asesor'),
  (85,'CARTERACOLOMBINA1@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (86,'CARTERATEAMFOOD@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (88,'CARTERAJANIROX@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (89,'CARTERAPHARMA@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (90,'CARTERAFABRICATO@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (91,'CALAZANSCOLE@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (92,'CARTERAEUROPARTES1@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (93,'CARTERANTEK@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (95,'CARTERAJHONSON@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (96,'CARTERARYSTA@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (97,'CARTERAMETALES1@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (98,'CARTERATECNOQUIMICAS1@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (99,'CARTERABRINKS1@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (100,'ASESOR 1','Rol asesor','Rol asesor','Asesor'),
  (101,'ASESOR 2','Rol asesor','Rol asesor','Asesor'),
  (102,'carterahecto@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (104,'CARTERAMARIORAMIREZ@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (105,'CARTERAIGNACIO@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (106,'JURIDICO','Rol asesor','Rol asesor','Coordinador'),
  (107,'CARTERADISCLINICAS@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (108,'carteragrocarga@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (109,'carteranestle@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (110,'carteraicaro17@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (111,'CARTERAEROFLEX@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (112,'coordinador','Rol asesor','Rol asesor','Asesor'),
  (130,'wilmar.ibg@gmail.com','Rol asesor','Rol asesor','Asesor'),
  (131,'jusone@gmail.error','Rol asesor','Rol asesor','Asesor'),
  (132,'wilmar.ibg@gmail.asesor','Rol asesor','Rol asesor','Asesor'),
  (133,'wilmar.ibg@gmail.asesor2','Rol asesor','Rol asesor','Asesor'),
  (134,'fmusc@hotmail.com','Rol asesor','Rol asesor','Asesor'),
  (135,'Asesorusc@cojunal.com','Rol asesor','Rol asesor','Asesor'),
  (136,'info@info.com','Rol empresa','Rol empresa','Empresa'),
  (139,'coordinadorusc_2@cojumal.com','Rol asesor','Rol asesor','Asesor'),
  (140,'Asesorusc_2@cojunal.com','Rol asesor','Rol asesor','Asesor'),
  (145,'programaticaexcel@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (146,'wilmar.io@gmail.com','Rol asesor','Rol asesor','Asesor'),
  (147,'ae@esio.com','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (148,'sfddsdf@loin.cm','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (149,'sdsd@rkp.powc','Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Coordinador pre jurídico'),
  (150,'sw@sw.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (151,'wq@wq.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (152,'asa','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (153,'pedro@email.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (154,'pedrito@email.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (155,'AsesorUsc_J@cojunal.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (156,'AsesorUsc_PJ@cojunal.com','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (157,'AsesorUsc_J@cojunal.com2','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (158,'CordinadorUsc_J@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (159,'activo@email.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (160,'CordinadorUsc_PJ@cojunal.com','Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Coordinador pre jurídico'),
  (161,'Coordinador_juridico_1@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (162,'Asesor_juridico_1@cojunal.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (163,'Coordinador_J2@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (164,'Coordinador_PJ2@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (165,'Coordinador_PJ2@cojunal.com.co','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (166,'Coordinador_J3@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (167,'Coordinador_J4@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (168,'ing.alelopez@@gmail.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (169,'ing.alelopez@gml.com','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (170,'Coordinador_J5@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (171,'Coordinador_J6@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (172,'Cordinador_PJ6@cojunal.com','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (173,'Coordinador_PJ06@cojunal.com','Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Coordinador pre jurídico'),
  (174,'Asesor_J6@cojunal.com','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (175,'Asesor_PJ6@cojunal.com','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (176,'frt@trf.co','Rol de asesor jurídico','Rol de asesor jurídico','Asesor jurídico'),
  (177,'wer@wer.co','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico'),
  (178,'raul@cjnl.com','Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Coordinador pre jurídico'),
  (179,'diana@srvc.co','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (180,'josediaz78963@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (181,'wilmar.ibarguen@qentek.com','Rol empresa','Rol empresa','Empresa'),
  (182,'w@2.xom','Rol empresa','Rol empresa','Empresa'),
  (183,'wrtrr@2.xom','Rol empresa','Rol empresa','Empresa'),
  (184,'wrtrdsar@2.xom','Rol empresa','Rol empresa','Empresa'),
  (185,'wewqertrdsar@2.xom','Rol empresa','Rol empresa','Empresa'),
  (186,'CARTERADISCLINICA@GMAIL.COM','Rol empresa','Rol empresa','Empresa'),
  (187,'ibarguen_cp@hotmail.com','Rol de coordinador pre jurídico','Rol de coordinador pre jurídico','Coordinador pre jurídico'),
  (188,'wilmar.ibarguen@quentek.com','Rol empresa','Rol empresa','Empresa'),
  (189,'hhhhkjh@ff.com','Rol empresa','Rol empresa','Empresa'),
  (190,'cesar.lombana@unisoftsystem.com.co','Rol empresa','Rol empresa','Empresa'),
  (191,'buustag@gmail.co','Rol empresa','Rol empresa','Empresa'),
  (192,'josediaz78963@hotmail.com','Rol empresa','Rol empresa','Empresa'),
  (193,'josediaz78964@hotmail.com','Rol empresa','Rol empresa','Empresa'),
  (194,'josediaz78965@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (195,'wilmar.ibarguen@bluewebfactory.com','Rol de asesor pre jurídico','Rol de asesor pre jurídico','Asesor pre jurídico'),
  (196,'johnkstro@gmail.com','Rol empresa','Rol empresa','Empresa'),
  (197,'juliocesar.cortes@unisoftsystem.com.co','Rol de coordinador jurídico','Rol de coordinador jurídico','Coordinador jurídico');
COMMIT;

#
# Data for the `advisers` table  (LIMIT 0,500)
#

INSERT INTO `advisers` (`idAdviser`, `parentAdviser`, `name`, `email`, `passwd`, `dCreation`, `dUpdate`, `active`, `idAuthAssignment`, `weeklyGoal`, `monthlyGoal`, `status_idStatus`) VALUES 
  (40,68,'ASESORBOGOTA0003','nicvalencia@gmail.com','28a9f23c0f837339f327d1eb7d7c53a2','2017-06-29 16:06:33','2017-08-24 08:08:36',1,84,100,100,2),
  (41,69,'ASESORBOGOTA0001','LUZ.CASTRO@COJUNAL.COM','aa73ef469261e6fb865bc4ff597fb6be','2017-06-30 13:06:46','2017-07-10 16:07:13',1,100,100,100,2),
  (42,69,'ASESORBOGOTA0002','CARTERA@COJUNAL.COM','81dc9bdb52d04dc20036dbd8313ed055','2017-06-30 14:06:50','2017-07-10 16:07:28',1,101,100,100,2),
  (44,0,'JURIDICO','Nicolas.Valencia@unisoftsystem.com.co','2edf0263cd0434ea7e646b2570d56152','2017-07-18 12:07:57','2017-07-31 16:07:38',1,106,100,100,5),
  (45,0,'Nicolas coordinador','marilyncev@gmail.com','cffa109438a6e7f055f94fb45429753d','2017-08-03 11:08:06','2017-08-03 11:08:06',1,112,2,2,6),
  (58,69,'wilmar test cordinador','wilmar.ibg@gmail.com','882ddac5c49e3e76c84987e908a8d542','2017-08-18 07:08:16','2017-08-18 07:08:16',0,130,0,0,2),
  (59,0,'jose prueba','jusone@gmail.error','a8e779f6538b6cfda5e232d077831ef4','2017-08-18 07:08:05','2017-08-18 07:08:05',1,131,0,0,6),
  (60,45,'wilmar test asesor','wilmar.ibg@gmail.asesor','e9a60a52604b469bea073cc3cae22ea6','2017-08-18 08:08:13','2017-08-18 08:08:13',1,132,0,0,2),
  (61,68,'wilmar test asesor 2','wilmar.ibg@gmail.asesor2','e675b305504aa178b3e2d4ddbf732d27','2017-08-18 08:08:41','2017-08-18 08:08:41',1,133,0,0,2),
  (62,0,'CordinadorUsc','fmusc2@hotmail.com','e78c746fe031d4dc726bc619bc522d21','2017-08-23 13:08:04','2017-09-18 06:09:39',1,134,0,0,6),
  (63,90,'AsesorUsc','Asesorusc@cojunal.com','38b63e171b918059e9f0d44b55df5ae5','2017-08-23 13:08:17','2017-08-23 13:08:17',0,135,0,0,2),
  (64,0,'CoordinadorUsc_2','coordinadorusc_2@cojumal.com','cbf0da29fa1006f9e2094a247e0b5451','2017-08-30 09:08:21','2017-08-30 09:08:21',1,139,0,0,6),
  (65,62,'AsesorUsc_2','Asesorusc_2@cojunal.com','e64b2ff1d1fef0120e0c441411961c3f','2017-08-30 09:08:03','2017-08-30 09:08:03',0,140,0,0,2),
  (66,69,'ase 01','wilmar.io@gmail.com','d9b1cabb7a8f6e9ef6006e54dfad72a5','2017-09-04 14:09:56','2017-09-04 14:09:56',0,146,0,0,2),
  (67,68,'ase 02','ae@esio.com','b6edfc8a7cde7bb532106c5b0142037f','2017-09-04 14:09:00','2017-09-04 14:09:00',1,147,0,0,2),
  (68,0,'ffgf','sfddsdf@loin.cm','81cf6f22d57b6db7ff36bcec4ba3273a','2017-09-04 14:09:46','2017-09-04 14:09:46',1,148,0,0,6),
  (69,0,'sdsdsd','sdsd@rkp.powc','299290054711912d7faa7c3d51a294de','2017-09-04 14:09:34','2017-09-04 14:09:34',0,149,0,0,6),
  (70,80,'sw','sw@sw.com','616e9c666bc8d06064557ae255f524d6','2017-09-05 12:09:32','2017-09-05 12:09:32',0,150,0,0,2),
  (71,45,'wq','wq@wq.com','96af13115f8217f3e1c1be8c5c414fea','2017-09-05 12:09:08','2017-09-05 12:09:08',0,151,0,0,2),
  (72,0,'pedro','pedro@email.com','002127bf8e5b0d10a653c3b7574a0e5e','2017-09-05 13:09:13','2017-09-05 13:09:13',0,153,0,0,6),
  (73,59,'pedrito','pedrito@email.com','c5c5789509265f6cd690a1e18c91a458','2017-09-05 13:09:35','2017-09-05 13:09:35',0,154,0,0,2),
  (74,77,'AsesorUsc_J','AsesorUsc_J@cojunal.com','2c802d563e3db6c1f7a61ba5bab0fb21','2017-09-05 13:09:03','2017-09-05 13:09:03',0,155,0,0,2),
  (75,72,'AsesorUsc_PJ','AsesorUsc_PJ@cojunal.com','b22c36e66ec168c3cef7c4e2e4d1abbd','2017-09-05 13:09:50','2017-09-05 13:09:50',0,156,0,0,2),
  (76,68,'AsesorUsc_J2','AsesorUsc_J@cojunal.com2','845a5e4fd524062b6dc9ebb51893e3d0','2017-09-05 13:09:45','2017-09-05 13:09:45',0,157,0,0,2),
  (77,0,'CordinadorUsc_J','CordinadorUsc_J@cojunal.com','dc23d5002a84eab78cb9bc5b8b0bb212','2017-09-05 13:09:39','2017-09-05 13:09:39',0,158,0,0,6),
  (78,82,'activo','activo@email.com','ba7e3b8c3a6e3bc875b9e51737fa3518','2017-09-05 13:09:05','2017-09-05 13:09:05',1,159,0,0,2),
  (79,0,'CordinadorUsc_PJ','CordinadorUsc_PJ@cojunal.com','15106275df110d42a6a4ab8b1b14fd83','2017-09-05 13:09:54','2017-09-05 13:09:54',1,160,0,0,6),
  (80,0,'Coordinador_juridico_1','Coordinador_juridico_1@cojunal.com','8f4cc10b23b684f1c89b8413b83ab71f','2017-09-05 14:09:54','2017-09-05 14:09:54',1,161,0,0,6),
  (81,80,'Asesor_juridico_1','Asesor_juridico_1@cojunal.com','42a0fd59f2f3fdf8dde71c4dcef61b21','2017-09-05 14:09:57','2017-09-05 14:09:57',0,162,0,0,2),
  (82,0,'Coordinador_J2','Coordinador_J2@cojunal.com','5af525fcd9fe0875ce96e981320456de','2017-09-05 18:09:46','2017-09-05 18:09:46',1,163,0,0,6),
  (83,0,'Coordinador_PJ2','Coordinador_PJ2@cojunal.com','4e13e53e3f229df88a00f55a5569c043','2017-09-05 18:09:08','2017-09-05 18:09:08',1,164,0,0,6),
  (84,0,'Coordinador_PJ2','Coordinador_PJ2@cojunal.com.co','a3218c16465523ce84b1952c88af8d2d','2017-09-05 18:09:37','2017-09-05 18:09:37',1,165,0,0,6),
  (85,0,'Coordinador_J3','Coordinador_J3@cojunal.com','e14994c2c84062957b0ded59f3537bcb','2017-09-05 18:09:06','2017-09-05 18:09:06',1,166,0,0,6),
  (86,0,'Coordinador_J4','Coordinador_J4@cojunal.com','5af525fcd9fe0875ce96e981320456de','2017-09-05 18:09:46','2017-09-05 18:09:46',1,167,0,0,6),
  (87,0,'López','ing.alelopez@gml.com','8d4b17ced2b4e03fccafcef7091832ef','2017-09-05 18:09:07','2017-09-05 18:09:07',1,169,0,0,2),
  (88,0,'Coordinador_J5','Coordinador_J5@cojunal.com','e4172d122919d809a7ac70517fd9e8c6','2017-09-05 18:09:54','2017-09-05 18:09:54',1,170,0,0,6),
  (89,0,'Coordinador_J6','Coordinador_J6@cojunal.com','231d8c6ee70ea171f99d4d64498db116','2017-09-05 19:09:26','2017-09-05 19:09:26',1,171,0,0,6),
  (90,0,'Cordinador_PJ6','Cordinador_PJ6@cojunal.com','15663f77f97a594347656d5ade797087','2017-09-05 19:09:56','2017-09-05 19:09:56',1,172,0,0,6),
  (91,0,'Coordinador_PJ06','Coordinador_PJ06@cojunal.com','8f136ac015757b29a7dcb026fbfca3f2','2017-09-05 19:09:12','2017-09-05 19:09:12',1,173,0,0,6),
  (92,0,'Asesor_J6','Asesor_J6@cojunal.com','8c246d851906c430f50dc80d179720ad','2017-09-05 19:09:40','2017-09-05 19:09:40',1,174,0,0,2),
  (93,0,'Asesor_PJ6','Asesor_PJ6@cojunal.com','e9d46ee502e8107259e38c07816c3b78','2017-09-05 19:09:58','2017-09-05 19:09:58',1,175,0,0,2),
  (94,95,'Asesor prueba','frt@trf.co','094dab4a33a0d18a4a423a3a16f10fca','2017-09-06 10:09:27','2017-09-06 10:09:27',0,176,0,0,2),
  (95,0,'coordinador prueba','wer@wer.co','32aef5a050557e6045cf7a0b55a9da27','2017-09-06 10:09:39','2017-09-06 10:09:39',1,177,0,0,6),
  (96,0,'Raul','raul@cjnl.com','b8d1ca3cf3d292eb457e42afed383cc0','2017-09-06 10:09:52','2017-09-06 10:09:52',1,178,0,0,6),
  (97,72,'diana','diana@srvc.co','a207988656658fbf529ac0b8778e95cc','2017-09-06 10:09:30','2017-09-06 10:09:30',0,179,0,0,2),
  (98,0,'wilmar cp','ibarguen_cp@hotmail.com','fa1b522f047acb181e428c16d8b68015','2017-09-14 15:09:18','2017-09-14 15:09:18',1,187,0,0,6),
  (99,77,'Wilmar Asesor TEST','wilmar.ibarguen@bluewebfactory.com','405a2e7fb6a97ca387d23605a35f4b50','2017-10-02 14:10:59','2017-10-02 14:10:59',1,195,0,0,2),
  (100,0,'julio','juliocesar.cortes@unisoftsystem.com.co','2eb8522da653e1a8943e7d45ea41e10b','2017-10-18 10:10:11','2017-10-18 10:10:11',1,197,0,0,6);
COMMIT;

#
# Data for the `departaments` table  (LIMIT 0,500)
#

INSERT INTO `departaments` (`idDepartament`, `name`) VALUES 
  (1,'Colombia');
COMMIT;

#
# Data for the `cities` table  (LIMIT 0,500)
#

INSERT INTO `cities` (`idCity`, `name`, `idDepartament`) VALUES 
  (1,'Antioquia',1),
  (2,'Atlántico',1),
  (3,'Bolívar',1),
  (4,'Boyacá',1),
  (5,'Caldas',1),
  (6,'Cauca',1),
  (7,'Cesar',1),
  (8,'Córdoba',1),
  (9,'Cundinamarca',1),
  (10,'Guajira',1),
  (11,'Huila',1),
  (12,'Magdalena',1),
  (13,'Meta',1),
  (14,'Nariño',1),
  (15,'Norte de Santander',1),
  (16,'Quindío',1),
  (17,'Risaralda',1),
  (18,'Santander',1),
  (19,'Sucre',1),
  (20,'Tolima',1),
  (21,'Valle del Cauca',1);
COMMIT;

#
# Data for the `districts` table  (LIMIT 0,500)
#

INSERT INTO `districts` (`idDistrict`, `name`, `idCity`) VALUES 
  (1,'Bello',1),
  (2,'Caldas',1),
  (3,'Copacabana',1),
  (4,'Envigado',1),
  (5,'Guarne',1),
  (6,'Itagui',1),
  (7,'La Ceja',1),
  (8,'La Estrella',1),
  (9,'La Tablaza',1),
  (10,'Marinilla',1),
  (11,'Medellín',1),
  (12,'Rionegro',1),
  (13,'Sabaneta',1),
  (14,'San Antonio de Prado',1),
  (15,'San Cristóbal',1),
  (16,'Caucasia',1),
  (17,'Barranquilla',1),
  (18,'Malambo',1),
  (19,'Puerto Colombia',2),
  (20,'Soledad',2),
  (21,'Arjona',3),
  (22,'Bayunca',3),
  (23,'Carmen de Bolívar',3),
  (24,'Cartagena',3),
  (25,'Turbaco',3),
  (26,'Arcabuco',4),
  (27,'Belencito',4),
  (28,'Chiquinquirá',4),
  (29,'Combita',4),
  (30,'Cucaita',4),
  (31,'Duitama',4),
  (32,'Mongui',4),
  (33,'Nobsa',4),
  (34,'Paipa',4),
  (35,'Puerto Boyacá',4),
  (36,'Ráquira',4),
  (37,'Samaca',4),
  (38,'Santa Rosa de Viterbo',4),
  (39,'Sogamoso',4),
  (40,'Sutamerchán',4),
  (41,'Tibasosa',4),
  (42,'Tinjaca',4),
  (43,'Tunja',4),
  (44,'Ventaquemada',4),
  (45,'Villa de Leiva',4),
  (46,'La Dorada',5),
  (47,'Manizales',5),
  (48,'Villamaria',5),
  (49,'Caloto',6),
  (50,'Ortigal',6),
  (51,'Piendamo',6),
  (52,'Popayán',6),
  (53,'Puerto Tejada',6),
  (54,'Santander Quilichao',6),
  (55,'Tunia',6),
  (56,'Villarica',6),
  (57,'Valledupar',7),
  (58,'Cerete',8),
  (59,'Montería',8),
  (60,'Planeta Rica',8),
  (61,'Alban',9),
  (62,'Bogotá',9),
  (63,'Bojaca',9),
  (64,'Bosa',9),
  (65,'Briceño',9),
  (66,'Cajicá',9),
  (67,'Chía',9),
  (68,'Chinauta',9),
  (69,'Choconta',9),
  (70,'Cota',9),
  (71,'El Muña',9),
  (72,'El Rosal',9),
  (73,'Engativá',9),
  (74,'Facatativa',9),
  (75,'Fontibón',9),
  (76,'Funza',9),
  (77,'Fusagasuga',9),
  (78,'Gachancipá',9),
  (79,'Girardot',9),
  (80,'Guaduas',9),
  (81,'Guayavetal',9),
  (82,'La Calera',9),
  (83,'La Caro',9),
  (84,'Madrid',9),
  (85,'Mosquera',9),
  (86,'Nemocón',9),
  (87,'Puente Piedra',9),
  (88,'Puente Quetame',9),
  (89,'Puerto Bogotá',9),
  (90,'Puerto Salgar',9),
  (91,'Quetame',9),
  (92,'Sasaima',9),
  (93,'Sesquile',9),
  (94,'Sibaté',9),
  (95,'Silvania',9),
  (96,'Simijaca',9),
  (97,'Soacha',9),
  (98,'Sopo',9),
  (99,'Suba',9),
  (100,'Subachoque',9),
  (101,'Susa',9),
  (102,'Tabio',9),
  (103,'Tenjo',9),
  (104,'Tocancipa',9),
  (105,'Ubaté',9),
  (106,'Usaquén',9),
  (107,'Usme',9),
  (108,'Villapinzón',9),
  (109,'Villeta',9),
  (110,'Zipaquirá',9),
  (111,'Maicao',10),
  (112,'Riohacha',10),
  (113,'Aipe',11),
  (114,'Neiva',11),
  (115,'Cienaga',12),
  (116,'Gaira',12),
  (117,'Rodadero',12),
  (118,'Santa Marta',12),
  (119,'Taganga',12),
  (120,'Villavicencio',13),
  (121,'Ipiales',14),
  (122,'Pasto',14),
  (123,'Cúcuta',15),
  (124,'El Zulia',15),
  (125,'La Parada',15),
  (126,'Los Patios',15),
  (127,'Villa del Rosario',15),
  (128,'Armenia',16),
  (129,'Calarcá',16),
  (130,'Circasia',16),
  (131,'La Tebaida',16),
  (132,'Montenegro',16),
  (133,'Quimbaya',16),
  (134,'Dosquebradas',17),
  (135,'Pereira',17),
  (136,'Aratoca',18),
  (137,'Barbosa',18),
  (138,'Bucaramanga',18),
  (139,'Floridablanca',18),
  (140,'Girón',18),
  (141,'Lebrija',18),
  (142,'Oiba',18),
  (143,'Piedecuesta',18),
  (144,'Pinchote',18),
  (145,'San Gil',18),
  (146,'Socorro',18),
  (147,'Sincelejo',19),
  (148,'Armero',20),
  (149,'Buenos Aires',20),
  (150,'Castilla',20),
  (151,'Espinal',20),
  (152,'Flandes',20),
  (153,'Guamo',20),
  (154,'Honda',20),
  (155,'Ibagué',20),
  (156,'Mariquita',20),
  (157,'Melgar',20),
  (158,'Natagaima',20),
  (159,'Payande',20),
  (160,'Purificación',20),
  (161,'Saldaña',20),
  (162,'Tolemaida',20),
  (163,'Amaime',21),
  (164,'Andalucía',21),
  (165,'Buenaventura',21),
  (166,'Buga',21),
  (167,'Buga La Grande',21),
  (168,'Caicedonia',21),
  (169,'Cali',21),
  (170,'Candelaria',21),
  (171,'Cartago',21),
  (172,'Cavasa',21),
  (173,'Costa Rica',21),
  (174,'Dagua',21),
  (175,'El Carmelo',21),
  (176,'El Cerrito',21),
  (177,'El Placer',21),
  (178,'Florida',21),
  (179,'Ginebra',21),
  (180,'Guacarí',21),
  (181,'Jamundi',21),
  (182,'La Paila',21),
  (183,'La Unión',21),
  (184,'La Victoria',21),
  (185,'Loboguerrero',21),
  (186,'Palmira',21),
  (187,'Pradera',21),
  (188,'Roldanillo',21),
  (189,'Rozo',21),
  (190,'San Pedro',21),
  (191,'Sevilla',21),
  (192,'Sonso',21),
  (193,'Tulúa',21),
  (194,'Vijes',21),
  (195,'Villa Gorgona',21),
  (196,'Yotoco',21),
  (197,'Yumbo',21),
  (198,'Zarzal',21);
COMMIT;

#
# Data for the `campaigns` table  (LIMIT 0,500)
#

INSERT INTO `campaigns` (`idCampaign`, `name`, `companyName`, `idNumber`, `address`, `contactName`, `contactEmail`, `percentageCommission`, `interest`, `fees`, `valueService1`, `valueService2`, `comments`, `fCreacion`, `dUpdate`, `passwd`, `idAdviser`, `idDistrict`, `active`, `phone`) VALUES 
  (42,'COLOMBINA','COLOMBINA S.A.S','890301884-5','CARRERA 1 #24-56','KELLY ARBOLEDA','CARTERACOLOMBINA1@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 16:06:51','2017-06-29 16:06:51','8ff75e927d520e435a4d23569ecf2a57',40,169,1,'28861921'),
  (43,'TEAM','TEAM FOOD ','860000006-4','AUTOPISTA SUR #57-21','ALEXANDRA RAMIREZ','CARTERATEAMFOOD@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE ','2017-06-29 17:06:59','2017-06-29 17:06:59','905926b4ac06d236999aa1881918d224',40,62,1,'7709000'),
  (44,'JANIROX','JANIROX','900197421-8','CARRERA 27 # 12A-21','RUBEN DARIO JARAMILLO','CARTERAJANIROX@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 17:06:19','2017-06-29 17:06:19','e5ca205624d8bd1d43322749ba5b2d09',40,62,1,'2378212'),
  (45,'MEDICAL PFARMACEUTICAL','PHARMACEITICAL','900318758-5','CARRERA 30 # 86-47','WILSON HERRERA','CARTERAPHARMA@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 17:06:26','2017-06-29 17:06:26','67535b6f44cb291c56100e1569f3746b',40,62,1,'7435402'),
  (46,'FABRICATO','FABRICATO','890900308-4','CARRERA 50 # 38-32','CARLOS BOLIVAR ','CARTERAFABRICATO@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE ','2017-06-29 17:06:16','2017-06-29 17:06:16','2da48d207fbc26c0ae8ca9ed34510274',40,62,1,'3108287464'),
  (47,'CALASANZ','COLEGIO CALASANZ','860014710-2','CARRERA 23 # 73A-10','SANDRA CORONADO ','CALAZANSCOLE@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 18:06:46','2017-06-29 18:06:46','fb48e1281ef7c8d7a01933bcf535bb58',40,62,1,'6774118'),
  (48,'EUROPARTES','EUROPARTES IMPORTACIONES GAM SAS','900716988-1','CALLE 17 # 103B-81','ALVARO ARTURO SANDOVAL SANTOS','CARTERAEUROPARTES1@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 19:06:13','2017-06-29 19:06:13','81b51e0591e0f441c3589cb73d550f1a',40,62,1,'4744238'),
  (49,'ANTEK','ANTEK SAS','830058286-0','CALLE 25B # 85B-54','CASTRO NUÑEZ HENRY EDUARDO ','CARTERANTEK@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-29 19:06:33','2017-06-29 19:06:33','77c9d07147d820a9cbc262f90a3c2b98',40,62,1,'79628982'),
  (51,'JOHNSON','JOHNSON & JOHNSON S.A','890101815-9','CALLE 15 # 31-146 URBANIZACIÓN ACOPI','ESTELLA GUZMAN ','CARTERAJHONSON@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-30 08:06:03','2017-06-30 08:06:03','b61efe8393ef3e0d1e63d61f22180968',40,169,1,'265413229'),
  (52,'ARYSTA','ARYSTA LIFESCIENCE COLOMBIA SAS','860022207-2','CALLE 127 # 17A - 30 ','PATRICIA UYAZAN','CARTERARYSTA@GMAIL.COM',0,0,0,22222,0,'CARTERA VIGENTE','2017-06-30 08:06:04','2017-07-19 07:07:50','03034f42955d159bc7a7a6e35c1e7c1a',40,62,1,'3134156724'),
  (53,'METALES ESTRUCTURALES','METALES ESTRUCTURALES','830075260-1','CALLE 8 # 29 - 44','LUIS MARTINEZ','CARTERAMETALES1@GMAIL.COM',0,0,0,0,0,'ACTIVO CARTERA VIGENTE','2017-06-30 09:06:21','2017-06-30 11:06:36','35fea0d2592dd964f1deb258c2c2a884',40,62,1,'310331517'),
  (54,'TECNOQUIMICAS','TECNOQUIMICAS SA','890300466-5','CALLE 23 # 7 - 39 ','PAULA PERALTA','CARTERATECNOQUIMICAS1@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-30 09:06:30','2017-06-30 11:06:56','e242417e3bf43aa05c561eea4595b262',40,169,1,'24483500'),
  (55,'BRINKS ','BRINKS DE COLOMBIA S.A','860350234-8','AV CALLE 26 # 96J-90 PISO 8','JUAN CAMILO AYALA','CARTERABRINKS1@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE','2017-06-30 12:06:38','2017-06-30 14:06:11','376843055c83a0630197405134407725',40,62,1,'7449400'),
  (56,'HECTOR FERNANDO ','HECTOR FERNANDO ','80136490','CALLE DE LAS COMETA','HECTOR FERNANDO GARCIA','carterahecto@gmail.com',0,0,0,0,0,'CARTERA VIGENTE','2017-07-04 09:07:47','2017-07-04 17:07:56','06696514895cc22aa72b9f008e2e8444',40,79,1,'3188896886'),
  (57,'MARIO RAMIREZ','MARIO RAMIREZ','19176391-1','CRESPO CALLE 67 # 6-19 APARTAMENTO 301','MARIO RAMIREZ','CARTERAMARIORAMIREZ@GMAIL.COM',0,0,0,0,0,'CARTERA VEGENTE ','2017-07-13 11:07:53','2017-07-13 11:07:53','3d0f7149f4927d18aa1cf551d7f7c382',42,24,1,'3157433633'),
  (58,'JOSE IGNACIO REINA VELEZ ','JOSE IGNACIO REINA VELEZ ','6035413','CARRERA 2 B OESTE 15-15 APARTAMENTO 703 ','JOSE IGNACIO REINA VELEZ ','CARTERAIGNACIO@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE ','2017-07-17 17:07:27','2017-07-17 17:07:27','39d98a6fd7dcd82f60aec01b5f9e4b06',40,169,1,'3154181634'),
  (59,'DISCLINICAS','DISTRIBUCIONES CLINICAS SOCIEDAD ANONIMA DISCLINICA S.A','800005727-0','CARRERA 49 C 80 166','ELSY MARIA VELAZQUEZ CABALLERO','CARTERADISCLINICA@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE ','2017-07-18 15:07:08','2017-07-19 07:07:40','71091f9b1f5db242992984d708f5a4cf',42,17,1,'3782201'),
  (60,'AGROCARGA','AGROCARGA INTERNACIONAL S A S','860350563','carrera 100 No 26 - 35 piso 3','CARLOS ANTONIO ESPINOSA','carteragrocarga@gmail.com',0,0,0,0,0,NULL,'2017-07-19 11:07:42','2017-07-19 11:07:42','986264622c2e7894ddd95aa57778d7de',42,62,1,'3188268337'),
  (61,'NESTLE','NESTLE DE COLOMBIA S.A.','860002130','DG 92 17 A 42','SANDRA TAUTA ','carteranestle@gmail.com',0,0,0,0,0,NULL,'2017-07-19 11:07:01','2017-07-19 11:07:01','9d0e08af7413a379139bfb4c24a8941a',40,62,1,'5219000'),
  (62,'ICARO ','ICARO DIECISIETE SAS','800089040','AV CR 9 113 52 OF 1008','CESAR CARRERO','carteraicaro17@gmail.com',0,0,0,0,0,NULL,'2017-07-19 14:07:46','2017-07-19 14:07:46','af529f8a9cbad78fdc0375a6ecb7b5cb',40,62,1,'6374766'),
  (63,'AEROFLEX S.A.S','AROFLEX S.A.S','900379440-1','CARRERA 16A #79-05 CHICO BOGOTA OFICINA 506','ALEJANDRO FLOREZ ','CARTERAEROFLEX@GMAIL.COM',0,0,0,0,0,'CARTERA VIGENTE ','2017-07-24 08:07:56','2017-07-24 08:07:56','187c6cb85eba62d4a6249cf423412d7b',40,62,1,'3341134'),
  (64,'PRUEBA','PRUEBA','8888888','CALL','NADIE','CARTERA',0,0,0,0,0,'CAMPAÑA','2017-08-23 11:05:22','0000-00-00 00:00:00','2222222',45,62,1,'014620116'),
  (65,'PRUEBA','PRUEBA','555555555','CALLE','5555555','info@info.com',0,0,0,0,0,'fdsfdsfsfsdfsfsd','2017-08-24 09:08:25','2017-08-24 09:08:25','67a64040a49e15937fc17b5b5ebc12c2',40,5,1,'014620116'),
  (72,'wilmar test','1','123','1','1','programaticaexcel@gmail.com',456,75,74,100,150,'1','2017-08-31 11:08:03','2017-08-31 11:08:03','97ddfd6922662409f78ea09c0bb2e24e',58,1,1,'1'),
  (73,'Cliente_usc','1','900001','1','1','josediaz78963@gmail.com',10,0.2,1500000,150000,0,'1','2017-09-06 16:09:26','2017-09-06 16:09:26','56ce6b5fcbc68167144be28512fa292c',58,1,1,'1'),
  (74,'wilmar qentek','1','00001','1','1','wilmar.ibarguen@qentek.com',0.9,0.5,0.7,0,0,'1','2017-09-06 16:09:17','2017-09-06 16:09:17','7b91d01ccf1a44ca572adb6875a43673',58,1,1,'1'),
  (75,'w','1','0','1','1','w@2.xom',0,0,0,0,0,'1','2017-09-06 16:09:30','2017-09-06 16:09:30','dda47f0fb9fbba84262ea588349e0130',58,1,1,'1'),
  (76,'w','1','0','1','1','wrtrr@2.xom',0,0,0,0,0,'1','2017-09-06 16:09:58','2017-09-06 16:09:58','ae93d33f613de4c6f1b85d98a5c9665f',58,1,1,'1'),
  (77,'w','1','0','1','1','wrtrdsar@2.xom',0,0,0,0,0,'1','2017-09-06 16:09:14','2017-09-06 16:09:14','9f7aa58e627da59c9e981f52da5d3221',58,1,1,'1'),
  (78,'w','1','0','1','1','wewqertrdsar@2.xom',0,0,0,0,0,'1','2017-09-06 16:09:38','2017-09-06 16:09:38','ec0d0ba836c2868115d946fdb32dedce',58,1,1,'1'),
  (79,'DISCLINICAS','1','800005727-0','1','1','CARTERADISCLINICA@GMAIL.COM',0,0,0,0,0,'1','2017-09-13 10:09:15','2017-09-13 10:09:15','dec8bf33e5022b55dfab85addcb7a82d',59,1,1,'1'),
  (80,'Wilmar Quentek','1','000000','1','1','wilmar.ibarguen@quentek.com',0.05,0.12,0.05,0,0,'1','2017-09-15 14:09:42','2017-09-15 14:09:42','4421c72b4ea29deb8d3041efcb87f5ce',58,1,1,'1'),
  (81,'Cliente5_usc','1','9000005','1','1','hhhhkjh@ff.com',2,1,3,0,0,'1','2017-09-18 08:09:08','2017-09-18 08:09:08','e4494091a225fdc33a85603810519a22',63,1,1,'1'),
  (82,'Cliente6_usc','1','900006','1','1','cesar.lombana@unisoftsystem.com.co',10,12000,150000,0,0,'1','2017-09-18 08:09:00','2017-09-18 08:09:00','6c19f65346943860e043b333aed1869f',58,1,1,'1'),
  (83,'Buustag','1','900007','1','1','buustag@gmail.co',10,14000,20000,0,0,'1','2017-09-19 12:09:03','2017-09-19 12:09:03','c4dd46c6015becdd10c6df5f285da81f',58,1,1,'1'),
  (84,'RTF','1','900008','1','1','josediaz78963@hotmail.com',10,13000,15000,0,0,'1','2017-09-19 12:09:06','2017-09-19 12:09:06','e83b8e9108afb8f5e8713f741da88df5',58,1,1,'1'),
  (85,'Lafayete','1','90000010','1','1','josediaz78964@hotmail.com',10,23999,34000,0,0,'1','2017-09-19 14:09:37','2017-09-19 14:09:37','7c1b4dd0144c879bf2852c8975db4741',58,1,1,'1'),
  (86,'Jose Diaz 79865','1','900003','1','1','josediaz78965@gmail.com',20,10,15000,0,0,'1','2017-09-26 10:09:29','2017-09-26 10:09:29','45db16fa7885a08f9115ce59b1ba8ace',58,1,1,'1'),
  (87,'Jhon Castro','1','900.999.991','1','1','johnkstro@gmail.com',10,55,555,0,0,'1','2017-10-04 16:10:09','2017-10-04 16:10:09','6f5507dfc9d64ec0dbc1828c96d43526',58,1,1,'1');
COMMIT;

#
# Data for the `advisers_campaigns` table  (LIMIT 0,500)
#

INSERT INTO `advisers_campaigns` (`idAvidsersCampaign`, `idAdvisers`, `idCampaign`, `comment`) VALUES 
  (1,42,43,'CARTERA CON APROXIMADAMENTE $ 3600000000 MILLONES. DEDUDORES RENUENTES A PAGOS. EMPECEMOS A GESTIONAR PARA CUMPLOI CON METAS MENSUALES. '),
  (2,42,52,NULL),
  (3,42,54,NULL),
  (4,42,49,NULL),
  (5,41,55,NULL),
  (6,41,47,NULL),
  (8,41,49,NULL),
  (9,42,45,NULL),
  (10,42,51,NULL),
  (11,40,44,NULL),
  (12,40,42,NULL),
  (13,40,48,NULL),
  (14,40,53,NULL),
  (19,40,56,'CAMPAÑA CON UN SOLO DEUDOR'),
  (20,40,46,'cartera los colores '),
  (21,42,58,'CAMPAÑA CON UN SOLO CLIENTE '),
  (22,44,42,NULL),
  (23,40,43,NULL),
  (24,44,44,NULL),
  (25,45,46,'prueba');
COMMIT;

#
# Data for the `wallets` table  (LIMIT 0,500)
#

INSERT INTO `wallets` (`idWallet`, `idNumber`, `capitalValue`, `feeValue`, `interestsValue`, `dAssigment`, `dUpdate`, `dCreate`, `legalName`, `address`, `phone`, `email`, `idDistrict`, `idStatus`, `product`, `idAdviser`, `currentDebt`, `titleValue`, `validThrough`, `prescription`, `accountNumber`, `negotiation`, `vendorEmail`, `vendorName`, `vendorPhone`, `type`) VALUES 
  (5335,'1058228762',18919097,3783819.4,472977.425,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','MAYERLY ANDREA ARREDONDO','CARRERA 13 No 4 25','8598030','mayerly589@gmail.com',62,1,'BIENES',40,NULL,0,'2015-05-25','2017-05-25','18119',NULL,NULL,NULL,NULL,1),
  (5336,'1094905106',3570000,714000,89250,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','JULIO CESAR OCAMPO','ETAPA5 MZ P CASA406B ','7343719','juliocastro.1905@outlook.es',62,1,'BIENES',40,NULL,0,'2016-05-17','2018-05-17','18063',NULL,NULL,NULL,NULL,1),
  (5337,'1140842763',904154,180830.8,22603.85,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','JHON JAIRO TORRES','CALLE 61 No 23 71','3028545','',62,1,'BIENES',40,NULL,0,'2016-04-30','2018-04-30','18072',NULL,NULL,NULL,NULL,1),
  (5338,'1143228740',2176501,435300.2,54412.525,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','KAROL MARGARITA CASTRO','CRA 16F 45G13','3108240852','dorianjota@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-05-31','2017-05-31','14501',NULL,NULL,NULL,NULL,1),
  (5339,'12436973',5775465,1155093,144386.625,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','EDGAR EMILIO REMICIO CAMARGO','CL 27 5 A 125','3013135142','edemrec@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-07-15','2017-07-15','14722',NULL,NULL,NULL,NULL,1),
  (5340,'12712752',11708471,2341694.2,292711.775,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','LOZANO JUAN MANUEL','CL 8   9  29','321 5889750','MONICALOZANO95@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-03-06','2017-03-06','14456',NULL,NULL,NULL,NULL,1),
  (5341,'147395',23863458,4772691.6,596586.45,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','EUTIMIO ANTONIO ADARVE VARGAS','CARRERA 7 No 1348','3348129','',62,1,'BIENES',40,NULL,0,'2016-04-16','2018-04-16','18073',NULL,NULL,NULL,NULL,1),
  (5342,'15621888',4096516,819303.2,102412.9,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','GOMEZ ZULUAGA CARLOS ADRIAN ','CL 4 6 95 SEC EL CENTRO ','3148789616','AYGX100PRE22 @HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-01-08','2017-01-08','17845',NULL,NULL,NULL,NULL,1),
  (5343,'1649998',13119609,2623921.8,327990.225,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','ALEXANDER MARTINEZ','CR 3B  14 A 159 PISO 1','6875579','',62,1,'BIENES',40,NULL,0,'2015-10-24','2017-10-24','16003',NULL,NULL,NULL,NULL,1),
  (5344,'24727469',18671861,3734372.2,466796.525,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','ANA DILIA GONZALEZ','CRR 17 No 12 10','3215675455','comercialocomed@gmail.com',62,1,'BIENES',40,NULL,0,'2015-11-05','2017-11-05','18038',NULL,NULL,NULL,NULL,1),
  (5345,'35262461',3130112,626022.4,78252.8,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','MARIA TERESA PAMPLONA ','CLL 2B N 34 30 CASA ','3142180011','',62,1,'BIENES',40,NULL,0,'2015-03-26','2017-03-26','18075',NULL,NULL,NULL,NULL,1),
  (5346,'36181353',40032785,8006557,1000819.625,'2017-06-29','2017-07-18 12:30:05','2017-06-29 21:59:49','RINCON CUARTAS AMPARO DEL SOCORRO ','CRA 21 N13 21','5200734','MARIA.TRIJULLO@ALIANZAFARMACEUTICA.COM',62,5,'BIENES',44,NULL,0,'2016-03-02','2018-03-02','12450',NULL,NULL,NULL,NULL,1),
  (5347,'3906324',30486578,6097315.6,762164.45,'2017-06-29','2017-07-18 12:32:26','2017-06-29 21:59:49','JONATHAN DAVID MARTINEZ CORREA','CR 22 No 17 32','3017661890','jonathan_siervo@hotmail.com?',62,5,'BIENES',44,NULL,0,'2015-04-13','2017-04-13','14398',NULL,NULL,NULL,NULL,1),
  (5348,'40341277',4790083,958016.6,119752.075,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','SILVA QUICENO LAURA HELENA','CL 9 20 26','3105761523','cato.73@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-10-31','2017-10-31','16027',NULL,NULL,NULL,NULL,1),
  (5349,'40926057',15568332,3113666.4,389208.3,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','ALVARADO MEJIA YOLETH BRATIZ ','CLL 14 N 7 53 ','3008171711','',62,1,'BIENES',40,NULL,0,'2016-03-10','2018-03-10','17052',NULL,NULL,NULL,NULL,1),
  (5350,'55304037',39814528,7962905.6,995363.2,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','EYDIM JOHANA LOPEZ','CARRERA 15 No 10 15','3005280134','JHONL2324@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-05-12','2018-05-12','18060',NULL,NULL,NULL,NULL,1),
  (5351,'580870475',1000000,200000,25000,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','MINI MERCADO EXPRES ','CLL 6 N 15 56 BARRIO POLAR','3122957879','MARYLZ1@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-02-22','2017-02-22','17154',NULL,NULL,NULL,NULL,1),
  (5352,'63252389',12984261,2596852.2,324606.525,'2017-06-29','2017-07-18 12:32:57','2017-06-29 21:59:49','HERNANDEZ LEMA MARIA EUGENIA','CARRERA 4a No 28 32','3206668115','frutifreshna@gmail.com',62,5,'BIENES',44,NULL,0,'2016-04-29','2018-04-29','18064',NULL,NULL,NULL,NULL,1),
  (5353,'63335516',8989726,1797945.2,224743.15,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','LUZ MARINA MOROS','CRA 43  32  106','3126838134','LUZMARINAMOROS776@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2014-10-06','2016-10-06','14512',NULL,NULL,NULL,NULL,1),
  (5354,'70290904',5041685,1008337,126042.125,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','LUIS ARMANDO LOPEZ GIL ','CRA 42A N 296A SUR  168 INT 301','3007114880','',62,1,'BIENES',40,NULL,0,'2016-05-24','2018-05-24','18024',NULL,NULL,NULL,NULL,1),
  (5355,'71363170',10396425,2079285,259910.625,'2017-06-29','2017-07-06 14:45:32','2017-06-29 21:59:49','CARLOS ANDRES CORREAN ','CLL 21  21 31 SAN CARLOS ','3174596915','EWILADU84@YAHOO.ES ',62,2,'BIENES',40,NULL,0,'2015-11-23','2017-11-23','12045',NULL,NULL,NULL,NULL,1),
  (5356,'71767082',3912231,782446.2,97805.775,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49',' TOBON PUERTA DUVIAN MANUEL ','CLL 56 N 50 145','2310924','',62,1,'BIENES',40,NULL,0,'2015-05-05','2017-05-05','17189',NULL,NULL,NULL,NULL,1),
  (5357,'72040948',2366290,473258,59157.25,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','MIGUEL ANGEL GIRALDO QUINTERO ','CLL 17 N 4 49','3165268853','VELMAR_711@GMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-04-19','2018-04-19','18023',NULL,NULL,NULL,NULL,1),
  (5358,'73548726',51530891,10306178.2,1288272.275,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','JHON JAIRO BUELVAS MALO','FUNDACION','3126955201','',62,1,'BIENES',40,NULL,0,'2015-04-30','2017-04-30','18071',NULL,NULL,NULL,NULL,1),
  (5359,'77181497',19800000,3960000,495000,'2017-06-29','2017-07-18 12:33:19','2017-06-29 21:59:49','CARLOS SILVA DISTRIBUCIONES ','CRA 166 N 23 32 BRR SIMON BOLIVAR  CLL 16B CRA 8 ','3116829528','CARLOSSOLVAZULETA@HOTMAIL.COM',62,5,'BIENES',44,NULL,0,'2015-08-13','2017-08-13','10256',NULL,NULL,NULL,NULL,1),
  (5360,'80236620',5885735,1177147,147143.375,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','HENRY WERNEY ACEVEDO CASTELLANOS','CALLE 54 C SUR 95 A 18','3114844664','PAPELERIAUNIMAGIC@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-12-31','2018-12-31','14344',NULL,NULL,NULL,NULL,1),
  (5361,'900206882',54257127,10851425.4,1356428.175,'2017-06-29','2017-07-18 12:31:55','2017-06-29 21:59:49','CELK MERCADEO INVERSIONES E U','CLL 12B 1661 APTO 1','3205316568','CELKHERNANDEO@HOTMAIL.COM',62,5,'BIENES',44,NULL,0,'2016-12-31','2018-12-31','18033',NULL,NULL,NULL,NULL,1),
  (5362,'900333984',2000000,400000,50000,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','TRANSPORTES EL TESORO SAS ','CLL 40 E SUR 32 26','3217278014','LEIDYC.LAR@GMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-12-26','2017-12-26','12356',NULL,NULL,NULL,NULL,1),
  (5363,'900439707',110831798,22166359.6,2770794.95,'2017-06-29','2017-07-19 08:10:30','2017-06-29 21:59:49','COMERCIALIZADORA ICE CITY','AVENIDA 42 N 30 B 21 ','6829492','comercializadoraicecity@hotmail.com',62,2,'BIENES',40,NULL,0,'2016-02-01','2018-02-01','18132',NULL,NULL,NULL,NULL,1),
  (5364,'900872915',45116164,9023232.8,1127904.1,'2017-06-29','2017-07-21 13:56:04','2017-06-29 21:59:49','LA GRAN TIENDA DISTRUBUCIONES SAS','KILIMETRO 7 VIA GIRON  CRR 13 N5779','6199174','',62,5,'BIENES',44,NULL,0,'2015-12-31','2017-12-31','17007',NULL,NULL,NULL,NULL,1),
  (5365,'92521535',17450155,3490031,436253.875,'2017-06-29','2017-06-29 21:59:49','2017-06-29 21:59:49','LORA ALVAREZ ROGER FRANCISCO','CLL  30 27 08','3226509223','',62,1,'BIENES',40,NULL,0,'2016-04-07','2018-04-07','17087',NULL,NULL,NULL,NULL,1),
  (5366,'1020802265',1710137,342027.4,42753.425,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','SANCHEZ GOMEZ YULI KATHERIN','CRA 65 57F 51 SUR','3103446771','katerins23@hotmail.com',62,1,'BIENES ',40,NULL,0,'2015-11-28','2017-11-28','24020675',NULL,NULL,NULL,NULL,1),
  (5367,'10544341',12371031,2474206.2,309275.775,'2017-06-29','2017-07-19 13:46:24','2017-06-29 22:04:58','VELASCO MU¾OZ JOHN CARLOS','CRA 27 No. 35 33','3173430578','jamolina @uniquindio.edu.co',129,5,'BIENES',44,NULL,0,'2014-02-21','2016-02-21','50780',NULL,NULL,NULL,NULL,1),
  (5368,'1073151191',714373,142874.6,17859.325,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','JHON FREDY VIZCAINO MORALES','CRA 30 74 -64','3202337169','',62,1,'BIENES',40,NULL,0,'2015-09-12','2017-09-12','27020110',NULL,NULL,NULL,NULL,1),
  (5369,'11408647',9725543,1945108.6,243138.575,'2017-06-29','2017-07-19 10:02:52','2017-06-29 22:04:58','CARLOS HUMBERTO PADILLA NEIRA','CRA 13 N 14 60 LOCAL 1','3203723127','',67,5,'BIENES',44,NULL,0,'2014-01-25','2016-01-25','24020476',NULL,NULL,NULL,NULL,1),
  (5370,'19287321',5034338,1006867.6,125858.45,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','ESTUPI¾AN ROJAS JOSE ANTONIO','CL 43 No. 6 12','3212326383','paniicadorasanantoniotunja@yahoo.es',43,1,'BIENES',40,NULL,0,'2016-12-18','2018-12-18','24020368',NULL,NULL,NULL,NULL,1),
  (5371,'23810227',1743285,348657,43582.125,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','RINCON YARA ELIZABETH','CL 23 No. 05 L 01','3142296339','',34,1,'BIENES',40,NULL,0,'2015-04-27','2017-04-27','24020723',NULL,NULL,NULL,NULL,1),
  (5372,'63558582',1469096,293819.2,36727.4,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','ARGUELLO CERPA ERIKA','CR 22 NO 46 B-08','6942412','ecosandeliciosopan@yahoo.com',138,1,'BIENES',40,NULL,0,'2016-01-10','2018-01-10','27020223',NULL,NULL,NULL,NULL,1),
  (5373,'74244617',747605,149521,18690.125,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','GAMBOA BELTRAN ALFONSO','CL 68 C 8 SUR 11 CRA 19 5 77','33132495985','',62,1,'BIENES',40,NULL,0,'2015-11-18','2017-11-18','24020296',NULL,NULL,NULL,NULL,1),
  (5374,'7456345',27270861,5454172.2,681771.525,'2017-06-29','2017-07-19 10:49:08','2017-06-29 22:04:58','VARGAS ESPINOSA JAIME ARTURO','CRA 6 No. 19 A 48','301686356','distribucionesjr@hotmail.com',57,5,'BIENES',40,NULL,0,'2016-07-14','2018-07-14','436142',NULL,NULL,NULL,NULL,1),
  (5375,'75068938',368746,73749.2,9218.65,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','MU¾OZ HURTADO HUGO','CRA 35No. 100B 39','3207260007','hugomhurtado2006@hotmail.com',47,1,'BIENES',40,NULL,0,'2016-01-27','2018-01-27','29020094',NULL,NULL,NULL,NULL,1),
  (5376,'79209103',3572794,714558.8,89319.85,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','VASQUEZ LADINO PABLO CESAR','CL 57B No. 68A 29 SUR','3126699411','carmeng710@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-08-30','2017-08-30','24020038',NULL,NULL,NULL,NULL,1),
  (5377,'80450756',649431,129886.2,16235.775,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','MARTINEZ GIL HILDA','CR 68B 67 01 BELLAVISTA','3115810218','nelsonbarbosa276@gmail.com',62,1,'BIENES',40,NULL,0,'2015-08-25','2017-08-25','24020253',NULL,NULL,NULL,NULL,1),
  (5378,'830049285',6834734,1366946.8,170868.35,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','PRODUCTOS ALIMENTICIOS PAQUITO SAS','CL 75 No. 69Q 22','3168752213','yolandap4@hotmail.com',62,1,'BIENES',40,NULL,0,'2016-01-09','2018-01-09','24020226',NULL,NULL,NULL,NULL,1),
  (5379,'900173510',7551500,1510300,188787.5,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','DISTRIBUIDORA BOGOTA TCB LTDA','CL 03 No. C 9 76 ','3132490129','pabloemendezt@hotmail.com',62,1,'BIENES',40,NULL,0,'2014-12-30','2016-12-30','884301',NULL,NULL,NULL,NULL,1),
  (5380,'9002785927',25483827,5096765.4,637095.675,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','JHON ARLISON CHAPPARRO LEON','CR 7 No.19A-40','5714051','inversionesfavipan@hotmail.com',57,1,'BIENES',40,NULL,0,'2016-07-13','2018-07-13','14273',NULL,NULL,NULL,NULL,2),
  (5381,'900353794',19439608,3887921.6,485990.2,'2017-06-29','2017-07-19 10:26:13','2017-06-29 22:04:58','INDUSTRIAS INDUPAN SAS','CL 44 No. 18D 100','3135446629','inversionesfavipan@hotmail.com',57,5,'BIENES',40,NULL,0,'2012-01-21','2014-01-21','50020030',NULL,NULL,NULL,NULL,1),
  (5382,'900412995',5570588,1114117.6,139264.7,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','TYS PET SAS','CRA 7 No. 16 78 LC 1021','3155564764','amesotom@hotmail.com',169,1,'BIENES',40,NULL,0,'2014-10-01','2016-10-01','50791',NULL,NULL,NULL,NULL,1),
  (5384,'900849288',7242738,1448547.6,181068.45,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','MERKADISTRIBUCIONES SAS','CL 29F  No. 04 18','3219818862','merkadistribuciones@hotmail.com',97,1,'BIENES',40,NULL,0,'2016-11-15','2018-11-15','24021370',NULL,NULL,NULL,NULL,1),
  (5385,'94529101',2500000,500000,62500,'2017-06-29','2017-06-29 22:04:58','2017-06-29 22:04:58','JOSE RAUL HENAO SOTO','CRA 10 No. 1 295','3113512484','',181,1,'BIENES',40,NULL,0,'2016-04-29','2018-04-29','25020065',NULL,NULL,NULL,NULL,1),
  (5386,'22518962',7071000,1414200,176775,'2017-06-29','2017-06-29 22:16:58','2017-06-29 22:16:58','COMERCIALIZADORA GAMOPE SAS','MZ F CASA 14 URB VILLA DEL MAR','3008426790','kjperea45@hotmail.com',118,1,'BIENES',40,NULL,0,'2014-09-15','2016-09-15','14439',NULL,NULL,NULL,NULL,1),
  (5387,'900240160',2000000,400000,50000,'2017-06-29','2017-06-29 22:16:58','2017-06-29 22:16:58','CORPORACION AGENCIA DE DESARROLLO ECONOMICO LOCAL DEL COMPLEJO CENAGOSO DE LA ZAPATOSA ','CRA 19  A2  10 20','3205112555','njudithramirez@hotmail.com',57,1,'BIENES',40,NULL,0,'2015-09-16','2017-09-16','14472',NULL,NULL,NULL,NULL,1),
  (5388,'1013598482',8751034,1750206.8,218775.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DIEGO ARMANDO ROCHA MORCOTE','CL 58 SUR 19 A 15 IN 9 ','4518414','',62,1,'SERVICIO',40,NULL,0,'2013-07-28','2015-07-28','14587',NULL,NULL,NULL,NULL,1),
  (5389,'1020420118',11424768,2284953.6,285619.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MESA GALVIS DIOVER JOHAN ','CALLE 33 F No 19 63','2796417','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14822',NULL,NULL,NULL,NULL,1),
  (5390,'10262979',1178239,235647.8,29455.975,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FRANCISCO JAVIER BERNAL','CALLE 34 No 11 37 43','3142510436','luzkarina-310@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-02-24','2014-02-24','14612',NULL,NULL,NULL,NULL,1),
  (5391,'1033688233',11665825,2333165,291645.625,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CORDOBA  MORENO  ANDERSON STEVEN ','CL 22  12 12','4422762','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14809',NULL,NULL,NULL,NULL,1),
  (5392,'106260265',48562412,9712482.4,1214060.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ANDRES FELIPE RENDON RAMIREZ','CALLE 12 No   13 69 LC 107 ','3106196420','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14645',NULL,NULL,NULL,NULL,1),
  (5393,'1089479999',3548206,709641.2,88705.15,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CARLOS ALBERTO MUOZ MARTINEZ','CL 16 No 4 12','3166549351','',62,1,'SERVICIO',40,NULL,0,'2013-03-30','2015-03-30','14589',NULL,NULL,NULL,NULL,1),
  (5394,'1090399095',3137416,627483.2,78435.4,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SUAREZ CHACON RICARDO ANDRES  ','CALLE 22  No 3 9','3208107011','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14889',NULL,NULL,NULL,NULL,1),
  (5395,'1090415807',6664346,1332869.2,166608.65,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ANYI VANESA GRIMALDO COLLANTES ','CLL 65B   4C 09 L 08 09','5873283','',62,1,'SERVICIO',40,NULL,0,'2013-05-12','2015-05-12','14750',NULL,NULL,NULL,NULL,1),
  (5396,'1093763522',5899588,1179917.6,147489.7,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BOTERO RINCON JOSE AICARDO ','CLL 7   11   63','6489526','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14878',NULL,NULL,NULL,NULL,1),
  (5397,'1094893614',31168874,6233774.8,779221.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ARBELAEZ  OSPINA QUELIN JULIETH ','CALLE 45 No 1 0  CASA 10','6523342','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14832',NULL,NULL,NULL,NULL,1),
  (5398,'1095816722',3717398,743479.6,92934.95,'2017-06-29','2017-07-13 16:08:16','2017-06-29 23:35:24','CALDERON CASTELLANOS RICARDO ANDRES ','CALLE 90 No 21 87   CALLE 105A No 21 30','6943680','',62,2,'SERVICIO',40,NULL,0,'2013-10-05','2015-10-05','13958',NULL,NULL,NULL,NULL,1),
  (5399,'1095909642',749000,149800,18725,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ERICKA PAOLA REMOLINA FLORES','MZ 1 CA 1 LOS MANDARINOS','2778261','',62,1,'SERVICIO',40,NULL,0,'2013-09-26','2015-09-26','14622',NULL,NULL,NULL,NULL,1),
  (5400,'1098648945',9792254,1958450.8,244806.35,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','VILLAMIZAR JULIO CESAR  ','CL 59  49 55','3014818314','',62,1,'SERVICIO',40,NULL,0,'2013-03-15','2015-03-15','14024',NULL,NULL,NULL,NULL,1),
  (5401,'12229677',2000001,400000.2,50000.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ARBEY SARRIA GOMEZ','CARRERA 1 No 74 36','3107876627','ESKNDALO2005@HOTMAIL COM',62,1,'SERVICIO',40,NULL,0,'2014-11-16','2016-11-16','14613',NULL,NULL,NULL,NULL,1),
  (5402,'12277317',11005398,2201079.6,275134.95,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CARLOS ARTURO SANCHEZ CERQUERA','CRA 12 No 1B 41','2735975','dianita1023@hotmail com',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14644',NULL,NULL,NULL,NULL,1),
  (5403,'13259470',6828874,1365774.8,170721.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CARDENAS JESUS MARIA','AV 5 No 18 40','3145559670','wayneal5880@gmail com',62,1,'SERVICIO',40,NULL,0,'2014-01-20','2016-01-20','14827',NULL,NULL,NULL,NULL,1),
  (5404,'13364909',33425799,6685159.8,835644.975,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','AREVALO RINCON LUIS ENRRIQUE  ','AV 7 No 15 36','3106139132','dgconfeccionesjz@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14896',NULL,NULL,NULL,NULL,1),
  (5405,'13387168',15241252,3048250.4,381031.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PEDRO ANTONIO BOLIVAR OMAóA','CALLE 32 No 6B 46  CALLE 12 No 8 81  ETAPA ATALAYA','5787931','SAMUEL02029@HOTMAIL COM',62,1,'SERVICIO',40,NULL,0,'2013-08-26','2015-08-26','14510',NULL,NULL,NULL,NULL,1),
  (5406,'13458678',35852945,7170589,896323.625,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GALVIS  VARGAS  JOSE NEFTALI ','CALLE 12 No 3 47 COMUNEROS','5796628','danielfer10@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14895',NULL,NULL,NULL,NULL,1),
  (5407,'13489433',19760610,3952122,494015.25,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','JULIAN RODRIGUEZ LINDARTE','CALLE 76 No 16A 37','5820457','gracielaleon49@gmail com',62,1,'SERVICIO',40,NULL,0,'2013-06-17','2015-06-17','14509',NULL,NULL,NULL,NULL,1),
  (5408,'13508842',1904201,380840.2,47605.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PEREZ MORENO WAYNE ALBERTO  ','CARRERA 72A No 23F 36 Torre a Apartamento 203','3203264862','nalcionaldeherragesaristi@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14900',NULL,NULL,NULL,NULL,1),
  (5409,'13717286',58307670,11661534,1457691.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RAUL GERARDO SUAREZ ROJAS','CARRERA 39 No 42 78','6352293','laimperialarciniegas@yahoo',62,1,'SERVICIO',40,NULL,0,'2013-12-25','2015-12-25','14585',NULL,NULL,NULL,NULL,1),
  (5410,'13925430',8798832,1759766.4,219970.8,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','JAIRO RAVELO','CALLE 45 No 21 48  MANZANA A CASA 6 URBENIZACION ALAMEDA','6570841','elidamendozas2727@hotmail com',62,1,'SERVICIO',40,NULL,0,'2013-09-28','2015-09-28','14621',NULL,NULL,NULL,NULL,1),
  (5411,'14206878',7659882,1531976.4,191497.05,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','LEVID MORENO CORTES','CALLE 23 No 3 31','3103043677','Ingris2020@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-04-25','2014-04-25','14626',NULL,NULL,NULL,NULL,1),
  (5412,'14240126',1671949,334389.8,41798.725,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','QUINTERO RAMIREZ ADALBER ','CARRERA 4C No 25 65 piso 2','3157879213','kafejeans@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14903',NULL,NULL,NULL,NULL,1),
  (5413,'14319443',93970799,18794159.8,2349269.975,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ZAMUDIO CORTAZAR JOSE ALI ','DG 45 SUR 49 90','312301486','luzaydaperez@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14790',NULL,NULL,NULL,NULL,1),
  (5414,'14398972',3342793,668558.6,83569.825,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ACERO  JULIAN ANDRES ','CARRERA 11 No 13 13','2622604','miguel noriega@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14843',NULL,NULL,NULL,NULL,1),
  (5415,'14398981',17846492,3569298.4,446162.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DANIEL FELIPE CUELLAR','MANZANA D CASA 20B CORDOBA','8787364','dotacruzazul@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14625',NULL,NULL,NULL,NULL,1),
  (5416,'14838530',40752611,8150522.2,1018815.275,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BUSTAMANTE  HERNANDEZ YONNY ALBERTH ','CR 7  13 70 L 1 CC EL TESORO','3163103479','goyi3000@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14792',NULL,NULL,NULL,NULL,1),
  (5417,'16076493',33495488,6699097.6,837387.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FABIO NELSON GIRALDO GOMEZ','CALLE 13 No 13 38    CALLE 12 No 13 69','5621395','yeskala 03@hotmail com',62,1,'SERVICIO',40,NULL,0,'2013-10-06','2015-10-06','14580',NULL,NULL,NULL,NULL,1),
  (5418,'16475788',13472950,2694590,336823.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SALAZAR PRECIADO GONZALO ','CR 44 11 78 APT 101','325535876','milenabautista20@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14803',NULL,NULL,NULL,NULL,1),
  (5419,'16709224',5365378,1073075.6,134134.45,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','COLLAZOS PEREZ CARLOS ALBERTO ','CR 96 A 45 64','3173027810','lovelygil @hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14885',NULL,NULL,NULL,NULL,1),
  (5420,'17122174',5881988,1176397.6,147049.7,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GERMAN ARISTIZABAL GOMEZ','CALLE 24 A No 44 28','3681639','lineamedicamayitos@hotmail com',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14632',NULL,NULL,NULL,NULL,1),
  (5421,'17445151',5389898,1077979.6,134747.45,'2017-06-29','2017-07-13 16:59:48','2017-06-29 23:35:24','ALIRIO PE¾A','CLL 74 SUR    92 71','4001035','johnnyacl@hotmail com',62,2,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14610',NULL,NULL,NULL,NULL,1),
  (5422,'19268645',45423570,9084714,1135589.25,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GOMEZ  GUTIERREZ MANUEL LUCRECIO ','CRA 78    36A   42 SUR','2934440','cabrerafranklin@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-02-06','2014-02-06','13978',NULL,NULL,NULL,NULL,1),
  (5423,'19346035',21747198,4349439.6,543679.95,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','HERNANDO AVILA PAEZ','AV 68 No   12 54 SUR','2603166','jgarcia646@yahoo com ar',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14617',NULL,NULL,NULL,NULL,1),
  (5424,'19400019',2305200,461040,57630,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BARRERACALDERON CARLOS ALBERTO ','CR 20 8 53 LC 125','3204620442','c fajardon@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14857',NULL,NULL,NULL,NULL,1),
  (5425,'19491532',24823412,4964682.4,620585.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','AREVALO MENDEZ  HERNAN JAVIER ','CR 40 B    24 11','4723614','JMALAVER2009@HOTMAIL COM',62,1,'SERVICIO',40,NULL,0,'2013-10-07','2015-10-07','14686',NULL,NULL,NULL,NULL,1),
  (5426,'20504765',5500000,1100000,137500,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','TRIANA MATIZ VIRGINIA ','CARRERA 34A No 27A 54 SUR','7275854','luis jaimecp@hotmail com',62,1,'SERVICIO',40,NULL,0,'2014-06-07','2016-06-07','14685',NULL,NULL,NULL,NULL,1),
  (5427,'2231611',11176238,2235247.6,279405.95,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GRAJALES  EDWIN HERNANDO ','CALLE 17 No 3 55 APTO 202','3185713439','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14810',NULL,NULL,NULL,NULL,1),
  (5428,'22515559',8032217,1606443.4,200805.425,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BIURYCK JEANS','CALLE 35 No 41 18 piso 3','3720423','jpcerquera@gmail com',62,1,'SERVICIO',40,NULL,0,'2011-09-12','2013-09-12','14012',NULL,NULL,NULL,NULL,1),
  (5429,'28294011',35789572,7157914.4,894739.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','LEON AZA GRACIELA ','CALLE 1C No 16 51 SAN RANCISCO','6551206','SAPITOS FLORES@HOTMAIL COM',62,1,'SERVICIO',40,NULL,0,'2012-10-31','2014-10-31','13988',NULL,NULL,NULL,NULL,1),
  (5430,'31155777',1959983,391996.6,48999.575,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GARCIA  QUINTERO NOHRA ','CL 28 31 11 APT','2755021','josedanielgomezmunoz@hotmail com ',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14899',NULL,NULL,NULL,NULL,1),
  (5431,'31584406',2291594,458318.8,57289.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','QUINTERO  MARIA ANGELICA ','CR 9  15 63 LC 104 CC PETECUY','3117023736','frimport@hotmail com',62,1,'SERVICIO',40,NULL,0,'2016-06-15','2018-06-15','14892',NULL,NULL,NULL,NULL,1),
  (5432,'31847638',3693961,738792.2,92349.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ARCINIEGASLIBIA ','CALLE 18B  DG 23 58','4747756','lelayo-11@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14888',NULL,NULL,NULL,NULL,1),
  (5433,'31971511',4954907,990981.4,123872.675,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BEJARANO  AVENDA','CR 66 A 6 186','324747756','chaconnelson 69@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14837',NULL,NULL,NULL,NULL,1),
  (5434,'37179640',4000797,800159.4,100019.925,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MENDOZA EDIDA ','AV 7 No 12 47 LA ESTRELLA','3134630063','d animar16@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14887',NULL,NULL,NULL,NULL,1),
  (5435,'37276757',4067693,813538.6,101692.325,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','LINDARTE FONSECA MARLY','AV 21 NO 12 42','5710458','makano 229@hotmail com',62,1,'SERVICIO',40,NULL,0,'2016-06-15','2018-06-15','14886',NULL,NULL,NULL,NULL,1),
  (5436,'37279631',7255887,1451177.4,181397.175,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CHURIO PATINO INGRID YURLEY','MX 36 LT 11 CLARET','3219212237','gaposita68@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14824',NULL,NULL,NULL,NULL,1),
  (5437,'37294243',1187818,237563.6,29695.45,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ORTIZ MORENO DAYRA TATIANA  ','AV 7  12 31','3115296170','danipente75@yahoo es',62,1,'SERVICIO',40,NULL,0,'2015-05-16','2017-05-16','14863',NULL,NULL,NULL,NULL,1),
  (5438,'37843351',77881001,15576200.2,1947025.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PEREZ MEJIA LUZ AIDA ','CALLE 43 No 8 74','6442938','ferley084@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14867',NULL,NULL,NULL,NULL,1),
  (5439,'39632420',5769581,1153916.2,144239.525,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ANA LUCELIDA AVILA TORRES','CALLE 6 BIS No    80 C  62','4112588','MAERKS@GMAIL COM',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14637',NULL,NULL,NULL,NULL,1),
  (5440,'39719201',2690044,538008.8,67251.1,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GAMBA  MARIA ANDREA ','CL 51A 82C 37 SUR ','2733105','LOTOXJEANS@GMAIL COM',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14852',NULL,NULL,NULL,NULL,1),
  (5441,'39801675',3306000,661200,82650,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DERLY MAITET RAMIREZ MUNOZ','TV 2  48I 65 MZH','5697183','notificacionesbosque@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14844',NULL,NULL,NULL,NULL,1),
  (5442,'42102531',1639950,327990,40998.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BERMUDEZ QUIMBAYA DIANA MARIA ','CR 15  23 15 CENTENARIO','3243446','guantesvalleltda@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14904',NULL,NULL,NULL,NULL,1),
  (5443,'43595970',11643299,2328659.8,291082.475,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FERNANDEZ SANCHEZ YOLIMA A ','TV 45B  84 55 ','6126064','cimaxis textil@hotmail com?',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14808',NULL,NULL,NULL,NULL,1),
  (5444,'51963178',22271794,4454358.8,556794.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RUBIANO  RAMOS  ZORAIDA ','K 24D  3 42 SUR','3015592541','disguantesltda@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14796',NULL,NULL,NULL,NULL,1),
  (5445,'52251791',18197528,3639505.6,454938.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GLORIA ISABLE PERDOMO CUASPUD','CALLE 8 BIS F No   88F 58','4018514',' gerencia@coraza com co',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14627',NULL,NULL,NULL,NULL,1),
  (5446,'52271474',7404393,1480878.6,185109.825,'2017-06-29','2017-07-13 15:29:56','2017-06-29 23:35:24','GRACIELA VELANDIA OTALORA','CALLE 2 No 89 36  BLOQUE C CASA 9 PATIO BONITO','3202023704','shamaltda@hotmail com ',62,2,'SERVICIO',40,NULL,0,'2016-01-20','2018-01-20','14568',NULL,NULL,NULL,NULL,1),
  (5447,'52745793',30500000,6100000,762500,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','AURA EDILMA MU¾OZ SANABRIA','CRA 19 No    54 66','2051892','abrahamdini@hotmail com',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14604',NULL,NULL,NULL,NULL,1),
  (5448,'5471901',32925634,6585126.8,823140.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BALLESTEROS  ALVAREZ CARLOS DANIEL ','AV 5 No 17N 06','3114441214','oxigem0523@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14793',NULL,NULL,NULL,NULL,1),
  (5449,'59823201',8880596,1776119.2,222014.9,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ESTRADA BETANCOURT LILIANA DEL ROSARIO ','CR 3  21B 67','7321905','surtiuniformes@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14821',NULL,NULL,NULL,NULL,1),
  (5450,'60259298',2694605,538921,67365.125,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CASTILLO SANDOVAL GLORIA','CL 1  11 57','3124816104','coindotsas@gmail com  maria trujillop@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14891',NULL,NULL,NULL,NULL,1),
  (5451,'60285068',2291191,458238.2,57279.775,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','VARGAS RINCON NELLY DEL CARMEN ','CALLE 2 No 7E 196 BARRIO QUINTE ORIENTAL','5744021','yepesunidos@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-05-14','2014-05-14','14022',NULL,NULL,NULL,NULL,1),
  (5452,'60288756',19926805,3985361,498170.125,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PACHECO PARADA RAMONA DELIA  ','CL 12  3 13','5714405','amparocriv@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14799',NULL,NULL,NULL,NULL,1),
  (5453,'60337594',6920990,1384198,173024.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ROZO RINCON BERTHA CONSUELO  ','CL 7  4 98','5720458',' protextil@hotmail com ',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14876',NULL,NULL,NULL,NULL,1),
  (5454,'60357966',2786112,557222.4,69652.8,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RODRIGUEZ MARQUEZ MARIA INES  ','CL 10 AV 7 LOCAL 3 14','3114756842','coserycoser@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14850',NULL,NULL,NULL,NULL,1),
  (5455,'60383225',100172684,20034536.8,2504317.1,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','EDITH TERESA GUILLIN SALAZAR','MANZANA 4 LOTE 27 URBANIZACION LAS AMERICAS','3045903633','gruporiof@gmail com',62,1,'SERVICIO',40,NULL,0,'2013-09-05','2015-09-05','14660',NULL,NULL,NULL,NULL,1),
  (5456,'60443681',6911226,1382245.2,172780.65,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BAUTISTA ZAMBRANO SANDRA MILENA ','AV 9E  11 73','6829094','dotacionesdelsuroeste@hotmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14877',NULL,NULL,NULL,NULL,1),
  (5457,'63326650',7090000,1418000,177250,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RODRIGUEZ PRADA GLADYS','CR 35  107 40','3208029263','diovermg23@gmail com',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14825',NULL,NULL,NULL,NULL,1),
  (5458,'63513421',10547112,2109422.4,263677.8,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RODRIGUEZ DURAN GLADYS         ','PEATONAL 7AE No 27A 33','6213116','haconricardo039@gmail com',62,1,'SERVICIO',40,NULL,0,'2013-10-05','2015-10-05','14013',NULL,NULL,NULL,NULL,1),
  (5459,'63518633',9231795,1846359,230794.875,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BADILLO ORTIZ MYRIAM','CALLE 52 No 14 41','6991290','andreita705@hotmailcom',62,1,'SERVICIO',40,NULL,0,'2012-11-27','2014-11-27','14684',NULL,NULL,NULL,NULL,1),
  (5460,'63539797',4974341,994868.2,124358.525,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','AVILA BLANCO LENY YISETH ','TRANSV 154 No 24 141 local 8 EL BOSQUE','4450299','icardo botero@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-08-31','2014-08-31','13952',NULL,NULL,NULL,NULL,1),
  (5461,'65715164',5842882,1168576.4,146072.05,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GUARANGA  BLANCA FLOR ','CL  11B 16 10 SUR','2701662','DREAN WQA2@HORMAIL COM',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14833',NULL,NULL,NULL,NULL,1),
  (5462,'65747207',16700045,3340009,417501.125,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MORENO GUIZA CLAUDIA PATRICIA','CALLE 26A No 5 21 p 2','3716734','juliocevi 20@hotmail com',62,1,'SERVICIO',40,NULL,0,'2012-10-17','2014-10-17','14682',NULL,NULL,NULL,NULL,1),
  (5463,'66682156',5878468,1175693.6,146961.7,'2017-06-29','2017-07-13 15:58:57','2017-06-29 23:35:24','LIX KATHERINE PALACIO RIVERA','CRA 24 No 30 153','2873957','',62,2,'SERVICIO',40,NULL,0,'2014-01-21','2016-01-21','14597',NULL,NULL,NULL,NULL,1),
  (5464,'66780260',29556230,5911246,738905.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ISABEL CRISTINA MONTOYA GALINDO','CALLE 44 No 32 A 76','3108488272','',62,1,'SERVICIO',40,NULL,0,'2013-12-10','2015-12-10','14591',NULL,NULL,NULL,NULL,1),
  (5465,'66992933',1898528,379705.6,47463.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RODRIGUEZ ARENAS CLAUDIA LEVIS ','CL 13    6 73','8892572','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14901',NULL,NULL,NULL,NULL,1),
  (5466,'66995606',5384489,1076897.8,134612.225,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FRANCIA SILVA OSORIO','CRA 13 No 10 22','2609549','',62,1,'SERVICIO',40,NULL,0,'2013-12-26','2015-12-26','14595',NULL,NULL,NULL,NULL,1),
  (5467,'70952165',12541549,2508309.8,313538.725,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GARCIA GARCIA GERMAN DE JESUS ','CALLE 48D No 65a 15 OF 202','5962652','',62,1,'SERVICIO',40,NULL,0,'2012-09-14','2014-09-14','13977',NULL,NULL,NULL,NULL,1),
  (5468,'71213886',14991386,2998277.2,374784.65,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MORA EUSE GABRIEL ANGEL ','CR 46C  74SUR 58','5887607','',62,1,'SERVICIO',40,NULL,0,'2013-10-05','2015-10-05','13996',NULL,NULL,NULL,NULL,1),
  (5469,'71315762',1835320,367064,45883,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CARVAJAL  LOPEZ JHONY ALBERTO ','CL 28  84 195','4028852','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14902',NULL,NULL,NULL,NULL,1),
  (5470,'74347141',11304596,2260919.2,282614.9,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','HELMER DIAZ SUAREZ','CRA 82 No    0   23','6739671','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14603',NULL,NULL,NULL,NULL,1),
  (5471,'77186311',6621586,1324317.2,165539.65,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MAESTRE MU¾OZ CARLOS ALFONSO','CARRERA 23 No 54N 89 COLORADO','2018853','',62,1,'SERVICIO',40,NULL,0,'2013-11-28','2015-11-28','14681',NULL,NULL,NULL,NULL,1),
  (5472,'79265584',3175622,635124.4,79390.55,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FRANKLIN CABRERA RUBIO','CC PROVIDENCIA LC 23A','3484176','',62,1,'SERVICIO',40,NULL,0,'2015-09-17','2017-09-17','14641',NULL,NULL,NULL,NULL,1),
  (5473,'79311887',9506581,1901316.2,237664.525,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SANABRIA  VARGAS  RICARDO ','CL 53  15 86 OF 402','316844691','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14819',NULL,NULL,NULL,NULL,1),
  (5474,'79345411',25812783,5162556.6,645319.575,'2017-06-29','2017-07-17 14:32:58','2017-06-29 23:35:24','GARCIA  PEREZ JUAN CARLOS ','CL 148 95 97','2645582','',62,2,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14868',NULL,NULL,NULL,NULL,1),
  (5475,'79408913',19827207,3965441.4,495680.175,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FAJARDO CARLOS EDUARDO','AV BOYACA 36 88 SUR','7110052','',62,1,'SERVICIO',40,NULL,0,'2015-10-13','2017-10-13','14688',NULL,NULL,NULL,NULL,1),
  (5476,'79412065',8596370,1719274,214909.25,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ORLANDO BUSTOS GARCIA','CL 39BIS 68L 71 SUR ','3115134494','',62,1,'SERVICIO',40,NULL,0,'2011-12-07','2013-12-07','11468',NULL,NULL,NULL,NULL,1),
  (5477,'79446956',11968569,2393713.8,299214.225,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','JAVIER ENRIQUE MALAVER ESPEJO','CLL 173    40 32','4065142','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14611',NULL,NULL,NULL,NULL,1),
  (5478,'79691022',60622507,12124501.4,1515562.675,'2017-06-29','2017-07-19 09:05:36','2017-06-29 23:35:24','CARLOS ERNESTO SAAVEDRA PUENTES','CL 70A BIS  111D 29','2810874','',62,5,'SERVICIO',40,NULL,0,'2013-11-14','2015-11-14','14075',NULL,NULL,NULL,NULL,1),
  (5479,'79732635',20669753,4133950.6,516743.825,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CASTRO  PARDO  LUIS JAIME ','CL 186 No 54D 73 C42','3322110','',62,1,'SERVICIO',40,NULL,0,'2013-10-01','2015-10-01','14798',NULL,NULL,NULL,NULL,1),
  (5480,'800013093',2691282,538256.4,67282.05,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','COOPERATIVA DE CREDITO EL BOSQUE LTDA ','AV JIMENEZ 7 25 OF 812 813','314864268','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14851',NULL,NULL,NULL,NULL,1),
  (5481,'80016311',9473173,1894634.6,236829.325,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','LUIS FABIAN FORERO RAMIREZ','CALLE 25  No 20 130 CALLE 21 No 22 19 apto 302','3132922003','',62,1,'SERVICIO',40,NULL,0,'2014-06-16','2016-06-16','14583',NULL,NULL,NULL,NULL,1),
  (5482,'800232926',19456919,3891383.8,486422.975,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GUANTES VALLE LTDA ','CL 60 27 A 18 AP 804 TO 3 CON BOSQUES DE LAS MERCEDES','322744315','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14870',NULL,NULL,NULL,NULL,1),
  (5483,'80057214',18727794,3745558.8,468194.85,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','LUIS ANTONIO CASTILLO','CR 45 45 52','3123724702','',62,1,'SERVICIO',40,NULL,0,'2015-09-17','2017-09-17','14605',NULL,NULL,NULL,NULL,1),
  (5484,'80065650',10576630,2115326,264415.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CERQUERA MONTEALEGRE JUAN PABLO ','CL 29 6 66 LAS GRNAJAS','3115924938','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14811',NULL,NULL,NULL,NULL,1),
  (5485,'80211139',16819558,3363911.6,420488.95,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','JAIRO ANTONIO CRISTRANCHO TOVAR','CRA 3  9 74 SUR','7688415','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14616',NULL,NULL,NULL,NULL,1),
  (5486,'80254985',36526614,7305322.8,913165.35,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ORTIZ  SANCHEZ JHON ','CL 92A BIS SUR  1 15','2732815','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14894',NULL,NULL,NULL,NULL,1),
  (5487,'80271596',11525975,2305195,288149.375,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ACEVEDO BOHORQUEZ GIOVANNY MAURICIO ','CR 10  9 39 LOCAL 1210','5221318','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14874',NULL,NULL,NULL,NULL,1),
  (5488,'80413403',4039728,807945.6,100993.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GUERRERO MONTA¾O JOSE ALFREDO ','CLL 128B    51   19','4247049','',62,1,'SERVICIO',40,NULL,0,'2013-04-03','2015-04-03','13981',NULL,NULL,NULL,NULL,1),
  (5489,'805030692',26499303,5299860.6,662482.575,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SOCIEDAD DE COMERCIALIZACION INTE','CRA 49 13B 24','3350793','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14629',NULL,NULL,NULL,NULL,1),
  (5490,'80831507',15090991,3018198.2,377274.775,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MURCIA  PINZON CARLOS ARTURO ','CR 34 4B 42 CASA 102  CL 8 C 78 C 13','7652279','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14802',NULL,NULL,NULL,NULL,1),
  (5491,'811041841',255360857,51072171.4,6384021.425,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CI MAXIS TEXTIL SA','CALLE 11 CARRERA 10 38  EL LLANO   CALLE 9 No 6 54 LOCAL B','5724943','',62,1,'SERVICIO',40,NULL,0,'2011-12-13','2013-12-13','13954',NULL,NULL,NULL,NULL,1),
  (5492,'830048947',99505086,19901017.2,2487627.15,'2017-06-29','2017-07-21 12:17:41','2017-06-29 23:35:24','CONFECCIONES JESSUA  LTDA ','CL 37 SUR  68H 90','4037476','',62,5,'SERVICIO',40,NULL,0,'2012-01-17','2014-01-17','11617',NULL,NULL,NULL,NULL,1),
  (5493,'830094239',3272687,654537.4,81817.175,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PROINTEXCOL ','CR 68 C 37 B 23 SUR','312633492','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14845',NULL,NULL,NULL,NULL,1),
  (5494,'830104637',13472873,2694574.6,336821.825,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DISGUANTES LTDA ','CL 12A  26 24','7036192','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14873',NULL,NULL,NULL,NULL,1),
  (5495,'830135871',40388412,8077682.4,1009710.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','TEX INC INVERSIONES EU ','AV 8 No 10 77','4511920','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14893',NULL,NULL,NULL,NULL,1),
  (5496,'830504375',8529665,1705933,213241.625,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','METROTEXTILES SA ','CR 9 15 35 LC 24 ','6702425','',62,1,'SERVICIO',40,NULL,0,'2013-10-11','2015-10-11','13995',NULL,NULL,NULL,NULL,1),
  (5497,'830513423',20341130,4068226,508528.25,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CORAZA LTDA','CALLE 68    30   66 CASA B ','8959444','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14869',NULL,NULL,NULL,NULL,1),
  (5498,'84035445',61280000,12256000,1532000,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FREDY JULIAN RIOS','CALLE 107 No 22a 58','4202734','',62,1,'SERVICIO',40,NULL,0,'2014-02-28','2016-02-28','14530',NULL,NULL,NULL,NULL,1),
  (5499,'86003623',7952550,1590510,198813.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','URIEL ANTONIO VILLADA VALBUENA','TRANSV    80 A 65J 24 ','3102112727','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14602',NULL,NULL,NULL,NULL,1),
  (5500,'88167462',23819643,4763928.6,595491.075,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','TARAZONA  GONZALO ','CL 19A 12A SUR','6563622','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14795',NULL,NULL,NULL,NULL,1),
  (5501,'88197750',39299169,7859833.8,982479.225,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ORTEGA  QUINTERO JOSE LEONIDAS ','CALLE 30 No 2 137 CASA 6 BARRIO ACUARELA','3108027637','',62,1,'SERVICIO',40,NULL,0,'2012-01-19','2014-01-19','14003',NULL,NULL,NULL,NULL,1),
  (5502,'88199811',2553388,510677.6,63834.7,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CHACON SANTANDER NELSON ENRIQUE  ','CL 12 7 31 LC I 31 I 03 CC LA ESTRELLA','5822121','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14855',NULL,NULL,NULL,NULL,1),
  (5503,'88208569',6025191,1205038.2,150629.775,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','MARTINEZ BAYONA ERWIN ANTONIO ','CALLE 18 No 40 2','3134202331','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14831',NULL,NULL,NULL,NULL,1),
  (5504,'88212513',11786139,2357227.8,294653.475,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BONILLA MEDINA FERNANDO ANTONIO ','CALLE  10  No 7 59','3766365','',62,1,'SERVICIO',40,NULL,0,'2014-02-14','2016-02-14','14807',NULL,NULL,NULL,NULL,1),
  (5505,'88223661',17277736,3455547.2,431943.4,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CASTILLA SANTIAGO ISNEL  ','CL 24A  30B 05','6520370','',62,1,'SERVICIO',40,NULL,0,'2013-10-05','2015-10-05','13959',NULL,NULL,NULL,NULL,1),
  (5506,'900032093',20226297,4045259.4,505657.425,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','FABRICA DE ARTICULOS PARA SEGURIDAD ','CLL 12 B   3 51 CANDELARIA','2725494','',62,1,'SERVICIO',40,NULL,0,'2013-07-16','2015-07-16','14673',NULL,NULL,NULL,NULL,1),
  (5507,'900062898',11248073,2249614.6,281201.825,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CONFECCIONES CAROYCO BOGOTA E','CR 24 A 61 05','3103364762','',62,1,'SERVICIO',40,NULL,0,'2012-05-28','2014-05-28','13963',NULL,NULL,NULL,NULL,1),
  (5508,'900175453',6115886,1223177.2,152897.15,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CI ANNMICHELL S A S ','AV CL 63  80 10','4101147','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14879',NULL,NULL,NULL,NULL,1),
  (5509,'900177735',18035061,3607012.2,450876.525,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SHAMA COMERCIAL LTDA','CR 12B 22 15','8137748','',62,1,'SERVICIO',40,NULL,0,'2011-12-07','2013-12-07','11462',NULL,NULL,NULL,NULL,1),
  (5510,'900238074',5554541,1110908.2,138863.525,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GALLARDINI TEXTILES COLOMBIANOS LTDA ','CL 65  46 20','3600896','',62,1,'SERVICIO',40,NULL,0,'2015-09-17','2017-09-17','14882',NULL,NULL,NULL,NULL,1),
  (5511,'900283988',2679870,535974,66996.75,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SURTIUNIFORMES DE LA COSTA LTDA ','AV 68 No    60 81','7049161','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14853',NULL,NULL,NULL,NULL,1),
  (5512,'900299944',10170729,2034145.8,254268.225,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CSI CONFECCIONES DE SEGURIDAD','CR 24    75A 47','315476514','',62,1,'SERVICIO',40,NULL,0,'2013-12-17','2015-12-17','14590',NULL,NULL,NULL,NULL,1),
  (5513,'900323622',5766182,1153236.4,144154.55,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','COMPANIA INTEGRAL DE DOTACIONES COINDOT SAS','CALLE 31 No 42 25','3720855','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14880',NULL,NULL,NULL,NULL,1),
  (5514,'900326223',10531832,2106366.4,263295.8,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','YEPES UNIDOS SOCIEDAD POR ACCIONES SIMPLIFICADA ','CL 15 SUR  18 46 P4','4732661','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14814',NULL,NULL,NULL,NULL,1),
  (5515,'900351293',3188123,637624.6,79703.075,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DOTARTE CON ESTILO SAS ','CR 23 A 8 A 30 ','5542244','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14847',NULL,NULL,NULL,NULL,1),
  (5516,'900352194',3462841,692568.2,86571.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','PROTEXTIL DE OCCIDENTE S A S ','CALLE 44 No 1CW 70','3155398189','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14890',NULL,NULL,NULL,NULL,1),
  (5517,'900382017',8665492,1733098.4,216637.3,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DISTRIBUCIONES INDUSTRIALES ','CR 23  16 79','7234251','',62,1,'SERVICIO',40,NULL,0,'2012-12-15','2014-12-15','14615',NULL,NULL,NULL,NULL,1),
  (5518,'900386178',4740417,948083.4,118510.425,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','INSUMOS COSER Y COSER SAS ','CLL 9    36   80 OF    603','3008998847','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14838',NULL,NULL,NULL,NULL,1),
  (5519,'900387891',8748462,1749692.4,218711.55,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','NEW START COMPANY SAS ','CL 16 SUR No    18 49 OF 346B ','3664485','',62,1,'SERVICIO',40,NULL,0,'2013-10-31','2015-10-31','13998',NULL,NULL,NULL,NULL,1),
  (5520,'900405647',17780989,3556197.8,444524.725,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','BASE TEXTILES SAS ','CARRERA 22A No 110 27','6853179','',62,1,'SERVICIO',40,NULL,0,'2013-04-29','2015-04-29','14687',NULL,NULL,NULL,NULL,1),
  (5521,'900416722',43756873,8751374.6,1093921.825,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','COLOMBIANA EN SEGURIDAD INDUSTRIAL','CR 52 C    39B 22 SUR ','3125830923','',62,1,'SERVICIO',40,NULL,0,'2014-04-03','2016-04-03','14582',NULL,NULL,NULL,NULL,1),
  (5522,'900442908',25694681,5138936.2,642367.025,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DENIM WKSAS','CALLE 52 No 24 84','6112325','',62,1,'SERVICIO',40,NULL,0,'2012-11-04','2014-11-04','14683',NULL,NULL,NULL,NULL,1),
  (5523,'900456189',9781371,1956274.2,244534.275,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ZOE DOTACIONES SAS ','AV CL 68    4 51 SUR ','2627483','',62,1,'SERVICIO',40,NULL,0,'2013-07-29','2015-07-29','14026',NULL,NULL,NULL,NULL,1),
  (5524,'900487029',108574860,21714972,2714371.5,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DOTACIONES VELANDIA ','CL 29C SUR  44A 60','6943591','',62,1,'SERVICIO',40,NULL,0,'2013-06-25','2015-06-25','14703',NULL,NULL,NULL,NULL,1),
  (5525,'900498015',5526573,1105314.6,138164.325,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GRUPO RIOFF SAS','CALLE 12 No 13 73','3719866','',62,1,'SERVICIO',40,NULL,0,'2013-12-15','2015-12-15','14522',NULL,NULL,NULL,NULL,1),
  (5526,'900590236',14024574,2804914.8,350614.35,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','DOTASUROESTE SAS ','CR 52 D CL 81 17','2467728','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14883',NULL,NULL,NULL,NULL,1),
  (5527,'91259772',34034377,6806875.4,850859.425,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','GABRIEL PORTILLA SANABRIA','CL 20  17 10','3174339592','',62,1,'SERVICIO',40,NULL,0,'2015-09-17','2017-09-17','14584',NULL,NULL,NULL,NULL,1),
  (5528,'91476956',10313528,2062705.6,257838.2,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RIVERO  DANIEL  ','CL 43 No 26 57','6801219','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14817',NULL,NULL,NULL,NULL,1),
  (5529,'91529044',3148813,629762.6,78720.325,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','RAMIREZ MANTILLA LUIS FERLEY ','CR 16  35 11 LC 8 9','3186322613','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14848',NULL,NULL,NULL,NULL,1),
  (5530,'93384756',13092236,2618447.2,327305.9,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','SANCHEZ SAAVEDRA CARLOS ARTURO ','CARRERA 4 No 17 25','3511725','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14805',NULL,NULL,NULL,NULL,1),
  (5531,'93386121',7005543,1401108.6,175138.575,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','ENCISO  PARRA  MARCO ARVEY ','CARRERA  No 36a 38','8122273','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14826',NULL,NULL,NULL,NULL,1),
  (5532,'94350878',109501915,21900383,2737547.875,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','QUINTERO ARISTIZABAL FRANCISCO LUIS ','CALLE 4 SUR No 10 A   15 ','3003734019','',62,1,'SERVICIO',40,NULL,0,'2011-05-19','2013-05-19','14672',NULL,NULL,NULL,NULL,1),
  (5533,'94367385',6490468,1298093.6,162261.7,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','OSORIO  MANUEL ANTONIO ','CL 22 7A 6','3001255466','',62,1,'SERVICIO',40,NULL,0,'2015-06-15','2017-06-15','14897',NULL,NULL,NULL,NULL,1),
  (5534,'94398892',19848460,3969692,496211.5,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','JORGE ENTIQUE CRUZ GUZMAN','CALLE 43 No   2F  48','6649853','',62,1,'SERVICIO',40,NULL,0,'2014-07-22','2016-07-22','14628',NULL,NULL,NULL,NULL,1),
  (5535,'9455505',5425898,1085179.6,135647.45,'2017-06-29','2017-06-29 23:35:24','2017-06-29 23:35:24','CASTILLO FERNANDEZ JOHNY ','CRA 3A NORTE N 3 BIS   09 B MADRIGAL YUMBO ','3146540774','zuelitas17@hotmail com',62,1,'SERVICIO',40,NULL,0,'2014-08-16','2016-08-16','14836',NULL,NULL,NULL,NULL,1),
  (5559,'76267910',137856367,27571273.4,3446409.175,'2017-06-30','2017-06-30 00:08:20','2017-06-30 00:08:20','GUSTAVO ADOLFO AGUILAR VIVAS','CARRERA 7 No 23 27','6452187','INGANDRIS08@GMAIL.COM',135,1,'BIENES',40,NULL,0,'2013-10-28','2015-10-28','14',NULL,NULL,NULL,NULL,1),
  (5560,'19391024',718904225,143780845,17972605.625,'2017-06-30','2017-06-30 00:44:33','2017-06-30 00:44:33','CARLOS IVAN VILLEGAS GIRALDO','Av Calle 26 N 59 51 Torre 3 Oficina 504','3134576729','',62,1,'BIENES',40,NULL,0,'2016-07-21','2018-07-21','0015',NULL,NULL,NULL,NULL,1),
  (5561,'51854766',718904225,143780845,17972605.625,'2017-06-30','2017-06-30 00:44:33','2017-06-30 00:44:33','EDNA PIEDAD CUBILLOS CAICEDO','CALLE 6 SUR No 15a 24','7455700','',62,1,'BIENES',40,NULL,0,'2016-07-02','2018-07-02','0012',NULL,NULL,NULL,NULL,1),
  (5562,'11378494',919532,183906.4,22988.3,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CIFUENTES SABOGAL PLUTARCO ','TV 12 14 29','318672290','davidperdomodelgado@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-08-22','2016-08-22','15073',NULL,NULL,NULL,NULL,1),
  (5563,'14237048',5201208,1040241.6,130030.2,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','BUSTOS  RODRIGUEZ FERNANDO ','cl 184  41 61','3125737524',' fbustosr2@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-06-30','2014-06-30','15042',NULL,NULL,NULL,NULL,1),
  (5564,'19151742',137112,27422.4,3427.8,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','BUSTOS MALAVER MARIO ','CL 184  41 61 BALMORAL NORTE','3125737524','malaver01@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-03-05','2017-03-05','15047',NULL,NULL,NULL,NULL,1),
  (5565,'406645',2412916,482583.2,60322.9,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','RODRIGUEZ SILVA JOSE AGUSTIN  ','CR 5  5 49','8582018','cfavilab@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-11-15','2016-11-15','14921',NULL,NULL,NULL,NULL,1),
  (5566,'41941305',349206,69841.2,8730.15,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ARANGO GARCIA TATIANA ','CR 24 51 40 AP 202 ','3125278248','t.arango@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-07-17','2016-07-17','14928',NULL,NULL,NULL,NULL,1),
  (5567,'800001845',1991132,398226.4,49778.3,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','SERPET JR Y CIA S EN C  ','CR 30  46 140 LAS AMERICAS','7477605','cartera@serpetjr.com',62,1,'SERVICIOS',40,NULL,0,'2013-10-11','2015-10-11','14935',NULL,NULL,NULL,NULL,1),
  (5568,'800010961',2784705,556941,69617.625,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','NORCARBON SAS','CL 74  56 36 OF 901','3601670','mvasquez@pacificcoalsa.com',62,1,'SERVICIOS',40,NULL,0,'2013-03-06','2015-03-06','15050',NULL,NULL,NULL,NULL,1),
  (5569,'800037241',12103245,2420649,302581.125,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','M I OVERSEAS LIMTED  ','KM 1.5 VIA SIBERIA - COTA BASE SLB','6330821','finanfiscal@slb.com',62,1,'SERVICIOS',40,NULL,0,'2013-09-01','2015-09-01','15002',NULL,NULL,NULL,NULL,1),
  (5570,'800073584',221443543,44288708.6,5536088.575,'2017-06-30','2017-07-19 11:04:41','2017-06-30 00:54:34','ANTEA COLOMBIA SAS','CL 35  7 25 P12','3276300','edith.alvarez@anteagroup.com',62,5,'SERVICIOS',40,NULL,0,'2016-04-07','2018-04-07','15091',NULL,NULL,NULL,NULL,1),
  (5571,'800111304',1277587,255517.4,31939.675,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','EMPRESA DE ACUEDUCTO Y ALCANTARILLADO DE PUERTO ASIS','CR 33 13 A 01 KENNEDY','984227253','gerenciaeaap@puertoasis-putumayo.gov.co',62,1,'SERVICIOS',40,NULL,0,'2014-07-01','2016-07-01','15023',NULL,NULL,NULL,NULL,1),
  (5572,'800149453',1182542,236508.4,29563.55,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CENTRO POLICLINICO DEL OLAYA  ','CR 21  22 68 SUR','3612888','dir_tatianaj@cpo.com.co',62,1,'SERVICIOS',40,NULL,0,'2014-01-14','2016-01-14','15039',NULL,NULL,NULL,NULL,1),
  (5573,'800200598',9784635,1956927,244615.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CONMIL SAS','CR 7  73 55 P14 ','3139030','garcia.lm@prodesa.com',62,1,'SERVICIOS',40,NULL,0,'2015-01-05','2017-01-05','15005',NULL,NULL,NULL,NULL,1),
  (5574,'800222310',13521581,2704316.2,338039.525,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PIEDRAS Y DERIVADOS SA  ','VIA USME KM 7 BOGOTA','7610333','',62,1,'SERVICIOS',40,NULL,0,'2012-06-30','2014-06-30','14994',NULL,NULL,NULL,NULL,1),
  (5575,'800222763',5140327,1028065.4,128508.175,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PEDRO GOMEZ Y CIA SA ','CL 70 7 53','6060303','ocortes@pedrogomez.com.co',62,1,'SERVICIOS',40,NULL,0,'2014-11-01','2016-11-01','15045',NULL,NULL,NULL,NULL,1),
  (5576,'800250321',742560,148512,18564,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','DRILLSITE FLUID TREATMENT DRIFT SA - EN REORGANIZACION','CR 7  156 68','7454609','nbahos@driftsa.net',62,1,'SERVICIOS',40,NULL,0,'2014-02-03','2016-02-03','15088',NULL,NULL,NULL,NULL,1),
  (5577,'813000008',2624122930,524824586,65603073.25,'2017-06-30','2017-07-19 11:03:48','2017-06-30 00:54:34','ATP INGENERIA SAS  EN REORGANIZACION','CRA 7A  124 79','6378494','contacto@atpingenieria.com',62,5,'SERVICIOS',44,NULL,0,'2015-09-25','2017-09-25','14933',NULL,NULL,NULL,NULL,1),
  (5578,'830003107',472282,94456.4,11807.05,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PRODUQUIM LTDA ','CL 21 SUR  68G 15','2614621','',62,1,'SERVICIOS',40,NULL,0,'2013-11-13','2015-11-13','14937',NULL,NULL,NULL,NULL,1),
  (5579,'830011142',41095710,8219142,1027392.75,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GEOLOGOS PETROLEROS DE COLOMBIA SA','CR 17  155A 54','4772146','listoes@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-07-15','2015-07-15','14946',NULL,NULL,NULL,NULL,1),
  (5580,'830018986',40510968,8102193.6,1012774.2,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ESTUDIO DE MANEJO AMBIENTAL EDEMA LTDA','AV CARACAS 43 22  OF302','2886617','martindanielp@iam.com',62,1,'SERVICIOS',40,NULL,0,'2010-11-17','2012-11-17','14949',NULL,NULL,NULL,NULL,1),
  (5581,'830021100',1596315,319263,39907.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TERMINALES AUTOMOTRICES SA','CL 5 14 100 KM 19','4221523','mnope@k-automotivecorp.com',62,1,'SERVICIOS',40,NULL,0,'2014-05-28','2016-05-28','15000',NULL,NULL,NULL,NULL,1),
  (5582,'830021417',4587030,917406,114675.75,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CARBONES COLOMBIANOS DEL CERREJON SAS','CL 74 56 36 OF 901','3601670','mvasquez@pacificcoalsa.com',62,1,'SERVICIOS',40,NULL,0,'2015-02-16','2017-02-16','15058',NULL,NULL,NULL,NULL,1),
  (5583,'830022258',7173442,1434688.4,179336.05,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','SOCIEDAD DE COMERCIALIZACION INTERNACIONAL GRAVINAL SA','CL 125 19 89 OF 502','6581697','gerencia@gravinal.com',62,1,'SERVICIOS',40,NULL,0,'2012-09-13','2014-09-13','15026',NULL,NULL,NULL,NULL,1),
  (5584,'830047455',837172,167434.4,20929.3,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GALLARDO VASQUEZ COMPAOIA S EN C S','CR 3 21 46 AP 2502','2410632','arenablanca@telecom.com.co',62,1,'SERVICIOS',40,NULL,0,'2012-12-03','2014-12-03','15013',NULL,NULL,NULL,NULL,1),
  (5585,'830073007',2966250,593250,74156.25,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ORGANIZACION NO GUBERNAMENTAL ASOCIACION MULTIACTIVA COMUNITARIA ONG AMC','CR 20 52 20','2118091','ong_amc@etb.net.co',62,1,'SERVICIOS',40,NULL,0,'2012-09-06','2014-09-06','15052',NULL,NULL,NULL,NULL,1),
  (5586,'830079832',415548,83109.6,10388.7,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','SUBARU DE COLOMBIA SA','CR 19  66 45','3481755','mlondono@seikoucolombia.com',62,1,'SERVICIOS',40,NULL,0,'2013-07-02','2015-07-02','14911',NULL,NULL,NULL,NULL,1),
  (5587,'830084556',1373610,274722,34340.25,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','OIL FIELD SOLUTIONS LTDA','AV 19  114 65 OF 301','8054717','oilfieldsolutions@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-10-05','2014-10-05','15016',NULL,NULL,NULL,NULL,1),
  (5588,'830085521',62378037,12475607.4,1559450.925,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','VAROSA ENERGY LTDA','CL 93B  17 25 OF 209','4824787','varosaenergylfa@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-07-03','2015-07-03','14944',NULL,NULL,NULL,NULL,1),
  (5589,'830093647',5676507,1135301.4,141912.675,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ALIANCO INGENIERIA LTDA ','CR 32 B 4 61 P 2','2775031','aliancoingenieria@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-09-05','2016-09-05','15032',NULL,NULL,NULL,NULL,1),
  (5590,'830101778',502454,100490.8,12561.35,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','FRANQUICIAS Y CONCESIONES SA','AV CR 68 13 41','8029445','impuestos@frayco.com.co',62,1,'SERVICIOS',40,NULL,0,'2014-11-30','2016-11-30','14906',NULL,NULL,NULL,NULL,1),
  (5591,'830104904',492954,98590.8,12323.85,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GC INVERSIONES S EN C  ','CR 69B  37B 66 SUR','7416759','castrocontadores@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-04-13','2016-04-13','14975',NULL,NULL,NULL,NULL,1),
  (5592,'830106376',3037912,607582.4,75947.8,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CORPORACION IPS SALUDCOOP','CL 116  21 37','6511000','notificaciones@ipssaludcoopenliquidacion.com',62,1,'SERVICIOS',40,NULL,0,'2015-03-17','2017-03-17','15051',NULL,NULL,NULL,NULL,1),
  (5593,'830129979',465465,93093,11636.625,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','SOLUCIONES Y SERVICIOS INTEGRALES EMPRESARIALES LTDA','CL 88 61 29 ','2259297','administrativo@soliser.com.co',62,1,'SERVICIOS',40,NULL,0,'2015-02-23','2017-02-23','14914',NULL,NULL,NULL,NULL,1),
  (5594,'830131978',800646,160129.2,20016.15,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PARQUE INDUSTRIAL ECOEFICIENTE DE ARTES GRAFICAS - PH','CL 17 A 21 45','3115588777','argos1951@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-07-16','2014-07-16','15082',NULL,NULL,NULL,NULL,1),
  (5595,'830132875',955840,191168,23896,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','RAMSHORN INTERNATIONAL LIMITED','CL 113  7 21 TORRE A OF 706','6291716','orlando.ramirez@ramshorn.com.co',62,1,'SERVICIOS',40,NULL,0,'2014-01-09','2016-01-09','15076',NULL,NULL,NULL,NULL,1),
  (5596,'830147429',448824,89764.8,11220.6,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','C I TRASNACIONAL DE HIDROCARBUROS Y BIOCOMBUSTIBLES SAS','CL 110  9 25 OF607 TORRE PACIFIC','3001010','',62,1,'SERVICIOS',40,NULL,0,'2013-09-03','2015-09-03','14927',NULL,NULL,NULL,NULL,1),
  (5597,'830509383',72338626,14467725.2,1808465.65,'2017-06-30','2017-07-19 10:39:42','2017-06-30 00:54:34','INCON EU','CL 23  27 12','6359087','mendietamedina@gmail.com',62,5,'SERVICIOS',40,NULL,0,'2012-06-30','2014-06-30','14940',NULL,NULL,NULL,NULL,1),
  (5598,'830511431',1526676,305335.2,38166.9,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','RETAMBORES LTDA','CR 9  9 62','7211763','rhumano@retamboresltda.com',62,1,'SERVICIOS',40,NULL,0,'2012-10-08','2014-10-08','15004',NULL,NULL,NULL,NULL,1),
  (5599,'832000283',13910925,2782185,347773.125,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CORPORACION AUTONOMA REGIONAL DE LA ORINOQUIA CORPORINOQUIA','CR 23  18 31 BARRIO EL GALVAN','6358588','direccion@corporinoquia.gov.co',62,1,'SERVICIOS',40,NULL,0,'2013-06-30','2015-06-30','14982',NULL,NULL,NULL,NULL,1),
  (5600,'860451858',2850700,570140,71267.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TECNICOS EN COMBUSTION Y TRATAMIENTO DE AGUAS SAS','KM 15 PARQUE INDUSTRIAL DEL NORTE TOCANCIPA','7456600','yadira.piedrahita@tecca.com.co',62,1,'SERVICIOS',40,NULL,0,'2015-09-17','2017-09-17','15070',NULL,NULL,NULL,NULL,1),
  (5601,'890504655',140780959,28156191.8,3519523.975,'2017-06-30','2017-07-19 07:50:04','2017-06-30 00:54:34','INTEGRAL DE SERVICIOS TECNICOS SAS','AV CL 127 7 A 47 P 3 BRR SANTA BARBARA','7429792','mguerrero@ist.com.co',62,5,'SERVICIOS',40,NULL,0,'2014-10-23','2016-10-23','14919',NULL,NULL,NULL,NULL,1),
  (5602,'900012579',3402780,680556,85069.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','VECTOR GEOPHYSICAL SAS','PARQUE IND ACROPOLIS BG 7 Y 8 VD CANAVITA','8786735','gilberto.galindo@cglsa.com',62,1,'SERVICIOS',40,NULL,0,'2015-02-18','2017-02-18','14986',NULL,NULL,NULL,NULL,1),
  (5603,'900024672',3000000,600000,75000,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TRANSPORTES CARIBE LTDA ','CR 30  9 05','4227487','transportescaribe@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-06-23','2015-06-23','15036',NULL,NULL,NULL,NULL,1),
  (5604,'900044618',42540540,8508108,1063513.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TRAYECTORIA OIL & GAS','CL 113 7 45 TORRE B OF 1210','5169999','',62,1,'SERVICIOS',40,NULL,0,'2015-07-11','2017-07-11','14967',NULL,NULL,NULL,NULL,1),
  (5605,'900050841',3626490,725298,90662.25,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ECOFINANZAS LTDA  ','CRA 142  46 61','3158635133','contabilidad@ecofinanzasltda.com',62,1,'SERVICIOS',40,NULL,0,'2015-08-19','2017-08-19','14958',NULL,NULL,NULL,NULL,1),
  (5606,'900060235',15280481,3056096.2,382012.025,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','FUNDACION DE APOYO A LA CORPORACION UNIVERSITARIA DEL HUILA CORHUILA','CL 21 6 01','8740710','univlab@corhuila.edu.co',62,1,'SERVICIOS',40,NULL,0,'2012-06-30','2014-06-30','14973',NULL,NULL,NULL,NULL,1),
  (5607,'900101550',338415,67683,8460.375,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GRUPO HAIKAL SA','CL 49B SUR 79 40 INT 1 AP 202 MZ U12','5388198','gerencia@polshcar.com',62,1,'SERVICIOS',40,NULL,0,'2014-10-08','2016-10-08','14947',NULL,NULL,NULL,NULL,1),
  (5608,'900132937',682212,136442.4,17055.3,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','UMWELT COLOMBIA SAS  ','CL 42 BIS SUR  75A 26','2648640','gerencia@umweltcolombia.com',62,1,'SERVICIOS',40,NULL,0,'2015-09-17','2017-09-17','14908',NULL,NULL,NULL,NULL,1),
  (5609,'900136423',127252,25450.4,3181.3,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','MARWE SERVICIOS INTEGRALES SAS','CR 21 A  80BIS 36','2569843','marwe.ser.int.ltda@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-03-15','2017-03-15','17089',NULL,NULL,NULL,NULL,1),
  (5610,'900223945',382800,76560,9570,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','INTERNATIONAL PARK OF CREATIVITY','CL 54  25 89 BARRIO ARBOLEDA','6209249','parquedelacreatividad@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-05-17','2017-05-17','15074',NULL,NULL,NULL,NULL,1),
  (5611,'900231322',4204723,840944.6,105118.075,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ECOTRES SAS','CR 23 N 163 A 31 OF 202','5266787','contador@ecotr3s.co',62,1,'SERVICIOS',40,NULL,0,'2013-12-01','2015-12-01','15065',NULL,NULL,NULL,NULL,1),
  (5612,'900254651',14973315,2994663,374332.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GREEN POWER SUCURSAL COLOMBIA ','CL 113 7 45 T B OF 1210','3174414739','cbaena@trayectoriaoilgas.com',62,1,'SERVICIOS',40,NULL,0,'2015-08-24','2017-08-24','14977',NULL,NULL,NULL,NULL,1),
  (5613,'900260346',18298139,3659627.8,457453.475,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ELOGY TECNOLOGIA ECOLOGICA SAS','CL 15  15 59 OF 403','6356590','elogy.gerencia@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-07-04','2017-07-04','14970',NULL,NULL,NULL,NULL,1),
  (5614,'900282958',408555,81711,10213.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','OSMO EQUIPOS SAS  ','CR 6 26 85 P 17','3374360','contacto@osmo.com.co',62,1,'SERVICIOS',40,NULL,0,'2015-01-19','2017-01-19','14924',NULL,NULL,NULL,NULL,1),
  (5615,'900284840',12692267,2538453.4,317306.675,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PASION AMBIENTAL LTDA','CL 138 54 C 40 IN 1 AP 101 ED CODAZZI','4856953','pasionambiental@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-06-20','2014-06-20','15001',NULL,NULL,NULL,NULL,1),
  (5616,'900285446',299355,59871,7483.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TRUCHERA EL OASIS SAS','CR 73 9 51','3123790602','jc-contadoresasociadossa@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-04-15','2017-04-15','14954',NULL,NULL,NULL,NULL,1),
  (5617,'900299496',8025924,1605184.8,200648.1,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','INVERSIONES Y CONSTRUCCIONES DE COLOMBIA GUZMAN & GUZMAN LTDA SIGLA INVERCON G&G LTDA','CL 49  8B 93 EDIFICIO LA TORA OF 403','6022206','administrativa@invercongyg.com',62,1,'SERVICIOS',40,NULL,0,'2015-05-09','2017-05-09','15022',NULL,NULL,NULL,NULL,1),
  (5618,'900322539',2069083,413816.6,51727.075,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','AGUAS Y ASEO DE SUBACHOQUE ','CR 2  3 20','8245125','aguasyaseodesubachoque@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-09-02','2015-09-02','14932',NULL,NULL,NULL,NULL,1),
  (5619,'900338636',4441185,888237,111029.625,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','SERVIAMPETROL LTDA','CL 2  2 65','4284783','serviampetrol@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-08-08','2016-08-08','15059',NULL,NULL,NULL,NULL,1),
  (5620,'900344056',26051393,5210278.6,651284.825,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','LABORATORIO DE ENSAYOS QUIMICOS MICROBIOLOGICOS E INDUSTRIALES SA','CR 44  16 89','5245181','laboratorio@laboratoriosquimindustriales.com',62,1,'SERVICIOS',40,NULL,0,'2013-03-19','2015-03-19','14962',NULL,NULL,NULL,NULL,1),
  (5621,'900346779',24902767,4980553.4,622569.175,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','A&A CONSULTORIA E INGENIERIA SAS','CR 15 77 50 OF 301','2572232','contacto@aaconsultoriaeingenieria.com',62,1,'SERVICIOS',40,NULL,0,'2013-09-23','2015-09-23','14963',NULL,NULL,NULL,NULL,1),
  (5622,'900349815',557589,111517.8,13939.725,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','INVERSIONES AUTOMOTRICES DE COLOMBIA SAS','AV CR 24  62 39','3459646','',62,1,'SERVICIOS',40,NULL,0,'2013-03-15','2015-03-15','18040',NULL,NULL,NULL,NULL,1),
  (5623,'900363252',7223436,1444687.2,180585.9,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CENTRAL SAS','CL 12 8 77 ','3134487823','centalssas@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-09-23','2015-09-23','15025',NULL,NULL,NULL,NULL,1),
  (5624,'900365740',467248,93449.6,11681.2,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CONSORCIO EXPRESS SAS','CL 32 SUR 3 C 08','7431824','gerencia@consorcioexpress.co',62,1,'SERVICIOS',40,NULL,0,'2014-01-10','2016-01-10','14938',NULL,NULL,NULL,NULL,1),
  (5625,'900366632',771516,154303.2,19287.9,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','MR FRESH SAS','CL 83  45 72 LAVADERO TIENDA MAKRO','3178362880','ADRIANA.GUEVARA@GPC.COM.CO',62,1,'SERVICIOS',40,NULL,0,'2015-08-11','2017-08-11','15084',NULL,NULL,NULL,NULL,1),
  (5626,'900384381',13770658,2754131.6,344266.45,'2017-06-30','2017-07-19 11:02:02','2017-06-30 00:54:34','LUPIN ROSENBERTG ET ASSOCIES','CL 113  7 21 TORRE A OFICINA 1101','7021392','info@lupienrosenberg.com',62,5,'SERVICIOS',40,NULL,0,'2015-01-01','2017-01-01','14941',NULL,NULL,NULL,NULL,1),
  (5627,'900407026',115776,23155.2,2894.4,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','ESPECIALISTAS EN INGENIERA MEDIO AMBIENTE Y SERVICIOS SAS','CR 43A  16B 50 LOCAL 1001','3163339','',62,1,'SERVICIOS',40,NULL,0,'2015-07-08','2017-07-08','15057',NULL,NULL,NULL,NULL,1),
  (5628,'900414477',420420,84084,10510.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CONSTRUCCIONES TARENTO SAS','CL 72 7 64 P 2','3257176','ingeurbecont@etb.net.co',62,1,'SERVICIOS',40,NULL,0,'2014-11-05','2016-11-05','14988',NULL,NULL,NULL,NULL,1),
  (5629,'900418991',18995038,3799007.6,474875.95,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','UNION TEMPORAL PERFORACIONES 2','CL 93  49 A 12','3115548434','representantelegal.utp2010@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-08-03','2014-08-03','14969',NULL,NULL,NULL,NULL,1),
  (5630,'900444953',8171625,1634325,204290.625,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','INGENIERIA Y GESTION DE LA CALIDAD Y EL MEDIO AMBIENTE SAS','KM 19 VIA MOSQUERA MADRID','8933396','ingeqma@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-11-05','2015-11-05','15006',NULL,NULL,NULL,NULL,1),
  (5631,'900458973',218400,43680,5460,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','UNIVERSAL CLEAN SERVICES SAS','CR 24 33 A 60','5470953','president@ultragripsolutions.com',62,1,'SERVICIOS',40,NULL,0,'2014-02-25','2016-02-25','15028',NULL,NULL,NULL,NULL,1),
  (5632,'900461608',1260000,252000,31500,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','OIL LIFT TECHNOLOGY SAS ','CL 146  7 64  OF 303','2587100','oilfieldsolutions@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2012-07-07','2014-07-07','15031',NULL,NULL,NULL,NULL,1),
  (5633,'900473026',1782762,356552.4,44569.05,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','MINING & ENVIRONMENT SAS','CL 80 50 54 IN 1 AP 101','7037457','mining&environment@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-12-09','2016-12-09','14960',NULL,NULL,NULL,NULL,1),
  (5634,'900497538',835380,167076,20884.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','COMERCIALIZADORA PNS SAS','KM 5 VIA CAJICA TABIO','4887000','dduarte@alqueria.com.co',62,1,'SERVICIOS',40,NULL,0,'2015-06-23','2017-06-23','15080',NULL,NULL,NULL,NULL,1),
  (5635,'900529834',4112549,822509.8,102813.725,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','GEOSOLUCIONES AMBIENTALES SAS','CL 7 5 A ESTE 49','3213260191','geosoam@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2014-07-06','2016-07-06','15075',NULL,NULL,NULL,NULL,1),
  (5636,'900553170',2121420,424284,53035.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','EMBOTELLADORA DE LA SABANA SAS','KM 22 CENTRAL NORTE VEREDA CANAVITA','4011400','silvia.barrero@kof.com.mx',62,1,'SERVICIOS',40,NULL,0,'2014-11-25','2016-11-25','14929',NULL,NULL,NULL,NULL,1),
  (5637,'900563335',264941,52988.2,6623.525,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','FUNDACION DE INVESTIGACION Y METODOLOGIA PARA LA PROTECCION AMBIENTAL','CR 74  64 J 20','4306021','funalciencia@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-09-16','2017-09-16','14999',NULL,NULL,NULL,NULL,1),
  (5638,'900597916',1633780,326756,40844.5,'2017-06-30','2017-07-19 08:02:40','2017-06-30 00:54:34','QUIMICA INGENIERIA Y TECNOLOGIA ECOLOGICA SAS','CL 74  20A 63','3206625404','quinytec.sas@gmail.com',62,5,'SERVICIOS',40,NULL,0,'2013-11-13','2015-11-13','14972',NULL,NULL,NULL,NULL,1),
  (5639,'900607534',1226820,245364,30670.5,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','CONSORCIO BETA OIL','CL 93 15 59 OF 104','2576911','proyectos@oyping.com',62,1,'SERVICIOS',40,NULL,0,'2015-08-16','2017-08-16','15035',NULL,NULL,NULL,NULL,1),
  (5640,'900621490',58970835,11794167,1474270.875,'2017-06-30','2017-07-19 10:14:00','2017-06-30 00:54:34','ENERGIA RENOVABLES COLOMBIA ERECOL SAS','CR 43A  1 85 OF 411  EL POBLADO','3122315','iccsas@hotmail.es',62,5,'SERVICIOS',40,NULL,0,'2016-02-10','2018-02-10','14945',NULL,NULL,NULL,NULL,1),
  (5641,'900653911',8118995,1623799,202974.875,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','TRADIK SAS  ','CR 11  14 53','8526474','angelaarevaloromero@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-01-09','2017-01-09','15009',NULL,NULL,NULL,NULL,1),
  (5642,'900759947',14684879,2936975.8,367121.975,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','PETRONAL CO SUCURSAL COLOMBIA ','CL 100 11 A 35 P 3 // CL 187 46 51 CA 14','316711359','petronal@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-04-17','2017-04-17','14978',NULL,NULL,NULL,NULL,1),
  (5643,'900822710',1097554,219510.8,27438.85,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','BB SERVICIOS AMBIENTALES SAS  ','CL 45  41 07 RIONEGRO','345321559','bbotero@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-07-27','2017-07-27','15056',NULL,NULL,NULL,NULL,1),
  (5644,'93436132',3755722,751144.4,93893.05,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','LIZARRALDE GILDARDO  ','CL 22J  113 46 IN 20  AP 339','7037457','lizarralde_06@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2013-07-12','2015-07-12','14913',NULL,NULL,NULL,NULL,1),
  (5645,'9861392',184556,36911.2,4613.9,'2017-06-30','2017-06-30 00:54:34','2017-06-30 00:54:34','MARTINEZ RUIZ DIEGO MAURICIO  ','CR 18  43 20 SAN FERNANDO','3428463','diegoingecmacol@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2015-01-15','2017-01-15','15037',NULL,NULL,NULL,NULL,1),
  (5646,'22518962',13824789,2764957.8,345619.725,'2017-06-30','2017-06-30 13:14:29','2017-06-30 13:14:29','CHAPARRO VERGARA OLGA LUCIA','TRANSVERSAL 11 NO 27 C 05','3145682033','NASLYSOFIA@HOTMAIL.COM',147,1,'BIENES',40,NULL,0,'2014-12-10','2016-12-10','14347',NULL,NULL,NULL,NULL,1),
  (5647,'1054708679',7778744,1555748.8,194468.6,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','C I  BIOFLORA FARM LTDA','CL 3 NO 4 35','3144375554','',61,1,'BIENES',40,NULL,0,'2015-04-02','2017-04-02','00047',NULL,NULL,NULL,NULL,1),
  (5648,'12846650',1403671,280734.2,35091.775,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','FZ DISTRIBUCIONES MARKETING AGROPECUARIO ','CALLE 6 NO 2 45 BARRIO BRUCELAS EN PITALITO','3117572885','',114,1,'BIENES',40,NULL,0,'2013-10-12','2015-10-12','00061',NULL,NULL,NULL,NULL,1),
  (5649,'12972595',383922218,76784443.6,9598055.45,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','PROVEEDORA DE INSUMOS Y SERVICIOS AGRICOLAS ANONIMA  UNIPERSONAL  ','CL 20 C 12 08 BRR EL RECUERDO','7218470','',122,1,'BIENES',40,NULL,0,'2009-05-22','2011-05-22','00022',NULL,NULL,NULL,NULL,1),
  (5650,'15424230',75828524,15165704.8,1895713.1,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGRICOL LTDA','CR 16 10 39 AP 225','5613032','',11,1,'BIENES',40,NULL,0,'2008-10-27','2010-10-27','00030',NULL,NULL,NULL,NULL,1),
  (5651,'3336958',5355176,1071035.2,133879.4,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGROINDUSTRIAL LA PRADERA LTDA','CL 36 21 67 OF 206','6472091','',138,1,'BIENES',40,NULL,0,'2009-06-30','2011-06-30','00052',NULL,NULL,NULL,NULL,1),
  (5652,'40369987',5042600,1008520,126065,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','COMERCIALIZAR B R ','CR 6 23 32','6430200','',62,1,'BIENES',40,NULL,0,'2009-03-26','2011-03-26','00053',NULL,NULL,NULL,NULL,1),
  (5653,'40401494',4631856,926371.2,115796.4,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','CONDE APARICIO Y CIA CENTRO AGRICOLA S A ','CL 48 29 A 76 CA 128 CONJ ARAGUANEY BRR CAUDAL\n','3183836443','',120,1,'BIENES',40,NULL,0,'2009-11-27','2011-11-27','00055',NULL,NULL,NULL,NULL,1),
  (5654,'4290928',55951220,11190244,1398780.5,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','LADINO PINZON ANA CECILIA ','CL 6 9 08 BRR CENTRO','3143574680','',62,1,'BIENES',40,NULL,0,'2015-02-26','2017-02-26','00032',NULL,NULL,NULL,NULL,1),
  (5655,'52466176',7659300,1531860,191482.5,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','EMPRESA PECOOPERATIVA COAGROSPLENDOR ','CR 79 H 58 C 33 BRR JOSE ANTONIO GALAN\n','7792728','',62,1,'BIENES',40,NULL,0,'2008-10-03','2010-10-03','00048',NULL,NULL,NULL,NULL,1),
  (5656,'63749990',22681757,4536351.4,567043.925,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','PRODIAGRO E U  Y DISTRIBUCIONES AGROPECIARIAS ','CARRERA 5 NO 24 52   CARRERA 3   9 55 OF 303A','2611375','',155,1,'BIENES',40,NULL,0,'2011-11-28','2013-11-28','00038',NULL,NULL,NULL,NULL,1),
  (5657,'70908667',3146172,629234.4,78654.3,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','TUMBAJOY CIRO ANIBAL ','CL 31 30 B 42','3667615','',10,1,'BIENES',40,NULL,0,'2014-06-25','2016-06-25','00058',NULL,NULL,NULL,NULL,1),
  (5658,'79184903',88178088,17635617.6,2204452.2,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','ROJAS CIERRA OMAR ARMANDO ','CR 2 3 25 UNE CUNDINAMARCA','3163521241','',61,1,'BIENES',40,NULL,0,'2013-05-18','2015-05-18','00062',NULL,NULL,NULL,NULL,1),
  (5659,'800200232',3135458,627091.6,78386.45,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','INVERSIONES LOS SAMANES LTDA','CALLE 14 NO 16 17','2243551','',62,1,'BIENES',40,NULL,0,'2016-01-26','2018-01-26','00059',NULL,NULL,NULL,NULL,1),
  (5660,'800200232',6663218,1332643.6,166580.45,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','COMERCIALIZADORA JO AGRO S A S','CR 28 46 48','2753290','',186,1,'BIENES',40,NULL,0,'2007-09-26','2009-09-26','00051',NULL,NULL,NULL,NULL,1),
  (5661,'801002214 4',162678920,32535784,4066973,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','EMPRESA COOPERATIVA COMINSUCAMPO ','CL 26 15 42 LC 5\n\n','7411952','',128,1,'BIENES',40,NULL,0,'2012-03-27','2014-03-27','00026',NULL,NULL,NULL,NULL,1),
  (5662,'80545037',4999926,999985.2,124998.15,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','DISTRIBUIDORA AGRICOLA Y VETERINAROA LA 24 ','CR 17 61 N 66 CA G 08 BRR LOS ARRAYANES','8373787','',52,1,'BIENES',40,NULL,0,'2012-12-09','2014-12-09','00054',NULL,NULL,NULL,NULL,1),
  (5663,'809006593',8321868,1664373.6,208046.7,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','MERA GONZALES ERNESTO RENE','CARRERA 5 NO 25 03 YOPAL','6348385','',62,1,'BIENES',40,NULL,0,'2011-10-28','2013-10-28','00046',NULL,NULL,NULL,NULL,1),
  (5664,'813003788',3165848,633169.6,79146.2,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGRICOLA LA COSECHA DE AGECIRAS LTDA ','CL 7 1 17 BRR CENTRO','3153236431','',114,1,'BIENES',40,NULL,0,'2015-07-26','2017-07-26','00057',NULL,NULL,NULL,NULL,1),
  (5665,'816007447 0',7502962,1500592.4,187574.05,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','PABON PADILLA MARTHA ISABEL','CL 7 14 48 BARRIO CAMBULOS','3357927','',135,1,'BIENES',40,NULL,0,'2009-11-24','2011-11-24','00049',NULL,NULL,NULL,NULL,1),
  (5666,'820001092 7',8651460,1730292,216286.5,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','DISTRIBUIDORA AGROPECIARIO BACATA ','CL 33 A 15 A 04 BRR LA PRIMAVERA\n','3153016955','',62,1,'BIENES',40,NULL,0,'2011-05-09','2013-05-09','00045',NULL,NULL,NULL,NULL,1),
  (5667,'830027649 8',34018143,6803628.6,850453.575,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','GàNZALEZ LOPEZ JENNY BIBIANA ','Cr 15A NRO  8A 25 ','7748717','',58,1,'BIENES',40,NULL,0,'2009-03-27','2011-03-27','00035',NULL,NULL,NULL,NULL,1),
  (5668,'830125279',75328610,15065722,1883215.25,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','SETA INSUMOS LTDA ','CL 30 A 6 22 OF 3101','2315534','',62,1,'BIENES',40,NULL,0,'2008-04-14','2010-04-14','00031',NULL,NULL,NULL,NULL,1),
  (5669,'830506953 8',21723722,4344744.4,543093.05,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','CANTE AREVALO JOSE GUSTAVO ','CD INDUSTRIAL TERPEL KM 1 VIA PALERMO MZ A BG 2\n','8750731','',114,1,'BIENES',40,NULL,0,'2008-04-19','2010-04-19','00039',NULL,NULL,NULL,NULL,1),
  (5670,'8440018891',218592893,43718578.6,5464822.325,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGRICOLA DISTRICAMPO LTDA','Cl 30 NRO  28 46 T15 AP 104','6354482','',62,1,'BIENES',40,NULL,0,'2008-03-13','2010-03-13','00023',NULL,NULL,NULL,NULL,1),
  (5671,'900011909',181128466,36225693.2,4528211.65,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGROCOTORRA LTDA','DG 2 7 24','3155214885','',114,1,'BIENES',40,NULL,0,'2016-05-28','2018-05-28','00025',NULL,NULL,NULL,NULL,1),
  (5672,'900087742 5',87141800,17428360,2178545,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','8 A PEREZ S A S ','CL 13 1 B 45\n\n','2277612','',155,1,'BIENES',40,NULL,0,'2011-08-05','2013-08-05','00029',NULL,NULL,NULL,NULL,1),
  (5673,'900139649',38145511,7629102.2,953637.775,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','GREEN PROTECCION DE CULTIVOS LTDA ','AV IDEMA ZONA INDUSTRIAL REMOLINO','2484390','',155,1,'BIENES',40,NULL,0,'2012-03-23','2014-03-23','00034',NULL,NULL,NULL,NULL,1),
  (5674,'900155915',25033823,5006764.6,625845.575,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','PROFIAGRO PUPIALES ','CL LA ESPERANZA CR 4 12 A 11 BR  LA ESPERANZA','6875358','',62,1,'BIENES',40,NULL,0,'2016-01-26','2018-01-26','00037',NULL,NULL,NULL,NULL,1),
  (5675,'900167595',4483500,896700,112087.5,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','TECNICAMPO DEL CENTRO S A S ','CL 18 56 40','3319246','',169,1,'BIENES',40,NULL,0,'2009-02-19','2011-02-19','00056',NULL,NULL,NULL,NULL,1),
  (5676,'900195143 6',99358386,19871677.2,2483959.65,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','ROJAS CIERRA OMAR ARMANDO ','CR 5 5 50 BRR CENTRO CORR CHICORAL','2889043','',151,1,'BIENES',40,NULL,0,'2009-09-24','2011-09-24','00027',NULL,NULL,NULL,NULL,1),
  (5677,'900226908',12257058,2451411.6,306426.45,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','COMERCIALIZADORA DEL CAMPO LTDA ','CR 5 12 04','8532651','',52,1,'BIENES',40,NULL,0,'2014-04-02','2016-04-02','00041',NULL,NULL,NULL,NULL,1),
  (5678,'900275328',185674296,37134859.2,4641857.4,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','JAIME LOPEZ ACEVEDO ','CL 7 SUR 13 A 21','7455037','',43,1,'BIENES',40,NULL,0,'2012-11-28','2014-11-28','00024',NULL,NULL,NULL,NULL,1),
  (5679,'900281348',88178088,17635617.6,2204452.2,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','COMERCIALIZADORA AGROSERVICE E U ','CL 8 15 55 BRR LAS AMERICAS','3106036903','',59,1,'BIENES',40,NULL,0,'2015-01-30','2017-01-30','00028',NULL,NULL,NULL,NULL,1),
  (5680,'900314219',6873861,1374772.2,171846.525,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AVENDA¥O YARSE NICOLAS ALBERTO ','KM 2 VTE LA UNION TORO CARRETERA PANORAMA','2293879','',183,1,'BIENES',40,NULL,0,'2010-03-01','2012-03-01','00050',NULL,NULL,NULL,NULL,1),
  (5681,'900408946',19015051,3803010.2,475376.275,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','CARLOS ROBERTO RAMIREZ','CR 4 13 A 11','3204917494','',70,1,'BIENES',40,NULL,0,'2015-03-23','2017-03-23','00040',NULL,NULL,NULL,NULL,1),
  (5682,'900522629',33339758,6667951.6,833493.95,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','CIRO ANTONIO FUENTES MORENO ','CR 23 28 41 BRR SAJONIA','3217007908','',193,1,'BIENES',40,NULL,0,'2016-01-26','2018-01-26','00036',NULL,NULL,NULL,NULL,1),
  (5683,'900528454',10954361,2190872.2,273859.025,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','GRUPO C LOZANO NILO S A S ','KM 2 VIA PALERMO BG 2\n\n','8751833','',114,1,'BIENES',40,NULL,0,'2015-12-28','2017-12-28','00043',NULL,NULL,NULL,NULL,1),
  (5684,'900552328',11487513,2297502.6,287187.825,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGRIOCONAL LTDA ','CALLE 1 NO 11 34 GUADALAJARA','2280646','',166,1,'BIENES',40,NULL,0,'2015-02-18','2017-02-18','00042',NULL,NULL,NULL,NULL,1),
  (5685,'900638270',1167443200,233488640,29186080,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','FERTILIZANTES Y AFROINSUMOS LIMITADA ','CL 7 8 B 40 BRR BARRIO PABLO VI','3126551466','',58,1,'BIENES',40,NULL,0,'2014-04-15','2016-04-15','00021',NULL,NULL,NULL,NULL,1),
  (5686,'900765464',3074152,614830.4,76853.8,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','AGROARMENIA SAS','CR 23 29 A 10 BRR CENTRO\n\n','3128639097','',62,1,'BIENES',40,NULL,0,'2016-09-11','2018-09-11','00060',NULL,NULL,NULL,NULL,1),
  (5687,'9261246',46496926,9299385.2,1162423.15,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','DINAMICA REGIONAL PRECOOPERATIVA ','CR 8 34 31','3126982693','',59,1,'BIENES',40,NULL,0,'2009-07-06','2011-07-06','00033',NULL,NULL,NULL,NULL,1),
  (5688,'98364090',9555820,1911164,238895.5,'2017-06-30','2017-06-30 14:14:54','2017-06-30 14:14:54','OTALORA ROJAS DIEGO ALEXANDER ','CR 2   4 45 BRR SAN FRANCISCO','3013937842','',121,1,'BIENES',40,NULL,0,'2008-09-25','2010-09-25','00044',NULL,NULL,NULL,NULL,1),
  (6065,'830049122',9127170,1825434,228179.25,'2017-06-30','2017-07-19 09:43:35','2017-06-30 16:19:54','PT INGENIERIA DE PROYECTOS SA','CRA 51   102A   68','6110701','',62,5,'BIENES',40,NULL,0,'2014-06-12','2016-06-12','14352',NULL,NULL,NULL,NULL,1),
  (6066,'860001330',43698921,8739784.2,1092473.025,'2017-06-30','2017-07-19 09:44:20','2017-06-30 16:19:54','CONSULTECNICA SA','CARRERA 82B No 54a 03 sur','7841024','financiero@consultecnica.com.co',62,5,'BIENES',40,NULL,0,'2014-06-10','2016-06-10','14320',NULL,NULL,NULL,NULL,1),
  (6067,'860048529',11655424,2331084.8,291385.6,'2017-06-30','2017-06-30 16:19:54','2017-06-30 16:19:54','HIDROAGRICOLAS REPA Y GALLO LTDA','FUNZA VIA A LA ARGENTINA KM 1 ','3123823952','MAURICIOGALLO61@HOTMAIL.COM',76,1,'BIENES',40,NULL,0,'2014-06-11','2016-06-11','14453',NULL,NULL,NULL,NULL,1),
  (6076,'10207225834',3419724,683944.8,85493.1,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROGUERIA MILENIO COFREM','CRA 35  54A  08 MANZ CASS BRASILIA','6812770','JUANFERNANDO-MG@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-02-23','2017-02-23','85145',NULL,NULL,NULL,NULL,1),
  (6077,'10957883581',1901712,380342.4,47542.8,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROGUERIA PHARMA PAZ','CR 50 W 49 A 03 BRR RINCON DE LA PAZ','6769098','',62,1,'BIENES',40,NULL,0,'2015-12-09','2017-12-09','27615',NULL,NULL,NULL,NULL,1),
  (6078,'1101752083',7919687,1583937.4,197992.175,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','COMERCIALIZADORA MERCATODO','CRA 18   11  62 I NT 15 LC 109','3203452886','ymnieves@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-02-09','2017-02-09','45942',NULL,NULL,NULL,NULL,1),
  (6079,'11219009701',1353352,270670.4,33833.8,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','SUPER LOS PAISANOS','CR 22S   52B 47 51','3106574509','CHOQUETICO89_LOVE@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-03-04','2018-03-04','58848',NULL,NULL,NULL,NULL,1),
  (6080,'11240128919',2041380,408276,51034.5,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROG  BARRANQUILLA DE ORO','CR 17   12 10','3116795395','',62,1,'BIENES',40,NULL,0,'2013-04-19','2015-04-19','34592',NULL,NULL,NULL,NULL,1),
  (6081,'134910375',19310067,3862013.4,482751.675,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','BODEGA SANTANDERANA','GLP A LOCAL 21 CENABASTOS ','3107782590','ALFREDOQUINDU13@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-05-06','2018-05-06','23147',NULL,NULL,NULL,NULL,1),
  (6082,'161886130',16449942,3289988.4,411248.55,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','GRANERO MERCATODO J C ','CR 33 47 74','6475532','fiestasin15@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-12-04','2017-12-04','24768',NULL,NULL,NULL,NULL,1),
  (6083,'22058378',51381304,10276260.8,1284532.6,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','AGENCIA DE ABARROTES MR','CLL 51 N 45 45','3205800214','',62,1,'BIENES',40,NULL,0,'2015-04-02','2017-04-02','12548',NULL,NULL,NULL,NULL,1),
  (6084,'274784630',1947306,389461.2,48682.65,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','AUTO SERVICIO LA RIVERA MBB ','CLL 70C   11 C 47 ','3142708868','CREMINDA70@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2015-11-30','2017-11-30','35486',NULL,NULL,NULL,NULL,1),
  (6085,'31730479',4247684,849536.8,106192.1,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','ALARCON YEPES PEDRO JOSE ','CR 9   7 52 ','3124326966','nutrifor47@gmail.com',62,1,'BIENES',40,NULL,0,'2014-05-03','2016-05-03','25487',NULL,NULL,NULL,NULL,1),
  (6086,'394165941',2027831,405566.2,50695.775,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','GRANERO MIXTO E VECINO','CLL 104 N21 04','8273853','MILADY24NOV@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-02-12','2018-02-12','68452',NULL,NULL,NULL,NULL,1),
  (6087,'400197845',1805644,361128.8,45141.1,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','PA¥ALERAS TUTYS ','CRA 102   131 70','6862208','',62,1,'BIENES',40,NULL,0,'2015-05-03','2017-05-03','58745',NULL,NULL,NULL,NULL,1),
  (6088,'406145643',732901,146580.2,18322.525,'2017-06-30','2017-06-30 17:23:44','2017-06-30 18:59:32','DROGUERIA SUPER NUEVA ','CRA5 N 5 48 CENTRO ','3202748195','',62,2,'BIENES',40,NULL,0,'2016-02-08','2018-02-08','95214',NULL,NULL,NULL,NULL,1),
  (6089,'52116722',2572014,514402.8,64300.35,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','SUPER MERCADFO BARATODO','CRA 7 N 21 33','321492081','miriamhernnadez_73@yahoo.es',62,1,'BIENES',40,NULL,0,'2012-04-05','2014-04-05','21345',NULL,NULL,NULL,NULL,1),
  (6090,'63324317',5189333,1037866.6,129733.325,'2017-06-30','2017-06-30 16:34:57','2017-06-30 18:59:32','GARCIA GOMEZ BLANCA','CL 55 17 C 06 LC 806 08 P 1 ','376427412','acastiltda@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-01-05','2017-01-05','35641',NULL,NULL,NULL,NULL,1),
  (6091,'716210139',29469101,5893820.2,736727.525,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','GRANOS Y ENLATADOS LA GRAN CICALOTA ','CRA 14   104 33','3146764416','',62,1,'BIENES',40,NULL,0,'2016-02-03','2018-02-03','89553',NULL,NULL,NULL,NULL,1),
  (6092,'73073552',3608731,721746.2,90218.275,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROGUERIA REPUBLICA DE CHILE','MANZANA 67 LOTE 13','3014511546','',62,1,'BIENES',40,NULL,0,'2016-08-03','2018-08-03','35871',NULL,NULL,NULL,NULL,1),
  (6093,'76986870',7868885,1573777,196722.125,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DISTRIB  DE QUESO CAQUETA JHON','CR 5 26 73','6725992','JHONCARD123@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-03-27','2018-03-27','67819',NULL,NULL,NULL,NULL,1),
  (6094,'8000408831',44026151,8805230.2,1100653.775,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','SUPERVENTAS LTDA','CARRERA 100 No 97 57','8281018','SUPERVENTAS@EDATEL.NET.COM',62,1,'BIENES',40,NULL,0,'2016-05-31','2018-05-31','14419',NULL,NULL,NULL,NULL,1),
  (6095,'800273963',31533729,6306745.8,788343.225,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','LOS CHAGUALOS PRADO','BRR EL PRADO TV 25 D 22 20 MZ 147','3116331853','raulmarinogomez@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-09-24','2017-09-24','50886',NULL,NULL,NULL,NULL,1),
  (6096,'8300649783',44765379,8953075.8,1119134.475,'2017-06-30','2017-07-19 11:12:08','2017-06-30 18:59:32','IMPORT  Y DIST  CRISTIAN S A','CALLE 35 SUR   70   14','7444344','',62,5,'BIENES',40,NULL,0,'2014-12-01','2016-12-01','33169',NULL,NULL,NULL,NULL,1),
  (6097,'83233091',2271062,454212.4,56776.55,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROGUERIA BRAYAN','CLL 132   96 37','3123879575','drogueriabrayan83@hotmail.com',62,1,'BIENES',40,NULL,0,'2015-10-02','2017-10-02','35558',NULL,NULL,NULL,NULL,1),
  (6098,'840884995',1949818,389963.6,48745.45,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','DROGUERIA ANA','CALLE 2  7 194','3004503984','',62,1,'BIENES',40,NULL,0,'2015-08-23','2017-08-23','62810',NULL,NULL,NULL,NULL,1),
  (6099,'881977350',5603929,1120785.8,140098.225,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','ABASTO CAMILO ORLANDO ','GA 17 MOD 2 CENTRAMAYORISTA URB GARCIA HERREROS','3172626717','JREYESUILLAN@HOTMAIL.COM',62,1,'BIENES',40,NULL,0,'2012-02-20','2014-02-20','78453',NULL,NULL,NULL,NULL,1),
  (6100,'891100024',65131397,13026279.4,1628284.925,'2017-06-30','2017-07-19 11:09:36','2017-06-30 18:59:32','ALMACENES YEP S AA','CRA 6A   20   54','3174336947','florencia@almacenesyep.com.co',62,5,'BIENES',40,NULL,0,'2014-11-18','2016-11-18','14416',NULL,NULL,NULL,NULL,1),
  (6101,'8911000249',64284356,12856871.2,1607108.9,'2017-06-30','2017-07-19 11:09:08','2017-06-30 18:59:32','ALMACENES YEP S A  ','KILOMETRO 3 VIA FUNZA   SIBERIA PARQ  IND GALICIA BOD  11 Y 12','8259775','',62,5,'BIENES',40,NULL,0,'2014-12-15','2016-12-15','30837',NULL,NULL,NULL,NULL,1),
  (6102,'9001067009',3841725,768345,96043.125,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','AGROVETERINARIA MENEGUA LTDA','CLL 6  11 021','3102942512','AGROVETMENEGUA@YAHOO.COM',62,1,'BIENES',40,NULL,0,'2011-12-31','2013-12-31','21546',NULL,NULL,NULL,NULL,1),
  (6103,'900318758',29133156,5826631.2,728328.9,'2017-06-30','2017-07-19 10:59:57','2017-06-30 18:59:32','PHARMACEUTICAL HEALTH CARE SAS','TRANSVERSAL 93 NO  53 48 BODEGA 88','3005454961','GERENCIA@PHARMACEUTICALHC.COM',62,5,'BIENES',40,NULL,0,'2015-10-15','2017-10-15','14838',NULL,NULL,NULL,NULL,1),
  (6104,'9003595545',13493844,2698768.8,337346.1,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','PA¥ALERIA Y CACHARRERIA EL DESCUENTO S A S','CLL 52  12C 25','3014511545','ELDESCUENTO.PANALERA@GMAIL.COM',62,1,'BIENES',40,NULL,0,'2016-03-02','2018-03-02','27614',NULL,NULL,NULL,NULL,1),
  (6105,'9004732562',23061135,4612227,576528.375,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','PA LA TIENDA SAS','CR 4 A 20 65 BARRIO EL CARMEN','3212258316','',62,1,'BIENES',40,NULL,0,'2016-04-23','2018-04-23','19679',NULL,NULL,NULL,NULL,1),
  (6106,'9005075493',38131518,7626303.6,953287.95,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','SERVI EXPRESS PLAZA SAS','CALLE 8 No 42c 22 LOCAL 2','3797272','distribucionesserviexpressplaza@hotmail.com',62,1,'BIENES',40,NULL,0,'2016-11-08','2018-11-08','32815',NULL,NULL,NULL,NULL,1),
  (6107,'900521055',34866177,6973235.4,871654.425,'2017-06-30','2017-06-30 18:59:32','2017-06-30 18:59:32','SOLUCIONES PARA EMPAQUES SAS ','CLL 26 N 109 40   AC 24 N 75 54 APTO 302','3012364055','infosoluempaques.com',62,1,'BIENES',40,NULL,0,'2013-05-06','2015-05-06','23168',NULL,NULL,NULL,NULL,1),
  (6177,'7186191',515084,103016.8,12877.1,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','JOSE HERACLIO MERCHAN GAONA','cra 5  10 49 apto 404','3102318805','josemercha08@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2017-11-21','2019-11-21','900145780',NULL,NULL,NULL,NULL,1),
  (6178,'800090968',1486636,297327.2,37165.9,'2017-06-30','2017-07-06 15:47:08','2017-06-30 20:27:56','ESTACION DE SERVICIO ZONA FRANCA SAS',' Barrio Mnaga calle  29 27 05','6607853','lsolana@districandelaria.com',62,2,'SERVICIOS',40,NULL,0,'2017-03-12','2019-03-12','800090968',NULL,NULL,NULL,NULL,1),
  (6179,'800201668',712983,142596.6,17824.575,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','SEGURIDAD ONCOR LTDA','carrera 49 C 93 08 ','6211605','',62,1,'SERVICIOS',40,NULL,0,'2017-01-06','2019-01-06','800201668',NULL,NULL,NULL,NULL,1),
  (6180,'800216303',9471223,1894244.6,236780.575,'2017-06-30','2017-07-05 10:11:07','2017-06-30 20:27:56','HOSPITAL SAN BLAS','trasversal 5 este  19 52 sur','3280969','',62,2,'SERVICIOS',40,NULL,0,'2017-08-16','2019-08-16','800216303',NULL,NULL,NULL,NULL,1),
  (6181,'802008914',11572634,2314526.8,289315.85,'2017-06-30','2017-07-06 09:33:06','2017-06-30 20:27:56','HOTEL BARRANQUILLA PLAZA S A ','Avenida Alberto Assa  79 246','3610000','tesoreria@hbp.com.co',17,2,'SERVICIOS',40,NULL,0,'2017-08-14','2019-08-14','802008914',NULL,NULL,NULL,NULL,1),
  (6182,'802023443',3129286,625857.2,78232.15,'2017-06-30','2017-07-06 14:17:30','2017-06-30 20:27:56','NVERSIONES T  DURAN & CIA  SAS','Carrera 32 30 15 Soledad','3634141','danieltarud@hotmail.com',17,2,'SERVICIOS',40,NULL,0,'2017-08-25','2019-08-25','802023443',NULL,NULL,NULL,NULL,1),
  (6183,'805017907',6060118,1212023.6,151502.95,'2017-06-30','2017-07-05 10:19:29','2017-06-30 20:27:56','J  Y P  LTDA','Calle 10 43 11 ','6807296','jypltda@une.net.co',169,2,'SERVICIOS',40,NULL,0,'2017-09-18','2019-09-18','805017907',NULL,NULL,NULL,NULL,1),
  (6184,'830109503',2120795,424159,53019.875,'2017-06-30','2017-07-06 14:56:32','2017-06-30 20:27:56','INVERSIONES COMBITA LIMITADA','carvajal kennedy  calle 26 A sur No 64 A 39','2702201','invercomltda@hotmail.com',62,2,'SERVICIOS',40,NULL,0,'2017-09-21','2019-09-21','830109503',NULL,NULL,NULL,NULL,1),
  (6185,'830509551',1784447,356889.4,44611.175,'2017-06-30','2017-07-06 15:39:40','2017-06-30 20:27:56','INVERSIONES SAMORE SAS','Carrera  31 38 A 51 Sur ','7204182','admin@briosamore.com',62,2,'SERVICIOS',40,NULL,0,'2017-07-28','2019-07-28','830509551',NULL,NULL,NULL,NULL,1),
  (6186,'860005140',5513046,1102609.2,137826.15,'2017-06-30','2017-07-05 10:33:43','2017-06-30 20:27:56','SURTIDORA DE AVES SUCURSAL LTDA','Calle 22  14 50','6000949','',62,2,'SERVICIOS',40,NULL,0,'2017-09-20','2019-09-20','860005140',NULL,NULL,NULL,NULL,1),
  (6187,'890901177',206693,41338.6,5167.325,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','COOFINEP YOLOMBO','carrera 7  35 27','6076565','',43,1,'SERVICIOS',40,NULL,0,'2017-09-25','2019-09-25','890901177',NULL,NULL,NULL,NULL,1),
  (6188,'890906033',1324100,264820,33102.5,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','COOP DE TRANSPORTADORES SAN ANTONIO',' Calle 42 S 74 04 Medell­n','4440468','juridica@cootrasana.com.co',62,1,'SERVICIOS',40,NULL,0,'2017-09-14','2019-09-14','890906033',NULL,NULL,NULL,NULL,1),
  (6189,'890906465',497858,99571.6,12446.45,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','JUANBE CENTRO MUNDIAL DE LLANTAS LTDA','Calle  8 B 65 281 Medell­n','4488011','',11,1,'SERVICIOS',40,NULL,0,'2017-11-23','2019-11-23','890906465',NULL,NULL,NULL,NULL,1),
  (6190,'892301629',5199755,1039951,129993.875,'2017-06-30','2017-07-05 10:34:35','2017-06-30 20:27:56','SERVIPAN S A ','Villa Ol­mpica Lt 46','3823170','',17,2,'SERVICIOS',40,NULL,0,'2017-09-21','2019-09-21','892301629',NULL,NULL,NULL,NULL,1),
  (6191,'900026211',1215065,243013,30376.625,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','DISTRIBUCIONES SANTA MARTA S A S ','carrera 10 9 A 36 Santa Marta','4200068','maryury.prada@disan.co',62,1,'SERVICIOS',40,NULL,0,'2017-09-09','2019-09-09','900026211',NULL,NULL,NULL,NULL,1),
  (6192,'900043796',3208385,641677,80209.625,'2017-06-30','2017-07-06 14:06:33','2017-06-30 20:27:56','GAS NATURAL VEHICULAR SAN BUENAVENTURA  S A','Carrera 4 32 84 soacha','5797194','p.gas.snbuenaventura@etb.net.co',62,2,'SERVICIOS',40,NULL,0,'2017-05-24','2019-05-24','900043796',NULL,NULL,NULL,NULL,1),
  (6193,'900120482',3823961,764792.2,95599.025,'2017-06-30','2017-07-06 14:01:40','2017-06-30 20:27:56','INVERSIONES JR & A','Av Cr  9 103 39˜','6121088','estacionbiomax103@hotmail.com',62,2,'SERVICIOS',40,NULL,0,'2017-09-23','2019-09-23','900120482',NULL,NULL,NULL,NULL,1),
  (6194,'900139910',38483805,7696761,962095.125,'2017-06-30','2017-07-05 09:43:38','2017-06-30 20:27:56','DON JEDIONDO SOPITAS Y PARRILLA S A S','Carrera 55 B 79 B 50','7953590','contabilidad@donjediondo.com',62,2,'SERVICIOS',40,NULL,0,'2017-03-12','2019-03-12','900139910',NULL,NULL,NULL,NULL,1),
  (6195,'900425332',1221003,244200.6,30525.075,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','EDS SANTA ELENA VALLE S A S','carrera santa elena la blanquita  el cerrito  valle','2557401','estacion_santahelena@hotmail.com',62,1,'SERVICIOS',40,NULL,0,'2017-07-14','2019-07-14','900425332',NULL,NULL,NULL,NULL,1),
  (6196,'900449021',907497,181499.4,22687.425,'2017-06-30','2017-07-07 14:21:43','2017-06-30 20:27:56','HERCUR SAS','Calle 132 94 F 52','6862698','dicol.ltda@hotmail.com',62,2,'SERVICIOS',40,NULL,0,'2117-03-12','2119-03-12','900449021',NULL,NULL,NULL,NULL,1),
  (6197,'900464256',2152163,430432.6,53804.075,'2017-06-30','2017-07-06 14:51:31','2017-06-30 20:27:56','EL PARAISO DE ROZO S A S ','kilometro 7 via palma seca rozo palmira valle','3188273812','rozo@yahoo.com',186,2,'SERVICIOS',40,NULL,0,'2017-06-27','2019-06-27','900464256',NULL,NULL,NULL,NULL,1),
  (6198,'900513317',6739525,1347905,168488.125,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','KNOW HOW CONSULTING SAS','Carrera 7 BIS A 124 45','6942244','nelson.4cabrera@gmail.com',62,1,'SERVICIOS',40,NULL,0,'2017-08-17','2019-08-17','900513317',NULL,NULL,NULL,NULL,1),
  (6199,'900607916',3097142,619428.4,77428.55,'2017-06-30','2017-07-06 14:31:08','2017-06-30 20:27:56','DORADOS Y PLATEADOS RABY S A S','Calle 70 A Bis 23 18','6063436','yandrademoreno@gmail.com',62,2,'SERVICIOS',40,NULL,0,'2017-06-26','2019-06-26','900607916',NULL,NULL,NULL,NULL,1),
  (6200,'900631450',29000000,5800000,725000,'2017-06-30','2017-07-06 09:08:16','2017-06-30 20:27:56','DESARROLLADORA CC  FONTANAR S A S ','Carrera 19 A 90 13','3794848','aida.correa@cimento.com',62,2,'SERVICIOS',40,NULL,0,'2017-06-14','2019-06-14','900631450',NULL,NULL,NULL,NULL,1),
  (6201,'900925006',5795376,1159075.2,144884.4,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','NEGOCIOS E INVERSIONES MONTESUR S A S ','Carrera 25 25 268 Av Okala˜','3116608316','marielah@comaderas.com',147,1,'SERVICIOS',40,NULL,0,'2017-09-19','2019-09-19','900925006',NULL,NULL,NULL,NULL,1),
  (6202,'900952494',10261951,2052390.2,256548.775,'2017-06-30','2017-06-30 20:27:56','2017-06-30 20:27:56','ADMINISTRACI…N DE ESTACIONES LA UNION S A S','CALLE 68 19 84','6062942','franciscogomez@outlook.com',62,1,'SERVICIOS',40,NULL,0,'2017-08-15','2019-08-15','900952494',NULL,NULL,NULL,NULL,1),
  (6203,'11522356',8480626,1696125.2,212015.65,'2017-07-02','2017-07-05 17:20:44','2017-07-02 17:49:41','JUAN CARLOS RUIZ','KR 50A No 1174b 06 in 3ap 201','3005070765','INDESJC@HOTMAIL.COM',62,2,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16079',NULL,NULL,NULL,NULL,1),
  (6204,'13488429',21958259,4391651.8,548956.475,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','IBARRA ALBARRACIN JOSE RAMON','AVDA KR 15 No 17065 TR 4 AP315','3156363681','tecdimec@gmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14433',NULL,NULL,NULL,NULL,1),
  (6205,'15510858',22750422,4550084.4,568760.55,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','HERBERT VINCK POSADA','KR 49B 171A 20  CASA  5','3127276682','LIGIANORA@GMAIL.COM',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16083',NULL,NULL,NULL,NULL,1),
  (6206,'16666395',4744172,948834.4,118604.3,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','CASTRO SALAZAR MARIO','Cll 85 No 60 13 casa 154','3138799739','mariocasal2003@yahoo.es',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14432',NULL,NULL,NULL,NULL,1),
  (6207,'17070462',511480,102296,12787,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','ARDILA SANCHEZ ENRIQUE','CL 175 No17B 80 PI 6 AP 201','6682633','enmarhari@gmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14431',NULL,NULL,NULL,NULL,1),
  (6208,'18260835',1460214,292042.8,36505.35,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','PEREZ BAUTISTA ALONSO','CALLE 173 A No 20A 32 INT 8  APT 430','3105571593','alonsoperez.consultores@gmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14428',NULL,NULL,NULL,NULL,1),
  (6209,'19217871',7681620,1536324,192040.5,'2017-07-02','2017-07-14 12:17:09','2017-07-02 17:49:41','JOSE ARMANDO DIAZ','Krr 50 134 32','3123092311','JOSEARMANDO-52@HOTMAIL.COM',62,2,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','17088',NULL,NULL,NULL,NULL,1),
  (6210,'26988977',4223400,844680,105585,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','DILIA ROSA CARRILLO','CLL 26 59 51','3177176492','',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16006',NULL,NULL,NULL,NULL,1),
  (6211,'52055274',8261499,1652299.8,206537.475,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','PATRICIA CORTES AGUIRRE','CLL 159  56 75 AP 703 T3','3115607434','patriciacortesag@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','13925',NULL,NULL,NULL,NULL,1),
  (6212,'52089080',14989491,2997898.2,374737.275,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','AMALFI MARITZA PINEDA','CLL 62 17141','3142271423','',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16084',NULL,NULL,NULL,NULL,1),
  (6213,'5934320',1845129,369025.8,46128.225,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','SAENZ NESTOR HUGO','KR 62 No171 41 IN8','3142442181','asaenz44@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2012-04-15','2014-04-15','14435',NULL,NULL,NULL,NULL,1),
  (6214,'71692775',5893036,1178607.2,147325.9,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','ALVAREZ ALDANA JOSE LUIS','CL 182 No 45  45  AP1101 TR 5','3105669251','joseluisalvarez67@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14430',NULL,NULL,NULL,NULL,1),
  (6215,'79217122',7053944,1410788.8,176348.6,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','ROZO ESCOBAR DAVID RICARDO','Tranversal 76 No 130-48 bloque 8 apt 502','5330852','davidehijo@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14434',NULL,NULL,NULL,NULL,1),
  (6216,'79385439',1597979,319595.8,39949.475,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','RODRIGUEZ BULLA LUIS EVENCIO','KR 48 No 174B 07 IN 6 AP 102','4780624','luiseven.rodriguez@gmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14438',NULL,NULL,NULL,NULL,1),
  (6217,'79486888',6072632,1214526.4,151815.8,'2017-07-02','2017-07-17 17:05:13','2017-07-02 17:49:41','QUILAGUY CORREDOR WILSON','CL 181C No9 30 IN2 AP 504','3158799665','cahetosa@yahoo.es',62,2,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14429',NULL,NULL,NULL,NULL,1),
  (6218,'79509027',10181151,2036230.2,254528.775,'2017-07-02','2017-07-18 14:10:24','2017-07-02 17:49:41','LONDO ANGEL FRANK','KR76B No 89 69','3013501780','',62,5,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','12269',NULL,NULL,NULL,NULL,1),
  (6219,'79869570',4352625,870525,108815.625,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','VASQUEZ JAIME JUAN CARLOS','CL 175 No 17B   80 TR 5 AP 502','3132827683','vas_juan@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14436',NULL,NULL,NULL,NULL,1),
  (6220,'80089324',10369350,2073870,259233.75,'2017-07-02','2017-07-14 11:34:50','2017-07-02 17:49:41','JUAN GUILLERMO BECERRA','CARRERA 5 No 185c 21 Int 11 APTO 303','5161632','JUANGBR7@HOTMAIL.COM',62,2,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16004',NULL,NULL,NULL,NULL,1),
  (6221,'80412931',7965080,1593016,199127,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','FERNANDO PALACIOS BERMUDEZ','CRR 17 A  175 82 IN 2 AP 1301','3123223463','FPB33@HOTMAIL.COM',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16081',NULL,NULL,NULL,NULL,1),
  (6222,'8740041',533036,106607.2,13325.9,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','WALDEMAR STRUSS FRANCO','CL173A No 20A 32 IN2 AP 308','3186086820','strussw@hotmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','13370',NULL,NULL,NULL,NULL,1),
  (6223,'88210242',5041385,1008277,126034.625,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','TORRES NOVOA NESTOR ALEXANDER','VIA CAJICA TABIO 2 05 TORRE 2 AP 502','3185895303','ntorres@petrologyc.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14104',NULL,NULL,NULL,NULL,1),
  (6224,'91488546',9870800,1974160,246770,'2017-07-02','2017-07-02 17:49:41','2017-07-02 17:49:41','GOMEZ GUALDRON ROY STEPHEN','CL 159 No 56 75 TR 3 AP 302','3002501681','roygomez1976@gmail.com',62,1,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','14251',NULL,NULL,NULL,NULL,1),
  (6225,'92513434',9083160,1816632,227079,'2017-07-02','2017-07-14 12:02:55','2017-07-02 17:49:41','FRANCISCO CERRA ARROYO','CRR 8A  159B 27 AP 601','5276200','',62,2,'PRODUCTO',40,NULL,0,'2014-04-15','2016-04-15','16086',NULL,NULL,NULL,NULL,1),
  (6227,'80086173',80086173,16017234.6,2002154.325,'2017-07-05','2017-07-05 14:02:01','2017-07-05 14:02:01','CLAUDIO ANDRES MEJIA CORRALES','DIRECCION  CALLE 74 No 11-21 APTO 201','5897575','corrales.mac@gmail.com',79,1,'bienes',40,NULL,0,'2017-04-26','2019-04-26','71',NULL,NULL,NULL,NULL,1),
  (6228,'900501552',22567623,4513524.6,564190.575,'2017-07-05','2017-07-05 19:10:11','2017-07-05 19:10:11','equipos y terrastest sas','carrera 7 No 114-33 Of 605  ','3101331','contabilidad@equiposyterrtest.com',62,1,'factura',40,NULL,0,'2016-03-02','2018-03-02','118',NULL,NULL,NULL,NULL,1),
  (6229,'900574224',31171897,6234379.4,779297.425,'2017-07-07','2017-07-07 15:14:37','2017-07-07 15:14:37','LA GLORIETA BELLO  SAS','CALLE 51 #45 59','3235800214','LAGLORIETABELLO@GMAIL.COM',1,1,'BIENES',40,NULL,0,'2017-04-30','2019-04-30','120',NULL,NULL,NULL,NULL,1),
  (6230,'70288258',17823964,3564792.8,445599.1,'2017-07-07','2017-07-07 17:20:52','2017-07-07 17:20:52','INVERSIONES ARIAS ALZATE ','CR 49 48 17 P 4','5312153','BANQUETESCASABLANCA08@HOTMAIL.COM',12,1,'BIENES',40,NULL,0,'2017-02-11','2019-02-11','000080',NULL,NULL,NULL,NULL,1),
  (6231,'52397114',9764104,1952820.8,244102.6,'2017-07-13','2017-07-13 15:34:42','2017-07-13 15:34:42','DIANA PATRICIA CORREA ','CARRERA 93 N132 62 ','6854130','DIANACORREA79@YAHOO.ES ',62,1,'SERVICIOS',40,NULL,0,'2017-03-25','2019-03-25','85',NULL,NULL,NULL,NULL,1),
  (6232,'1032440642',7820373,1564074.6,195509.325,'2017-07-13','2017-07-14 10:23:25','2017-07-13 16:30:31','MARIA CAMILA BERNAL RODRIGEZ ','CALLE 51 N 56A 70','3132490474','MCBR02173@YAHOO.ES',62,2,'SERVICIOS ',40,NULL,0,'2016-05-13','2018-05-13','84',NULL,NULL,NULL,NULL,1),
  (6233,'20995581',6547394,1309478.8,163684.85,'2017-07-13','2017-07-14 10:36:03','2017-07-13 16:30:31','BLANCA YANNETH VILLAREAL ','TRANSVERSAL 85 N 52C 19','3004272794','YANETHVILLAREAL2013@GMAIL.COM',62,2,'SERVICOS',40,NULL,0,'2017-05-26','2019-05-26','86',NULL,NULL,NULL,NULL,1),
  (6234,'52146760',1474796,294959.2,36869.9,'2017-07-13','2017-07-14 11:07:09','2017-07-13 16:30:31','SANDRA PATRICIA MELO CARMONA ','CARRERA  74 N 138 69 TORRE 3 APTO 201','3204111107','SENDYMELO3@HOTMAIL.COM',62,2,'SERVICIOS',40,NULL,0,'2017-11-26','2019-11-26','88',NULL,NULL,NULL,NULL,1),
  (6235,'52253031',11115840,2223168,277896,'2017-07-13','2017-07-18 14:30:50','2017-07-13 16:30:31','SANDRA PATRICIA SANCHEZ ','KM 1 5 VARIANTE COTA CHIPAO DE AGUAS CASA 44','3188217773','SANDRAPATRICIA1974@HOTMAIL.COM',62,2,'SERVICIOS',40,NULL,0,'2016-02-10','2018-02-10','87',NULL,NULL,NULL,NULL,1),
  (6236,'82002013',8000000,1600000,200000,'2017-07-13','2017-07-13 17:02:48','2017-07-13 17:02:48','LA COPORACION OZONO ','CALLE 16A N 66 55','4357621','CONTACTO@CORPOOZONO.ORG',62,1,'SERVICIOS',40,NULL,0,'2015-06-30','2017-06-30','119',NULL,NULL,NULL,NULL,1),
  (6237,'8001067740',281900000,56380000,7047500,'2017-07-13','2017-07-13 17:17:04','2017-07-13 17:17:04','MERCADO ZAPATOCA S.S','CARRERA 60 N 4 24 ','2629610','GARCHA409@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2014-01-20','2016-01-20','122',NULL,NULL,NULL,NULL,1),
  (6238,'9007134545',18719470,3743894,467986.75,'2017-07-14','2017-07-14 13:53:41','2017-07-14 13:53:41','IRON COOPER COMPANY SAS ','CALLE 10 N 34-11 OF 3  CALLE 45 SUR NO 39 22','3661489','KPATINO@QICCOMSAS.COM',4,1,'SERVICIOS',40,NULL,0,'2017-02-28','2019-02-28','123',NULL,NULL,NULL,NULL,1),
  (6239,'79361601',6997036,1399407.2,174925.9,'2017-07-14','2017-07-14 17:46:20','2017-07-14 17:46:20','WILLIAM CAICEDO BARAHONA ','CARRERA 56B N 127 04 APTO 118 ','2264543','WILLIAMCAI55@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2015-02-20','2017-02-20','16038',NULL,NULL,NULL,NULL,1),
  (6240,'79361601',6997036,1399407.2,174925.9,'2017-07-14','2017-07-14 17:46:20','2017-07-14 17:46:20','WILLIAM CAICEDO BARAHONA ','CARRERA 56B N 127 04 APTO 118 ','2264543','WILLIAMCAI55@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2015-02-20','2017-02-20','16038',NULL,NULL,NULL,NULL,1),
  (6241,'79361601',6997036,1399407.2,174925.9,'2017-07-14','2017-07-14 17:50:26','2017-07-14 17:50:26','WILLIAM CAICEDO BARAHONA ','CARRERA 56B N 127 04 APTO 118 ','2264543','WILLIAMCAI55@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2015-02-20','2017-02-20','16038',NULL,NULL,NULL,NULL,1),
  (6242,'79361601',6997036,1399407.2,174925.9,'2017-07-14','2017-07-14 17:50:26','2017-07-14 17:50:26','WILLIAM CAICEDO BARAHONA ','CARRERA 56B N 127 04 APTO 118 ','2264543','WILLIAMCAI55@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2015-02-20','2017-02-20','16038',NULL,NULL,NULL,NULL,1),
  (6243,'79361601',6997036,1399407.2,174925.9,'2017-07-14','2017-07-14 17:53:56','2017-07-14 17:53:56','WILLIAM CAICEDO BARAHONA ','CARRERA 56 B N 127 04 APTO 118 ','2264543','WILLIAMCAI55@HOTMAIL.COM',62,1,'SERVICIOS',40,NULL,0,'2015-02-20','2017-02-20','16038',NULL,NULL,NULL,NULL,1),
  (6244,'8600583037',6946000,1389200,173650,'2017-07-18','2017-07-18 14:48:29','2017-07-18 14:48:29','CEP CONSTRUCTORES ASOCIADOS S A','CALLE 22 B 32 B 22 BARRIO FLORIDA OCCIDENTAL','2695566','CEP@CEPCONSTRUCTORES.COM',62,1,'SERVICIO',40,NULL,0,'2017-03-31','2019-03-31','124',NULL,NULL,NULL,NULL,1),
  (6245,'98662159',21894776,4378955.2,547369.4,'2017-07-18','2017-07-19 17:07:42','2017-07-18 19:06:02','DISTRIBUCOL','CL 93  96 A 69','3183058492','DISTRIBUCOL@GMAIL.COM',11,5,'BIENES',40,NULL,0,'2017-06-08','2019-06-08','797938',NULL,NULL,NULL,NULL,1),
  (6246,'284784630',1947306,389461.2,48682.65,'2017-07-18','2017-07-18 19:47:11','2017-07-18 19:47:11','AUTOSERVICIO LA RIVERA MBB','CL 70 C 111 C 47 BRR LA RIVIERA','3142708868','creminda70@hotmail.com',62,1,'BIENES',40,NULL,0,'2017-10-05','2019-10-05','291209',NULL,NULL,NULL,NULL,1),
  (6247,'9007134545',18719470,3743894,467986.75,'2017-07-18','2017-07-18 19:59:08','2017-07-18 19:59:08','IRON COOPER CAMPANY SAS','CALLE 10 A N 34 11 OF 3 ','3661028','GERENCIA@ICCMSAS.COM',4,1,'SERVICIO',40,NULL,0,'2017-02-20','2019-02-20','00123',NULL,NULL,NULL,NULL,1),
  (6248,'8110153335',24418957,4883791.4,610473.925,'2017-07-19','2017-07-19 14:03:47','2017-07-19 15:23:55','NUTRINORTE','CARRERA 13 11 54','3104639708','',11,5,'SERVICIOS',40,NULL,0,'2010-07-13','2012-07-13','9942',NULL,NULL,NULL,NULL,1),
  (6249,'11201185',17100000,3420000,427500,'2017-07-19','2017-07-19 16:45:34','2017-07-19 16:45:34','JUAN RICARDO MOYA CASTILLO ','calle 2 sur n 5-96','3125834085','hoangcho13@gmail.com',62,1,'BIENES',40,NULL,0,'2016-01-17','2018-01-17','8',NULL,NULL,NULL,NULL,1),
  (6250,'17104190',121192252,24238450.4,3029806.3,'2017-07-19','2017-07-19 16:45:34','2017-07-19 16:45:34','AIR FLOWERS C.I LTDA','DG 3 9 02 CONJ QUINTAS DEL MARQUEZ CA F 6','8931557','enrique.matizf6@gmail.com',62,1,'BIENES',40,NULL,0,'2016-01-17','2018-01-17','10',NULL,NULL,NULL,NULL,1),
  (6251,'830093104',11238157,2247631.4,280953.925,'2017-07-19','2017-07-19 16:45:34','2017-07-19 16:45:34','CI EXPOCOLOMBIA','CR 10 15 39 OF 404','4821000','expocolombia@hotmail.com',62,1,'BIENES',40,NULL,0,'2016-01-17','2018-01-17','9',NULL,NULL,NULL,NULL,1),
  (6252,'830502089',80000000,16000000,2000000,'2017-07-19','2017-07-19 13:26:35','2017-07-19 18:15:27','INVERSIONES MORENO TAMAYO ','CR 43 63 20','3685921','VANJOMO@HOTMAIL.COM',17,5,'BIENES',40,NULL,0,'2015-04-07','2017-04-07','9122',NULL,NULL,NULL,NULL,1),
  (6253,'2677336',15997070,3199414,399926.75,'2017-07-19','2017-07-19 13:36:06','2017-07-19 18:31:33','FELIX ANTONIO ARIAS VALENCIA','CR 21 27 55','2245471','felixarias123@hotmail.com',193,5,'BIENES',40,NULL,0,'2010-08-20','2012-08-20','84',NULL,NULL,NULL,NULL,1),
  (6254,'900278592',26512709,5302541.8,662817.725,'2017-07-19','2017-07-19 13:36:26','2017-07-19 18:31:33','INDUSTRIAS RICO PAN RIYE S.A.S','CR 7 19 A 40 BRR KENNEDY','5714051','rickpan2@yahoo.es',57,5,'BIENES',40,NULL,0,'2014-10-27','2016-10-27','14158',NULL,NULL,NULL,NULL,1),
  (6255,'1038626368',11355923,2271184.6,283898.075,'2017-07-19','2017-07-19 13:42:03','2017-07-19 18:41:15','El Mundo del Bebe Supia','calle 32 No 7-33','3143804782','milemonu1988@gmail.com',2,5,'BIENES',40,NULL,0,'2017-03-07','2019-03-07','6',NULL,NULL,NULL,NULL,1),
  (6256,'899999026',18417000,3683400,460425,'2017-07-19','2017-07-19 13:42:22','2017-07-19 18:41:15','CAJA DE PREVISION SOCIAL DE COMINACIONES CAPRECOM','CL 67 N 16 30','2943333','apoderadogeneral@caprecom.gov.co',62,5,'BIENES',40,NULL,0,'2016-01-17','2018-01-17','87',NULL,NULL,NULL,NULL,1),
  (6257,'800100960',124247443,24849488.6,3106186.075,'2017-07-19','2017-07-19 19:36:44','2017-07-19 19:36:44','COLREGISTROS SAS','CARRERA 7 77 07 PISO 8 ','5954910','',62,1,'SERVICIOS ',40,NULL,0,'2014-01-20','2016-01-20','14323',NULL,NULL,NULL,NULL,1),
  (6258,'900296178',8623380,1724676,215584.5,'2017-07-19','2017-07-19 19:36:44','2017-07-19 19:36:44','URGENCIAS VITALES DEL CASANARE ','TRANSV 7 B 32 03','6345727','',62,1,'SERVICIOS ',40,NULL,0,'2014-01-20','2016-01-20','14152',NULL,NULL,NULL,NULL,1),
  (6259,'72040948',2366290,473258,59157.25,'2017-10-04','2017-10-04 19:10:46','2017-10-04 19:10:46','MIGUEL ANGEL GIRALDO QUINTERO','CLL 17 N 4 49','3165268853','VELMAR_711@GMAIL.COM',62,1,'BIENES',40,NULL,NULL,'2016-04-19','2018-04-19','18023',NULL,NULL,NULL,NULL,1),
  (6260,'73548726',51530891,10306178.2,1288272.275,'2017-10-04','2017-10-04 19:10:49','2017-10-04 19:10:49','JHON JAIRO BUELVAS MALO','FUNDACION','3126955201','',62,1,'BIENES',40,NULL,NULL,'2015-04-30','2017-04-30','18071',NULL,NULL,NULL,NULL,1),
  (6261,'77181497',19800000,3960000,495000,'2017-10-04','2017-10-04 19:10:53','2017-10-04 19:10:53','CARLOS SILVA DISTRIBUCIONES','CRA 166 N 23 32 BRR SIMON BOLIVAR  CLL 16B CRA 8','3116829528','CARLOSSOLVAZULETA@HOTMAIL.COM',62,5,'BIENES',40,NULL,NULL,'2015-08-13','2017-08-13','10256',NULL,NULL,NULL,NULL,1),
  (6262,'80236620',5885735,1177147,147143.375,'2017-10-04','2017-10-04 19:10:57','2017-10-04 19:10:57','HENRY WERNEY ACEVEDO CASTELLANOS','CALLE 54 C SUR 95 A 18','3114844664','PAPELERIAUNIMAGIC@HOTMAIL.COM',62,1,'BIENES',40,NULL,NULL,'2016-12-31','2018-12-31','14344',NULL,NULL,NULL,NULL,1),
  (6263,'900206882',54257127,10851425.4,1356428.175,'2017-10-04','2017-10-04 19:11:02','2017-10-04 19:11:02','CELK MERCADEO INVERSIONES E U','CLL 12B 1661 APTO 1','3205316568','CELKHERNANDEO@HOTMAIL.COM',62,5,'BIENES',40,NULL,NULL,'2016-12-31','2018-12-31','18033',NULL,NULL,NULL,NULL,1),
  (6264,'900333984',2000000,400000,50000,'2017-10-04','2017-10-04 19:13:14','2017-10-04 19:13:14','TRANSPORTES EL TESORO SAS','CLL 40 E SUR 32 26','3217278014','LEIDYC.LAR@GMAIL.COM',62,1,'BIENES',40,NULL,NULL,'2015-12-26','2017-12-26','12356',NULL,NULL,NULL,NULL,1),
  (6265,'900439707',110831798,22166359.6,2770794.95,'2017-10-04','2017-10-04 19:13:16','2017-10-04 19:13:16','COMERCIALIZADORA ICE CITY','AVENIDA 42 N 30 B 21','6829492','comercializadoraicecity@hotmail.com',62,2,'BIENES',40,NULL,NULL,'2016-02-01','2018-02-01','18132',NULL,NULL,NULL,NULL,1),
  (6266,'900872915',45116164,9023232.8,1127904.1,'2017-10-04','2017-10-04 19:13:17','2017-10-04 19:13:17','LA GRAN TIENDA DISTRUBUCIONES SAS','KILIMETRO 7 VIA GIRON  CRR 13 N5779','6199174','',62,5,'BIENES',40,NULL,NULL,'2015-12-31','2017-12-31','17007',NULL,NULL,NULL,NULL,1),
  (6267,'92521535',17450155,3490031,436253.875,'2017-10-04','2017-10-04 19:13:20','2017-10-04 19:13:20','LORA ALVAREZ ROGER FRANCISCO','CLL  30 27 08','3226509223','',62,1,'BIENES',40,NULL,NULL,'2016-04-07','2018-04-07','17087',NULL,NULL,NULL,NULL,1),
  (6268,'1020802265',1710137,342027.4,42753.425,'2017-10-04','2017-10-04 19:13:21','2017-10-04 19:13:21','SANCHEZ GOMEZ YULI KATHERIN','CRA 65 57F 51 SUR','3103446771','katerins23@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2015-11-28','2017-11-28','24020675',NULL,NULL,NULL,NULL,1),
  (6269,'10544341',12371031,2474206.2,309275.775,'2017-10-04','2017-10-04 19:13:26','2017-10-04 19:13:26','VELASCO MU¾OZ JOHN CARLOS','CRA 27 No. 35 33','3173430578','jamolina @uniquindio.edu.co',62,5,'BIENES',40,NULL,NULL,'2014-02-21','2016-02-21','50780',NULL,NULL,NULL,NULL,1),
  (6270,'1073151191',714373,142874.6,17859.325,'2017-10-04','2017-10-04 19:13:28','2017-10-04 19:13:28','JHON FREDY VIZCAINO MORALES','CRA 30 74 -64','3202337169','',62,1,'BIENES',40,NULL,NULL,'2015-09-12','2017-09-12','27020110',NULL,NULL,NULL,NULL,1),
  (6271,'11408647',9725543,1945108.6,243138.575,'2017-10-04','2017-10-04 19:13:29','2017-10-04 19:13:29','CARLOS HUMBERTO PADILLA NEIRA','CRA 13 N 14 60 LOCAL 1','3203723127','',62,5,'BIENES',40,NULL,NULL,'2014-01-25','2016-01-25','24020476',NULL,NULL,NULL,NULL,1),
  (6272,'19287321',5034338,1006867.6,125858.45,'2017-10-04','2017-10-04 19:13:30','2017-10-04 19:13:30','ESTUPI¾AN ROJAS JOSE ANTONIO','CL 43 No. 6 12','3212326383','paniicadorasanantoniotunja@yahoo.es',62,1,'BIENES',40,NULL,NULL,'2016-12-18','2018-12-18','24020368',NULL,NULL,NULL,NULL,1),
  (6273,'23810227',1743285,348657,43582.125,'2017-10-04','2017-10-04 19:13:33','2017-10-04 19:13:33','RINCON YARA ELIZABETH','CL 23 No. 05 L 01','3142296339','',62,1,'BIENES',40,NULL,NULL,'2015-04-27','2017-04-27','24020723',NULL,NULL,NULL,NULL,1),
  (6274,'63558582',1469096,293819.2,36727.4,'2017-10-04','2017-10-04 19:13:34','2017-10-04 19:13:34','ARGUELLO CERPA ERIKA','CR 22 NO 46 B-08','6942412','ecosandeliciosopan@yahoo.com',62,1,'BIENES',40,NULL,NULL,'2016-01-10','2018-01-10','27020223',NULL,NULL,NULL,NULL,1),
  (6275,'7456345',27270861,5454172.2,681771.525,'2017-10-04','2017-10-04 19:13:36','2017-10-04 19:13:36','VARGAS ESPINOSA JAIME ARTURO','CRA 6 No. 19 A 48','301686356','distribucionesjr@hotmail.com',62,5,'BIENES',40,NULL,NULL,'2016-07-14','2018-07-14','436142',NULL,NULL,NULL,NULL,1),
  (6276,'79209103',3572794,714558.8,89319.85,'2017-10-04','2017-10-04 19:13:37','2017-10-04 19:13:37','VASQUEZ LADINO PABLO CESAR','CL 57B No. 68A 29 SUR','3126699411','carmeng710@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2015-08-30','2017-08-30','24020038',NULL,NULL,NULL,NULL,1),
  (6277,'80450756',649431,129886.2,16235.775,'2017-10-04','2017-10-04 19:13:38','2017-10-04 19:13:38','MARTINEZ GIL HILDA','CR 68B 67 01 BELLAVISTA','3115810218','nelsonbarbosa276@gmail.com',62,1,'BIENES',40,NULL,NULL,'2015-08-25','2017-08-25','24020253',NULL,NULL,NULL,NULL,1),
  (6278,'900173510',7551500,1510300,188787.5,'2017-10-04','2017-10-04 19:13:39','2017-10-04 19:13:39','DISTRIBUIDORA BOGOTA TCB LTDA','CL 03 No. C 9 76','3132490129','pabloemendezt@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2014-12-30','2016-12-30','884301',NULL,NULL,NULL,NULL,1),
  (6279,'9002785927',25483827,5096765.4,637095.675,'2017-10-04','2017-10-04 19:13:40','2017-10-04 19:13:40','JHON ARLISON CHAPPARRO LEON','CR 7 No.19A-40','5714051','inversionesfavipan@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2016-07-13','2018-07-13','14273',NULL,NULL,NULL,NULL,1),
  (6280,'900353794',19439608,3887921.6,485990.2,'2017-10-04','2017-10-04 19:13:42','2017-10-04 19:13:42','INDUSTRIAS INDUPAN SAS','CL 44 No. 18D 100','3135446629','inversionesfavipan@hotmail.com',62,5,'BIENES',40,NULL,NULL,'2012-01-21','2014-01-21','50020030',NULL,NULL,NULL,NULL,1),
  (6281,'900412995',5570588,1114117.6,139264.7,'2017-10-04','2017-10-04 19:13:43','2017-10-04 19:13:43','TYS PET SAS','CRA 7 No. 16 78 LC 1021','3155564764','amesotom@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2014-10-01','2016-10-01','50791',NULL,NULL,NULL,NULL,1),
  (6282,'94529101',2500000,500000,62500,'2017-10-04','2017-10-04 19:13:46','2017-10-04 19:13:46','JOSE RAUL HENAO SOTO','CRA 10 No. 1 295','3113512484','',62,1,'BIENES',40,NULL,NULL,'2016-04-29','2018-04-29','25020065',NULL,NULL,NULL,NULL,1),
  (6283,'22518962',7071000,1414200,176775,'2017-10-04','2017-10-04 19:13:47','2017-10-04 19:13:47','COMERCIALIZADORA GAMOPE SAS','MZ F CASA 14 URB VILLA DEL MAR','3008426790','kjperea45@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2014-09-15','2016-09-15','14439',NULL,NULL,NULL,NULL,1),
  (6284,'900240160',2000000,400000,50000,'2017-10-04','2017-10-04 19:13:49','2017-10-04 19:13:49','CORPORACION AGENCIA DE DESARROLLO ECONOMICO LOCAL DEL COMPLEJO CENAGOSO DE LA ZAPATOSA','CRA 19  A2  10 20','3205112555','njudithramirez@hotmail.com',62,1,'BIENES',40,NULL,NULL,'2015-09-16','2017-09-16','14472',NULL,NULL,NULL,NULL,1),
  (6285,'1013598482',8751034,1750206.8,218775.85,'2017-10-04','2017-10-04 19:13:51','2017-10-04 19:13:51','DIEGO ARMANDO ROCHA MORCOTE','CL 58 SUR 19 A 15 IN 9','4518414','',62,1,'SERVICIO',40,NULL,NULL,'2013-07-28','2015-07-28','14587',NULL,NULL,NULL,NULL,1),
  (6286,'1020420118',11424768,2284953.6,285619.2,'2017-10-04','2017-10-04 19:13:52','2017-10-04 19:13:52','MESA GALVIS DIOVER JOHAN','CALLE 33 F No 19 63','2796417','',62,1,'SERVICIO',40,NULL,NULL,'2015-06-15','2017-06-15','14822',NULL,NULL,NULL,NULL,1),
  (6287,'10262979',1178239,235647.8,29455.975,'2017-10-04','2017-10-04 19:13:55','2017-10-04 19:13:55','FRANCISCO JAVIER BERNAL','CALLE 34 No 11 37 43','3142510436','luzkarina-310@hotmail com',62,1,'SERVICIO',40,NULL,NULL,'2012-02-24','2014-02-24','14612',NULL,NULL,NULL,NULL,1);
COMMIT;

#
# Data for the `effects` table  (LIMIT 0,500)
#

INSERT INTO `effects` (`idEffect`, `effectName`) VALUES 
  (1,'Acuerdo de pago'),
  (2,'Al dia o cancelado'),
  (3,'Ilocalizado'),
  (4,'Insolvente'),
  (5,'Mensaje con terceros'),
  (6,'No contesta'),
  (7,'Pago parcial'),
  (8,'Reclamacion'),
  (9,'Renuente'),
  (10,'Gestion de cobro'),
  (11,'No se presento'),
  (12,'Direccion no existe'),
  (13,'No lo conocen'),
  (14,'No recibe'),
  (15,'Entrega a terceros'),
  (16,'Recibido'),
  (17,'Direccion incorrecta'),
  (18,'No atiende'),
  (19,'Desasignada'),
  (20,'Acuerdo directo'),
  (21,'Amerita proceso > Juridico');
COMMIT;

#
# Data for the `agendas` table  (LIMIT 0,500)
#

INSERT INTO `agendas` (`idAgenda`, `idAction`, `dAction`, `dCreation`, `idWallet`, `idAdviser`, `idEffect`, `comment`, `timer`) VALUES 
  (1,1,'2017-07-04','2017-06-30 16:26:13',6090,42,3,'6427412 NUMERO EQUIVOCADO // SE EVIDENCIA QUE LA EMPRESA LAS ANTILLAS ESTA DIRIGIDA POR LA SEÑORA BLANCA GARCIA CON EL CORREO ELECTRONICO asesorias_zory@hotmail.com 3188107054 NUMERO APAGADO \n','00:01:06'),
  (2,1,'2017-07-04','2017-06-30 17:03:27',6099,42,6,'3172626717 NUMERO FUERA DE SERVICIO //3103155060 NUMERO NO RESPONDE CON ESTE NUMERO YA SE HABÍA TENIDO CONTACTO PARA ACUERDO DE PAGO cliente no presenta comparendos al día de hoy no presenta solicitudes ante entidades de transito ','00:01:54'),
  (3,1,'2017-06-30','2017-06-30 17:21:55',6088,42,2,'3212574120 RESPONDE LA SEÑORA DIANA LOAIZA INDICA QUE TECNOQUIMICAS LE ENTREGO PAZ Y SALVO , LO ENVIA VIA WATHASP PENDIENTE VALIDAR EL ENVIO , CLIENTE ENVIA EFECTIVAMENTE PAZ Y SALVO REMITIDO POR TECNOQUIMICAS ENVIADO A PAGOS','00:01:55'),
  (4,1,'2017-07-05','2017-07-04 08:49:00',6086,42,6,'CORREO ELECTRONICO miladis.tamayo@gmail.com, EN INVESTIGACIÓN AFILIADA A CAFÉ SALUD, REPRESENTANTE LEGAL, MILADIS DE LA ROSA TAMAYO // 8273853 EL  NUMERO ESTA EN FUNCIONAMIENTO PERO NO RESPONDEN PENDIENTE VOLVER A LLAMAR \n','00:09:25'),
  (5,1,'2017-07-04','2017-07-04 09:02:02',6099,42,6,'3103155060 ANTERIORMENTE SE HABIA TENIDO COMUNICACIÓN CON ESTE NUMERO, O RESPONDEN PENDIENTE VOLVER A COMUNICARNOS','00:08:29'),
  (6,1,'2017-07-04','2017-07-04 09:10:24',6096,42,3,'CLIENTE PRESENTA 2 DEMANDAS, DONDE LAS DEMANDAS SALIERON A FAVOR DEL DEUDOR, 3425245 NUMERO FUERA DE SERVICIO, REVISANDO LA CARPETA DEL CLIENTE NO REGISTRA MAS NÚMEROS DE CONTACTO','00:07:10'),
  (7,1,'2017-07-05','2017-07-04 09:59:30',6095,42,6,'EN INVESTIGACIÓN SE ENCUENTRA EL NUMERO 6627453 EN LA CIUDAD DE CARTAGENA, CON EL CORREO contabilidad@supermercadoloschagualos.com, CON LA DIRECCION BRR EL PRADO DG 21 22 16,REPRESENTANTE LEGAL RAUL MARINO GOMEZ GIRALDO CON CC 73160454 CORREO raulmarinogomez@hotmail.com TELEFONO 6627453 Y FRANCISCO URIEL GOMEZ  CC 73230574 TELEFONO 6627453 // 6627453 NUMERO NO RESPONDEN PENDIENTE VOLVER A COMUNICARNOS ','00:13:36'),
  (8,2,'2017-07-04','2017-07-04 10:13:32',5335,40,9,'CR 13 #4-25 VITERBO/CALDAS\nSE ENCUENTRA NUEVO NUMERO DE TELEFONO: 8691771\nIndica que entrego 33 congeladores y COLOMBINA le esta cobrando 16 de mas los cuales ella no recibió anteriormente; manifiesta a su vez que COLOMBINA los recogió directamente y ALIADO. Anexando que colocara demanda por retención de documentos.\n\n\n8691771\n\n8691771\n\n8691771\n\nmayerly589@gmail.com\n\nCámara de Comercio:  MANIZALES\n','00:04:24'),
  (9,1,'2017-07-16','2017-07-04 10:28:30',5352,40,1,'SE HABLA DIRECTAMENTE CON LA SEÑORA MARÍA EUGENIA HERNANDEZ, CLIENTE MANIFIESTA QUE PARA EL 17 DE JULIO       ABONARA A LA DEUDA.  SE VOLVERÁ A LLAMAR EL DÍA 16 PARA VALIDAR EL ABONO. ','00:04:16'),
  (10,1,'2017-07-08','2017-07-04 10:43:26',5336,40,3,'Nos comunicamos con CODEUDORA ,quien indica que al realizar la solicitud en COLOMBINA le indicaron que no podía servir como segunda responsable de los equipos y hasta el momento no tenia conocimiento alguno respecto a esto. nos facilita el numero directo del DEUDOR, pero no hubo comunicación alguna con el cliente. en gestión de cobro','00:00:32'),
  (11,1,'2017-07-08','2017-07-04 10:50:17',5337,40,1,'cliente manifiesta que le están descontando directamente de la nomina confirmar descuentos. confirmar total de descuentos por nomina, para aplicar pagos en cartera.     ','00:02:50'),
  (12,1,'2017-07-04','2017-07-04 10:56:59',6104,42,6,'4454528 NUMERO EN CALI NO RESPONDEN 3014511545 NUMERO NO RESPONDEN SE LE INISTE PENDIENTE VOLVER A COMUNICARNOS\n','00:08:56'),
  (13,1,'2017-07-08','2017-07-04 12:16:04',5339,40,3,'se envía notificación de cobro al correo \nedemrec@hotmail.com, registra dirección  CL 27 5 A 125 BRR SANTA ROSA Valledupar / Cesar, se trata de comunicar al numero de celular 3013135142 pero no hay respuesta alguna. cliente en gestion de cobro\n','00:22:54'),
  (14,1,'2017-07-04','2017-07-04 12:22:09',6099,42,6,' Matricula No 174344 Cancelada , activo eps Cafesalud direccion calle 13 No 2-101 barro garcia herrrera 2 en Cúcuta telefono 310-3155060 fijo 5781392 esposa Esther ohanna Alzate Martinez  cedula de ciudadania 3,,50391 celular 3002143064, en veeduria arroja direccion  manzana 2 bodega 17 sec nueva sexta cenabastos  correo electronico jreyesvillan@hotmail.om\n3172626717 NUMERO FUERA DE SERVICIO //3103155060 NUMERO NO RESPONDE CON ESTE NUIMERO YA SE HABIA TENIDO CONTACTO PARA ACUERDO DE PAGO cliente no presenta comparendos al dia de hoy no presenta solicitudes ante entidades de transito \n','00:00:49'),
  (15,1,'2017-07-08','2017-07-04 12:39:04',5356,40,3,'REGISTRA COMO  PERSONA NATURAL ESTADO DE LA MATRICULA ACTIVA, ULTIMO AÑO RENOVADO 2015, REGISTRA COMO PROPIETARIO DE CIGARRERIA SOLFRE PRINCIPAL ACTIVIDAD ECONOMICA  4711 - Comercio al por menor en establecimientos no especializados con surtido compuesto principalmente por alimentos, bebidas o   EN MEDELIN, MATRICULA ACTIVA ULTIMO AÑO RENOVADO 2015, NÚMEROS REGISTRA FUERA DE SERVICIOS. SE SIGUE CON LA GESTIÓN DE COBRO','00:02:41'),
  (16,1,'2017-07-08','2017-07-04 12:57:09',5340,40,3,'SE INVESTIGA AL CLIENTE Y SE ENCUENTRA LOS SIGUIENTES DATOS: \nDIRECCION: CL 8 9 29 BRR ALFONSO LOPEZ\nFundación / Magdalena, NUMERO DE CELULAR ENCOTRADO: 3135253364\nCámara de Comercio:  SANTA MARTA. NUMERO DE TELEFONO FUERA DE SERVICIO, EN PROCESOS DE COBRO. ','00:17:13'),
  (17,2,'2017-07-08','2017-07-04 14:25:32',5357,40,9,'CLIENTE RESIDENTE EN LA DIRECCION CL 16 #15-12 EN LA CUIDAD DE ARMENIA/QUINDIO\nTELEFONOS: 7312434.SE ENVIA NOTIFICACION AL CORREO : NELMAR_711@HOTMAIL.COM\nCÁMARA DE COMERCIO ACTIVA ARMENIA. NO HAY COMUNICACIÓN CON EL DEUDOR, SE DEJA MENSAJE DE VOZ AL NUMERO DE CELULAR 3165268853 \n','00:50:16'),
  (18,1,'2017-07-04','2017-07-04 14:50:39',6102,42,10,'se hace investigación, registra matricula activa, nos comunicamos al teléfono 3102942512  con la Representante legal y se hace un acuerdo de pago para el día 30 de junio y el otro 30 julio, se localizo en la dirección Calle 6 # 11-021 en puerto lopez , se envía notificación al correo agrovetmenegua@yahoo.comCLIENTE ESTA GENERANDO ABONOS DE PAGO DIRECTAMENTE A TECNOQUIMICAS. VALIDAR LOS SOPRTES DE PAGO.  SE LOCALIZO EN EL NUMERO y al 3102942512 Y SE ENCONTRO EL  CORREO agrovetmenegua@yahoo.com, NO TIENE VEHICULO. \n','00:01:40'),
  (19,1,'2017-07-18','2017-07-04 14:51:32',6102,42,1,'29/07/2017 cliente  inidca que esta realizando los pagos directamente a tecnoquimicas se le solicitan los soportes de pago indica que los esta entregando directamente con la compañia ','00:00:51'),
  (20,1,'2017-07-08','2017-07-04 14:54:17',5341,40,3,'NOS COMUNICAMOS AL NUMERO DE CELULAR: 3104947505 DE REFERENCIA DEL DEUDOR Y LA SEÑORA MANIFIESTA NO CONOCER AL SEÑOR  EUTIMIO. SE MARCA A LOS NUMERO DIRECTOS DEL CLIENTE Y SALEN FUERA DE SERVICIO, SE VUELVE A ENVIAR NOTIFICACIÓN Y SE SIGUE CON LA GESTION DE COBRO.','00:26:00'),
  (21,1,'2017-07-11','2017-07-04 14:59:10',6081,42,5,'Matricula activa direccion galpon a local 21 cenabastos telefono fio 5876701 correo electronico blsantandereana@gmail.com regimen contributico cafesalud, pension proteccion  cotizante direccion manzana 54 lote 5 barrio claret telefono fijo 5711220, esposa Martha cecilia Hurtao GONZALEZ C.C 60,327,391 calle 11A No 2-48 telefono fijo 5876701,5711220 correo auxiliarsantander@gmail.com telefono fijo 5773420','00:03:19'),
  (22,1,'2017-07-08','2017-07-04 15:09:03',5358,40,3,'CLIENTE RESIDENTE EN LA CUIDAD DE MARIA LA BAJA BOLIVAR, EN LA DIRECCION: BRR ARROYO ABAJO CALLE EL TAMARINDO CARRERA 12 #22-196, NUMERO DE TELEFONOS ENCONTRADOS DE CONTACTO FUERA DE SERVICIO 3213371978- 3126955201, SE SIGUE EN PROCESO DE INVESTIGACIÓN Y DE COBRO. ','00:07:16'),
  (23,1,'2017-07-08','2017-07-04 15:18:37',5342,40,3,'CLIENTE INCOMUNICADO, EN LA INVESTIGACION ARROJA NUMERO DE CELULAER: 3148789616 Y ESTA FUERA DE SERVICIO. SE SIGUE CON LA GESTIÓN DE INVESTIGACIÓN. ','00:08:44'),
  (24,2,'2017-07-08','2017-07-04 15:27:56',5359,40,9,'SE INVESTIGA AL CLIENTE SE ENCUENTRA QUE RESIDE EN LA CUIDAD DE VALLEDUPAR / CESAR CR 16 23 32 BRR SIMON BOLIVAR NUMERO DE CELULAR ENCONTRA :3116829528\nSE ENVIA NOTIFICACION AL CORREO carlossilvazuleta@hotmail.com\nCAMARA DE COMERCIO: VALLEDUPAR, SE DEJA MENSAJE DE VOZ Y SE SIGUE CON LA GESTION DE COBRO\n','00:08:44'),
  (25,1,'2017-07-06','2017-07-04 15:45:13',5360,40,10,'SE HABLA CON  EL DEUDOR EL CUAL MANIFIESTA QUE EN ESTOS MOMENTOS NO TIENE LA FACILIDAD PARA CANCELAR LA DEUDA, SE ESTABLECE UNA NUEVA CITA PARA EL DÍA JUEVES 6 DE JULIO EN LAS OFICINA DE COJUNAL. ','00:11:51'),
  (26,1,'2017-07-08','2017-07-04 15:56:06',5344,40,6,'SE DEJA  MENSAJE DE VOZ A LOS TRES NUMERO REGISTRADO DE LA CLIENTE, SE ENVIA NUEVAMENTE NOTIFICACION DE COBRO. AL CORREO: paula1730@outllook.es\nCámara de Comercio:  MANIZALES','00:09:59'),
  (27,1,'2017-07-11','2017-07-04 16:04:15',5361,40,9,'CLIENTE MANIFIESTA QUE ESTA SIN DINERO, ESTÁN EN QUIEBRA, NO TIENE PARA PAGAR. VOLVERLO A LLAMAR LA OTRA SEMANA EL DÍA 11 DE JULIO, PARA VER SI ESE DÍA PUEDE GENERAR UNA ALTERNATIVA DE PAGO. ','00:07:18'),
  (28,1,'2017-07-05','2017-07-04 16:38:16',5369,42,5,'RESPONDE LA SEÑORA ANDREA INIDCA QUE EL DEUDOR TRABAJA EN UNA FINCA POR LO CUAL NO TIENE NUMERO DE CONTACTO, SE LE DEJA MENSAJE CON DATOS PARA COMUNICARNOS, PENDIENTE VOLVER A LLAMAR','00:07:13'),
  (29,1,'2017-07-05','2017-07-04 16:45:02',5379,42,6,'3132490129 CONTESTAN PERO NO HABLAN TAN SOLO CONTESTAN LA LLAMADA','00:04:06'),
  (30,1,'2017-07-05','2017-07-04 16:47:00',5370,42,6,'3212326383 NUMERO NO RESPONDE SE LE DEJA MENSAJE DE VOZ PARA QUE SE COMUNIQUE PENDIENTE VOLVER A COMUNICARNOS','00:01:32'),
  (31,1,'2017-07-05','2017-07-04 17:09:55',5381,42,5,'3135446629 RESPONDE LA SEÑORA NADIA ALVAREZ INDICA QUE ELLA TAN SOLO ES EMPLEADA DE LA PANADERIA, NO TIENE DATOS DE CONTACTO DE LOS REPRESENTANTES LEGALES SE LE INDICAN DATOS PARA QUE SE COMUNIQUEN\n','00:07:04'),
  (32,1,'2017-07-08','2017-07-05 08:14:14',5345,40,5,'cliente residente en la cuidad de villavicencio/ meta en la direccion: CL 37 26 71 BRR SAN ISIDRO. numero de teléfono encontrado: 3142180011, se envía notificación al correo\nsistemasynegocios@yahoo.com.\nCámara de Comercio:  VILLAVICENCIO.\nse encuentra activa como beneficiario en coomeva eps en meta villacicencio. se habla con la hermana la señora camila pamplona, se le informa y se deja mensaje. ','00:13:00'),
  (33,1,'2017-07-05','2017-07-05 09:39:07',6194,41,10,'''Registra matricula activa No 1685049 con sucursal en la ciudad de Bucaramanga y Bogotá, ultimo año renovado 2017, Representante legal Maria Eugenia Diaz C.C 51.878.236,  Suplente Pedro antonio González  C.C 79.291.246 Direccion Carrera 55b No 79b-50 tel  7953590 correo electronico contabilidad@donjediondo.com se deja mensae para el señor Yeison Mendez financiero seenvia notificacion correo financiero@donjediondo.com\n14 jUNIO/2017 se deja nuevamente mensaje con Paola Nieto, se envia notificacion correo de la Gerente maria.diaz@donjediondo.com\n23 Junio /2017 se contacta a la señora Maria Eugenia Diaz 310-8832339 informa que se reunieron con Tatiana Galeano el cual le enviaron una propuesta de pagos, que estan a la espera de una respuesta, direccion via cota siberia km1,05 etapa 1 Casa 4, se le da respuesta que el tema es con Cojunal, ya que la obligacion a enviaron a cobro juridico, se le informa el numero de celular de la Dra. Janneth Castro.\n30 Junio/2017 se habla con la señora MARIA EUGENIA, que hablemos la otra semana para confirmar nueva reunion con dra Janneth y parte juridica de Don Jediondo','00:03:37'),
  (34,1,'2017-07-05','2017-07-05 09:48:14',6200,41,10,'''Matricula activa No 2335946 Ultimo año renovado 2017, representante legal Aura de Jesus Hurtado C.C 32.493.587, suplente Gabriel Escallon Escobar C.C 79.442.477 Direccion Carrrera 19a No 90-13 Of 401 tel 3794848 se habla con la señora Aida Correa  Directora financiera y contabilidad informa que han  enviado comunicado al señor Oscar Martinez y Marcela Acevedo para gestionar un cruce ya que Brink les adeuda la suma de $33.478.100 , se envia notificacion correo electronico aida.correa@cimento.com','00:01:15'),
  (35,1,'2017-07-05','2017-07-05 09:50:01',6181,41,10,'''Matricula activa No 268311  ultimo año renovado 2017, registra con otro establecimiento de comercio inversiones taja s.a, direccion carrera51b No 79-246 se habla con Nelsy en tesoreria que esta semana estan generando el pago de la obigacion  tel 3610311-18 se envia notificacion correo electronico tesoreria@hbp.com.co, egresos@hbp.com.co\n28 JUNIO 2017 En comunicacion con Nelsy nuevamente informa que no han realizado el pago, se deja mensaje para el señor Fabio Tarud telefonos de contacto 3610341/28 fijo gerencia 3610300','00:00:44'),
  (36,1,'2017-07-08','2017-07-05 09:53:12',5362,40,6,'CLIENTE RESIDENTE EN LA CUIDADA DE ENVIGADO/ANTIOQUIA, EN LA DIRECCION: CR 40 40 B SUR 39 BRR EL DORADO.\nNUMERO DE TELEFONO FIJO DE CASA: 4448777, CORREO ELECTRONICO AL CUAL SE LE ENVIO LA NOTIFICACION: DIRECCIONCOMERCIAL@TRANSPORTESELTESORO.COM\nCámara de Comercio:  ABURRA SUR.\n\nSE LE MARCA AL CLIENTE Y NO HUBO RESPUESTA ALGUNA. SE SIGUE CON LA GESTIÓN DE COBRO.','00:02:54'),
  (37,1,'2017-07-06','2017-07-05 09:55:28',6181,41,10,'Se habla con Yimi asistente de Gerencia, se deja nuevamente el mensaje,  en tesoreria informan que no han realizado el pago','00:05:26'),
  (38,1,'2017-07-06','2017-07-05 09:57:07',6202,41,3,'''Matricula activa No 2668481 ultimo año renovado 2016, representante legal Jairo Jesus Urbano Palacios C.C 12.991.831, suplente Francisco Gomez Sañudo C.C 12.986.837Direccion  AC 68 No 19-84 Bogotá tel 6062942 fuera de servicio correo electronico franciscogomez@outlook.com','00:00:41'),
  (39,1,'2017-07-05','2017-07-05 09:59:32',6202,41,3,'cuenta para visitar AC 68 No 19-84, empresa y direccion Carrera 3 No 59-49 Apto 703 representante legal','00:02:23'),
  (40,1,'2017-07-12','2017-07-05 10:02:52',5368,42,3,'3202337169 NUMERO FUERA DE SERVICIO 3115105025 NUMERO NO CORRESPONDE AL REPRESENTANTE LEGAL 0376021793 NUMERO FUERA DE SERVICIO DEUDOR REGISTRA UN CORREO PERSONAL pantera1318@hotmail.com','00:09:34'),
  (41,1,'2017-07-07','2017-07-05 10:04:28',6180,41,10,'''Direccion Transversal 5 est No 19-52 sur Tel 3280969/3444484, se envia notificacion correo electronico gerencia@hospitasanblas.gov.co, informa que este tema es con la Doctora Patricia Lozano.\n27 Junio me informan que me comunique con cuentas por pagar 2887635','00:00:57'),
  (42,1,'2017-07-08','2017-07-05 10:12:43',5346,40,3,'cliente residente en la cuidad de bogota d.c/ en la direccion carrera 56 a # 148-87 apto 1104 barrio la colina. telefono fijo de la empresa: 5200734.\ncorreo: maria.trujillo@alianzafarmaceutica.com\nCámara de Comercio:  BOGOTA. nos tratamps de comnica con el cliente al numero encontrado y no esta en servicio, en los links de investigación no arroja ningún otro dato del cliente. se sigue en gestión de cobro e investigación.','00:15:29'),
  (43,1,'2017-07-07','2017-07-05 10:12:58',6180,41,10,'se marca 2887635  cuentas por pagas, no entra la llamada realizar visita Diagonal 34 No 5-43 Unidad san Blas','00:01:50'),
  (44,1,'2017-07-07','2017-07-05 10:17:36',6198,41,10,'''Matricula cancelada No 0002199691 ultimo año renovado 2015,sociedad comercial,11 empleados. Direccion  carrera7 BIS A 124 45, BOGOTA, telefono 6942244\nLiquidador: Cabrera Rios Nelson        C.C 16701149\nSuplente del liquidador: Tunjano Garzon Angie Lorena        C.C1070013098 \nSe contacta al señor Liquidador el señor Nelson Cabrera 3004200415 el cual informa que me hara llegar la informacion como esta la liquidacion se le envia notificacion correo electronico  nelson.4cabrera@gmail.com\n','00:01:25'),
  (45,1,'2017-07-08','2017-07-05 10:19:59',5363,40,9,'se programo visita en yopal, nos comunicamos con la representante legal Elizabeth Niño, al telefono 320 461 0057 pero ella se niega, contesta la asistente y dice que no puede dar informacion.\n13 JUNIO/2017  Se presentaron en las instalaciones de COJUNAL ,en representación de la Comercializadora ICE CITY en la ciudad de Villavicencio las Doctoras  Dunia de la Vega y Olga Lucia indicando que hasta la fecha la acreedora no tiene ningún saldo pendiente, ya que hizo la respectiva entrega de los congeladoras. 09 JUNIO/2017 No es posible contactar a la sñra Elizabeth Niño en numeros registrados,se envía notificación a numero de whatsapp 3204610057','00:04:13'),
  (46,1,'2017-07-07','2017-07-05 10:20:25',6183,41,3,'Matricula activa No 0000545089 ultimo año de renovacion 2016  16 empleados  direccion calle 10 43 11 Cali, Colombia,telefono  (2) 6807296 fuera de servicio calle 10 ente carrera 43 y 44 lote 1 Aut sur  TEL  5137829 fuera de servicio 3136551491 no contesta, representante legal Juan Guillermo Sanchez  C.C 80.422.175, suplente Patricia Bolaños C.C 31979.636, Registra 10 No 43-11  barrio departamental, correo electronico jypltda@une.net.co, se envia notificacion de cobro.\n27 Junio se hace investigacion representante legal  celulare 3136551491,3104099049 fijo 3043416 direccion calle 22 No 110-120 Casa 41 barrio Ciudad jardin, se envia notificacion correo pattyboes@hotmail.com \n\n','00:00:56'),
  (47,1,'2017-07-07','2017-07-05 10:24:19',6201,41,2,'Camara de comercio Sincelejo  No  de inscripcion RUP 000000003269 Fecha de renovacion 20170419  Fecha de inscripcion 20160226 , estado del proponente NORMAL direccion carrera 25 25-268 Av Okala Sincelejo, Colombia telefono celular (57) 3116608316,  direccion actual  carrera 25 No 25-269 en Sucre telefono de contacto 2821175 se habla con la señora Mariela informa que las facturas de diicembre ya le generaron el pago  y mañana realizan el pago del saldo, se envia notificacion correo electronico marielah@comaderas.com\n15 Junio de 2017 se habla nuevamente con la señora Mariela informa que  ya generaron el pago total de la obligacion, quedo de enviar soporte\n16 Junio allega soporte de pago total de la obligacion.\n\n','00:02:55'),
  (48,2,'2017-07-05','2017-07-05 10:26:45',5347,40,9,'Se dicta despacho comisorio para el secuestro de los bienes del deudor , esta pendiente  el envio de los mismos a colombina  para los gastos estimados.\n\n12 JUNIO/2017 Proceso Jurídico (Entro a proceso de embargo)','00:04:00'),
  (49,1,'2017-07-05','2017-07-05 10:31:31',6186,41,7,'Matricula activa No 0000119672 ultimo año de renovacion 2017 23 empleados organizacion de sociedad Limitada  Fecha de renovacion 20170330 Fecha de vigencia 20181207 Gerente Gonzalez Cimadevilla Ana Maria  C.c  000000051939284  \nSuplente de Gerente  Cimadevilla de Gonzalez Adelia  C.c  000000028420522 ,direccion Calle 22 14 - 50 Bogotá, Colombia   telefono (57) 2431040/3414711 Adriana Fernandez\n27 Junio, se confirma que realizaron abono por $1.383.220, el 21 de Junio, se habla con la contadora para el saldo, informa que  la que autoriza los pagos es la señora Ana Maria, se envia notificacion nuevamente.\n','00:01:14'),
  (50,1,'2017-07-05','2017-07-05 10:32:08',5364,40,9,'se ordeno mandamiento de pago a favor de colombina ,se le envió notificación al demandado teniendo en cuenta lo estipulado en el articulo 289CGP.\n10 JUNIO/2017 No es posible comunicarnos con el deudor ni codeudor, no registra números adicionales o informacion de contacto adicional a esta.','00:01:58'),
  (51,1,'2017-07-05','2017-07-05 10:36:59',6190,41,7,'Camara de comercio Valledupar  No de inscripcion RUP 000000002591 Fceha de Renovacion 20160623 direccion Villa Olímpica Lt 46 Barranquilla, Colombia telefono  (5) 3823170 direccion actual calle 39 No 6a-88 Valedupar telefono de contacto 5717122 se habla con la señora Kelly Cuello, que el dia 15 Junio realizaon un abono y el saldo para el 21 de Junio.\n16 Junio  envian soporte por $ 2.264.899 \n20 Junio envian soporte por $ 2.323.071','00:02:23'),
  (52,1,'2017-07-05','2017-07-05 10:37:55',5377,42,3,'3115810218 NUMERO EQUIVOCADO 3103033163 NUMERO FUERA DE SERVICIO 3115510  NUMERO FUERA DE SERVICIO  ','00:13:22'),
  (53,1,'2017-07-06','2017-07-05 10:45:40',6190,41,10,'Se habla con Kely que hablemos el dia de mañana para confirmar el pago del saldo','00:06:19'),
  (54,2,'2017-07-05','2017-07-05 10:45:48',6065,40,1,'La cuantía es de $7.946.200.oo, en la reorganización ya graduaron y reconocieron créditos el 31 de agosto de 2015, solamente nos reconocieron dos facturas: a) Factura No. AA-30695 por valor de $1.205.240, del 09 de Junio de 2014, para ser pagada el 08 de julio de 2014. b) Factura No. AA-30696 por valor de $1.021.960, del 09 de Junio de 2014, para ser pagada el 08 de julio de 2014. Ya hubo traslado de el proyecto y se resolvieron objeciones en audiencia del 11 de julio de 2016. Dentro del proceso judicial, el 10/08/2016 remiten expediente a la superintendencia. Estamos a la espera de acuerdo de reorganización','00:02:07'),
  (55,1,'2017-07-05','2017-07-05 10:45:55',5384,42,3,'3219818862 NUMERO EQUIVOCADO 3046245003 NUMERO FUERA DE SERVICIO 9026005','00:07:10'),
  (56,2,'2017-07-05','2017-07-05 10:47:59',6066,40,9,'Nos reconocieron en el proyecto de graduación de créditos presentado el 7 de abril de 2016. A la espera de audiencia para saneamiento de objeciones del proyecto de graduación de créditos.','00:01:39'),
  (57,1,'2017-07-05','2017-07-05 10:50:32',6193,41,8,'Matricula activa  No   0001655335 ultimo año Renovacion 20170331 empleados 16 fecha de matricula 20061127 fecha de vigencia 20361127  Sociedad Limitada direccion Avenida Carrera 9 103 39  estacion se servicio bionax telefono  6121088   Gerente Lopez Camacho Rafael Jos lopeze C.C 19237465, se habla con la señora Susana Bolivar, informa que no les registra obligacion con Brink se envia notificacion con estado de cuenta correo  electronico estacionbiomax103@hotmail.com\n15 Junio se comunica la señora Marha Lopez iforma que es la contadora de la empresa y que estas facturas ya las cancelaron 3102876894\n28 Junio, se deja mensaje con Susana, pendiente del soporte de pago.\n','00:02:04'),
  (58,1,'2017-07-05','2017-07-05 10:59:10',6193,41,8,'Se habla nuevamente con la señora marha solicita se le marque sobre las 3pm para recordarle sobre el soporte, que ella ya valido y este cuenta ya esta cancelada','00:08:36'),
  (59,1,'2017-07-11','2017-07-05 11:02:29',6067,40,10,'se habla con el señor Mauricio directamente, dice que esta pendiente de ese ultimo pago, y que esta esperando un dinero que le entra la otra semana para validar el pago. que le marque el dia 11 de julio para darme respuesta de esa deuda. ','00:08:47'),
  (60,1,'2017-07-07','2017-07-05 11:03:28',6192,41,3,'Matricula activa No 0001526882 ultimo año de renovacion 2015  fecha de renovacion 20150331 fecha de matricula 20050905 sociedades acciones simplificadas sas  direccion carrera 4 32-84 soacha,Bogota telefono 5797194 /5797457 fuera de servicio,    Representante Legal Guerra Camargo Julian Guillermo  C.C 79947760,  registra direccion Calle 98 No 9-25 Apto 302 telefono 3050131 se deja mensaje con la empreada , se envia notificacion de cobro correo electronico p.gas.snbuenaventura@etb.net.co, jgerra@lticol.com.\nrealizar visita en residencia representante y oficina\n\n','00:02:33'),
  (61,1,'2017-07-06','2017-07-05 13:00:23',6182,41,10,'Matricula activa  No  0000367181  ultimo año de Renovación 2016 fecha de renovación 20160407 fecha de vigencia 99991231 , 90 empleados dirección carrera 51d No 822-26 en Barranquilla barrio Tubrado tel 3736368, se habla con Yesenia que este tema es con el señor Daniel Tarud gerente general, se envia notificacion correo electronico danieltarud@hotmail.com\n\n\n','00:01:45'),
  (62,1,'2017-07-06','2017-07-05 13:06:49',6199,41,10,'Matricula activa No 0002311289  ultimo año de Renovacion 2017  fecha de Renovacion 20170424 fecha de vigencia 99991231, 10 empleados ,direccion calle 70 A Bis 23-18 Bogotá, telefono 6063436\nrepresentante legal Alcidiades Calderon Ortiz C.C 3,150,584 suplente Yenny Paola Andrade C.C 111017878 Telefono 6018992 fuera de servicio se envia notificacion correo electronico alcidescalderon@hotmail.com, yandrademoreno@gmail.com\nse habla con la señora Astrid Villalobos, informa que le envie nuevamente la notificacion correo astridvillalobos1975@gmail.com\n\n','00:05:23'),
  (63,1,'2017-07-07','2017-07-05 13:11:07',6197,41,3,'Matricula activa No  0000095953 ultimo año de Renovacion 2014 fecha de renovacion 2014  regisra direccion m7 via palmaseca en palmira tel 318-8273812, se envia notificacion correo electronico el paraisode rozo@yahoo.com\n','00:01:26'),
  (64,1,'2017-07-05','2017-07-05 13:45:37',6184,41,10,'Matricula activa No 0001217201  ultimo año de Renovacion 20170404 fecha de matricula 20020927 fecha de vigencia 20320920 sociedad comercial ,direccion carvajal-kennedy  calle 26 A sur No 64 A 39   telefono 2702201  Gerente Combita Vargas Segundo Ricardo C.c 17165640 direccion actual Carrera 70B No 24-08 sur barrio carvajal tel de contacto 4462525 se deja mensaje para el señor Ariel Combita, se envia notificacion correo electronico  invercomltda@hotmail.com\n27 Julio se habla con la asistente la señora Gloria, informa que estaran realizando el pago esta semana, se le suministra datos cuenta bancolombia de Brinks','00:02:15'),
  (65,1,'2017-07-06','2017-07-05 13:48:25',6185,41,10,'Matricula activa No 0001435203 ultimo año de Renovacion 2017 fecha de Renovacion 20170516 fecha de vigencia 99991231 sociedad comercial, empleados 4  Representante Legal Jimenez Barrera Jose Homero  C.c5787214  Representante Legal Suplente Jimenez Ororstegui Mauricio Alejandro  C.c 80425741  direccion Carrera  31 No 38 A 51 Sur barrio ingles , telefono 7204182, se habla con el señor Oswaldo Barrera, que le envie la informacion por correo para dar respuesta el dia de mañana admin@briosamore.com\n28 Junio/2017 se habla nuevamente con el señor Oswaldo informa que hablemos el viernes 30 Junio para confirmar el soporte o en su defecto el pago\n\n','00:01:59'),
  (66,1,'2017-07-05','2017-07-05 13:50:26',6178,41,10,'Matricula activa ultimo año renovado 2017, representante legal Lucia Martinez Gomez .C.C 45465954 SUPLENTE Maira Carmenza Martinez C.C 45755025 direccion Calle 29 No 27-05 manga Cartagena telefono de contacto 6626447 se habla con el señor Luis Carlos Solana manifiesta que no tienen obligacion pendiente con Brink,  que enviara los soportes de pago, se envia notificacion cobro al correo lsolana@districandelaria.com\n14 Junio envian soportes de consignaciones las cuales no tienen nada que ver con  Brink de Colombia, se le informa que estas consignaciones son de Prosegur\n','00:00:33'),
  (67,1,'2017-07-05','2017-07-05 14:08:12',6188,41,10,'Matricula activa  No 80224 ultimo año de Renovacion 2017 ,40 empleados ,Representante Legal   Jose Javier Castaño Giraldo     designacion  C.c 70.084.127  direccion  Calle 42 S 74-04 Medellín, , telefono (4) 4440468, se habla con el departamento juridico la dra Carolina Pineda, solicita se le envia la notificacion al correo juridica@cootrasana.com.co\n','00:07:16'),
  (68,1,'2017-07-06','2017-07-05 14:08:48',6188,41,10,'Se marca nuevamente se deja mensaje con Daniela Zuleta','00:00:35'),
  (69,1,'2017-07-07','2017-07-05 14:10:13',6195,41,10,'Matricula activa  No 0000045876  ultima año de Renovacion 2017 fecha de renovacion 20170331 fecha de matricula 20110331,empleados 5,direccion carrera santa elena la blanquita, el cerrito, valle; telefono  (2)2557401 telefono de contacto 311-3442856 se habla con Deysi informa que no registra obligacion alguna, se le envia notificacion con estado de cuenta correo electronico estacion_santahelena@hotmail.com\n28 Junio/2017 se habla con Yesica que estn buscando los soportes ya que es del año 2014 el tema es con el señor Diego Giraldo\n','00:00:31'),
  (70,1,'2017-07-05','2017-07-05 14:14:08',6191,41,10,'Matrícula No 0000090173ultimo año de renovado 2017  fecha de renovacion 20170228 fecha de matricula 20050531 fecha de vigencia 20350524, sociedad comercial,direccion carrera 10 9 A-36 Santa Marta, Colombia,telefono (5) 4200068 Representante Legal Gerente Prada Monsalve Miguel Angel C.c 85468372, se contacta a la señora Maryury prada informa que le envien estado de cuenta para confirmar si adeudan estas facturas, se envia notificacion cobro correo electronico maryury.prada@disan.co\n','00:02:52'),
  (71,1,'2017-07-25','2017-07-05 14:24:22',6228,40,1,'Matricula  activa No 0002184051 ultimo año renovado 2017,representante legal el señor Fredy Triana, se habla en departamento de contabilidad informan que tienen programación de pagos hasta Julio, se envía notificación correo electrónico contabilidad@equiposyterrtest.com, f.triana@equiposyterrastest.com. direccion actual carrera 7 No 114-33 Of 605  TEL 3101331.\n5 de julio nos volvemos a comunicar  con la señora Maria Hernandez coordinadora administrativa y de cartera, y manifiesta que la empresa no ha podido generar los pagos porque no han tenido solvencia económica. que los pagos se generara para la ultima semana de julio exactamente el 25. ','00:11:05'),
  (72,1,'2017-07-05','2017-07-05 14:45:57',6196,41,10,' Matrícula  activa No 0002117015 ultimo año renovado 2017 fecha de renovacion 20170330 fecha de matricula 20110705 fecha de vigencia 99991231,10 empleados,Representante Legal Romero Rodriguez Edwin  C.c  79647802  \nSuplente Rodriguez de Romero Rosalbina C.c 20937494  direccion Calle 132 94 F 52, Bogota,telefono 6862698 no reponde celular del señor Romero 315-2243567 no responde direccion Carrera 46 No 57-36 apto 401 Nicolas de Ferdeman, se envia notificacion correo electronico dicol.ltda@hotmail.com, edssantasofiasuba@yahoo.com, \n15 Junio se comunica la señora Leidy Caro , informa que estas facturas ya fueron canceladas desde 13 de mayo de 2014, que solicitara al señor edwion Romero de archivo para enviar los soportes.\n','00:00:35'),
  (73,1,'2017-07-05','2017-07-05 14:47:05',5353,40,1,'cliente viene pagando 1000000 mensual directo a la empresa. hasta el momneto esta pendiente de dos cuotas de mayo y junio la cual sumasn dos mllones de pesos. esta es la gestión actual del cliente. ','00:02:20'),
  (74,1,'2017-07-05','2017-07-05 15:02:29',5363,40,10,'el 6 de julio las abogadas DE LA COMERCILIZADORA ICE  CITY, se reunirán con los funcionarios Ana Aracelly Perez e Ivan  Rangel para tratar uno a uno cada proceso de cobro generado por los congeladores. ','00:07:37'),
  (75,1,'2017-07-05','2017-07-05 15:06:42',5354,40,1,'se tuvo contacto el cual reconoce la obligación, se hizo acuerdo de pago en cuatro cuotas mensuales, el cual incumplió con  el pago de la primera cuota, se le envía notificacion correo electronico ljsg.johana@live.com\nNo se contacta al R legal ni al codeudor para validar motivo del incumplimiento del acuerdo de pago. se contacta al deudor y hay que LLAMARLO LA SEMANA SIGUIENTE 23 MAYO.','00:03:02'),
  (76,1,'2017-07-07','2017-07-05 15:07:21',6196,41,10,'En comunicacion con Leidy informa que cuando realizaron el pago, el banco se equivoco y realizaron el pago a otra empresa, le informo que este tramite es interno entre ellos, que debe realizar el pago inmediato, aduce que hablara con el gerente para que le autorice el pago ya que esta fuera del pais','00:03:59'),
  (77,1,'2017-07-08','2017-07-05 15:07:57',5354,40,6,'se marca al cliente al numero correspondiente y se y no hay respuesta, se deja mensaje de voz. se sigue en gestión de cobro.','00:01:14'),
  (78,2,'2017-07-05','2017-07-05 15:41:16',5338,40,7,'cuenta saldada- ','00:00:57'),
  (79,1,'2017-07-10','2017-07-05 16:14:43',6178,41,10,'Se habla nuevamente con el señor Luis Carlos, informa que confirmara con la estación ya que ellos son districandelaria que administradores de Zona Franca, que paso con estas facturas que no le registra a ellos','00:42:34'),
  (80,1,'2017-07-10','2017-07-05 16:18:59',5375,42,1,'3207260007 cliente indica que cancela el dia lunes 10/07/2017  200.000 en banco de occidente, cliente no esta de acuerdo con el cobro debido a que al dia de hoy tan solo debe los honorarios indica que va a validar con team pendiente validar el pago el dia lunes','00:26:11'),
  (81,1,'2017-07-08','2017-07-05 16:31:12',5348,40,1,'Se contacta al esposo Carlos Torres al telefono 3105761523, se esta confirmando la dirección por que se mudaron para la ciudad de villavicencio, nos informa que la Sra. Laura no tiene  telefono de contacto directo. Estamos a la espera del soporte de pago.\n10 JUNIO/2017 Se habla con la sñra LAURA SILVA informa que para este mes realizara el pago de la cuota por el misma valor acordado  el mes pasado.Soporte de pago  15 mayo 2017.\nSe llama al numero 3105761523 contesta el señor Carlos Torres y confirma que el dia Jueves 29 Junio realiza un abono parcial de $200,000 \n','00:11:32'),
  (82,2,'2017-07-06','2017-07-05 16:35:49',5365,40,1,'En comunicación con el deudor afirma que esta realizando pagos directos a colombina, se niega a enviar soportes de pago, dice que los solicitemos directamente a ustedes, por validar esta informacion y saldo actual.\n12 JUNIO/2017 Nos comunicamos al numero celular 3014144589 y se deja mensaje con familiar quien indica que es la hermana del DEUDOR.','00:04:03'),
  (83,1,'2017-07-06','2017-07-05 16:36:16',5374,42,8,'se le genero demanda al cliente, se le solicita informacion al apoderado en valledupar, en donde el apoderado manifiesta que en juzgado ya emitio respuesta, apoderado no entrega detalles acerca de la desision  de juzgado','00:02:45'),
  (84,1,'2017-07-07','2017-07-05 16:38:30',6191,41,8,'Se habla nuevamente con Maryury informa que la factura No 31011232 por $2.648.184 le realizaron el pago completo el 18 de abril de 2016, se le envia comunicado a la señora clara de Brink para validar informacion y saldo','00:22:53'),
  (85,1,'2017-07-07','2017-07-05 16:55:15',6179,41,10,'Matrícula activa No  0000557155 ultimo año renovado 2017 fecha renovacion 20170314 fecha de matricula 19930716 fecha de vigencia 20330716,empleados 3897, direccion  carrera 49 C 93-08 Bogotá ,telefono 6211605 Representantes Gerente Perilla Medrano  German  Hernando   C.c 000000079285464  y  Subgerente  Perilla Medrano Javier Mauricio  C.c 000000079452798  \n','00:00:43'),
  (86,1,'2017-07-10','2017-07-05 17:01:08',6177,41,8,'Matrícula cancelada   No 0000071001 ultimo año de renovacion 2013 fecha de renovacion 20140127 fecha matricula 20031029 fecha de cancelacion 20140305 sociedad comercial, persona natural\nCR 5 10 49 CON ALTOS DEL FONCE TO F AP 404 San Gil / Santander 3102318805 correo electronico josemerchan08@gmail.com, se envia notificacion de cobro.\nse comunica el cliente informa que el no tiene ni ha tenido relaciones comerciales con Brinks, se le informa teléfono directo de ellos para  validar','00:04:16'),
  (87,7,'2017-07-05','2017-07-05 17:01:38',5343,40,4,'DEUDOR INSOLVENTE, ILOCALIZADOS, CON MATRICULA MERCANTIL CANCELADAS.','00:08:25'),
  (88,1,'2017-07-06','2017-07-05 17:04:12',6189,41,6,'Matrícula  activa No 0000665703 ultimo año renovado 2010  fecha vigencia 20901231  afiliados \nregistra telefono fijo 4488011 fuera de servicio direccion Cl 8B 65 281 en Medellín, telefono 2324421\n\n','00:01:18'),
  (89,1,'2017-07-10','2017-07-05 17:07:13',6187,41,3,'Matrícula activa No 0000048524 ultimo año renovado 2017  fecha matricula 19970115 fecha vigencia  99991231 sociedad economia solidaria , empleados 221,direccion  carrera 7  35-27 telefono 6076565, Gerente General  y Representante Legal Principal (Designacion)  Oscar  Ospina Piña C.c5.868.622\n                     ','00:01:22'),
  (90,1,'2017-07-05','2017-07-05 17:19:48',6203,41,10,' no registra en camara de comercio direccion Carrera 50a No 174b-06 torre 3 Apto 201 BARRIO BULEVAR TEL 6693827 Tiene acuerdo de pago para el 29 de mayo con el colegio calazans, Incumple acuerdo, allegan por parte del colegio cheque por la sum de $32.000.000 el cual giro y salio devuelto por fondos insuficientes, realizar el coro por el valor del cheque.','00:03:47'),
  (91,1,'2017-07-07','2017-07-05 17:21:16',6203,41,10,'cra 50 A 174 B 06 torre:3 apt:201 barrio baviera IV -CELULAR 3228005720 el señor manifiesta que no tiene el dinero para pagar pero que esta esperando que le entre un pago para poder cancelar el valor total del cheque que giro sin fondos al colegio calazans  , el señor quiere llegar a un arreglo pero manifiesta que primero quiere conseguir una plata para poder negociar- CORREO.de la esposa molifa6@hotmail.com','00:00:31'),
  (92,1,'2017-07-06','2017-07-06 09:03:46',5365,40,6,'se le marca al cliente a los respectivos numero y no hay respuesta... el numero de celular 3103609439, es el numero del vendedor de colombina. se sigue en gestión de cobro','00:04:10'),
  (93,7,'2017-07-06','2017-07-06 09:22:32',5349,40,4,'Se hace investigacion, se registra como persona natural, el estado de la matricula se encuentra activa, el ultimo año renovado es en 2017, se envia notificacion a la direccion Carrera 12 A N  14 36 Riohacha / La Guajira y correo electronico ybalvaradom@hotmail.com  se ivestigo el telefono 3008171711,  El codeudor Luis Eduardo, registra como persona natural en camara de comercio, estado de la matricua esta activa, ultimo año renovado 2014, CL 17 A 7 87 Riohacha / La Guajira, la cual se envió notificacion fisica y correo electronico crownluiss@hotmail.com y el telefono celular 3043979613.\nLlegan correo electronico Kelly Molinares, suspendiendo el cobro de este cliente.','00:17:55'),
  (94,1,'2017-07-06','2017-07-06 09:32:29',6194,41,1,'Se presenta a las instalaciones de Counal la señora Maria Eugenia, se hace acuerdo de girar cheque posfechado por el saldo del capital','00:14:38'),
  (95,1,'2017-06-10','2017-07-06 09:37:27',5350,40,9,'Se cofirma la matricula esta activa, ultimo año renovado 2017, nos comunicamos al numero (5) 3705053 con la Sra. Marina Sanchez madre de la deudora nos informa que ella es propietaria de heladeria antojate nos confirma la direccion de recidencia  Carrera 15 N 10-13 en plato magdalena y telefon de contacto 3107385437.10 JUNIO/2017 Nos comunicamos con la mama de R.Legal quien recibe mensaje para que la señora se comunique a COJUNAL.  Cliente en stand by desde septiembre de 2016. ','00:02:01'),
  (96,1,'2017-07-11','2017-07-06 09:43:10',6181,41,10,'En comunicacion con el gerente el señor Fabio Tarud informa su inconformismo sobre que le hayan enviado a cobro juridico, ya que ha trabajado con la Brinks por mas de 30 años, no hace propuesta de pago, quiere que la Brinks lo llame?','00:09:15'),
  (97,1,'2017-07-07','2017-07-06 09:44:10',5350,40,6,'SE HABLA CON EL SEÑOR JHON  LOPEZ HERMANO DE LA CLIENTE QUIEN MANIFIESTA QUE LLAMEMOS DIRECTAMENTE A LA CLIENTE A SU NUMERO PERSONAL 3107385437, MARCAMOS A SU NUMERO Y NO HAY RESPUESTA ALGUNA. SE SIGUE EN GESTION DE COBRO','00:06:41'),
  (98,1,'2017-06-10','2017-07-06 09:56:32',5351,40,6,'Se envia notificacion correo electronico marylz@hotmail.com, telefonos de la señora Mary Luz fuera de servicio, se hace investigacion por parte de Codeudor el señor Gulmer Amuri, se envia notificacion correo electronico  gilmeyurgaky@hotmail.com,  telefonos 312-8839692 /6795674, se ubica telefono 314-5373680 no conocen a los deudores.\n12 JUNIO/2017 Se deja mensaje de voz con numero de contacto COJUNAL. 10 JUNIO/2017 Numeros registrados no contestan;se envia notificacion al whatsapp 3122957879','00:03:36'),
  (99,1,'2017-06-10','2017-07-06 09:56:32',5351,40,6,'Se envia notificacion correo electronico marylz@hotmail.com, telefonos de la señora Mary Luz fuera de servicio, se hace investigacion por parte de Codeudor el señor Gulmer Amuri, se envia notificacion correo electronico  gilmeyurgaky@hotmail.com,  telefonos 312-8839692 /6795674, se ubica telefono 314-5373680 no conocen a los deudores.\n12 JUNIO/2017 Se deja mensaje de voz con numero de contacto COJUNAL. 10 JUNIO/2017 Numeros registrados no contestan;se envia notificacion al whatsapp 3122957879','00:03:36'),
  (100,1,'2017-07-06','2017-07-06 10:50:56',5335,40,9,'se habla con la cliente directamente y manifiesta que ella ya no debe nada a la empresa colombina, que ella tenia en su poder 33 congeladores y los mismo se entregaron al aliado. nos enviara una carta de entrega donde se valida que los congeladores están en posesión del aliado. manifiesta que envira dichos soportes. de nuestra parte se sigue con la gestión de cobro y se envía notificación al correo de la deudora con el soporte de los datos de los congeladores.','00:51:07'),
  (101,1,'2017-07-06','2017-07-06 11:17:24',5378,42,6,' 3168752213 REPRESENTANTE LEGAL NO RESPONDE SE LE INISTSE EN EL NUMERO 2315020 RESPONDE JENNNIFER INDICA QUE NO SE ENCUENTRA LA CONTADORA NI EL REPRESENTANTE LEGAL, SE LE DEJA MENSAJE CON DATOS PARA QUE SE COMUNIQUE PENDIENTE VOLVER A COMUNICARNOS \n','00:24:07'),
  (102,1,'2017-07-06','2017-07-06 11:37:06',5371,42,5,'3132303047 RESPONDE EL SEÑOR BERNARDO FAMILIAR DE LA REPRESENTANTE LEGAL, INDICA QUE QUE LE DEJA EL MENSAJE SE LE INDICAN DATOS DE CONTACTO 3144136634\nNUMERO DE LA HERMANA BEATRIZ RINCON IDNICA QUE NO TIENE EL NUMERO DE CONTACTO DE LA REPRESENTANTE LEGAL PENDIENTE VOLVER A COMUNICARNOS ','00:18:16'),
  (103,1,'2017-07-06','2017-07-06 11:54:17',5353,40,7,'CLIENTE ENVIO SOPORTE DE PAGO Y LA CUENTA YA ESTA SALDADA','00:15:13'),
  (104,1,'2017-07-11','2017-07-06 12:27:53',5336,40,10,'cliente manifiesta que la plata la cogieron los transportadores, manifiesta que el no es el responsable de la deuda. El responsable de la deuda es el señor Jose Tovar, el cual es el transportador, que el solo alquilo el camión. quedo pendiente de llamar al supuesto responsable para generar el pago  de la deuda.','00:17:48'),
  (105,1,'2017-07-06','2017-07-06 13:57:30',5337,40,7,'CLIENTE MANIFIESTA QUE YA CANCELO LA DEUDA QUE TENIA PENDIENTE CON LA EMPRESA COLOMBINA, LE DESCONTABAN $180.000 SEMANAL PARA SUPLIR LA DEUDA. SE VALIDA CON COLOMBINA, CON LA SEÑORA KENIA DE CARTERA LA CUAL RESPALDA LA INFORMACION DEL CLIENTE, DEUDA CANCELADA LA ULTIMA SEMANA DE JULIO... ','01:25:53'),
  (106,1,'2017-07-07','2017-07-06 14:05:16',6193,41,8,'Se habla nuevamente con la señora Marha que esta scaneando los soportes para enviarlos','00:03:34'),
  (107,1,'2017-07-17','2017-07-06 14:16:13',5366,42,1,'3103446771 responde la deudora indica que puede realizar pagos mensuales de 400.000 en donde se vana diferir a capital y a honorarios katerins23@hotmail.com 400 mensuales durante 6 meses ','02:38:40'),
  (108,1,'2017-07-07','2017-07-06 14:30:21',6182,41,10,'Se habla nuevamente con Yecenia que hablemos el día de mañana, ya que tiene entendido que se giro cheque no sabe el vaor que hablara con el señor Daniel Tarud','00:12:49'),
  (109,1,'2017-07-11','2017-07-06 14:36:46',5354,40,6,'no hay comunicación con el cliente.','00:24:54'),
  (110,1,'2017-07-11','2017-07-06 14:36:46',5354,40,6,'no hay comunicación con el cliente.','00:24:54'),
  (111,1,'2017-07-10','2017-07-06 14:47:18',6199,41,1,'Se habla con Astrid que realizan el pago de la obligacion el día lunes 10 de Julio, se le envía correo confirmando como realizar los pagos de la obligacion de Capital, intereses y honorarios','00:16:08'),
  (112,1,'2017-07-07','2017-07-06 15:11:25',6184,41,10,'Se habla con Gloria, informa que no le han autorizado pago, le dará el mensaje al señor Ariel Combita','00:13:28'),
  (113,1,'2017-07-07','2017-07-06 15:18:20',5355,40,1,'el señor Carlos manifiesta que el ya aclaró con colombina que el no es el deudor de esa cuenta. que no sabe porque le cobran a el si la empresa arreglo con el correspondiente deudor el señor willinton Andres  el esta pagando a la empresa. se valida con henrry wilson mejia vendedor de colombina si esta informacion es cierta para que envíen los soportes.','00:20:31'),
  (114,1,'2017-07-07','2017-07-06 15:37:34',5357,40,6,'NO HAY COMUNICACION CON EL CLIENTE.','00:04:22'),
  (115,1,'2017-07-10','2017-07-06 15:41:09',6185,41,1,'En comunicacion con el señor Oswaldo informa que 10 Julio realiza pago de capital y sobre los intereses este pago lo autoriza el jefe','00:01:28'),
  (116,1,'2017-07-07','2017-07-06 15:50:53',5340,40,4,'SE HABLA CON LA HIJA  DEL CLIENTE, DICE QUE EL DEUDOR ESTA BASTANTE ENFERMO Y ESTA INTERNADO EN UNA CLÍNICA, Y NO HAY COMO PAGAR, ADEMAS QUE GENERARAN UNA DEMANDA CONTRA COLOMBINA PUESTO QUE ESTA SE QUEDO CON MUCHA PLATA DEL SEÑOR, EN UNOS ACUERDO DE PAGOS QUE SE HICIERON DIRECTAMENTE CON LA EMPRESA. SE VALIDARA CON LA EMPRESA COLOMBINA LA INFORMACIÓN.','00:10:11'),
  (117,1,'2017-07-07','2017-07-06 15:50:53',5340,40,4,'SE HABLA CON LA HIJA  DEL CLIENTE, DICE QUE EL DEUDOR ESTA BASTANTE ENFERMO Y ESTA INTERNADO EN UNA CLÍNICA, Y NO HAY COMO PAGAR, ADEMAS QUE GENERARAN UNA DEMANDA CONTRA COLOMBINA PUESTO QUE ESTA SE QUEDO CON MUCHA PLATA DEL SEÑOR, EN UNOS ACUERDO DE PAGOS QUE SE HICIERON DIRECTAMENTE CON LA EMPRESA. SE VALIDARA CON LA EMPRESA COLOMBINA LA INFORMACIÓN.','00:10:11'),
  (118,1,'2017-07-07','2017-07-06 15:58:23',5376,42,5,'3126699411 NUMERO APAGADO  RESPONDE LA SRA SANDRA EN LA PANADERIA LUKAS INDICA QUE NO SE ENCUENTRA LA PERSONA ENCARGADA SE LE DEJA MENSAJE CON DATOS PARA QUE SE COMUNIQUE  \n','00:14:29'),
  (119,1,'2017-07-13','2017-07-06 16:20:07',5363,40,10,' se valida con el señor Ivan rangel de colombina, la reunión realizada con las abogadas de COMERCIALIZADORA ICE CITY  quien manifiesta que enviara un correo a  cojuanal, informando de forma general lo que se trato en la reunión. las abogadas llevaron documento donde validad que se generaron entrega. por parte de colombina validaran dichos documentos y entre miércoles y jueves de la próxima semana de julio, se volverán a reunir para validar la deuda. ','00:19:17'),
  (120,1,'2017-07-13','2017-07-06 16:20:07',5363,40,10,' se valida con el señor Ivan rangel de colombina, la reunión realizada con las abogadas de COMERCIALIZADORA ICE CITY  quien manifiesta que enviara un correo a  cojuanal, informando de forma general lo que se trato en la reunión. las abogadas llevaron documento donde validad que se generaron entrega. por parte de colombina validaran dichos documentos y entre miércoles y jueves de la próxima semana de julio, se volverán a reunir para validar la deuda. ','00:19:17'),
  (121,1,'2017-07-11','2017-07-07 09:04:08',5367,42,1,'3234499444 DEUDOR REALIZA PAGO EL DIA DE HOY EN LA TARDE ABONO POR 500.000 PENDIENTE CONFIRMAR EN LA TARDE CLIENTE CON ACUERDO DE PAGO REALIZADO ANTERIORMENTE \n','00:01:04'),
  (122,1,'2017-07-13','2017-07-07 09:19:33',5379,42,1,'3132490129 teresa caviedes con acuerdo de pagos mensuales por 400.000 realizo el pego en el mes de junio el dia 11/06/2017 pendiente confirmar el proximo pago el dia 12/07/2017 ','00:01:27'),
  (123,1,'2017-07-11','2017-07-07 09:22:20',6200,41,10,'5 julio/2017 informa que a señora Aida esta en licencia de maternidad de Habla con la señora lorena Martinez analista de Tesoreria,  informa que no han recibido respuesta al tema sobre el cruce enviandocumentacion de correos, se reenvia a la señora Clara Pachon, ','00:06:37'),
  (124,1,'2017-07-28','2017-07-07 09:39:29',5369,42,1,'3203723127 DEUDOR INDICA QUE TAN SOLO PUEDE REALIZAR ABONO MENSUALES DE 300.000  LOS DIAS 28 DE CADA MES SOLICITA LA INFORMACION DE PAGO VIA CORREOE ELECTRONICO A comercializadora.ya@hotmail.com  SE LE ENVIA CORREO CON LA INFORMACIÓN DE PAGO ','00:18:44'),
  (125,1,'2017-07-11','2017-07-07 10:33:38',5373,42,9,'3142947286 responde el deudor pide que le de un momento cuelga se le insiste no responde pendiente volver a comunicarnos ','00:09:04'),
  (126,1,'2017-07-11','2017-07-07 10:41:05',6186,41,7,'07 Julio/2017 se habla  con Yeimi Diaz, confirma que pasar por cheque el dia de hoy por valor de $1.543.341, se le informa a la señora clara\n  ','00:01:50'),
  (127,1,'2017-07-13','2017-07-07 11:05:43',6190,41,10,'07 Junio se habla nuevamente con Kelly que hasta la otra semana realizan pago del saldo $611.785','00:00:38'),
  (128,1,'2017-07-14','2017-07-07 11:14:03',5355,40,1,'CLIENTE HA REALIZADO 3 ABONOS POR VALOR DE:  $396450 EL DIA 17 DE MAYO, EL SEGUNDO ABONO LO REALIZO  EL DÍA 31  MAYO POR VALOR DE $250000, Y EL TERCERO DE $250000 EL DÍA 30 JUNIO. ','00:17:09'),
  (129,1,'2017-07-14','2017-07-07 11:14:03',5355,40,1,'CLIENTE HA REALIZADO 3 ABONOS POR VALOR DE:  $396450 EL DIA 17 DE MAYO, EL SEGUNDO ABONO LO REALIZO  EL DÍA 31  MAYO POR VALOR DE $250000, Y EL TERCERO DE $250000 EL DÍA 30 JUNIO. ','00:17:09'),
  (130,1,'2017-07-12','2017-07-07 11:23:04',6193,41,8,'06 Junio/2017 la señora Martha envia soportes Adjunto envio consignaciones por $577.100 pagando las facturas 86679 y 86506.\n$ 787.706 pagando fact. 79164 y 8881 y $ 863.959 pagando fact. 66853 y 75300.\nQue pendiente de enviar las consignaciones de sept 15 de 2015 de las fact. 75300-75581-75860-6434 y 6626. ya que este archivo esta en otro lugar.\n','00:04:34'),
  (131,1,'2017-07-07','2017-07-07 11:52:09',5381,42,3,'3215397290 numero del señor padre de jennifer chaparro se encuentra fuera de servicio 3164430622 numero del esposo de jennifer chaparro fuera de servicio 3105163330 numero de jhon chaparro hermano de jenifer chaparro numero fuera de servico 3135446529 numero de jeniffer chaparro apagado 3005574105 numero  de jenifer chaparro fuera de servicio (5)3786714 numero en barranquilla se encuentra fuera de servicio5711141 numero de indupan no responden //  jennifer chaparro dueña de CAMPERO MITSUBISHI MODELO 1998 NATIVA con placas EUX293 COLOR OLIVA BEIGE  CABINADO registra comparendo con placas HXN078 no se encuentra propietario del vehiculo ','00:00:40'),
  (132,1,'2017-07-07','2017-07-07 12:41:51',6230,40,9,'se localiza en el telefono celula 3137466380 al Representante legal luis Alberto Ariaz Alzate se envio notificacion de cobro al correo electronico banquetescasablanca@hotmail.com .  09 JUNIO/2017 Se llama al numero registrado donde contestan pero no dan razon y finalizan la respectiva llamada.','00:00:50'),
  (133,1,'2017-07-10','2017-07-07 13:44:20',5372,42,1,'3183774935 responde la deudora indica que el dia lunes 10/07/2017 realiza pago por valor de 120.000 en bancolombia indica que va a hacer lo posible por cancelar la totalidad en el mes de agosto pendiente confirmar pago','00:11:04'),
  (134,1,'2017-07-10','2017-07-07 13:58:35',6188,41,10,'07 Junio se comunica la señora clara de Brink que este cliente se esta comunicando con ellos para el pago, confirmar si generaron el pago directo\n','00:00:31'),
  (135,1,'2017-07-13','2017-07-07 14:13:33',6230,40,9,'Se habla con la señora Diana la secretaria de inversiones arias alzate, quien manifiesta que ya le\n ha dado varias veces la razón al señor de la informacion de la deuda pero no responde y hace caso omiso a lo expuesto.  ','01:31:41'),
  (136,1,'2017-07-10','2017-07-07 14:21:58',6196,41,10,'07 Julio/2017 se habla nuevamente con leidy que el gerente llega hasta el dia lunes a la oficina para saber si autoriza pago.\n','00:00:13'),
  (137,1,'2017-07-12','2017-07-07 14:41:19',5348,40,1,'SE COMUNICA CON LA DEUDORA LAURA HELENA SILVA, QUIEN NOS INDICA QUE EFECTIVAMENTE ESTÁN ABONANDO A LA DEUDA PERO QUE NO HA PODIDO GENERA MAS ABONO PORQUE NO HA ENTRADO DINERO A SU EMPRESA. QUE EL MIÉRCOLES 12 DE JULIO, HARÁ RESPECTIVO PAGO.  ','00:16:02'),
  (138,1,'2017-07-12','2017-07-07 14:41:19',5348,40,1,'SE COMUNICA CON LA DEUDORA LAURA HELENA SILVA, QUIEN NOS INDICA QUE EFECTIVAMENTE ESTÁN ABONANDO A LA DEUDA PERO QUE NO HA PODIDO GENERA MAS ABONO PORQUE NO HA ENTRADO DINERO A SU EMPRESA. QUE EL MIÉRCOLES 12 DE JULIO, HARÁ RESPECTIVO PAGO.  ','00:16:02'),
  (139,1,'2017-07-10','2017-07-10 11:00:20',5621,42,6,'\"2572232 NUMERO NO RESPONDE   REPRESENTANTE LEGAL PEREA SANCHEZ ANDRES CC 86062230  DIRECCION AV CR 15 77 50 OF 301 TELEFONO 2572232 CORREO ELECTRONICO andresp19000@hotmail.com /// DIRECCION DE LA EMPRESA CR 15 77 50 OF 301\nTELEFONO 2572232 CORREO contacto@aaconsultoriaeingenieria.com BOGOTA  CLIENTE NO PRESENTA NUMEROS DE CONTACTO\"\n','00:59:11'),
  (140,1,'2017-07-14','2017-07-10 11:14:38',5618,42,5,'8245125 RESPONDE GIOVANI EN EL AREA DE PAGOS INDICAQUE ELLOS CANCELARON LA OBLIGACION, SE LES SOLICITA LOS COMPROBANTES VIA CORREOE ELECTRONICO PENDIENTE CONFIRMAR EN EL TRANSCURSO DE LA SEMANA \n','00:00:31'),
  (141,1,'2017-07-10','2017-07-10 11:43:44',5589,42,3,'REPRESENTANTE LEGAL  PEREZ FONSECA CARLOS EDWIN CC 79210571 SUPLENTE PEREZ FONSECA JOHN ALEJANDRO  CC 80166288  DIRECCION CR 32 B 4 61 P 2 Bogotá, D.C. TELEFONO  2775031 CORREO ELECTRONICO aliancoingenieria@hotmail.com // REPRESENTANTE LEGAL  PEREZ FONSECA CARLOS EDWIN CC 79210571 DIRECCION CR 32 B 4 61 P 2 BRR VERAGUAS CANTRAL  Bogotá, D.C. TELEFONO 2775031 CORREOE ELECTRONICO aliancoingenieria@hotmail.com /// PEREZ FONSECA JOHN ALEJANDRO  CC 80166288 TELEFONO 3165812786 CORREO johnalejandro.perez@hotmail.com DIRECCION CL 36 BIS SUR 3 46 BRR VILLA DE LOS ALPES //  SE ENVIA CORREOS SOLICITANDO INFORMACION DE CONTACTO\n','00:26:04'),
  (142,1,'2017-07-12','2017-07-10 11:54:20',5570,42,5,'3124804983 RESPONDE REPRESENTANTE LEGAL JUAN MANUEL MARTINEZ INDICA QUE LA EMPRESA ANTEA SE ENCUENTRA EN PROCESO DE REORGANIZACION, ENDICA QUE NOS ENVIARA DATOS DE LA PROMOTORA ENCARAGA Y NOMBRADA POR LA SUPER SOCIEDADES PARA VALIDAR FECHAS DE PAGOS A PROVEEDORES, PENDIENTE CONFIRMAR DATOS\n','00:10:07'),
  (143,1,'2017-07-14','2017-07-10 12:26:04',5362,40,1,'SE HABLA  CON EL SEÑOR ALEXANDER PEREZ  INDICA QUE HAN GENERADO ABONOS DIRECTAMENTE A COLOMBINA, Y QUE ESTÁN EN PROCESOS DE CRUCES DE CUENTAS, YA QUE LA EMPRESA COLOMBINA LE TIENE UNA DEUDA PENDIENTE. VALIDAR CON CARTERA DE COLOMBINA SI ES VERAZ LA INFORMACIÓN, Y CUANTOS ABONOS HAN GENERADO.   ','00:08:50'),
  (144,2,'2017-07-10','2017-07-10 15:20:00',5386,40,1,'EN INVESTIGACION REGISTRA MATRICULA ACTIVA No 135976  ULTIMA FECHA DE RENOVACION 2015, IINMUEBLE  CON MATRICULA No 080-20354 A NOMBRE DEL SEÑOR JOSE ALBERTO MOZO, EL CUAL SE ENCUENTRA EMBARGADO POR LA EMPRESA CIRCULO DE VIAJES UNIVERSAL S.A, PROCESO QUE CURSA EN EL JUZGADO DECIMO CIVIL MUNICIPAL DE SANTA MARTA. EN COMUNICACIÓN CON EL CODEUDOR INFORMA QUE ESTE NO ES EL SALDO REAL A CAPITAL, SE HABLAN CON EL SEÑOR DARIO DE JARINOX INFORMA QUE NOS CONFIRMARA EL SALDO A CAPITAL, EL CUAL SE HACE ACUERDO CON EL SEÑOR ALBERTO DE PAGOS MENSUALES DE $1.000.0000 A PARTIR DEL 15 DE ABRIL. ','00:00:15'),
  (145,1,'2017-07-11','2017-07-10 15:22:14',5566,42,10,'\"DIRECCION CL 25 F 85 B 23 P 3 Bogotá, D.C. CORREO t.arango@hotmail.com\n SE LE ENVIA CORREO ELECTRONICO SOLITANDO COMUNICACIÓN 3125278248 RESPONDE LA DEUDORA INDICA QUE YA HABIA CANCELADO EN EL 2016 SE LE SOLICITA ENVIARNOS LOS SOPORTES VIA CORREO ELECTRONICO PENDIENTE RECIBIRLO \"\n','00:28:26'),
  (146,1,'2017-07-10','2017-07-10 15:22:37',5387,40,1,'SE GENERA INVESTIGACIÓN MATRICULA ACTIVA, NO REGISTRA INMUEBLES NI VEHÍCULOS, EN COMUNICACIÓN CON EL SEÑOR ERNESTO MEJIA, REPRESENTANTE LEGAL, SE HAN GENERADO ABONOS PARCIALES A LA OBLIGACION, COMPROMISO PAGO SALDO LA PRIMERA SEMANA DE ABRIL.','00:01:39'),
  (147,1,'2017-07-11','2017-07-10 16:36:36',5566,42,7,'cliente realizo pago tan solo de capital por valor de $ 349,206','00:04:19'),
  (148,1,'2017-07-10','2017-07-10 16:44:07',5566,42,10,'cliente realizo pago tan solo de capital por valor de $ 349,206','00:00:59'),
  (149,1,'2017-07-10','2017-07-10 17:03:46',5643,42,10,'EN COMUNICACIÓN CON EL SR BERNALDO INFORMA QUE NO TIENE OBLIGACIÓN PENDIENTE CON ANTEK, QUE ELLOS LE HICIERON UNA COTIZACIÓN Y GENERARON EL PAGO, QUE ANTEK LE DEBE EL INFORME DE UNOS ANÁLISIS QUE YA SE CANCELARON.','00:00:51'),
  (150,1,'2017-07-11','2017-07-10 17:33:07',6227,40,9,'NO REGISTRA EN CÁMARA DE COMERCIO, DIRECCIÓN  CALLE 74 No 11-21 APTO 201, TELÉFONO FIJO 5897575, REGISTRA DIRECCIÓN CASA EN GIRADOR CALLE DE LAS CAMOTAS CS2C-546, TELÉFONO FIJO 8883257 FUERA DE SERVICIO. POR PARTE DE LA MAMA LA SEÑORA ISABEL CRISTINA CORRALES SE LE ENCONTRÓ UNA CAMIONETA JEEP MODELO 2003 PLACA BOU405, SE ENVÍA NOTIFICACIÓN COBRO CORREOS ELECTRÓNICOS corrales.mac@gmail.com,cristincor@hotmail.com, luzm.pulido@interasesore.eu.co\n28 Junio se habla con Yenny asistente del señora Cristina isabel, informa que esta de viaje que regresa en la semana de 10 de Julio se envía notificación correo electrónico gerencia@turismundo.com','00:10:19'),
  (151,2,'2017-07-14','2017-07-11 08:17:27',6229,40,9,' Registra LA GORIETA BELLO SAS EN LIQUIDACIÓN, matricula No 158446 cancelada en enero 29 de 2016 con dos establecimientos de comercio AGENCIA DE ABARROTES LA GLORIETA, matricula activa  AGENCIA DE ABARROTES LA GLORIETA 2 matricula cancelada, por parte de la codeudora la señora Natalia Lopez, registra dirección calle 51 nO 46-75 Apto 201 barrio prado bello teléfono fijo 2065175 no contestan celular 301-6373810 se habla con la codeudora se le notifica sobre el cobro, informa que hablara con la señora Mariela confirma  datos de la glorieta celular 313-6126953 fijo 4449191    contestan de Efrain Parra, están funcionando hace una semana, no dan informacion de la Glorieta ni la señora Mariela, se envia notificacion correo electronico laglorietabello@gmail.com','00:01:43'),
  (152,1,'2017-07-11','2017-07-11 09:36:46',5643,42,8,'5321559 RESPONDE LA SRA VALENTINA INDICA QUE EL SEÑOR BERNARDO NO SE ENCUENTRA SE LE DEJA MENSAJE PARA QUE SE COMUNIQUE // REPRESENTANTE LEGAL BOTERO FUNEME BERNARDO ANTONIO  70551917 SUPLENTE 32527087 CORREO ELECTRONICO ACTUALIZADO ','00:54:26'),
  (153,1,'2017-07-11','2017-07-11 10:00:35',5563,42,6,'TELEFONO 2780868 Ibagué CORREO ELECTRONICO fbustosr2@gmail.com DEUDOR ACTIVO EN SALUD TOTAL S.A. SE ENVÍA CORREO ELECTRÓNICO SOLICITANDO QUE SE COMUNIQUE  \n','00:07:24'),
  (154,1,'2017-07-11','2017-07-11 10:50:51',5563,42,10,'3134182078 CLIENTE INDICA QUE YA CANCELO PERO QUE AUN NO TIENE EL COMPROBANTE SE LE SOLICITA NOS ENVIA EL COMPROBANTE VIA ELECTRONICO','00:01:12'),
  (155,1,'2017-07-12','2017-07-11 11:13:52',5564,42,9,'3125737524 CLIENTE INDICA QUE LE FACTURARON LOS ESTUDIOS, PERO LOS RESULTADOS NUNCA LLEGARON INDICA QUE NO VA A CANCELAR, SE LE SOLICITA LA INFORMACIÓN POR ESCRITO PARA SOLICITAR INFORMACIÓN A ANTEK \n','00:19:02'),
  (156,1,'2017-07-14','2017-07-11 13:00:45',6191,41,10,'allega correo solicitando copias de las facturas ya que no registran en contabilidad, se le reenvia correo a la señora Clara Pachon.\n','00:00:50'),
  (157,1,'2017-07-31','2017-07-11 14:52:25',5361,40,9,'NOS COMUNICAMOS CON EL SEÑOR HENRY VARGAS DEUDOR DE LA OBLIGACION, MANIFIESTA QUE AUN NO PUEDE DAR SOLUCIONES A LA DEUDA, QUE EN UNOS 20 DIAS PODRÍA PASAR UNA PROPUESTA ECONÓMICA PARA GENERAR OPCIONES DE PAGO. ','00:08:40'),
  (158,1,'2017-07-31','2017-07-11 14:52:26',5361,40,9,'NOS COMUNICAMOS CON EL SEÑOR HENRY VARGAS DEUDOR DE LA OBLIGACION, MANIFIESTA QUE AUN NO PUEDE DAR SOLUCIONES A LA DEUDA, QUE EN UNOS 20 DIAS PODRÍA PASAR UNA PROPUESTA ECONÓMICA PARA GENERAR OPCIONES DE PAGO. ','00:08:40'),
  (159,1,'2017-07-11','2017-07-11 15:25:25',6185,41,2,'cuenta al dia recuperada','00:01:00'),
  (160,1,'2017-07-15','2017-07-11 16:12:09',5563,42,9,'3125737524 DEUDOR INDICA QUE NO ESTA DEACUERDO CON EL COBRO DEBIDO A QUE NUNCA LE INFORMARON CUANDO LE ENTREGABAN LOS RESULTADOS DEL ESTUDIO, INDICA QUE EL DE DE MAÑANA SE ACERCA A LAS INSTALACIONES DE ANTEK PARA SOLICITAR INFORMACION DE LOS RESULTADOS Y DE LA MISMA MANERA CONFIRMAR EL PAGO \n','00:00:20'),
  (161,1,'2017-07-15','2017-07-11 16:21:14',5564,42,9,'3125737524 DEUDOR INDICA QUE NO ESTA DEACUERDO CON EL COBRO DEBIDO A QUE NUNCA LE INFORMARON CUANDO LE ENTREGABAN LOS RESULTADOS DEL ESTUDIO, INDICA QUE EL DE DE MAÑANA SE ACERCA A LAS INSTALACIONES DE ANTEK PARA SOLICITAR INFORMACION DE LOS RESULTADOS Y DE LA MISMA MANERA CONFIRMAR EL PAGO \n','00:00:35'),
  (162,1,'2017-07-12','2017-07-11 16:25:25',5563,42,10,'3134182078 DEUDOR INDICA QUE VALIDARA LA OBLIGACIÓN CON ANTEK PENDIENTE COMUNICARNOS ','00:03:04'),
  (163,1,'2017-07-12','2017-07-11 16:37:41',5596,42,5,'GERENTE BUITRAGO RODRIGUEZ ELIZABETH   C.C. 51905726 SUPLENTE DEL GERENTE MORALES RODRIGUEZ NATALIA MILENA           C.C.1020750302 telefono 3001010 bogota correo elibuitrago@gmail.com direccion CL 110 9 25 OF 912 3001010 en bogota responde arlin indica que los encargados se encuentran en una reunion se le indican datos para que se comunique /// se envia correo electronico solicitando informacion \n','00:10:51'),
  (164,1,'2017-07-12','2017-07-11 17:05:55',5582,42,10,'\"DIRECCION CL 74 56 36 OF 901 EN Barranquilla / Atlántico NUMERO FIJO 3601670 CORREO mvasquez@caribbeanresources.co\nOTRA DIRECCION Calle 77B N 57  141 OFICINA 708 //  3601670 NUMERO NO RESPONDEN SE LE INSISTE  SE ENVIA CORREO SOLICITANDO COMUNICACIÓN \"\n','00:08:26'),
  (165,1,'2017-07-12','2017-07-12 11:04:47',6106,42,10,'Registra matricula activa No 539969 ultimo año renovado 2016, representante legal Nestor Sanchez, se envia notificacion correo electronico distribuciones serviexpressplaza@hotmail.com, se marca telefono fijo 3797272 se deja mensaje con Patricia Gomez, confirma recibido de la notificacion, el señor Nestor informa que estan tramitando lo del pago de la obligacion. no define fecha de pago. ///  empresa con camioneta de placas KJN231 color BLANCO LUNA marca CHEVROLET N300 modelo 2014 matriculada en secretaria de transito de puerto colombia avaluada en 28,000,000 segun fasecolda\n','00:28:00'),
  (166,1,'2017-07-14','2017-07-12 11:38:23',5348,40,1,'NOS COMUNICAMOS CON LA DEUDORA EL CUAL MANIFIESTA CANCELAR EL DÍA MAÑANA 13 DE JULIO Y ENVIAR RESPECTIVO SOPORTE.','00:04:25'),
  (167,1,'2017-07-14','2017-07-12 11:38:23',5348,40,1,'NOS COMUNICAMOS CON LA DEUDORA EL CUAL MANIFIESTA CANCELAR EL DÍA MAÑANA 13 DE JULIO Y ENVIAR RESPECTIVO SOPORTE.','00:04:25'),
  (168,1,'2017-07-12','2017-07-12 11:51:39',6093,42,10,'REPRESENTANTE LEGAL REGISTRA CON OTRA EMPRESA CON NOMBRE KAWAMOTOS JC EN NEIVA REGISTRO MERCANTIL VIGENTE  3207613817 NUMERO FUERA DE SERVICIO 0346727992 NUMERO NO RESPONDEN SE LE INSISTE PENDIENTE VOLVER A COMUNICARNOS  SE EVIDENCIA QUE EL REPRESENTANTE LEGAL FALLECIO','00:01:11'),
  (169,1,'2017-07-12','2017-07-12 11:59:30',6082,42,10,'SE LOCALIZA CORREO johannalp14@hotmail.com 3103044295 NUMERO APAGADO DIREECION CL 2 E 11 A 16 BRR TRANSPORTADORES\nFlorencia / Caquetá NUMERO 3103044295 CORREO julianbt1330@hotmail.com SE ENVIA CORREO SOLICITANDO CONMUNICACION ','00:01:55'),
  (170,1,'2017-07-19','2017-07-12 14:15:40',6227,40,5,'SE HABLA CON LA LUZVIVIAN RECEPCIONISTA-SECRETARIA, DEL SEÑOR CLAUDIO ANDRES MEJIA. QUIEN INDICA QUE EL SEÑOR NO VA A LA OFICINA, SOLO SE COMUNICA CON ELLA Y ELLA ENTREGA TODOS LOS RECADOS E INFORMACIÓN PERTINENTE PARA EL. ','00:05:53'),
  (171,1,'2017-07-21','2017-07-12 14:36:33',5350,40,8,'NOS COMUNICAMOS DIRECTAMENTE CON LA DEUDORA, ELLA MANIFIESTA QUE LA EMPRESA COLOMBINA NO LA HA GENERADO REPORTE DE ENTRGA DE ESAS NEVERAS, ELLA MANIFIESTA QUE NO DEBE NADA Y QUE COLOMBINA LE DIJO QUE LA DEUDA ESTABA CONGELADA. LLAMAR LA OTRA SEMANA PARA VALIDAR INFORMACIÓN DE LO QUE LD ICE EL SEÑOR JULIO TRABAJADOR DE COLOMBINA, QUIEN LE QUEDO EN ENTREGAR SOPORTE.  ','00:15:39'),
  (172,1,'2017-07-21','2017-07-12 14:36:33',5350,40,8,'NOS COMUNICAMOS DIRECTAMENTE CON LA DEUDORA, ELLA MANIFIESTA QUE LA EMPRESA COLOMBINA NO LA HA GENERADO REPORTE DE ENTRGA DE ESAS NEVERAS, ELLA MANIFIESTA QUE NO DEBE NADA Y QUE COLOMBINA LE DIJO QUE LA DEUDA ESTABA CONGELADA. LLAMAR LA OTRA SEMANA PARA VALIDAR INFORMACIÓN DE LO QUE LD ICE EL SEÑOR JULIO TRABAJADOR DE COLOMBINA, QUIEN LE QUEDO EN ENTREGAR SOPORTE.  ','00:15:39'),
  (173,1,'2017-07-12','2017-07-12 15:00:07',6083,42,10,'(8)4449101 responde luisa indica que la compañía y el local ya no pertenece a la señora mariela de jesus, indica que llevan 1 semana en la bodega  pendiente volver a comunicarnos en las mañanas para poder contactar a la señora mariela \nse realizo investigacion no arroja informacion de vehiculo, le adeuda  colombina por la razon social  la glorieta bello cuenta 120','00:31:37'),
  (174,1,'2017-07-12','2017-07-12 16:13:39',6101,42,10,'CLIENTE SE ENCUENTRA EN LIQUIDACION EL AREA JURIDICA DE COJUNAL VALIDARA LA INFORMACION EN LA SUPER INTENDENCIA PENDIENTE VALIDAR\n','00:05:29'),
  (175,1,'2017-07-13','2017-07-13 07:48:56',6101,42,10,'el señor Octavio RESTREPO CASTAÑO responde al correo enviado con anterioridad:\n---------------------------------------------\nDe: Octavio RESTREPO CASTAÑO <octaviorestrepo@gmail.com>\nFecha: 12 de julio de 2017, 17:05\nAsunto: Re: COBRANZAS JURIDICA TECNOQUIMICAS\nPara: RAUL FERNANDO GORDILLO <cartera@cojunal.com>\n\n\nBuena tarde:estamos pendiente de que la SUPERSOCIEDADES convoque a audiencia para aprobar el auto de adjudicación y así proceder a hacer pagos y adjudicaciones hasta donde alcance el valor de los activos. Cordialmente \n','00:12:37'),
  (176,1,'2017-07-13','2017-07-13 08:58:45',6102,42,9,'3102942512 responde la sra patricia indica que esta realizando los pagos a directamente a tecnoquimicas se le solicitan los comprobantes hace que no escucha y cuelga se le envia correo solicitando los comprobantes','00:12:56'),
  (177,1,'2017-07-25','2017-07-13 09:04:02',5358,40,9,'CLIENTE ILOCALIZADO. NO HAY COMUNICACIÓN ALGUNA Y EN LA INVESTIGACIÓN ARROJA LOS MISMOS DATOS. ','00:08:43'),
  (178,1,'2017-07-20','2017-07-13 10:51:43',6227,40,9,'SE HABLA CON LA SEÑORA ISABELL MAMA DEL SEÑOR CLAUDIO ANDRES MEJIA, LA CUAL MANIFIESTA QUE YA NO HABLA CON EL. QUE YA NO TIENEN CONTACTO, PUESTO QUE YA NO TRABAJAN JUNTOS. ELLA TRATAR DE COMUNICARSE CON EL Y DARÁ LA RESPECTIVA INFORMACIÓN. SE SIGUE EN LA GESTIÓN DE COBRO','00:03:29'),
  (179,1,'2017-07-17','2017-07-13 11:49:22',6182,41,10,'se habla nuevamente con Yeenia informa que nos comununiquemos al telefono fio 3610300 preguntar por el seor paul tarud, que el me da respuesta del tema, se marca se deja mensaje con yemy, se envia notificacion correo electronico gerencia @hbp.com.co','00:02:35'),
  (180,1,'2017-07-20','2017-07-13 14:21:36',5341,40,9,'SE TRATO DE COMUNICAR A LOS TELÉFONOS CORRESPONDIENTE CON EL DEUDOR PERO NO HAY COMUNICACIÓN DIRECTA CON EL CLIENTE. NOS COMUNICAMOS CON LA SEÑORA VIVIANA LOPEZ QUIEN MANIFIESTA QUE EL SEÑOR LES VENDIÓ EL NEGOCIO Y CAMBIARON DE RAZÓN SOCIAL.  NO SABEN NADA DE EL. ','00:03:01'),
  (181,1,'2017-07-20','2017-07-13 14:21:36',5341,40,9,'SE TRATO DE COMUNICAR A LOS TELÉFONOS CORRESPONDIENTE CON EL DEUDOR PERO NO HAY COMUNICACIÓN DIRECTA CON EL CLIENTE. NOS COMUNICAMOS CON LA SEÑORA VIVIANA LOPEZ QUIEN MANIFIESTA QUE EL SEÑOR LES VENDIÓ EL NEGOCIO Y CAMBIARON DE RAZÓN SOCIAL.  NO SABEN NADA DE EL. ','00:03:01'),
  (182,1,'2017-07-20','2017-07-13 14:29:24',5359,40,9,'NO HAY COMUNICACIÓN CON EL CLIENTE. LOS TELÉFONOS ESTÁN FUERA DE SERVICIOS. LA INVESTIGACION ARROJA LOS MISMOS DATOS','00:07:18'),
  (183,1,'2017-07-20','2017-07-13 14:32:03',5342,40,9,'SIN COMUNICACIÓN CON EL CLIENTE. NO GENERA NUEVA INVESTIGACIÓN. ','00:02:29'),
  (184,1,'2017-07-20','2017-07-13 14:59:06',5344,40,5,'SE LLAMA AL CLIENTE. NO SE ENCORABA EN EL MOMENTO PERO SE DEJA RECADO. EN GESTION DE COBRO','00:03:21'),
  (185,1,'2017-07-17','2017-07-13 15:37:34',5446,41,10,'se habla con la señora Lucero  3115627445 informa que la señora Graciela no se encuentra en la ciudad, este cliente realizo el pag del capital el año pasao con cheques posfechados el cual salieron devueltos por fondos. la deudora a venido realizando abonos parciales recogiendo los cheques , solicita se le entreguen los cheques que ha recogido','00:07:36'),
  (186,1,'2017-07-13','2017-07-13 15:38:04',5362,40,1,'CLIENTE ENVIARAN SOPORTES DE PAGO DE LOS ABONOS REALIZADOS. ','00:36:36'),
  (187,1,'2017-07-13','2017-07-13 15:38:04',5362,40,1,'CLIENTE ENVIARAN SOPORTES DE PAGO DE LOS ABONOS REALIZADOS. ','00:36:36'),
  (188,1,'2017-07-19','2017-07-13 15:58:35',5363,40,10,'ESTÁN  VALIDANDO LOS DOCUMENTOS QUE LAS ABOGADAS ENTREGARON. EL DÍA MIÉRCOLES 19 DE JULIO YA TIENEN RESPUESTA DE ESE PROCESO.ESTO SOPORTADO POR EL SEÑOR IVAN RANGEL','00:15:48'),
  (189,1,'2017-07-10','2017-07-13 15:59:42',5463,41,10,'se habla con el señor Jose, esposo de la deudora 3008099677 informa que el día de maraña realiza un abono de $1.000.000 y cuotas mensuales de $800.000, este cliente ya había realizado acuerdo l cual no cumplio','00:00:43'),
  (190,1,'2017-07-13','2017-07-13 16:05:01',5346,40,9,'SIN COMUNICACIÓN. ','00:02:45'),
  (191,1,'2017-07-13','2017-07-13 16:05:01',5346,40,9,'SIN COMUNICACIÓN. ','00:02:45'),
  (192,1,'2017-07-13','2017-07-13 16:23:55',5350,40,8,'NO LLAMAR A LA CLIENTE... CUENTA STAN BEY ','00:00:54'),
  (193,1,'2017-07-11','2017-07-13 16:49:10',5398,41,10,'Se habla con ricardo 3102655576 a la fecha adeuda un saldo de $1.300.000 el quedo con la hermana la señora Erika que ella realizaba este pago del saldo ya que el presto el nombre, se le marca a la hermana 3215471092 no contesta','00:40:53'),
  (194,1,'2017-07-18','2017-07-13 17:02:45',5421,41,10,'Se habla con el señor Alirio que el dia mañana realiza consignacion de $500.000 celular 3132847226, este cliente se hizo acuerdo verbal por $500.000 mensuales','00:02:56'),
  (195,1,'2017-07-14','2017-07-14 09:17:23',5370,42,10,'DIRECCION CL 43 6 12 BRR POZO DONATO EN Tunja / Boyacá NUMERO FIJO 7407358  CORREO ELECTRONICO NUMERO FIJO NO RESPONDE SE LE INSISTE, SE LE ENVIA CORREO ELECTRONICO 3212326383  NUMERO NO RESPONDE SE LE ISNISTE NO CONTESTA SE LE DEJA MENSAJE DE VOZ','00:16:44'),
  (196,1,'2017-07-14','2017-07-14 09:21:19',5421,41,1,'BIENES NO REGISTRA // RETIRADO COOMEVA E.P.S. S.A. CONTRIBUTIVO 03/01/2014 COTIZANTE. CLIENTE VISITA A COJUNAL Y SE LLEGA A ACUERDO DE PAGO CON LA DOCTORA JHANET CASTRO DEVOLUCIÓN DE MERCANCIA POR 11.000.000 EFECTIVO 1 MILLON Y 17 CHEQUES POR 1 MILLON MENSUAL NOS COMUNICAMOS CON LA CLIENTE NUEVAMENTE PARA VALIDAR NUMERO DE PRENDAS VALOR UNITARIO Y TOTAL NO CONTESTA SE DEJA MENSAJE ACUERDO DE PAGO CON COJUNAL','00:01:20'),
  (197,1,'2017-07-14','2017-07-14 09:21:19',5421,41,1,'BIENES NO REGISTRA // RETIRADO COOMEVA E.P.S. S.A. CONTRIBUTIVO 03/01/2014 COTIZANTE. CLIENTE VISITA A COJUNAL Y SE LLEGA A ACUERDO DE PAGO CON LA DOCTORA JHANET CASTRO DEVOLUCIÓN DE MERCANCIA POR 11.000.000 EFECTIVO 1 MILLON Y 17 CHEQUES POR 1 MILLON MENSUAL NOS COMUNICAMOS CON LA CLIENTE NUEVAMENTE PARA VALIDAR NUMERO DE PRENDAS VALOR UNITARIO Y TOTAL NO CONTESTA SE DEJA MENSAJE ACUERDO DE PAGO CON COJUNAL','00:01:20'),
  (198,1,'2017-07-14','2017-07-14 09:49:48',5524,41,1,'SE HABLA CON DEUDORA  INFORMA QUE GENERA PAGO PARA EL DÍA DE HOY POR $700.000 EN COMUNICACIÓN CON LA DEDURORA INFORMA QUE GENERA PAGO EL DÍA DE MAÑANA, SE LE INFORMA QUE GENERE CONSIGNACIÓN DIRECTA A LOS COLORES. SE HABLA CON LA DEUDORA QUE REALIZA PAGO EL JUEVES 31 DE MARZO 2016-03 EN COMUNICACIÓN CON LA DEUDORA INFORMA QUE HABLEMOS A FINALES DE MES DE MARZO, PARA GENERAR EL PAGO SEGÚN ACUERDO.   TITULAR GENERO ABONO $700.000 EL DÍA 19 FEBRERO PRÓXIMO PAGO 26 DE FEBRERO 2016-01. SE REALIZA VISITA ME ATIENDE LA TITULAR QUEDO DE PRESENTARSE LA OTRA SEMANA PARA HACER ACUERDO DE PAGO INFORMA QUE ESTE NO ES EL SALDO QUE BUSCARA LOS SOPORTES PARA ACLARAR EL SALDO A CAPITAL. GESTION DE BETY VALIDAR INFORMACION.  SE HABLA CON LA SEÑORA ANA, INFORMA QUE EL LUNES CON SEGURIDAD GENERA EL ABONO DIRECTO A LOS COLORES POR $700.000. SE HABLA CON LA TT INFORMA QUE EL VIERNES 17/06/16 PASARAMOS A RECOGER 1,000,000','00:12:50'),
  (199,1,'2017-07-14','2017-07-14 09:49:48',5524,41,1,'SE HABLA CON DEUDORA  INFORMA QUE GENERA PAGO PARA EL DÍA DE HOY POR $700.000 EN COMUNICACIÓN CON LA DEDURORA INFORMA QUE GENERA PAGO EL DÍA DE MAÑANA, SE LE INFORMA QUE GENERE CONSIGNACIÓN DIRECTA A LOS COLORES. SE HABLA CON LA DEUDORA QUE REALIZA PAGO EL JUEVES 31 DE MARZO 2016-03 EN COMUNICACIÓN CON LA DEUDORA INFORMA QUE HABLEMOS A FINALES DE MES DE MARZO, PARA GENERAR EL PAGO SEGÚN ACUERDO.   TITULAR GENERO ABONO $700.000 EL DÍA 19 FEBRERO PRÓXIMO PAGO 26 DE FEBRERO 2016-01. SE REALIZA VISITA ME ATIENDE LA TITULAR QUEDO DE PRESENTARSE LA OTRA SEMANA PARA HACER ACUERDO DE PAGO INFORMA QUE ESTE NO ES EL SALDO QUE BUSCARA LOS SOPORTES PARA ACLARAR EL SALDO A CAPITAL. GESTION DE BETY VALIDAR INFORMACION.  SE HABLA CON LA SEÑORA ANA, INFORMA QUE EL LUNES CON SEGURIDAD GENERA EL ABONO DIRECTO A LOS COLORES POR $700.000. SE HABLA CON LA TT INFORMA QUE EL VIERNES 17/06/16 PASARAMOS A RECOGER 1,000,000','00:12:50'),
  (200,1,'2017-07-14','2017-07-14 10:08:31',5527,41,9,'SE REALIZA LA VISITA EL DEUDOR VENDIÓ EL LOCAL A LA SEÑORA DORIS HERNANDEZ. SE INVESTIGA QUE EL DEUDOR ESTA VIVIENDO EN EL DIAMANTE. \t','00:05:07'),
  (201,1,'2017-07-18','2017-07-14 10:19:12',6235,41,10,' Regimen contributivo Sanitas desafiliado  como beneficiario direccion Carrera 67 No 167-61 Of 607 telefono 6698766 , no registra vehiculo Se envia notificacion correos electronicos sandrapatricia1974@hotmail.com,jairongv@gmail.com, se habla con la señora Sandra, quedo de presentarse el día viernes 29 de mayo para hacer acuerdo de pago.\n25 mayo/2017 se presenta a las instalaciones de Cojunal los padres, quedan de presentarse nuevamente el martes 30 mayo para hacer acuerdo de pago.','00:04:02'),
  (202,1,'2017-07-14','2017-07-14 10:20:52',5504,41,9,'LA PERSONA JURIDICA ACTUALMENTE SE ENCUENTRA ACTIVA CON EL NUMERO DE MATRICULA 0000207469, EN CUCUTA NORTE DE SANTANDER. SE ENVIA NOTIFICACION , NO REGISTRA BIENES, NO REGISTRA VEHÍCULOS, REGISTRA COMO REPRESENTANTE LEGAL DE STUDIOFER Y PERCHERONES JEANS, SE ENVÍA NOTIFICACIÓN. ','00:06:18'),
  (203,1,'2017-07-14','2017-07-14 10:20:52',5504,41,9,'LA PERSONA JURIDICA ACTUALMENTE SE ENCUENTRA ACTIVA CON EL NUMERO DE MATRICULA 0000207469, EN CUCUTA NORTE DE SANTANDER. SE ENVIA NOTIFICACION , NO REGISTRA BIENES, NO REGISTRA VEHÍCULOS, REGISTRA COMO REPRESENTANTE LEGAL DE STUDIOFER Y PERCHERONES JEANS, SE ENVÍA NOTIFICACIÓN. ','00:06:18'),
  (204,1,'2017-07-19','2017-07-14 10:21:04',6235,41,10,'cliente quedo de hacer propuesta de pago capital con unos accesorios de baño, pendiente envió de la misma','00:01:51'),
  (205,1,'2017-07-19','2017-07-14 10:24:29',6232,41,10,'Se envia notificacion de cobro, se habla con la señora Maria Camila, que hablemos el día viernes para darnos una respuesta, sobre el pago, ya que hablara con el papá\n26 Myo/2017 se habla nuevamente con la deudora, dice que hablemos el martes 30 de Mayo para darme una respuesta al tema\n12 Junio/2017 se habla nuevamente con la deudora informa que el papa de ela es quien genera los pagos, que se hacercaran esta semana a las instalaciones de cojunal, para hacer u acuerdo de pago.','00:01:03'),
  (206,1,'2017-08-01','2017-07-14 10:34:39',6232,41,10,'En comunicación con la deudora informa que actualmente depende de los pabres, que el papa es quien le va a cancelar la obligacion que harán propuesta de pago principios de agosto','00:10:08'),
  (207,1,'2017-07-14','2017-07-14 10:36:40',6233,41,10,'No registra en regimen contributivo ni subsidiado direccion transversal 85 No 52c-19 telefono 2958675 no registra vehiculo.30 mayo/2017 se presenta a las instalaciones de cojunal, la señora Blanca el cuel informa que no tiene como cancelar la obligacion , labora por dias, el sñor Ovidio es soldado profesional en la frontera venezuela-colombia. 09 JUNIO/2017 Se habla con la sñra Blanca e informa que la semana pasada se presento a Cojunal y esta a espera de carta por parte de la institucion educativa,sñr Ovidio no contesta. ','00:00:35'),
  (208,1,'2017-07-14','2017-07-14 10:36:49',5465,41,9,'SE REALIZO VISITA, SE HACE ACUERDO CON LA SRA CLAUDIA RODRIGUEZ DE CANCELAR $2.000.000EN JULIO 15 DE 2016.  SE REALIZA VISITA SE DEJA NOTIFICACIÓN DEBAJO DE LA PUERTA. COTIZANTE CC 1144085392 Mosquera Rodriguez Steven Armando BENEFICIARIO RC 1105384889 MOSQUERA RODRIGUEZ MARIA JOSE 31/05/2013 BENEFICIARIO CC 16724444 Mosquera Armando. SE LLAMA  S LOS RESPECTIVOS NÚMEROS Y NO CONTESTAN  ','00:06:21'),
  (209,1,'2017-07-14','2017-07-14 10:47:19',5422,41,9,'INMUEBLE NO REGISTRA, SALUD: CONTRIBUTIVO CAFESALUD EPS Activo Cotizante Principal Bogotá, D.C. - BOGOTÁ. NOS COMUNICAMOS EL 21 DE SEPTIEMBRE DE 2015.','00:02:59'),
  (210,1,'2017-07-14','2017-07-14 10:47:20',5422,41,9,'INMUEBLE NO REGISTRA, SALUD: CONTRIBUTIVO CAFESALUD EPS Activo Cotizante Principal Bogotá, D.C. - BOGOTÁ. NOS COMUNICAMOS EL 21 DE SEPTIEMBRE DE 2015.','00:02:59'),
  (211,1,'2017-07-24','2017-07-14 10:55:18',6233,41,4,'Se habla con la señora Blanca manifiesta que no ha recibido respuesta por parte del Colegio en cuanto  su cituacion, actualmente labora por turnos cuando la llaman en area administrativa, esta separada el señor ovidio le responde con una cuota de $400.000 que fue lo que estipulo el juzgado, en comunicación con el informa que el no tiene como cancelar la obligacion es renuente','00:18:37'),
  (212,1,'2017-07-14','2017-07-14 11:07:30',6234,41,10,'Regimen contributiva salud total  direccion Clle 100B No 72-43 barrio Alamos  norte telefono 7589320Se envia notificacion cobro, se habla con la señora Sandra Melo, quedo de dar respuesta de pago el viernes 29 de mayo. 09 JUNIO/2017 Se habla con la sñra Sandra Melo,quien informa que ira directamente al colegio hasta la proxima semana y que ese mismo dia en horas de la tarde nos dara respuesta alguna.\n28 Junio/2017 se habla con la señora Sandra, informa que no se ha presentado al colegio ya que ha estado indispuesta de salud, quedo de ir la otra semana','00:00:20'),
  (213,1,'2017-07-19','2017-07-14 11:09:23',6234,41,10,'Se habla nuevamente con la señora Sandra Melo 320-4111107 inform que no se presentado al colegio por tema de salud. se le informa que necesitamos una respuesta al tema de la obligacion, responde que con seguridad ira directamente al colegio el día martes 18 julio','00:01:51'),
  (214,1,'2017-07-14','2017-07-14 11:29:46',6203,41,10,' no registra en camara de comercio direccion Carrera 50a No 174b-06 torre 3 Apto 201 BARRIO BULEVAR TEL 6693827 Tiene acuerdo de pago para el 29 de mayo con el colegio calazans, Incumple acuerdo, allegan por parte del colegio cheque por la suma de $32.000.000 el cual giro y salio devuelto por fondos insuficientes, realizar el cobro por el valor del cheque se confirma direccion actual  CARRERA 54D No 189-59 torre1 apto 402  -CELULAR 3228005720 el señor manifiesta que no tiene el dinero para pagar pero que esta esperando que le entre un pago para poder cancelar el valor total del cheque que giro sin fondos al colegio calazans  , el señor quiere llegar a un arreglo pero manifiesta que primero quiere conseguir una plata para poder negociar- CORREO.de la esposa molifa6@hotmail.com','00:13:34'),
  (215,1,'2017-07-14','2017-07-14 11:37:00',6220,41,10,'Registra regimen contriutivo eps salud total  cesalntias colfondos vigente direccion carrera 5 No 185c-21 Torre 11 Apto 303 tel 6458601  fuera de servicio correo electronico juangbr7@hotmail.com ,\nEn comuncacion con la señora Luz Amanda informa que ya empezo a laborar nuevamente,hace copromiso de abono para mediados de Junio.Se habla nuevamente con la señora Amanda informa que pudo realizar el abono en Diciembre, no le renovaron contrato, estan pasando una crisis economica el señor Juan Igual esta desempleado.','00:02:09'),
  (216,1,'2017-07-17','2017-07-14 11:39:08',6220,41,10,'no registra ningun establecimiento de comercio- car 5 # 185 c 21 torre:11 apt:303 - telefono 6458601 se llama a este numero presenta no servicio - CORREO:juangbr7@hotmail.com - EPS:salud total - PENSION: colfondos - ARL:Colpatria - Caja compensacion no tiene - \n27 junio/2017  deudora incumple compromiso de abono  para mediados de Junio, informa que se le presento una calamidad familiar fallacecimiento de la mama, que retoma pagos a mediados de julio tlefono de contacto 3208307461','00:02:07'),
  (217,1,'2017-07-14','2017-07-14 11:47:35',6210,41,2,'cuenta al dia, recuperada','00:01:44'),
  (218,1,'2017-07-14','2017-07-14 12:13:03',6225,41,10,'En investigacion no registra inmuebles a su nombre, se envia notificacion, deudor hace compromisos que incumple, manifiesta presentarse a las instalaciones de cojunal el día 05 de julio para hacer acuerdo de pago.','00:10:07'),
  (219,1,'2017-07-11','2017-07-14 12:14:07',6225,41,10,'Se habla nuevamente con el señor francisco 3057103483 informa que el martes 18 Julio se presenta a las instalaciones de Cojunal','00:01:02'),
  (220,1,'2017-07-14','2017-07-14 12:35:30',6209,41,10,'se habla con la sra Dilia manifiesta que hablara con el esposo armando y nos debelen la llamada , se envía notifican a correo electrónico en investigación registra inmueble matricula 50n20016280 embargado 13 de julio se habla nuevamente con la sra Dilia manifiesta que el responsale es el esposo y ella no responderá por a obligación que esperemos a que el se comunique\t','00:00:54'),
  (221,1,'2017-07-17','2017-07-14 12:43:32',6209,41,10,'Se habla nuevamente con la señora Carmen Edilia 313-8688516 informa que  entre el lunes y el martes 17 y 18 de Julio estará dando respuesta al tema','00:08:02'),
  (222,1,'2017-07-14','2017-07-14 13:36:46',5372,42,7,'CLIENTE REALIZO PAGO POR 120.000  COMO ABONO A LA OBLIGACIÓN, CANCELA LA TOTALIDAD EN EL MES DE AGOSTO','00:01:34'),
  (223,1,'2017-07-14','2017-07-14 13:38:51',5379,42,7,'CLIENTE REALIZO PAGO DE CUOTA SEGUN ACUERDO ','00:01:04'),
  (224,1,'2017-07-14','2017-07-14 13:40:47',5367,42,7,'CLIENTE REALIZO PAGO POR 500.000','00:00:42'),
  (225,1,'2017-07-14','2017-07-14 14:05:18',5368,42,6,'SE ENVIA CORREO SOLICITANDO COMUNICACION AL pantera1318@hotmail.com 3202337169 NUMERO NO RESPONDE SE LE ISNISTE 3115105025 RESPONDE DANILO CONOCIDO DEL DEUDOR INDICA QUE SE LE DAÑO EL CELULAR AL DEUDOR SE LE DEJA MENSAJE // DEUDOR ES REPRESENTANTE DE PANADERIA Y BISCOCHERIA LA ESTRELLA ','00:10:52'),
  (226,1,'2017-07-14','2017-07-14 14:28:13',5385,42,10,'3113512484 numero no responden se le insiste se le deja mensaje de voz para que se comunique se envia correo electronico ','00:12:26'),
  (227,1,'2017-07-14','2017-07-14 14:45:40',5384,42,10,'3219818862 numero apagado merkadistribuciones@hotmail.com se envía correo, rebota debido a que no existe 9026005 numero fijo no responde se le insiste ','00:16:40'),
  (228,1,'2017-07-14','2017-07-14 16:51:45',5375,42,10,'3207260007 deudor indica que cancela 200.000 el día lunes 17/07/2017 pendiente validar el pago el dia lunes, envia comprobante via what','02:03:29'),
  (229,4,'2017-07-17','2017-07-17 08:23:17',5366,42,5,'el dia 15/07/2017 sobre las 8:00 am se realizo visita en la direccion carrera 65 Numero 57F  51 sur, en donde se solicita a la deudora, como respuesta de una familiar de la deudora en este caso la abuela, es que la deudora se encuentra trabajando se le deja mensaje con datos de contacto para que se comunique, posterior a la visita se recibe llamada sobre la 1:35 pm del papa de la deudora del numero 3142974954 en donde se comunica con palabras soeces indicando que la abuela quien atendió al visita estuvo a punto de un infarto debido a la misma, con amenazas indicaba que volviera a la visita a cobrarle a el de una manera agresiva, sobre la 1:44 pm del mismo dia recibo una llamada de la deudora del numero 8118272 de la misma manera llama de una manera agresiva con amenazas indicando que no se podían hacer la visitas de esa manera. la informacion que se entrego a la persona que atendió la visita fue solicitandole comunicación con COJUNAL.  ','00:17:13'),
  (230,1,'2017-07-19','2017-07-17 09:32:54',5408,40,10,'NOS COMUNICAMOS DIRECTAMENTE CON EL DEUDOR, QUIEN RECONOCE LA OBLIGACIÓN FINANCIERA. DICE QUE LES ENVIEMOS FACTURAS DEL COMPROMISO, PARA EVALUARLAS Y LLEGAR A UN ACUERDO DE PAGO.  ','00:27:19'),
  (231,1,'2017-07-19','2017-07-17 09:32:54',5408,40,10,'NOS COMUNICAMOS DIRECTAMENTE CON EL DEUDOR, QUIEN RECONOCE LA OBLIGACIÓN FINANCIERA. DICE QUE LES ENVIEMOS FACTURAS DEL COMPROMISO, PARA EVALUARLAS Y LLEGAR A UN ACUERDO DE PAGO.  ','00:27:19'),
  (232,1,'2017-07-18','2017-07-17 10:29:03',5463,40,1,'SE VALIDAD CON EL CLIENTE EL ABONO A LA DEUDA, QUIEN MANIFIESTA QUE SI SE GENERO, Y QUE ENVIARA RESPECTIVO SOPORTE. ','00:07:22'),
  (233,1,'2017-07-21','2017-07-17 11:15:18',5528,40,6,'NO HAY COMUNICACIÓN CON EL CLIENTE EN LOS RESPECTIVOS NÚMEROS DE TELÉFONOS REGISTRADOS. SE SIGUE EN GESTIÓN DE COBRO E INVESTIGACIÓN. ','00:06:55'),
  (234,1,'2017-07-19','2017-07-17 11:53:07',5526,40,5,'NOS COMUNICAMOS CON LA SEÑORA LUCERO VILLALOBOS LA VENDEDORA DE MOSTRADOR DE LA EMPRESA. MANIFIESTA QUE DARÁ RECADO AL RESPECTIVO ENCARGADO DEL PAGO. ','00:07:46'),
  (235,1,'2017-07-19','2017-07-17 12:35:13',5406,40,5,'NOS COMUNICAMOS CON EL HIJO DIEGO GALVIS. QUIEN DICE Y MANIFIESTA QUE EL SEÑOR ESTA EN VENEZUELA, QUE ELLOS NO TIENEN CONOCIMIENTO DEL SEÑOR DESDE HACE MUCHO TIEMPO. QUE EL SE FUE POR QUE EL NEGOCIO QUEDO EN QUIEBRA. LE DEJAMOS RECADO CON EL HIJO, COMUNICÁNDOLE QUE SE LE HARÁ EL RESPECTIVO PROCESO JURÍDICO. QUE CUANDO HABLE CON SEÑOR LE COMENTE A VER SI SE PUEDE LLEGAR A UN ACUERDO DE PAGO. ','00:31:26'),
  (236,1,'2017-07-18','2017-07-17 14:31:55',5398,41,10,'Se habla con la señora Erika, informa que hablemos el dia de mañana 18 julio para darme una respuesta del saldo','00:01:05'),
  (237,1,'2017-07-26','2017-07-17 14:34:49',5474,41,10,'Se hbl CON EL SEÑOR JUAN CARLOS 3204498960 INFORMA QUE RETOMARA PAGOS NUEVAMENTE A FINALES DE JULIO, ESTE CLIENTE  TIENE A LA FEHA SALDO DE CAPITAL $20.812.783 MAS INTERESES Y HONORARIOS','00:01:49'),
  (238,1,'2017-07-17','2017-07-17 17:08:15',6217,41,4,'Registra activo regimen contributivo cotizante compensar, direccion Carrera 34 No 187-80 Calle 181c No 9-30 Int 2 Apto 504, en comunicaion con la señora Carmen Helena informa que no han  generado el pago, el apartamento en la Calle 181 lo perdieron no hace propuesta de pago, el señor Wilson  manifiesta que esta desempleado cuelga la llamada.no registra vehiculos a su nombre','00:03:00'),
  (239,2,'2017-07-18','2017-07-18 10:28:51',6244,42,11,'se recibe la cuenta en donde indicialmente se le notifica via correo electrónico, se envía notificacion con datos de contacto','00:01:20'),
  (240,1,'2017-07-18','2017-07-18 10:52:16',6244,42,5,'responde la señora andrea lopez indica que la persona en tesoreria no se encuentra, se le deja informacion acerca del cobro pendiente comunicarnos ','00:23:23'),
  (241,1,'2017-07-18','2017-07-18 11:10:10',5375,42,7,'cliente cancela en una sola consignación de $200.000 a cojunal en donde no especifica intereses ni honorarios ','00:02:59'),
  (242,1,'2017-07-18','2017-07-18 11:13:46',5375,42,7,'cliente cancela en una sola consignación de $200.000 a cojunal en donde no especifica intereses ni honorarios','00:03:35'),
  (243,1,'2017-07-18','2017-07-18 11:15:28',5375,42,7,'cliente cancela en una sola consignación de $200.000 a cojunal en donde no especifica intereses ni honorarios','00:01:40'),
  (244,1,'2017-07-21','2017-07-18 14:32:00',6235,41,6,'Se marca a la señora Sandra y al señor Jairo para saber sobre la propuesta que iba a envia, no contestan','00:01:09'),
  (245,1,'2017-07-22','2017-07-19 09:05:27',5478,40,9,'NO HAY COMUNICACIÓN CON EL CLIENTE, SE INVESTIGA DE NUEVO Y ARROJA NUEVO TELÉFONO FIJO, PERO ESTA FUERA DE SERVICIO. SE SIGUE EN PROCESO DE COBRO E INVESTIGACIÓN. ','00:03:56'),
  (246,3,'2017-07-25','2017-07-19 09:29:08',5359,44,16,'SE PRESENTA DEMANDA EN CONTRA DE CARLOS SILVA ZULETA , EN NUEVA INVESTIGACION SE ENVIDIA QUE LA DEUDORA POSEE VEHÍCULOS POR TAL RAZÓN SE  ENVÍAN PODERES PARA INCLUIRLA EN LA DEMANDA ','00:03:54'),
  (247,1,'2017-07-25','2017-07-19 09:56:41',5387,40,10,'CLIENTE MANIFIESTA HABER CANCELADO LA OBLIGACIÓN, Y JANIROX DICE QUE EL SEÑOR PRESENTA UN SALDO DE  $20450000. CLIENTE DICE QUE ESE SALDO ES POR CUESTION DE RETENCIONES, QUE NO LO GENERARA. ','00:01:41'),
  (248,1,'2017-07-26','2017-07-19 10:44:52',6227,40,5,'NOS COMUNICAMOS NUEVAMENTE CON EL DEUDOR, NOS CONTESTAN LA SECRETARIA PERSONAL LUZVIVIAN, MANIFIESTA QUE ESTA SEMANA, NI LA SEÑORA ISABEL MADRE DEL DEUDOR NI EL CLIENTE  HAN IDO A LA OFICINA, SE DEJO EL RECADO Y Y SE SIGUE EN LA GESTION DE COBRO. ','00:04:41'),
  (249,1,'2017-07-26','2017-07-19 10:44:52',6227,40,5,'NOS COMUNICAMOS NUEVAMENTE CON EL DEUDOR, NOS CONTESTAN LA SECRETARIA PERSONAL LUZVIVIAN, MANIFIESTA QUE ESTA SEMANA, NI LA SEÑORA ISABEL MADRE DEL DEUDOR NI EL CLIENTE  HAN IDO A LA OFICINA, SE DEJO EL RECADO Y Y SE SIGUE EN LA GESTION DE COBRO. ','00:04:41'),
  (250,1,'2017-07-26','2017-07-19 11:00:25',5363,40,10,'NOS VOLVEMOS COMUNICAR CON IVAN  RANGEL, QUIEN MANIFIESTA QUE ESTA SEMANA NO SE REUNIERON YA QUE SU JEFE SE ENCUENTRA POR FUERA DE LA CUIDAD, EL DÍA LUNES 24 DE JULIO, ACORDARAN UNA NUEVA CITA, PARA CULMINAR TEMA DE COBRO. ','00:06:55'),
  (251,1,'2017-07-26','2017-07-19 11:37:07',5526,40,10,'NOS COMUNICAMOS DIRECTAMENTE CON EL SEÑOR OMAR VELANDIA, REPRESENTANTE LEGAL DE LA EMPRESA. NOS MANIFIESTA QUE EN ESTE MOMENTOS NO TIENE LA DISPONIBILIDAD ECONÓMICA PARA CANCELAR ESA OBLIGACIÓN, PUESTO QUE ELLOS QUEDARON MUY MAL ECONÓMICAMENTE PAGANDO OTROS CRÉDITOS A NIVEL EMPRESARIAL  QUE TENÍAN CON LOS COLORES. DE IGUAL MANERA SE LE GENERA UNA ALTERNATIVA DE PAGOS PARA CANCELAR POR CUOTAS MENSUALES Y ASÍ PUEDA SALIR DE OBLIGACIONISTA FINANCIERA. MANIFIESTA QUE ESTUDIARA LA ALTERNATIVA DE PAGO Y QUE LA OTRA SEMANA NOS TIENE TIENE UNA RESPUESTA PARA EL PAGO DE LA DEUDA. ','00:19:39'),
  (252,1,'2017-07-25','2017-07-19 12:22:00',5429,40,9,'NO HAY COMUNICACIÓN CON EL CLIENTE A LOS TELÉFONOS REGISTRADOS. SE INVESTIGA EN FACEBOOK Y NO TIENE PERFIL EN REDES SOCIALES. SE SIGUE EN INVESTIGACIÓN.  ','00:11:37'),
  (253,3,'2017-07-19','2017-07-19 12:34:51',5412,40,16,'CLIENTE ENFERMO CON CÁNCER. ','00:00:50'),
  (254,3,'2017-07-19','2017-07-19 12:34:51',5412,40,16,'CLIENTE ENFERMO CON CÁNCER. ','00:00:50'),
  (255,3,'2017-07-21','2017-07-19 12:35:09',5352,44,16,'* N INVESTIGACIÓN LA SEÑORA DIRECCIÓN CALLE 6 • 6 27 CIMITARRA SANTANDER CON CEL: 3206668115  FRUTIFRESHMA64GMAIL.COM ,SE EVIDENCIA QUE EL CODEUDOR NO TIENE NINGÚN VEHÍCULO NI APARECE EN CÁMARA DE COMERCIO DIRECCIÓN QUE REGISTRA CRA 20 CORRE CENTRO ECOPETROL BARRANCABERMEJA CON CELULAR 3176354987 REDBULLROJO@HOTMAIL.COM WHATSAPP 3174857769 DE LA DEUDORA','00:04:04'),
  (256,3,'2017-07-28','2017-07-19 12:58:10',5347,44,16,'LOS DEMNADADOS PLANTEARON ENVIAR UN PROPUESTA  DE PAGO PERO A LA FECHA NO HAY RESPUESTA DEL MISMO \n PENDIENTE DE RADICACIÓN DE EMBARGOS DEL VEHÍCULO EN PUERTO COLOMBIA (BARRANQUILLA)\nYA SE PRESENTÓ LIQUIDACIÓN DEL CRÉDITO\n* SE DEVOLVIO EL DESPACHO COMISORIO PARA QUE SE COMISIONARA OTRA INSPECCIÓN DE POLICÍA DEBIDO A QUE LA INSPECCIÓN COMISIONADA COLOCO MUCHOS OBSTÁCULOS PARA HACER LA DILIGENCIA.\n* LOS DEMANDADOS FUERON NOTIFICADOS, HUBO LA NECESIDAD DE TRASLADAR A UN FUNCIONARIO DE LA EMPRESA DE CORREOS ROA EXPRÉS DE VALLEDUPAR PARA HACER LAS DOS NOTIFICACIONES CITACIÓN Y AVISO POR QUE 472 NO DIO PARA NOTIFICAR Y DEVOLVIÓ EL CORREO, YA ESTE PROCESO ESTA NOTIFICADO LOS DEMANDADOS OTORGARON PODER A UN ABOGADO PERO YA LOS TÉRMINOS ESTABAN VENCIDO POR LO TANTO EL JUZGADO DICTÓ SENTENCIA Y ORDENÓ LA VENTA EN PÚBLICA SUBASTA,\n*ESTA DEMANDA SE PRESENTÓ EL DÍA 16 DE NOVIEMBRE DE 2016, FUE ADMITIDA EL 6 DE DICIEMBRE DE 2016, EN LA MISMA FECHA EL JUZGADO DECRETÓ EMBARGO DEL BIEN INMUEBLE\n','00:01:38'),
  (257,1,'2017-07-21','2017-07-19 14:28:33',5466,40,1,'CLIENTE MANIFIESTA ESTAR ABONANDO MENSUALMENTE A LA DEUDA DIRECTAMENTE A LOS COLORES. CLIENTE ENVIARA RESPECTIVAS SOPORTES DE PAGOS VÍA WHATSAAP AL NUMERO DE COJUNAL.','00:10:15'),
  (258,1,'2017-07-21','2017-07-19 14:28:34',5466,40,1,'CLIENTE MANIFIESTA ESTAR ABONANDO MENSUALMENTE A LA DEUDA DIRECTAMENTE A LOS COLORES. CLIENTE ENVIARA RESPECTIVAS SOPORTES DE PAGOS VÍA WHATSAAP AL NUMERO DE COJUNAL.','00:10:15'),
  (259,1,'2017-07-21','2017-07-19 16:31:45',6251,42,10,'3015197000 RESPONDE EL SEÑOR JUAN INDICA QUE AGROCARGA INICIO UN PROCESO JURIDICO CONTRA CI EXPOCOLOMBIA, SE LE INDICA QUE TAN SOLO SE REALIZO LA ENTREGA DE LA CARTERA A LA CASA DE COBRANZA, SE NIEGA EN ENTREGAR INFORMACION ACERCA DEL PAGO, SOLICITA LE ENVIEMOS CORREO ELECTRONICO SE ENVIA CORREO CON ESTADO DE CUENTA PIDE NOS COMUNIQUEMOS EL DIA VIERNES PARA CONFIRMAR LA RECEPCION DEL CORREO PENDIENTE VOLVER A COMUNICARNOS','00:03:34'),
  (260,1,'2017-07-21','2017-07-21 10:59:12',5345,40,5,'HABLAMOS CON LA SEÑORA MARÍA FERNANDA, EMPLEADA DE LA SEÑORA MARÍA PAMPLONA. NOS MANIFIESTA QUE LA SEÑORA NO SE ENCUENTRA EN EL MOMENTO QUE LE DARÁ EL RECADO, DE IGUAL FORMA SE VUELVE A ENVIAR NOTIFICACIÓN ESTA VEZ VÍA WHATSAAP.','00:08:12'),
  (261,1,'2017-07-24','2017-07-21 11:39:04',6186,41,7,'Se habla con Adriana informa que hablemos el lunes 24 de Julio para confirmar pago saldo','00:01:30'),
  (262,1,'2017-07-25','2017-07-21 12:40:03',6190,41,1,'promesa pago saldo martes 25 julio','00:01:03'),
  (263,1,'2017-07-27','2017-07-21 12:48:45',5434,40,3,'SE ENVÍA NOTIFICACIÓN ACTUALIZADA HASTA LA FECHA AL CORREO ELECTRÓNICO CORRESPONDIENTE, Y SE DEJA MENSAJE DE VOZ A LOS TELÉFONOS REGISTRADO. SE SIGUE EN GESTIÓN  DE COBRO. ','00:09:00'),
  (264,1,'2017-07-26','2017-07-21 12:52:02',6199,41,10,'Se habla nuevamente con Astrid informa que no han realizado el pago, ya que no les han entrado los recursos para cancelar, que hablemos la otra semana','00:01:23'),
  (265,3,'2017-07-28','2017-07-21 13:54:04',5361,44,14,'ESTAMOS EN ETAPA DE NOTIFICACIÓN PARA LO CUAL SE RADICARA EL EDICTO EMPLAZATORIO EN EL DIARIO DE ALTA CIRCULACIÓN NACIONAL COMO EL TIEMPO.\nSE ENVIARON VARIAS CITACIONES PARA DILIGENCIA DE NOTIFICACIÓN PERSONAL,  SE SÓLITO EMBARGO DE CUENTAS Y DE ESTABLECIMIENTO DE COMERCIO,  EN VIRTUD DE QUE DESPUÉS DE HABERSE HECHO LAS NOTIFICACIONES EN LA NUEVA DIRECCIÓN APORTADA AL PROCESO UNA SEÑORA INFORMÓ QUE ESTAS PERSONAS NO RESIDEN EN ESA RESIDENCIA, RAZÓN POR LA CUAL TUVE NECESIDAD DE SOLICITAR EL EMPLAZAMIENTO.\n SE PRESENTÓ DEMANDA EL DÍA 16 DE NOVIEMBRE DE 2016\n INFORME DE 8 DE MARZO. CURSA EN EL JUZGADO TERCERO CIVIL MUNICIPAL DE RIOHACHA LA GUAJIRA, ESTE PROCESO FUE ADMITIDO EL 19 DE DICIEMBRE DE 2016\n','00:04:47'),
  (266,1,'2017-07-27','2017-07-21 14:39:07',5524,40,1,'CLIENTE EN ACUERDO DE PAGO, CON CUOTAS DE $ 500000, ULTIMO ABONO FUE EL DIA 16 DE JUNIO. PRÓXIMO PAGO PARA EL DIA 27 DE JULIO. ','00:01:50'),
  (267,1,'2017-07-21','2017-07-21 15:19:50',5368,42,5,'0376003414 responde la señora nelly abuela del deudor, indica que el deudor no se encuentra se le deja mensaje con datos de contacto, en el numero 3202337164 deudor indica que desea realizar acuerdo pide llamar sobre las 5:30 debido a que se encuentra trabajando','00:01:51'),
  (268,3,'2017-07-31','2017-07-21 15:38:21',5364,44,14,'DEMANDA RADICADA EN LA CIUDAD DE GIRÓN SANTANDER NOS LIBRARON MANDAMIENTO DE PAGO A FAVOR DE COLOMBINA Y ESTAMOS EN ETAPA DE NOTIFICACIÓN, NO SE HA PODIDO ESTABLECER COMUNICACIÓN CON EL DEUDOR, AL ESTABLECER COMUNICACIÓN CON EL SEÑOR OSCAR CORZO ABOGADO DEL SEÑOR ÉL NOS MANIFIESTA QUE NO TIENE CONTACTO CON EL SEÑOR CARLOS MANUEL YA HACE MÁS DE 4 MESES ','00:17:47'),
  (269,1,'2017-07-21','2017-07-21 16:00:25',6251,42,10,'3015197000  en comunicación con el señor juan confirma el recibido del correo enviado el día miercoles indica que responden el día de mañana sábado 22 de julio sobre el medio día ','00:27:19'),
  (270,1,'2017-07-21','2017-07-21 16:03:01',5378,42,10,'responde la señora angela duarte  indica que la empresa como  PRODUCTOS ALIMENTICIOS PAQUITO SAS  ya no existe indica que se estan realizando pagos a proveedores, solicita un correo con la informacion para entregarla a la contadora correspondiente se envia correo a produccion@industriasalicol.com pendiente recibir respuesta ','00:02:12'),
  (271,1,'2017-07-21','2017-07-21 16:14:57',5373,42,10,'3142947286 responde mariluz indica que el deudor no se encuentra en el momento, pide volver a comunicarnos en 30 min se le solicita datos de contacto via redes sociales indica que nos los hace llegar via whatsapp','00:10:19'),
  (272,1,'2017-07-26','2017-07-21 16:28:29',5466,40,1,'NOS COMUNICAMOS CON LA CLIENTE, Y EFECTIVAMENTE HA VENIDO ABONANDO, ENVIO SOPORTES DE PAGO A WHATSAAP. SEGUIRA ABONANDO A LA DEUDA. ','00:01:23'),
  (273,1,'2017-07-26','2017-07-21 16:41:12',5442,40,5,'NOS COMUNICAMOS AL RESPECTIVO NUMERO Y HABLAMOS CON EL SEÑOR ALBEIRO BERMUDEZ, PADRE DE LA DEUDORA, LE DIMO LA RESPECTIVA INFORMACIÓN. MANIFIESTA QUE DARÁ EL RECADO','00:07:31'),
  (274,1,'2017-07-25','2017-07-21 17:07:45',5409,40,10,'NOS COMUNICAMOS CON LA SEÑORA NOHORA SUAREZ MAMA DEL DEUDOR. MANIFIESTA QUE EL SEÑOR RAUL GERARDO SUAREZ NO VIVE CON ELLA. SIN EMBARGO  OS REGALA EL NUMERO PERSONAL DEL CLIENTE.  NOS COMUNICAMOS AL RESPECTIVO NUMERO Y SE VA A BUZÓN DE VOZ, SIN EMBARGO SE DEJA EL RESPECTIVO MENSAJE DE VOZ. ','00:10:54'),
  (275,1,'2017-07-25','2017-07-21 17:07:45',5409,40,10,'NOS COMUNICAMOS CON LA SEÑORA NOHORA SUAREZ MAMA DEL DEUDOR. MANIFIESTA QUE EL SEÑOR RAUL GERARDO SUAREZ NO VIVE CON ELLA. SIN EMBARGO  OS REGALA EL NUMERO PERSONAL DEL CLIENTE.  NOS COMUNICAMOS AL RESPECTIVO NUMERO Y SE VA A BUZÓN DE VOZ, SIN EMBARGO SE DEJA EL RESPECTIVO MENSAJE DE VOZ. ','00:10:54'),
  (276,3,'2017-07-26','2017-07-24 09:30:05',5369,44,16,'SE PRESENTA DEMANDA ,SE SOLICITÓ COMO MEDIDAS CAUTELARES EMBARGO Y POSTERIOR SECUESTRO DE CUOTA PARTE DE INMUEBLES , DE BIENES MUEBLES Y ENSERES, SE SOLICITA CUOTA PARTE DE UNIDAD COMERCIAL , SE LIBRA MANDAMIENTO DE PAGO A FAVOR DE TEAM FOOD, SE ORDENA PRESENTA PÓLIZA JUDICIAL ,EN AUTO NO SE TIENE EN CUENTA PÓLIZA JUDICIAL PARA PODER DECRETAR EMBARGO YA QUE FUE EXPEDIDA POR VALOR MENOR DE 1 MILLÓN COMO SE HABÍA SOLICITADO , SE PRESENTA PÓLIZA JUDICIAL POR VALOR DE 1 MILLÓN COMO SE HABÍA SOLICITADO EN AUTO DE 10 DICIEMBRE ( EL RESPECTIVO MEMORIAL SE ENVIÓ POR CORREO POSTAL ), SE DECRETA EMBARGO Y POSTERIOR SECUESTRO DE  LA CUOTA PARTE DEL BIEN INMUEBLE N°50N-775995 EL CUAL FUE REGISTRADO EN LA OFICINA DE INSTRUMENTOS PUBLICOS DE BOGOTA EL 5 DE MAYO DE 2017 TAMBIEN SE DECRETO EL EMBARGO Y SECUESTRO DE BIENES MUEBLES Y EMSERES PARA LO QUE SE DECRETARON LOS CORRESPONDIENTES POLICÍA LOS CUALES FUERON RADICADOS EN LA RESPECTIVA INSPECCION DE POLICIA DE CHIA SE ESTA A LA ESPERA DE QUE SE ASIGNE SECUETRE .','00:08:36'),
  (277,1,'2017-07-26','2017-07-24 09:33:40',5369,44,5,'SE LLAMA AL SEÑOR CARLOS HUMBERTO PRIMERO SNO CONTESTA EL , NOS CUELGA Y AL VOLVER AS INTENTAR CONTESTA UNA SEÑORA ANDRA RODRIGUEZ QUIEN NOS MANIFIESTA QUE ES UNA VECINA QUE EL DE DEJO EL TELÉFONO PARA QUE LE CONTESTARA, LE DEJAMOS LOS NUMEROS DE CONTACTO PARA QUE SE COMUNIQUE CON NOSOTROS SE LE ENVÍA NOTIFICACIÓN A LA DIRECCIÓN DE CORREO ELECTRONICO COMERCILIZADORA.YA@HOTMAIL.COM','00:03:33'),
  (278,3,'2017-08-14','2017-07-24 10:35:33',5367,44,16,'SE PRESENTA DEMANDA LIBRAN MANDAMIENTO DE PAGO A FAVOR DE TEAM , EL DEUDOR HACE A CUERDO DE PAGO POR VALOR DE 500 MIL PESOS MENSUALES .','00:04:17'),
  (279,3,'2017-07-31','2017-07-24 11:53:15',6254,44,14,'SE PRESENTA DEMANDA ESTE PROCESO QUE SE ADELANTA EN LA CIUDAD DE VALLEDUPAR, LIBRARON MANDAMIENTO DE PAGO A FAVOR DE TEAM FOOD , SE HA SOLICITADO EMBARGO DE CUENTAS, ESTABLECIMIENTO DE COMERCIO Y DE VEHÍCULO,  SE HAN ENVIADO LAS CITACIONES Y AVISOS LOS PRIMEROS NO FUERON ACEPTADOS POR QUE HABÍA ERROR EN LAS DIRECCIONES APORTADAS LUEGO SE CORRIGIÓ Y SE ENVIARON NUEVAMENTE LAS COMUNICACIONES Y LOS AVISOS,  ESTÁ PENDIENTE PARA SENTENCIA, UNA VEZ SALGA EL PROCESO DEL DESPACHO CON LA SENTENCIA SE APORTARA LA LIQUIDACIÓN DEL CRÉDITO.  ','00:02:00'),
  (280,1,'2017-07-24','2017-07-24 11:53:30',5385,42,10,'3113512484  numero no responde se le insiste se envia correoe electronico solicitando comunicacion, se envia mensaje de voz, se envia mensaje via whatsapp, no se tiene respuesta pendiente volver a comunicarnos ','00:00:37'),
  (281,3,'2017-07-24','2017-07-24 12:17:50',5381,44,15,'2017 - 00185 ESTE PROCESO SE PRESENTÓ EL 27 DE ABRIL DE 2017 CORRESPONDIÓ AL JUZGADO PRIMERO CIVIL MUNICIPAL,  ESTE JUZGADO MEDIANTE AUTO DE FECHA 08 - 05 - 2017 RECHAZÓ LA DEMANDA Y LA ENVIÓ AL JUZGADO PRIMERO DE PEQUEÑAS CAUSAS Y COMPETENCIAS MÚLTIPLES DONDE CURSA HOY ESTAMOS A LA ESPERA DE SU ADMISIÓN,  ESE JUZGADO APENAS VA ADMITIENDO LAS DEMANDAS DEL MES DE MARZO.','00:10:19'),
  (282,1,'2017-07-25','2017-07-24 14:18:45',5344,40,6,'NOS COMUNICAMOS CON LA CLIENTE, PERO DEUDORA CUELGA LA LLAMADA, NO SE PUDO ESTABLECER COMUNICACIÓN CON LA DEUDORA. ','00:09:49'),
  (283,1,'2017-07-25','2017-07-24 14:18:45',5344,40,6,'NOS COMUNICAMOS CON LA CLIENTE, PERO DEUDORA CUELGA LA LLAMADA, NO SE PUDO ESTABLECER COMUNICACIÓN CON LA DEUDORA. ','00:09:49'),
  (284,1,'2017-07-26','2017-07-24 14:23:12',5345,40,5,'SE HABLA CON LA HIJA DE LA CLIENTE. LA SEÑORA CAMILA INDICA QUE  DARÁ EL RECADO.','00:03:57'),
  (285,1,'2017-07-31','2017-07-24 14:36:59',5348,40,10,'NOS COMUNICAMOS CON EL SEÑOR CARLOS TORRES, ESPOSO DE LA CLIENTE, EL CUAL MANIFIESTA QUE NO HAN PODIDO GENERAR EL PAGO PUESTO QUE ESTÁN ESPERANDO UN DINERO PARA PODER CANCELAR CUOTA DEL MES DE JULIO. QUE LE ESPEREMOS UNOS DÍAS MAS. ','00:10:07'),
  (286,1,'2017-07-24','2017-07-24 14:49:50',5349,40,9,'CORREO ENVIADO POR PARTE DE LA EMPRESA COLOMBINA NOS INDICA QUE SUSPENDAMOS EL COBRO A ESTA CLIENTE.  ','00:04:23'),
  (287,1,'2017-07-24','2017-07-24 14:49:50',5349,40,9,'CORREO ENVIADO POR PARTE DE LA EMPRESA COLOMBINA NOS INDICA QUE SUSPENDAMOS EL COBRO A ESTA CLIENTE.  ','00:04:23');
COMMIT;

#
# Data for the `assettypes` table  (LIMIT 0,500)
#

INSERT INTO `assettypes` (`idAssetType`, `assetTypeName`) VALUES 
  (1,'Bien Inmueble'),
  (2,'Bien Mueble'),
  (3,'Otro');
COMMIT;

#
# Data for the `assets` table  (LIMIT 0,500)
#

INSERT INTO `assets` (`idAsset`, `description`, `dCreation`, `idWallet`, `idAdviser`, `idType`, `assetName`) VALUES 
  (1,'MATRICULA ACTIVA ','2017-06-29 22:04:58',5369,40,1,'COMERCIALIZADORA PUNTO Y A'),
  (2,'MATRICULA 19287321','2017-06-29 22:04:58',5370,40,1,'LOTE'),
  (4,'CASA TITULAR ','2017-06-29 22:16:58',5386,40,1,'CASA'),
  (5,'CASA TITULAR ','2017-06-29 22:16:58',5387,40,1,'CASA'),
  (7,'CARRO DE PLACA  QID 094 MARCA FORD , CLASE AUTOMÓVIL PROPIEDAD DE LA CODEUDORA ','2017-07-13 00:00:00',5359,44,1,'CARRO'),
  (8,'CARRO DE PLACA DVD 880  MARCA RENAULT, CLASE DE VEHÍCULO AUTOMÓVIL PROPIEDAD DE LA CODEUDORA  ','2017-07-13 00:00:00',5359,44,1,'CARRO'),
  (9,' UNA MOTOCICLETA DE PLACA PHZ83D ','2017-07-14 00:00:00',5352,44,1,'MOTOCICLETA'),
  (10,'POSEE UN CARRO DE PLACA WFC774 LA SEÑORA MANIFIESTA QUE EL CARRO ESTA PIGNORADO PERO EN INVESTIGACION NO APARECE COMO TAL .','2017-07-14 00:00:00',5352,44,1,'CARRO'),
  (11,'POSEE UN CARRO DE PLACA WFC774 LA DEUDORA  MANIFIESTA QUE EL CARRO ESTA PIGNORADO ','2017-07-14 00:00:00',5352,44,1,'CARRO'),
  (12,'CARRO PLACA RIO101 MARCA MAZDA,CAMIONETA ','2017-07-14 00:00:00',5347,44,1,'CARRO'),
  (13,'CARRO PROPIEDAD DEL DEUDOR DE PLACA RIO101 MARCA MAZDA ,CAMIONETA PENDIENTE DE RADICAR OFICIOS DE EMBARGO DEL MISMO ','2017-07-14 00:00:00',5347,44,1,'CARRO');
COMMIT;

#
# Data for the `authitemchild` table  (LIMIT 0,500)
#

INSERT INTO `authitemchild` (`parent`, `child`, `idAuthItemChild`) VALUES 
  ('Asesor','Asesor',1),
  ('Empresa','Empresa',2);
COMMIT;

#
# Data for the `notificationType` table  (LIMIT 0,500)
#

INSERT INTO `notificationType` (`idNotificationType`, `name`, `description`, `crerateAt`) VALUES 
  (1,'Mensual','Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.','2017-09-01 16:04:31'),
  (2,'Semanal','Nulla quis lorem ut libero malesuada feugiat. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem.','2017-09-01 16:04:31'),
  (3,'Diaria','Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur aliquet quam id dui posuere blandit. Vivamus suscipit tortor eget felis porttitor volutpat. Nulla quis lorem ut libero malesuada feugiat. Donec sollicitudin molestie malesuada. Pellentesque in ipsum id orci porta dapibus.','2017-09-01 16:05:04');
COMMIT;

#
# Data for the `wallets_by_campaign` table  (LIMIT 0,500)
#

INSERT INTO `wallets_by_campaign` (`idWalletByCampaign`, `IdCampaign`, `campaignName`, `serviceType`, `notificationType`, `fee`, `interests`, `comisions`, `createAt`) VALUES 
  (91,72,'probando ohh','SERVICIO 2',2,3.5,0.3,1.3,'2017-09-11 16:25:47'),
  (92,72,'probando ohh','SERVICIO 2',2,1,52,0,'2017-09-11 16:26:16'),
  (93,72,'Campaña_001','SERVICIO 2',1,0,0,0,'2017-09-13 21:26:14'),
  (94,72,'Campaña C_001','SERVICIO 1',2,0.5,0.3,0.1,'2017-09-15 16:38:55'),
  (95,74,'WilmarQuentek_001','SERVICIO 2',2,0,0,0,'2017-09-15 19:45:08'),
  (96,74,'Campaña_003w','SERVICIO 2',2,0,0,0,'2017-09-15 20:40:25'),
  (97,74,'Cartera marzo 2010 001','SERVICIO 1',1,0,0,0,'2017-09-15 20:48:03'),
  (98,74,'Cartera marzo 2010 001','SERVICIO 1',1,0,0,0,'2017-09-15 20:48:11'),
  (99,74,'Cartera marzo 2010 001','SERVICIO 1',1,0,0,0,'2017-09-15 21:15:33'),
  (100,74,'Cartera marzo 2010 001','SERVICIO 1',1,0,0,0,'2017-09-15 21:15:59'),
  (101,74,'Cartera marzo 2010 001','SERVICIO 1',1,1,1,1,'2017-09-15 21:16:11'),
  (102,74,'Cartera marzo 2010 001','SERVICIO 1',1,0.7,0.5,0.9,'2017-09-15 21:17:05'),
  (103,82,'Campana_1000_W','SERVICIO 2',2,150000,12000,10,'2017-09-18 14:22:43'),
  (104,82,'Campana_1000_W','SERVICIO 2',2,150000,12000,10,'2017-09-18 14:40:17'),
  (105,82,'Cam6UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 14:58:27'),
  (106,82,'Cam6UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 14:59:36'),
  (107,82,'ad','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:04:56'),
  (108,82,'ad','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:05:29'),
  (109,82,'ad','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:06:47'),
  (110,82,'ad','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:06:53'),
  (111,82,'ad','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:09:23'),
  (112,82,'Camp001Wil18Sept','SERVICIO 1',3,150000,12000,10,'2017-09-18 15:10:23'),
  (113,82,'Cam8UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:23:15'),
  (114,82,'Cam9UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:25:03'),
  (115,82,'Cam10UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:31:37'),
  (116,82,'Cam10UscSep18','SERVICIO 1',1,150000,12000,10,'2017-09-18 15:32:28'),
  (117,82,'Camp004Wil18Sept','SERVICIO 1',1,150000,12000,10,'2017-09-18 20:14:18'),
  (118,84,'CampSep19','SERVICIO 1',1,15000,13000,10,'2017-09-19 17:40:33'),
  (119,85,'CampSep19-2','SERVICIO 2',3,23,33,43,'2017-09-19 19:50:16');
COMMIT;

#
# Data for the `campaigns_coordinator` table  (LIMIT 0,500)
#

INSERT INTO `campaigns_coordinator` (`id`, `idCampaign`, `idCoordinator`) VALUES 
  (30,93,91),
  (31,92,84),
  (32,94,98),
  (33,95,82),
  (36,91,89),
  (37,118,82),
  (38,119,84);
COMMIT;

#
# Data for the `campaigns_emails_notifications` table  (LIMIT 0,500)
#

INSERT INTO `campaigns_emails_notifications` (`idCampaign`, `emailNotification`) VALUES 
  (16,'wio'),
  (32,'andres@email.com'),
  (33,'programaticaexcel@gmail.com '),
  (33,'wilmari@gmail.com'),
  (34,'programaticaexcel@gmail.com '),
  (36,'programaticaexcel@gmail.com '),
  (37,'programaticaexcel@gmail.com '),
  (41,'programaticaexcel@gmail.com '),
  (47,'programaticaexcel@gmail.com '),
  (48,'programaticaexcel@gmail.com '),
  (49,'programaticaexcel@gmail.com '),
  (50,'programaticaexcel@gmail.com '),
  (51,'programaticaexcel@gmail.com '),
  (52,'programaticaexcel@gmail.com '),
  (53,'programaticaexcel@gmail.com '),
  (54,'programaticaexcel@gmail.com '),
  (55,'programaticaexcel@gmail.com '),
  (56,'programaticaexcel@gmail.com '),
  (57,'programaticaexcel@gmail.com '),
  (58,'programaticaexcel@gmail.com '),
  (59,'programaticaexcel@gmail.com '),
  (60,'programaticaexcel@gmail.com '),
  (61,'programaticaexcel@gmail.com '),
  (62,'programaticaexcel@gmail.com '),
  (63,'programaticaexcel@gmail.com '),
  (64,'programaticaexcel@gmail.com '),
  (65,'programaticaexcel@gmail.com '),
  (66,'programaticaexcel@gmail.com '),
  (67,'programaticaexcel@gmail.com '),
  (68,'programaticaexcel@gmail.com '),
  (69,'programaticaexcel@gmail.com '),
  (70,'programaticaexcel@gmail.com '),
  (71,'programaticaexcel@gmail.com '),
  (72,'programaticaexcel@gmail.com '),
  (73,'programaticaexcel@gmail.com '),
  (74,'programaticaexcel@gmail.com '),
  (75,'programaticaexcel@gmail.com '),
  (76,'programaticaexcel@gmail.com '),
  (77,'programaticaexcel@gmail.com '),
  (78,'programaticaexcel@gmail.com '),
  (79,'programaticaexcel@gmail.com '),
  (80,'programaticaexcel@gmail.com '),
  (81,'programaticaexcel@gmail.com '),
  (82,'programaticaexcel@gmail.com '),
  (83,'programaticaexcel@gmail.com '),
  (84,'programaticaexcel@gmail.com '),
  (85,'programaticaexcel@gmail.com '),
  (86,'programaticaexcel@gmail.com '),
  (86,'wilmar@email.com '),
  (87,'programaticaexcel@gmail.com '),
  (87,'wilmar@email.com '),
  (88,'programaticaexcel@gmail.com '),
  (88,'wilmar@gmail.com '),
  (89,'programaticaexcel@gmail.com '),
  (89,'wilmar@gmail.com '),
  (90,'programaticaexcel@gmail.com '),
  (90,'wilmar@gmail.com '),
  (92,'programaticaexcel@gmail.com '),
  (92,'wilmar@gmail.com '),
  (93,'programaticaexcel@gmail.com '),
  (94,'programaticaexcel@gmail.com '),
  (94,'wilmar.ibg@gmail.com '),
  (95,'wilmar.ibarguen@qentek.com '),
  (95,'wilmar.ibg@gmail.com '),
  (96,'wilmar.ibarguen@qentek.com '),
  (97,'wilmar.ibarguen@qentek.com '),
  (98,'wilmar.ibarguen@qentek.com '),
  (101,'wilmar.ibarguen@qentek.com '),
  (102,'wilmar.ibarguen@qentek.com '),
  (103,'cesar.lombana@unisoftsystem.com.co '),
  (104,'cesar.lombana@unisoftsystem.com.co '),
  (105,'cesar.lombana@unisoftsystem.com.co '),
  (106,'cesar.lombana@unisoftsystem.com.co '),
  (107,'cesar.lombana@unisoftsystem.com.co '),
  (108,'cesar.lombana@unisoftsystem.com.co '),
  (109,'cesar.lombana@unisoftsystem.com.co '),
  (110,'cesar.lombana@unisoftsystem.com.co '),
  (111,'cesar.lombana@unisoftsystem.com.co '),
  (112,'cesar.lombana@unisoftsystem.com.co '),
  (113,'cesar.lombana@unisoftsystem.com.co '),
  (114,'cesar.lombana@unisoftsystem.com.co '),
  (115,'cesar.lombana@unisoftsystem.com.co '),
  (116,'cesar.lombana@unisoftsystem.com.co '),
  (117,'cesar.lombana@unisoftsystem.com.co '),
  (117,'wilmar.ibg@gmail.com '),
  (118,'josediaz78963@hotmail.com '),
  (119,'josediaz78964@hotmail.com ');
COMMIT;

#
# Data for the `status` table  (LIMIT 0,500)
#

INSERT INTO `status` (`idStatus`, `description`, `dCreation`) VALUES 
  (30,'Localizado','2017-09-26'),
  (31,'Ilocalizado','2017-09-26'),
  (32,'Contactados','2017-09-26'),
  (33,'Paz y salvo','2017-10-02'),
  (34,'Renuente','2017-10-02');
COMMIT;

#
# Data for the `campaigns_status` table  (LIMIT 0,500)
#

INSERT INTO `campaigns_status` (`id`, `idCampaign`, `idStatus`, `modified_at`) VALUES 
  (50,91,30,'2017-09-26 14:51:45'),
  (51,119,32,'2017-09-26 16:00:17'),
  (52,91,31,'2017-10-02 21:07:25'),
  (54,91,32,'2017-10-02 21:09:31');
COMMIT;

#
# Data for the `cms_configuracion` table  (LIMIT 0,500)
#

INSERT INTO `cms_configuracion` (`idcmsconfiguracion`, `empresa`, `host`, `encryption`, `nombre_correo`, `username`, `password`, `apiKey`, `port`, `plantilla`, `fecha_actualizacion`, `usuario_actualiza`, `user_restful`, `password_restful`) VALUES 
  (1,'COJUNAL','smtp.mandrillapp.com',NULL,'COJUNAL - Info','altspruebas@mr-websolutions.com','Cojunal2015','CQ-Y-vTrJD75uSB3DJOE1Q','587','<table style=\"width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"padding: 0 0 30px 0;\">\r\n<table style=\"border: 1px solid #cccccc; border-collapse: collapse; width: 600px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td bgcolor=\"#E2E7EA\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px 0px 0px; color: #153643; font-size: 28px; font-weight: bold; font-family: Arial,sans-serif;\" align=\"center\"><img src=\"http://www.cojunal.com/uploads/cojunal_logo.jpg\" alt=\"\" width=\"201\" height=\"114\" />&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td bgcolor=\"#E2E7EA\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 20px 15px 20px 15px;\" bgcolor=\"#ffffff\">\r\n<table style=\"width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"color: #153643; font-family: Arial, sans-serif; font-size: 24px;\"><strong>COJUNAL</strong></td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 20px 0 30px 0; color: #153643; font-family: Arial, sans-serif; font-size: 16px; line-height: 20px;\">__content__</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 30px 30px 30px 30px;\" bgcolor=\"#5AD4D7\">\r\n<table style=\"width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"color: #ffffff; font-family: Arial, sans-serif; font-size: 14px;\" width=\"75%\">&reg; Cojunal&nbsp;2017</td>\r\n<td align=\"right\" width=\"25%\">&nbsp;</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>&nbsp;</p>','2017-04-04 16:30:50',1,'admin','123');
COMMIT;

#
# Data for the `cms_help` table  (LIMIT 0,500)
#

INSERT INTO `cms_help` (`idcmshelp`, `titulo`, `contenido`, `link`, `fecha_creacion`) VALUES 
  (2,'Cambio de Contraseña ','<h3>Para cambiar la contrase&ntilde;a, es necesario realizar los siguientes pasos:</h3>\r\n<p>&nbsp;1. Nos situamos en nuestro nombre de usuario en el men&uacute; del CMS &nbsp;y damos click sobre &eacute;l.</p>\r\n<p><img src=\"/uploads/Ayuda/Cambio%20Contrasena/Selection_054.png\" alt=\"\" width=\"554\" height=\"39\" /></p>\r\n<p>2. Nos aparecer&aacute; una ventana emergente como esta:&nbsp;</p>\r\n<p><img src=\"/uploads/Ayuda/Cambio%20Contrasena/imagenescritorio.png\" alt=\"\" width=\"600\" height=\"283\" /></p>\r\n<p>&nbsp;3. Diligenciamos los datos que se requieren y por &uacute;ltimo damos click en el bot&oacute;n Cambiar.</p>\r\n<p>&nbsp;4. Si los datos han sido diligenciados correctamente procederemos a verificar que nuestra contrase&ntilde;a ha sido cambiada, ingresando a nuestro sistema de nuevo.</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>',NULL,'2017-02-03 14:29:20'),
  (3,'Configurar Sitio','<h3>Para configurar el sitio se deben realizar los siguientes pasos:</h3>\r\n<p>1. Ir al panel de Administraci&oacute;n y seleccionar \"configurar sitio\".</p>\r\n<p>&nbsp;<img src=\"/uploads/Ayuda/Configurar%20sitio/Selection_055.png\" alt=\"\" width=\"231\" height=\"323\" /></p>\r\n<p>2. Luego se mostrar&aacute; una ventana para poder configurar los datos b&aacute;sicos del sitio, los cuales son:</p>\r\n<p><img src=\"/uploads/Ayuda/Configurar%20sitio/Selection_056.png\" alt=\"\" width=\"1038\" height=\"634\" /></p>\r\n<p>3. Todos los campos deben ser diligenciados, est&aacute;n marcados por el signo de asterisco. Los diferentes campos que se describen de la siguiente forma:</p>\r\n<ul>\r\n<li><strong>Nombre de empresa: &nbsp;</strong>Describe el nombre de la organizaci&oacute;n.</li>\r\n<li><strong>Nombre de correo:&nbsp;</strong>Describe el nombre del servidor base para el env&iacute;o de correos por medio de SMTP.</li>\r\n<li><strong>Host:&nbsp;</strong>Describe el nombre del host smtp al que se va a conectar para el env&iacute;o de correos. Por ejemplo: Gmail: \"smtp.gmail.com\", Hotmail: \"smtp.live.com\".</li>\r\n<li><strong>Usuario:&nbsp;</strong>Describe el nombre de usuario para el uso de una cuenta de correo de una organizaci&oacute;n. En el caso de los servidores de gmail o hotmail. El usuario es representado por el correo.</li>\r\n<li><strong>Contrase&ntilde;a:&nbsp;</strong>Describe la contrase&ntilde;a correspondiente al nombre de usuario ingresado anteriormente.</li>\r\n<li><strong>Puerto:&nbsp;</strong>Describe la compuerta que se va a utilizar mediante la conexion de internet, que recibe el servidor para poder utilizar los servicios correo electr&oacute;nico.&nbsp;</li>\r\n<li><strong>Plantilla:&nbsp;</strong>La plantilla describe como se puede ver el contenido del sitio principal y se puede editar siempre y cuando se deje la palabra reservada <strong>_content_.</strong></li>\r\n</ul>\r\n<p>4. Por &uacute;ltimo luego de que los cambos esten diligenciados haremos click en guardar para conservar estos cambios.</p>\r\n<p><img src=\"/uploads/Ayuda/Configurar%20sitio/Selection_057.png\" alt=\"\" width=\"978\" height=\"125\" /></p>',NULL,'2017-02-03 14:29:20'),
  (4,'Cómo Administrar Usuarios','<h3>Para administrar los usuarios debes realizar los siguientes pasos:</h3>\r\n<p>1. En el men&uacute; principal de nuuestro CMS, nos situamos al panel de administraci&oacute;n y seleccionamos la opci&oacute;n \"Usuarios\".</p>\r\n<p>&nbsp;<img src=\"/uploads/Ayuda/Configurar%20sitio/Selection_055.png\" alt=\"\" width=\"231\" height=\"323\" /></p>\r\n<p>2. Selecciona las opciones a realizar, puedes crear un usuario, buscar un usuario entre otras opciones como se muestra a continuaci&oacute;n.</p>\r\n<p><img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_060.png\" alt=\"\" width=\"1042\" height=\"355\" /></p>\r\n<p>3. Para buscar usuarios de una manera b&aacute;sica, si quieres borrarlo, verlo, o editarlo puedes buscarlos de la siguiente manera:&nbsp;</p>\r\n<ul>\r\n<li>Puedes ingresar el nombre del usuario o el email, nombre, apellido o puedes filtrar los resultados por rol o por el estado. En este caso se procedi&oacute; a buscar el usuario por medio de nombre de usuario o alias y se encontr&oacute; un resultado.</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_061.png\" alt=\"\" width=\"1019\" height=\"116\" /></p>\r\n<ul>\r\n<li>Se desplegan las diferentes opciones para los usuarios como ver, modificar y borrar. En este caso si hacemos click en ver representado por el s&iacute;mbolo <img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_068.png\" alt=\"\" width=\"20\" height=\"30\" />podemos ver los datos generales del usuario como se muestra a continuaci&oacute;n.</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_062.png\" alt=\"\" width=\"1049\" height=\"476\" /></p>\r\n<ul>\r\n<li>Si hacemos click en modificar representado por es s&iacute;mbolo de <img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_068.png\" alt=\"\" width=\"20\" height=\"30\" />&nbsp;podemos visualizar la siguiente interfaz:</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_062.png\" alt=\"\" width=\"1049\" height=\"476\" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Los campos que se encuentran con asterisco son obligatorios, esta informaci&oacute;n refleja si un usuario est&aacute; activo o no dentro del sistema.</p>\r\n<ul>\r\n<li>Si hacemos click en eliminar usuario identificado por el simbolo de&nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_067.png\" alt=\"\" width=\"17\" height=\"34\" />&nbsp;, se mostrar&aacute; esta ventana emergente confirmando el borrado o no del usuario.</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_065.png\" alt=\"\" width=\"380\" height=\"167\" /></p>\r\n<ul>\r\n<li>Para realizar una b&uacute;squeda avanzada es necesario que selecciones la opci&oacute;n de b&uacute;squeda avanzada. Luego de clickear este bot&oacute;n puedes ver la siguiente interfaz:</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_071.png\" alt=\"\" width=\"814\" height=\"489\" /></p>\r\n<p>Los campos no son olbigatorios ya que puedes buscar por cualquier termino, c&oacute;mo lo muestra el formulario.&nbsp;</p>\r\n<p>4. Para crear un usuario es necesario seleccionar el bot&oacute;n de crear usuario como se muestra a acontinuaci&oacute;n.</p>\r\n<p><img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_069.png\" alt=\"\" width=\"138\" height=\"44\" /> &nbsp;</p>\r\n<p>5. Una vez se seleccion&oacute; ese boton aparecer&aacute; una interfaz como esta, debemos ingresar los datos requeridos.</p>\r\n<p><img src=\"/uploads/Ayuda/Administrar%20Usuarios/Selection_070.png\" alt=\"\" width=\"820\" height=\"503\" />&nbsp;</p>\r\n<p>Es importante la definici&oacute;n de los roles ya que cada rol identifica las diferentes funciones de cada usuario. Aqui se describe cada rol:</p>\r\n<ul>\r\n<li><strong>Super Administrador:</strong> El super adminitrador puede realizar todas las acciones que se muestran en esta ayuda.</li>\r\n<li><strong>Administrador Cliente:.&nbsp;</strong>El administrador cliente puede ingresar al sistema pero no puede realizar las diferentes opciones del administrador, ya que el uso es restringido.</li>\r\n<li><strong>Usuario registrado Back:</strong>&nbsp;El usuario registrado back puede realizar las acciones que el super administrador le asige a este rol.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>',NULL,'2017-02-03 14:29:20'),
  (5,'Menú Roles','<h3>Para cambiar los roles es necesario realizar los siguientes pasos:</h3>\r\n<p>1. Debes ir al panel de adminsitraci&oacute;n y seleccionar el men&uacute; \"Rol\".</p>\r\n<p>&nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_055.png\" alt=\"\" width=\"231\" height=\"323\" /></p>\r\n<p>2. Luego de que has seleccionado la opci&oacute;n, se mostrar&aacute; la siguiente interfaz:</p>\r\n<p><img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_072.png\" alt=\"\" width=\"845\" height=\"334\" /></p>\r\n<p>3. Es posible realizar las diferentes acciones como en el item de usuarios, se puede buscar, crear, modificar los roles, no es posible eliminar estos roles.</p>\r\n<ul>\r\n<li>Para buscar los roles se realiza de la misma manera que los usuarios, por ejemplo si colocamos alguna letra o palabra dentro del campo de texto donde dice Rol autom&aacute;ticamente se actualizar&aacute; la tabla con los resultados de la b&uacute;squeda, como se muestra a continuaci&oacute;n:</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_073.png\" alt=\"\" width=\"843\" height=\"133\" /></p>\r\n<ul>\r\n<li>&nbsp;Para una b&uacute;squeda avanzada es necesario seleccionar el bot&oacute;n de b&uacute;squeda avanzada. Luego te mostrar&aacute; una interfaz como esta:</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_074.png\" alt=\"\" width=\"880\" height=\"448\" />&nbsp;</p>\r\n<ul>\r\n<li>Para editar el rol, debes seleccionar la opci&oacute;n de rol representada con el &iacute;cono de &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_067.png\" alt=\"\" width=\"15\" height=\"25\" />&nbsp;y luego aparecer&aacute; una interfaz como esta:</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_075.png\" alt=\"\" width=\"837\" height=\"274\" /></p>\r\n<p>Para editar esta informaci&oacute;n s&oacute;lo modifica lo que encuentras en la caja de texto y ese ser&aacute; el nuevo rol editado. Para guardar los cabios debes hacer click en guardar.</p>\r\n<ul>\r\n<li>Para ver la informaci&oacute;n relacionada con el rol solo debes hacer click en el siguiente s&iacute;mbolo &nbsp;<img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_068.png\" alt=\"\" width=\"20\" height=\"30\" />&nbsp;, luego de seleccionarlo se te mostrar&aacute; toda la informaci&oacute;n correspondiente al rol seleccionado.</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; <img src=\"/uploads/Ayuda/Administrar%20Roles/Selection_076.png\" alt=\"\" width=\"876\" height=\"195\" /></p>\r\n<p>&nbsp;La interfaz muestra todos los usuarios que pertenecen al rol seleccionado.</p>',NULL,'2017-02-03 14:29:20'),
  (6,'Permisos para Roles','<h3>Para crear o otorgar permisos para roles debes seguir los siguientes pasos:</h3>\r\n<p>1. Pimero debes seleccionar en el panel de administraci&oacute;n, la opci&oacute;n \"Permisos para roles\". Luego te aparecer&aacute; una interfaz como esta:</p>\r\n<p><img src=\"/uploads/Ayuda/Permisos%20roles/Selection_077.png\" alt=\"\" width=\"829\" height=\"247\" /></p>\r\n<p>2 Para buscar o realizar roles solo es necesario escribir el nobe del rol, con la lista desplegable que se muestra, tambien se puede por el nombre del controlador y la acci&oacute;n del controlador, lo mismo ser&iacute;a para una busqueda avanzada.&nbsp;</p>\r\n<p>3. Para crear permisos de rol tienes que seleccionar el siguiente bot&oacute;n.</p>\r\n<p><img src=\"/uploads/Ayuda/Permisos%20roles/Selection_078.png\" alt=\"\" width=\"197\" height=\"42\" /></p>\r\n<p>4. Aparecer&aacute; la siguiente interfaz y debes ingresar los datos requeridos para crear el permiso del rol.</p>\r\n<p>&nbsp;</p>\r\n<p><img src=\"/uploads/Ayuda/Permisos%20roles/Selection_079.png\" alt=\"\" width=\"829\" height=\"319\" /></p>\r\n<p>Los campos se representan de la siguiente forma:</p>\r\n<ul>\r\n<li><strong>Rol:&nbsp;</strong>Describe el rol del usuario al que se van a generar los permisos.</li>\r\n<li><strong>Controlador:&nbsp;</strong>Describe el nombre del controlador en el cual se almacenan las acciones que se van a permitir. El controlador esta situado en la Url. como en este caso.</li>\r\n</ul>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"/uploads/Ayuda/Permisos%20roles/Selection_085.png\" alt=\"\" width=\"212\" height=\"26\" /></p>\r\n<ol>\r\n<li><strong>cmsbase:&nbsp;</strong>Representa el nombre del sitio web.</li>\r\n<li><strong>cmsUsuario:&nbsp;</strong>Representa el nombre del controlador.</li>\r\n<li><strong>create:&nbsp;</strong>Representa la acci&oacute;n.</li>\r\n</ol>\r\n<ul>\r\n<li><strong>Acci&oacute;n:&nbsp;</strong>Describe la acci&oacute;n que se va a permitir para el rol seleccionado.&nbsp;</li>\r\n</ul>',NULL,'2017-02-03 14:29:20'),
  (7,'Botón Operaciones','<h3><strong>Bot&oacute;n Operaciones</strong>&nbsp;</h3>\r\n<p style=\"text-align: justify;\">El bot&oacute;n operaciones representa las acciones que se pueden realizar en cada pantalla, como acualizar, consultar, eliminar y todas las acciones b&aacute;sicas que se encuentran en cada item del sistema y aparecen dependiendo del &aacute;mbito en el que est&eacute; ya que cada &aacute;mbito representa lo que puedo hacer dentro del CMS.</p>\r\n<p style=\"text-align: justify;\">El bot&oacute;n operaciones se encuentra en la parte superior al lado del nombre del usuario as&iacute;:</p>\r\n<p style=\"text-align: justify;\"><img src=\"/uploads/Ayuda/Operaciones/Selection_081.png\" alt=\"\" width=\"165\" height=\"44\" /></p>\r\n<p style=\"text-align: justify;\">Si desplegamos el bot&oacute;n, nos mostrar&aacute; las diferentes opciones que tenemos pero como se d&iacute;jo antes dependen del &aacute;mbito en el que est&eacute;n. Un ejemplo claro ser&iacute;a el siguiente:</p>\r\n<p style=\"text-align: justify;\">Estamos situados en el m&oacute;dulo de \"Usuarios\", que est&aacute; situado si seleccionamos la opci&oacute;n de \"Usuarios\" en el men&uacute; Administraci&oacute;n.</p>\r\n<p style=\"text-align: justify;\"><img src=\"/uploads/Ayuda/Operaciones/Selection_082.png\" alt=\"\" width=\"209\" height=\"93\" /></p>\r\n<p style=\"text-align: justify;\">Vemos que aparece una opci&oacute;n en donde podemos crear el usuario, ya que estamos situados sobre la interfaz de inicio de los usuarios.</p>\r\n<p style=\"text-align: justify;\">Si seleccionamos un usuario al cual acabamos de buscar en la interfaz principal de usuarios nos cambiar&aacute;n las opciones del men&uacute; de operaciones conforme a lo que se pueda realizar con el usuario &nbsp;o con lo que haya seleccionado, asi ocurre en los diferentes m&oacute;dulos del CMS.</p>\r\n<p style=\"text-align: justify;\">Ejemplo: Se seleccion&oacute; un usuario para visualizar sus datos, o alguna otra acci&oacute;n. El men&uacute; me muestra lo siguiente:</p>\r\n<p style=\"text-align: justify;\"><img src=\"/uploads/Ayuda/Operaciones/Selection_083.png\" alt=\"\" width=\"202\" height=\"170\" /></p>\r\n<p style=\"text-align: justify;\">En cada m&oacute;dulo es igual ya que dependiendo a el m&oacute;dulo seleccionado y a las diferentes acciones que realizas, el men&uacute; va a cambiar.</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>',NULL,'2017-02-03 14:29:20'),
  (8,'Creación Menús','<h3>Para crear men&uacute;s debes seguir los siguientes pasos:</h3>\r\n<p>1. Debes seleccionar en el menu de administraci&oacute;n la opci&oacute;n \"Menus\", como se muestra aqu&iacute; en la siguiente imagen:</p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img src=\"/uploads/Ayuda/Menus/Selection_055.png\" alt=\"\" width=\"231\" height=\"323\" /></p>\r\n<p>2. Luego de haber seleccionado la opci&oacute;n de \"Men&uacute;s\" aparecer&aacute; la siguiente interfaz:</p>\r\n<p><img src=\"/uploads/Ayuda/Menus/Selection_086.png\" alt=\"\" width=\"799\" height=\"218\" /></p>\r\n<p>3. Para crear un Men&uacute;, debes hacer click en la opci&oacute;n Crear Men&uacute; como se muestra a continuaci&oacute;n:</p>\r\n<p><img src=\"/uploads/Ayuda/Menus/Selection_087.png\" alt=\"\" width=\"804\" height=\"377\" /></p>\r\n<p>Cada campo se explica a continuaci&oacute;n:</p>\r\n<ul>\r\n<li><strong>T&iacute;tulo:&nbsp;</strong>El t&iacute;tulo representa el nombre con el que se va a representar el men&uacute;.</li>\r\n<li><strong>Controlador:&nbsp;</strong>Es el nombre del controlador junto con la acci&oacute;n a realizar del men&uacute;.&nbsp;</li>\r\n<li><strong>Men&uacute; Dependiente:&nbsp;</strong>Si existen men&uacute;s dependientes en la lista desplegable aparecer&aacute;n, el men&uacute; dependiente es aquel que es padre de un item que se desea agregar, en el caso de que existan otros men&uacute;s en la parte lateral de nuestro CMS.&nbsp;</li>\r\n<li><strong>Encabezado visible para men&uacute; padre:&nbsp;</strong>Representa si el men&uacute; que se crea es hijo, ser&aacute; visible o no en el t&iacute;tulo de men&uacute; padre.</li>\r\n<li><strong>Men&uacute; Visible:&nbsp;</strong>Describe si el men&uacute; ser&aacute; visible o no.</li>\r\n<li><strong>&Iacute;cono del Men&uacute;:&nbsp;</strong>Representa el &iacute;cono o la forma que va a representar el t&iacute;tulo del men&uacute; o el contenido de los mismos.&nbsp;</li>\r\n</ul>\r\n<p>Cuando el men&uacute; se crea correctamente, este queda situado en la parte lateral de la interfaz del CMS como se muestra a continuaci&oacute;n:</p>\r\n<p><img src=\"/uploads/Ayuda/Menus/Selection_088.png\" alt=\"\" width=\"801\" height=\"288\" /></p>\r\n<p>Como vemos, una vez creado el men&uacute;, ser&aacute; mostrado un resumen sobre los datos que se guardaron del men&uacute; y se puede visualizar el men&uacute; creado en la parte lateral de nuestro CMS.</p>\r\n<p>Aqu&iacute; veremos que cuando regresarmos a la interfaz principal de los men&uacute;s, aparecer&aacute;n todos los men&uacute;s creados, en este caso aparece el men&uacute; que acabamos de crear. Como vemos tiene las diferentes opciones como editar, ver y eliminar, como est&aacute;n presentes en todos los items del men&uacute; administraci&oacute;n.</p>\r\n<p><img src=\"/uploads/Ayuda/Menus/Selection_089.png\" alt=\"\" width=\"793\" height=\"101\" /></p>\r\n<p>Si nos situamos en el men&uacute; operaciones podemos ver las siguientes opciones siempre y cuando estemos en la interfaz de crear men&uacute;.</p>\r\n<p>&nbsp;<img src=\"/uploads/Ayuda/Menus/Selection_090.png\" alt=\"\" width=\"200\" height=\"161\" /></p>\r\n<p>&nbsp;<strong>Nota:</strong> El men&uacute; se crea siempre y cuando exista un modelo, en la base de datos sobre ese men&uacute;.</p>',NULL,'2017-02-03 14:29:20');
COMMIT;

#
# Data for the `cms_icono` table  (LIMIT 0,500)
#

INSERT INTO `cms_icono` (`idcmsicono`, `icono_class`) VALUES 
  (1,'glyphicon-asterisk'),
  (2,'glyphicon-plus'),
  (3,'glyphicon-euro'),
  (4,'glyphicon-eur'),
  (5,'glyphicon-minus'),
  (6,'glyphicon-cloud'),
  (7,'glyphicon-envelope'),
  (8,'glyphicon-pencil'),
  (9,'glyphicon-glass'),
  (10,'glyphicon-music'),
  (11,'glyphicon-search'),
  (12,'glyphicon-heart'),
  (13,'glyphicon-star'),
  (14,'glyphicon-star-empty'),
  (15,'glyphicon-user'),
  (16,'glyphicon-film'),
  (17,'glyphicon-th-large'),
  (18,'glyphicon-th'),
  (19,'glyphicon-th-list'),
  (20,'glyphicon-ok'),
  (21,'glyphicon-remove'),
  (22,'glyphicon-zoom-in'),
  (23,'glyphicon-zoom-out'),
  (24,'glyphicon-off'),
  (25,'glyphicon-signal'),
  (26,'glyphicon-cog'),
  (27,'glyphicon-trash'),
  (28,'glyphicon-home'),
  (29,'glyphicon-file'),
  (30,'glyphicon-time'),
  (31,'glyphicon-road'),
  (32,'glyphicon-download-alt'),
  (33,'glyphicon-download'),
  (34,'glyphicon-upload'),
  (35,'glyphicon-inbox'),
  (36,'glyphicon-play-circle'),
  (37,'glyphicon-repeat'),
  (38,'glyphicon-refresh'),
  (39,'glyphicon-list-alt'),
  (40,'glyphicon-lock'),
  (41,'glyphicon-flag'),
  (42,'glyphicon-headphones'),
  (43,'glyphicon-volume-off'),
  (44,'glyphicon-volume-down'),
  (45,'glyphicon-volume-up'),
  (46,'glyphicon-qrcode'),
  (47,'glyphicon-barcode'),
  (48,'glyphicon-tag'),
  (49,'glyphicon-tags'),
  (50,'glyphicon-book'),
  (51,'glyphicon-bookmark'),
  (52,'glyphicon-print'),
  (53,'glyphicon-camera'),
  (54,'glyphicon-font'),
  (55,'glyphicon-bold'),
  (56,'glyphicon-italic'),
  (57,'glyphicon-text-height'),
  (58,'glyphicon-text-width'),
  (59,'glyphicon-align-left'),
  (60,'glyphicon-align-center'),
  (61,'glyphicon-align-right'),
  (62,'glyphicon-align-justify'),
  (63,'glyphicon-list'),
  (64,'glyphicon-indent-left'),
  (65,'glyphicon-indent-right'),
  (66,'glyphicon-facetime-video'),
  (67,'glyphicon-picture'),
  (68,'glyphicon-map-marker'),
  (69,'glyphicon-adjust'),
  (70,'glyphicon-tint'),
  (71,'glyphicon-edit'),
  (72,'glyphicon-share'),
  (73,'glyphicon-check'),
  (74,'glyphicon-move'),
  (75,'glyphicon-step-backward'),
  (76,'glyphicon-fast-backward'),
  (77,'glyphicon-backward'),
  (78,'glyphicon-play'),
  (79,'glyphicon-pause'),
  (80,'glyphicon-stop'),
  (81,'glyphicon-forward'),
  (82,'glyphicon-fast-forward'),
  (83,'glyphicon-step-forward'),
  (84,'glyphicon-eject'),
  (85,'glyphicon-chevron-left'),
  (86,'glyphicon-chevron-right'),
  (87,'glyphicon-plus-sign'),
  (88,'glyphicon-minus-sign'),
  (89,'glyphicon-remove-sign'),
  (90,'glyphicon-ok-sign'),
  (91,'glyphicon-question-sign'),
  (92,'glyphicon-info-sign'),
  (93,'glyphicon-screenshot'),
  (94,'glyphicon-remove-circle'),
  (95,'glyphicon-ok-circle'),
  (96,'glyphicon-ban-circle'),
  (97,'glyphicon-arrow-left'),
  (98,'glyphicon-arrow-right'),
  (99,'glyphicon-arrow-up'),
  (100,'glyphicon-arrow-down'),
  (101,'glyphicon-share-alt'),
  (102,'glyphicon-resize-full'),
  (103,'glyphicon-resize-small'),
  (104,'glyphicon-exclamation-sign'),
  (105,'glyphicon-gift'),
  (106,'glyphicon-leaf'),
  (107,'glyphicon-fire'),
  (108,'glyphicon-eye-open'),
  (109,'glyphicon-eye-close'),
  (110,'glyphicon-warning-sign'),
  (111,'glyphicon-plane'),
  (112,'glyphicon-calendar'),
  (113,'glyphicon-random'),
  (114,'glyphicon-comment'),
  (115,'glyphicon-magnet'),
  (116,'glyphicon-chevron-up'),
  (117,'glyphicon-chevron-down'),
  (118,'glyphicon-retweet'),
  (119,'glyphicon-shopping-cart'),
  (120,'glyphicon-folder-close'),
  (121,'glyphicon-folder-open'),
  (122,'glyphicon-resize-vertical'),
  (123,'glyphicon-resize-horizontal'),
  (124,'glyphicon-hdd'),
  (125,'glyphicon-bullhorn'),
  (126,'glyphicon-bell'),
  (127,'glyphicon-certificate'),
  (128,'glyphicon-thumbs-up'),
  (129,'glyphicon-thumbs-down'),
  (130,'glyphicon-hand-right'),
  (131,'glyphicon-hand-left'),
  (132,'glyphicon-hand-up'),
  (133,'glyphicon-hand-down'),
  (134,'glyphicon-circle-arrow-right'),
  (135,'glyphicon-circle-arrow-left'),
  (136,'glyphicon-circle-arrow-up'),
  (137,'glyphicon-circle-arrow-down'),
  (138,'glyphicon-globe'),
  (139,'glyphicon-wrench'),
  (140,'glyphicon-tasks'),
  (141,'glyphicon-filter'),
  (142,'glyphicon-briefcase'),
  (143,'glyphicon-fullscreen'),
  (144,'glyphicon-dashboard'),
  (145,'glyphicon-paperclip'),
  (146,'glyphicon-heart-empty'),
  (147,'glyphicon-link'),
  (148,'glyphicon-phone'),
  (149,'glyphicon-pushpin'),
  (150,'glyphicon-usd'),
  (151,'glyphicon-gbp'),
  (152,'glyphicon-sort'),
  (153,'glyphicon-sort-by-alphabet'),
  (154,'glyphicon-sort-by-alphabet-alt'),
  (155,'glyphicon-sort-by-order'),
  (156,'glyphicon-sort-by-order-alt'),
  (157,'glyphicon-sort-by-attributes'),
  (158,'glyphicon-sort-by-attributes-alt'),
  (159,'glyphicon-unchecked'),
  (160,'glyphicon-expand'),
  (161,'glyphicon-collapse-down'),
  (162,'glyphicon-collapse-up'),
  (163,'glyphicon-log-in'),
  (164,'glyphicon-flash'),
  (165,'glyphicon-log-out'),
  (166,'glyphicon-new-window'),
  (167,'glyphicon-record'),
  (168,'glyphicon-save'),
  (169,'glyphicon-open'),
  (170,'glyphicon-saved'),
  (171,'glyphicon-import'),
  (172,'glyphicon-export'),
  (173,'glyphicon-send'),
  (174,'glyphicon-floppy-disk'),
  (175,'glyphicon-floppy-saved'),
  (176,'glyphicon-floppy-remove'),
  (177,'glyphicon-floppy-save'),
  (178,'glyphicon-floppy-open'),
  (179,'glyphicon-credit-card'),
  (180,'glyphicon-transfer'),
  (181,'glyphicon-cutlery'),
  (182,'glyphicon-header'),
  (183,'glyphicon-compressed'),
  (184,'glyphicon-earphone'),
  (185,'glyphicon-phone-alt'),
  (186,'glyphicon-tower'),
  (187,'glyphicon-stats'),
  (188,'glyphicon-sd-video'),
  (189,'glyphicon-hd-video'),
  (190,'glyphicon-subtitles'),
  (191,'glyphicon-sound-stereo'),
  (192,'glyphicon-sound-dolby'),
  (193,'glyphicon-sound-5-1'),
  (194,'glyphicon-sound-6-1'),
  (195,'glyphicon-sound-7-1'),
  (196,'glyphicon-copyright-mark'),
  (197,'glyphicon-registration-mark'),
  (198,'glyphicon-cloud-download'),
  (199,'glyphicon-cloud-upload'),
  (200,'glyphicon-tree-conifer'),
  (201,'glyphicon-tree-deciduous'),
  (202,'glyphicon-cd'),
  (203,'glyphicon-save-file'),
  (204,'glyphicon-open-file'),
  (205,'glyphicon-level-up'),
  (206,'glyphicon-copy'),
  (207,'glyphicon-paste'),
  (208,'glyphicon-alert'),
  (209,'glyphicon-equalizer'),
  (210,'glyphicon-king'),
  (211,'glyphicon-queen'),
  (212,'glyphicon-pawn'),
  (213,'glyphicon-bishop'),
  (214,'glyphicon-knight'),
  (215,'glyphicon-baby-formula'),
  (216,'glyphicon-tent'),
  (217,'glyphicon-blackboard'),
  (218,'glyphicon-bed'),
  (219,'glyphicon-apple'),
  (220,'glyphicon-erase'),
  (221,'glyphicon-hourglass'),
  (222,'glyphicon-lamp'),
  (223,'glyphicon-duplicate'),
  (224,'glyphicon-piggy-bank'),
  (225,'glyphicon-scissors'),
  (226,'glyphicon-bitcoin'),
  (227,'glyphicon-btc'),
  (228,'glyphicon-xbt'),
  (229,'glyphicon-yen'),
  (230,'glyphicon-jpy'),
  (231,'glyphicon-ruble'),
  (232,'glyphicon-rub'),
  (233,'glyphicon-scale'),
  (234,'glyphicon-ice-lolly'),
  (235,'glyphicon-ice-lolly-tasted'),
  (236,'glyphicon-education'),
  (237,'glyphicon-option-horizontal'),
  (238,'glyphicon-option-vertical'),
  (239,'glyphicon-menu-hamburger'),
  (240,'glyphicon-modal-window'),
  (241,'glyphicon-oil'),
  (242,'glyphicon-grain'),
  (243,'glyphicon-sunglasses'),
  (244,'glyphicon-text-size'),
  (245,'glyphicon-text-color'),
  (246,'glyphicon-text-background'),
  (247,'glyphicon-object-align-top'),
  (248,'glyphicon-object-align-bottom'),
  (249,'glyphicon-object-align-horizontal'),
  (250,'glyphicon-object-align-left'),
  (251,'glyphicon-object-align-vertical'),
  (252,'glyphicon-object-align-right'),
  (253,'glyphicon-triangle-right'),
  (254,'glyphicon-triangle-left'),
  (255,'glyphicon-triangle-bottom'),
  (256,'glyphicon-triangle-top'),
  (257,'glyphicon-console'),
  (258,'glyphicon-superscript'),
  (259,'glyphicon-subscript'),
  (260,'glyphicon-menu-left'),
  (261,'glyphicon-menu-right'),
  (262,'glyphicon-menu-down'),
  (263,'glyphicon-menu-up ');
COMMIT;

#
# Data for the `cms_menu` table  (LIMIT 0,500)
#

INSERT INTO `cms_menu` (`idcmsmenu`, `cms_menu_id`, `titulo`, `url`, `icono`, `visible_header`, `visible`, `orden`) VALUES 
  (1,NULL,'test','cmsHelp/admin','glyphicon-minus',1,0,0),
  (2,NULL,'tes2','cmsHelp/admin','glyphicon-asterisk',1,0,2),
  (3,1,'sub','cmsHelp/admin','glyphicon-asterisk',1,0,1),
  (4,3,'sub sub','cmsHelp/admin','glyphicon-euro',1,1,3),
  (5,NULL,'Asesores','advisers/admin','glyphicon-user',1,1,0),
  (10,NULL,'Campañas','campaigns/admin','glyphicon-cloud',1,1,0),
  (11,10,'Asignar Deudores a Campañas','walletsHasCampaigns/admin','glyphicon-flag',0,1,0),
  (12,NULL,'Configuraciones','sysparams/admin','glyphicon-cog',0,1,0),
  (13,12,'Honorarios e Intereses','sysparams/admin','glyphicon-asterisk',1,1,0),
  (14,NULL,'Cartera','wallets/admin','glyphicon-inbox',0,1,0),
  (15,NULL,'Acciones y Efectos','actions/admin','glyphicon-list-alt',0,1,0),
  (16,15,'Acciones','action/admin','glyphicon-plus',1,1,0),
  (17,15,'Effectos','effects/admin','glyphicon-pencil',1,1,0),
  (18,15,'Acciones y Efectos','actionsHasEffects/admin','glyphicon-road',1,1,0),
  (19,10,'Agregar asesores a campañas','advisersCampaigns/admin','glyphicon-plus',0,1,0),
  (20,NULL,'Prospectos','tempoCampaigns/create','glyphicon-upload',1,1,0),
  (21,NULL,'Nosotros','cojAboutus/admin','glyphicon-asterisk',1,1,0),
  (22,21,'Texto Principal','cms/cojGenerictext/index/1','glyphicon-asterisk',1,1,0),
  (23,NULL,'Clientes','cojCompany/admin','glyphicon-asterisk',1,1,0),
  (24,NULL,'Servicios','cojServices/admin','glyphicon-asterisk',1,1,0),
  (25,24,'Título Principal','cms/cojGenerictext/index/4','glyphicon-asterisk',1,1,0),
  (26,24,'Texto Principal','cms/cojGenerictext/index/6','glyphicon-asterisk',1,1,0),
  (27,NULL,'Contacto','cojContact/admin','glyphicon-asterisk',1,1,0),
  (28,27,'Titulo Principal','cms/cojGenerictext/index/7','glyphicon-asterisk',1,1,0),
  (29,27,'Título Secundario','cms/cojGenerictext/index/8','glyphicon-asterisk',1,1,0),
  (30,27,'Texto Contacto','cms/cojGenerictext/index/9','glyphicon-asterisk',1,1,0),
  (31,NULL,'Home','cms/cojHome/admin','glyphicon-asterisk',1,1,0),
  (32,31,'Titulo Principal','cms/cojGenerictext/index/11','glyphicon-asterisk',1,1,0),
  (33,NULL,'Testimonios','cojTestimony/admin','glyphicon-asterisk',1,1,0),
  (34,NULL,'Mapa','cojMap/admin','glyphicon-asterisk',1,1,0),
  (35,31,'Título Secundario','cms/cojGenerictext/index/12','glyphicon-asterisk',1,1,0),
  (36,NULL,'Mensajes','cojMessage/admin','glyphicon-asterisk',1,1,0),
  (37,NULL,'Términos y Condiciones','cms/cojGenerictext/index/10','glyphicon-asterisk',1,1,0),
  (38,31,'Texto Empresa','cms/cojGenerictext/index/13','glyphicon-asterisk',1,1,0),
  (39,12,'Ciudad','districts/admin','glyphicon-asterisk',1,1,0),
  (40,NULL,'Coordinadores','coordinadores/admin','glyphicon-asterisk',1,1,0);
COMMIT;

#
# Data for the `cms_rol` table  (LIMIT 0,500)
#

INSERT INTO `cms_rol` (`idcmsrol`, `rol`) VALUES 
  (1,'Super Administrador'),
  (2,'Administrador Cliente'),
  (3,'Usuario Registrado Back'),
  (4,'Usuario Registrado Front'),
  (5,'Asesor Back');
COMMIT;

#
# Data for the `cms_usuario` table  (LIMIT 0,500)
#

INSERT INTO `cms_usuario` (`idcmsusuario`, `usuario`, `contrasena`, `nombres`, `apellidos`, `email`, `empresa`, `telefono`, `descripcion`, `ciudad`, `cms_rol_id`, `token_chage`, `activo`) VALUES 
  (1,'cojunal','431e5dee9f398fa400b388686a0d0db2','COJUNAL','cojunal','ing.alelopez@gmail.com','IMAGINAMOS','3123952837',NULL,'Bogota',1,NULL,1),
  (2,'user','467b617fec4d9fcb63505734ee224851','Manuel','Rodriguez','wilmar.ibg@gmail.com','IMAGINAMOS','+573015499367',NULL,'Bogota D.C.',2,NULL,1),
  (3,'usc','202cb962ac59075b964b07152d234b70','Usuario pruebas','...','josediaz78963@gmail.com','Usc',NULL,NULL,NULL,2,NULL,1);
COMMIT;

#
# Data for the `coj_aboutus` table  (LIMIT 0,500)
#

INSERT INTO `coj_aboutus` (`id`, `img_en`, `img_es`, `des_en`, `des_es`, `title_en`, `title_es`, `dCreation`, `dUpdate`) VALUES 
  (1,'/uploads/nosotros/img_dest_home1.jpg','/uploads/nosotros/img_dest_home1.jpg','Differential according to the age of the portfolio','diferen FGKFKDKD','MEDIDAS AL RESPECTO','medidas al respecto','2016-10-20 04:20:00','2016-10-20 18:18:50'),
  (2,'/uploads/nosotros/img_dest_home2.jpg','/uploads/nosotros/img_dest_home2.jpg','Differential according to the age of the portfolio','diferencial según la edad de la cartera','SPECIALIZATION','ESPECIALIZACIÓN','2016-10-20 15:45:16','2016-10-20 15:45:16'),
  (3,'/uploads/nosotros/img_dest_home3.jpg','/uploads/nosotros/img_dest_home3.jpg','Differential according to the age of the portfolio','diferencial según la edad de la cartera','FRONT OFFICE','OFICINA FRONTAL','2016-10-20 16:34:14','2016-10-20 16:34:14'),
  (4,'/uploads/nosotros/img_dest_home4.jpg','/uploads/nosotros/img_dest_home4.jpg','imagen ','imagen ','imagen ','imagen ','2016-10-20 16:48:20','2016-10-20 16:48:20'),
  (5,'/uploads/nosotros/img_dest_home5.jpg','/uploads/nosotros/img_dest_home5.jpg','Differential according to the age of the portfolio','diferencial según la edad de la cartera','NEGOTIATION','NEGOCIACIÓN','2016-10-20 16:52:47','2016-10-20 16:52:47'),
  (6,'/uploads/nosotros/img_dest_home6.jpg','/uploads/nosotros/img_dest_home6.jpg','Differential according to the age of the portfolio','diferencial según la edad de la cartera','HOME VISITIES','VISITAS DOMICILIARIAS','2016-10-20 16:56:17','2016-10-20 16:56:17');
COMMIT;

#
# Data for the `coj_company` table  (LIMIT 0,500)
#

INSERT INTO `coj_company` (`id`, `title_es`, `title_en`, `img_es`, `img_en`, `dCreation`, `dUpdate`) VALUES 
  (1,'CLARO','CLARO ','/uploads/nosotros/ola.png','/uploads/nosotros/ola.png','2016-10-21 16:11:38','2016-10-21 16:11:38'),
  (4,'TECNOQUIMICAS','TECNOQUIMICAS ','/uploads/nosotros/TECNOQUIMICAS.png','/uploads/nosotros/TECNOQUIMICAS.png','2016-12-12 18:01:57','0000-00-00 00:00:00'),
  (5,'JOHNSON´S','JOHNSON´S','/uploads/nosotros/johnsons%20baby.jpg','/uploads/nosotros/johnsons%20baby.jpg','2017-02-03 18:52:58','0000-00-00 00:00:00'),
  (6,'COLOMBIA','COLOMBINA','/uploads/nosotros/COLOMBINA%20(1).jpg','/uploads/nosotros/COLOMBINA%20(1).jpg','2017-02-03 18:53:37','0000-00-00 00:00:00');
COMMIT;

#
# Data for the `coj_contact` table  (LIMIT 0,500)
#

INSERT INTO `coj_contact` (`id`, `hotlines_es`, `hotlines_en`, `addres_es`, `addres_en`, `email_es`, `email_en`, `contact_email`, `dCreation`, `dUpdate`) VALUES 
  (1,'Bogotá 7470677','Bogotá 57 1 7470677 ','Calle 26 A # 13-97 oficina 1101 - 1106 Edificio Bulevar Tequendama Bogotá','Street 26 A # 13-97 office 1101 - 1106 Edificio Bulevar Tequendama Bogotá-Colombia','servicioalcliente@cojunal.com','servicioalcliente@cojunal.com','servicioalcliente@cojunal.com','2016-10-25 15:53:20','2016-10-25 15:53:20');
COMMIT;

#
# Data for the `coj_email_placeholder` table  (LIMIT 0,500)
#

INSERT INTO `coj_email_placeholder` (`idEmailPlaceholder`, `regiaterClientNotification`, `termsConditions`, `updateAt`) VALUES 
  (1,'<p>Hola,&nbsp;se ha creado una nueva campa&ntilde;a para la empresa %nombre%&nbsp;a la cual usted representa por favor ingrese al sistema para poder dar gesti&oacute;n de la misma.</p>\n\n<p>-<strong>Link de ingreso:</strong>&nbsp;http://cojunal.com/plataforma/beta/iniciar-sesion&nbsp;<br />\n-<strong>Usuario:</strong>&nbsp;%correo%&nbsp;<br />\n-<strong>Clave:</strong>&nbsp;%contrasena%</p>\n\n<p>Cordialmente,<br />\nStaff&nbsp;<a href=\"http://www.cojunal.com/plataforma/beta\" target=\"_blank\">cojunal.com</a>&nbsp;<br />\n&nbsp;</p>\n\n<p>&nbsp;</p>','<p>Este email a&uacute;n no ha sido configurado...</p>\n','2017-08-30'),
  (2,'<p>Hola,&nbsp;se ha creado una nueva empresa %nombre%&nbsp;a la cual usted representa por favor ingrese al sistema para poder dar gesti&oacute;n de la misma.</p>\r\n\r\n<p>-<strong>Link de ingreso:</strong>&nbsp;http://cojunal.com/plataforma/beta/iniciar-sesion&nbsp;<br />\r\n-<strong>Usuario:</strong>&nbsp;%correo%&nbsp;<br />\r\n-<strong>Clave:</strong>&nbsp;%contrasena%</p>\r\n\r\n<p>Cordialmente,<br />\r\nStaff&nbsp;<a href=\"http://www.cojunal.com/plataforma/beta\" target=\"_blank\">cojunal.com</a>&nbsp;<br />\r\n&nbsp;</p>\r\n\r\n<p>&nbsp;</p>','...','2017-09-25');
COMMIT;

#
# Data for the `coj_generictext` table  (LIMIT 0,500)
#

INSERT INTO `coj_generictext` (`id`, `text_es`, `text_en`, `dCreate`, `dUpdate`) VALUES 
  (1,'CONTAMOS CON MAS DE 30 AÑOS DE EXPERIENCIA EN LA ADMINISTRACION Y RECUPERACION DE CARTERA EN DIFERENTES EDADES DE MORA\r\n\r\n\r\n\r\n','WE HAVE MORE THAN 30 YEARS OF EXPERIENCE IN PORTFOLIO ADMINISTRATION AND RECOVERY.','2016-10-20 03:32:31','2016-10-26 01:53:42'),
  (2,'ELLOS CONFÍAN EN NOSOTROS','They trust us','2016-10-20 03:38:54','2016-10-26 01:54:25'),
  (3,'TU EMPRESA PODRÍA ESTAR AQUÍ','YOUR COMPANY COULD BE HERE','2016-10-20 22:11:57','2016-10-26 01:55:01'),
  (4,'CENTRO DE CONTACTO REAL ','CONTACT CENTER REAL ','2016-10-24 15:30:14','2016-10-26 01:55:38'),
  (5,'Contáctenos','Contact Us','2016-10-24 15:41:10','2016-10-26 01:56:13'),
  (6,'Somos una organización líder con más ce 27 años de experiencia en la administracion y recuperación de cartera en diferentes edades de mora, para los sectores más determinantes de la econmía nacional. prueba qwertyuipoiuytrewerty','We are a leading organization with more ce 27 years of experience in portfolio management and recovery at different ages past due, for the most crucial sectors of the national econmia. qwertyuiuytrewerty.','2016-10-25 00:46:06','2016-10-26 01:56:49'),
  (7,'Atención inmediata ','Hotlines time','2016-10-25 16:00:28','2016-10-26 01:57:54'),
  (8,'Encuentranos a nivel nacional','Address in Bogotá ','2016-10-25 16:00:28','2016-10-26 01:59:47'),
  (9,'Escribenos ahora mismo ','You can write to go ','2016-10-25 16:04:04','2016-10-26 02:00:18'),
  (10,'Términos y condiciones subida de archivos','Terms and conditions upload files','2016-10-26 01:52:25','2016-10-26 01:52:25'),
  (11,'LA RECUPERACIÓN DE SU CARTERA ','PORTFOLIO RECOVERY IN HANDS','2016-10-28 00:18:42','2016-10-28 00:18:42'),
  (12,'CLIENTES QUE CONFÍAN EN NOSOTROS !','They trust us COMPANY','2016-10-28 01:08:31','2016-10-28 01:08:31'),
  (13,'TU EMPRESA CON LAS MEJORES MARCAS','YOUR COMPANY ','2016-10-28 18:44:01','2016-10-28 18:44:01');
COMMIT;

#
# Data for the `coj_home` table  (LIMIT 0,500)
#

INSERT INTO `coj_home` (`id`, `img_es`, `img_en`, `title_es`, `title_en`, `des_es`, `des_en`, `dCreation`, `dUpdate`) VALUES 
  (1,'/uploads/nosotros/img_dest_home6.jpg','/uploads/nosotros/img_dest_home4.jpg','RECUPERACIÓN','HELLO','Las mejores estrategias del mercado colombiano. ','in pre-legal stage ','2016-10-28 00:22:19','2016-10-28 00:22:19'),
  (2,'/uploads/nosotros/img_dest_home2.jpg','/uploads/nosotros/img_dest_home2.jpg','ASESORíA JURÍDICA','Legal advice','financiera y jurídica','financial and legal','2016-10-28 00:44:45','2016-10-28 00:44:45'),
  (3,'/uploads/nosotros/img_dest_home3.jpg','/uploads/nosotros/img_dest_home3.jpg','No Aplica','No Aplica','No Aplica','No Aplica','2016-10-28 00:45:55','2016-10-28 00:45:55'),
  (4,'/uploads/nosotros/img_dest_home4.jpg','/uploads/nosotros/img_dest_home4.jpg','CENTRO DE CONTACTO','CONTACT CENTER','estrategica en etapa prejuridica','in pre-legal stage strategic','2016-10-28 00:49:22','2016-10-28 00:49:22'),
  (5,'/uploads/nosotros/img_dest_home5.jpg','/uploads/nosotros/img_dest_home5.jpg','No Aplica','No Aplica','No Aplica','No Aplica','2016-10-28 00:49:54','2016-10-28 00:49:54'),
  (6,'/uploads/nosotros/img_dest_home6.jpg','/uploads/nosotros/img_dest_home6.jpg','VISITAS DOMICILIARIAS','home visities','de cartera en general','portfolio in general','2016-10-28 01:01:43','2016-10-28 01:01:43');
COMMIT;

#
# Data for the `coj_map` table  (LIMIT 0,500)
#

INSERT INTO `coj_map` (`id`, `latitude`, `lgn`, `title_en`, `title_es`, `dCreation`, `dUpdate`) VALUES 
  (1,4.73712,-74.0605,'Prueba1','Prueba 2','2016-10-28 05:23:59','2016-10-28 05:23:59'),
  (2,4.72228,-74.0488,'BBC Cedritos Ingles','BBC Cedritos','2016-10-28 05:25:36','2016-10-28 05:25:36');
COMMIT;

#
# Data for the `coj_services` table  (LIMIT 0,500)
#

INSERT INTO `coj_services` (`id`, `img_es`, `img_en`, `title_es`, `title_en`, `subtitle_es`, `subtitle_en`, `des_es`, `des_en`, `dCreation`, `dUpdate`) VALUES 
  (1,'/uploads/nosotros/img_dest_home1.jpg','/uploads/nosotros/img_dest_home1.jpg','servicio de Ingreso','SERVICE 1','bienvenido','SERVICE NUMBER 1 introductory LOREM','HOLA .. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas prueba2','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','2016-10-21 21:30:23','2016-10-21 21:30:23'),
  (2,'/uploads/ahorranito.png','/uploads/nosotros/img_dest_home5.jpg','SERVICIO 2','SERVICE 2','SERVICIO LOREM','SERVICE NUMBER 2 introductory LOREM','prueba 1','Lorem ipsum dolor sit amet.','2016-10-21 21:34:45','2016-10-21 21:34:45'),
  (3,'/uploads/nosotros/img_dest_home3.jpg','/uploads/nosotros/img_dest_home3.jpg','SERVICIO 3','SERVICE 3','SERVICIO LOREM NUMERO 3','SERVICE NUMBER 3 introductory LOREM','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','2016-10-21 21:35:22','2016-10-21 21:35:22'),
  (4,'/uploads/nosotros/img_dest_home2.jpg','/uploads/nosotros/img_dest_home2.jpg','SERVICIO 4','SERVICE 4','SERVICIO LOREM NUMERO 4','SERVICE NUMBER 4 introductory LOREM','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','2016-10-21 21:36:13','2016-10-21 21:36:13'),
  (5,'/uploads/nosotros/img_dest_home3.jpg','/uploads/nosotros/img_dest_home3.jpg','SERVICIO 5','SERVICE 5','SERVICIO LOREM NUMERO 5','SERVICE NUMBER 5 introductory LOREM','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis hendrerit diam, id sagittis turpis imperdiet vel. Sed leo purus, scelerisque ac mollis quis, maximus sit amet tortor. Integer porttitor orci id lacus pulvinar, eu vulputate ipsum pretium. Vivamus augue eros, sodales sed cursus et, suscipit in ligula. Aliquam fermentum tortor metus, in lacinia lectus volutpat a. Nullam condimentum velit sed justo sodales sagittis. Duis vitae dictum eros, volutpat finibus turpis. Donec porttitor vitae dolor non ultricies. Nulla laoreet nisl eget condimentum malesuada. Phasellus ut vehicula urna. In ac eros mas','2016-10-21 21:36:36','2016-10-21 21:36:36');
COMMIT;

#
# Data for the `coj_testimony` table  (LIMIT 0,500)
#

INSERT INTO `coj_testimony` (`id`, `img_es`, `img_en`, `testi_es`, `testi_en`, `name_company_es`, `name_company_en`, `name_person_es`, `name_person_en`, `charge_person_es`, `charge_person_en`, `dCreation`, `dUpdate`) VALUES 
  (1,'/uploads/nosotros/HOSPITAL%20DE%20MEISSEN.png','/uploads/nosotros/HOSPITAL%20DE%20MEISSEN.png','la mejor empresa de recuperación de cartera.','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','IMAGINAMOS','CLARO','Daniel Cuervo ','Juan Perez','Producto','General Manager at Claro','2016-10-28 03:15:53','2016-10-28 03:15:53'),
  (2,'/uploads/nosotros/johnsons%20baby.jpg','/uploads/nosotros/johnsons%20baby.jpg','Lorem ipsum dolor sit amets, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','NESTLE','NESTLE','Juan Perez','Juan Perez','Gerente general en Nestle','General Manager at Nestle','2016-10-28 03:18:17','2016-10-28 03:18:17'),
  (3,'/uploads/nosotros/COLOMBINA%20(1).jpg','/uploads/nosotros/COLOMBINA%20(1).jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','CLARO','CLARO','Juan Perez','Juan Perez','Gerente general en Claro','General Manager at Claro','2016-10-28 03:19:24','2016-10-28 03:19:24'),
  (4,'/uploads/nosotros/ola.png','/uploads/nosotros/ola.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','NESTLE','NESTLE','Juan Perez','Juan Perez','Gerente general en Nestle','General Manager at Nestle','2016-10-28 03:20:33','2016-10-28 03:20:33'),
  (5,'/uploads/nosotros/TECNOQUIMICAS.png','/uploads/nosotros/TECNOQUIMICAS.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','CLARO','CLARO','Jesus Mora','Jesus Mora','Gerente de Operaciones CLARO','CLARO Operations Manager','2016-10-28 03:29:02','2016-10-28 03:29:02'),
  (6,'/uploads/nosotros/NESTLE.jpg','/uploads/nosotros/NESTLE.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula sapien et mi rhoncus','NESTLE','NESTLE','Jesus Mora','Jesus Mora','Gerente de Operaciones NESTLE','NESTLE Operations Manager','2016-10-28 03:30:51','2016-10-28 03:30:51');
COMMIT;

#
# Data for the `types` table  (LIMIT 0,500)
#

INSERT INTO `types` (`idType`, `name`, `dCreation`, `idAdviser`) VALUES 
  (1,'Telefono','2016-07-08 19:00:00',0),
  (2,'Referencia','2016-07-08 19:00:00',0),
  (3,'Correo','2016-07-08 19:00:00',0),
  (4,'Direccion','2016-07-08 19:00:00',0);
COMMIT;

#
# Data for the `demographics` table  (LIMIT 0,500)
#

INSERT INTO `demographics` (`idDemographic`, `value`, `idCity`, `idAdviser`, `idType`, `dCreation`, `idWallet`, `comment`, `relationshipType`, `phoneType`, `contactName`, `addressType`) VALUES 
  (1,'3217120514',9,40,1,'2017-06-29 21:59:49',5335,NULL,NULL,'CELULAR',NULL,NULL),
  (2,'3043363915',9,40,1,'2017-06-29 21:59:49',5336,NULL,NULL,'CELULAR',NULL,NULL),
  (3,'3043363882',9,40,1,'2017-06-29 21:59:49',5336,NULL,NULL,'CELULAR',NULL,NULL),
  (4,'321756241',9,40,1,'2017-06-29 21:59:49',5336,NULL,NULL,'CELULAR',NULL,NULL),
  (5,'3003523241',9,40,1,'2017-06-29 21:59:49',5337,NULL,NULL,'CELULAR',NULL,NULL),
  (6,'3681756',9,40,1,'2017-06-29 21:59:49',5338,NULL,NULL,'FIJO',NULL,NULL),
  (7,'3015182850',9,40,1,'2017-06-29 21:59:49',5338,NULL,NULL,'CELULAR',NULL,NULL),
  (8,'3015587931',9,40,1,'2017-06-29 21:59:49',5338,NULL,NULL,'CELULAR',NULL,NULL),
  (9,'3126151335',9,40,1,'2017-06-29 21:59:49',5339,NULL,NULL,'CELULAR',NULL,NULL),
  (10,'3135253364',9,40,1,'2017-06-29 21:59:49',5340,NULL,NULL,'CELULAR',NULL,NULL),
  (11,'3107178372',9,40,1,'2017-06-29 21:59:49',5340,NULL,NULL,'CELULAR',NULL,NULL),
  (12,'3222216',9,40,1,'2017-06-29 21:59:49',5341,NULL,NULL,'FIJO',NULL,NULL),
  (13,'3206518129',9,40,1,'2017-06-29 21:59:49',5341,NULL,NULL,'CELULAR',NULL,NULL),
  (14,'3217558496',9,40,1,'2017-06-29 21:59:49',5344,NULL,NULL,'CELULAR',NULL,NULL),
  (15,'3215675455',9,40,1,'2017-06-29 21:59:49',5344,NULL,NULL,'CELULAR',NULL,NULL),
  (16,'3142800438',9,40,1,'2017-06-29 21:59:49',5344,NULL,NULL,'CELULAR',NULL,NULL),
  (17,'3135552910',9,40,1,'2017-06-29 21:59:49',5347,NULL,NULL,'CELULAR',NULL,NULL),
  (18,'3107281565',9,40,1,'2017-06-29 21:59:49',5347,NULL,NULL,'CELULAR',NULL,NULL),
  (19,'3705053',9,40,1,'2017-06-29 21:59:49',5350,NULL,NULL,'FIJO',NULL,NULL),
  (20,'3107385437',9,40,1,'2017-06-29 21:59:49',5350,NULL,NULL,'CELULAR',NULL,NULL),
  (21,'3104967781',9,40,1,'2017-06-29 21:59:49',5350,NULL,NULL,'CELULAR',NULL,NULL),
  (22,'3174857769',9,40,1,'2017-06-29 21:59:49',5352,NULL,NULL,'CELULAR',NULL,NULL),
  (24,'3176996025',9,40,1,'2017-06-29 21:59:49',5352,NULL,NULL,'CELULAR',NULL,NULL),
  (25,'3002613496',9,40,1,'2017-06-29 21:59:49',5353,NULL,NULL,'CELULAR',NULL,NULL),
  (26,'3004143787',9,40,1,'2017-06-29 21:59:49',5353,NULL,NULL,'CELULAR',NULL,NULL),
  (27,'301559479',9,40,1,'2017-06-29 21:59:49',5353,NULL,NULL,'CELULAR',NULL,NULL),
  (29,'7312434',9,40,1,'2017-06-29 21:59:49',5357,NULL,NULL,'FIJO',NULL,NULL),
  (30,'3213371978',9,40,1,'2017-06-29 21:59:49',5358,NULL,NULL,'CELULAR',NULL,NULL),
  (31,'3114351566',9,40,1,'2017-06-29 21:59:49',5359,NULL,NULL,'CELULAR',NULL,NULL),
  (32,'2937730',9,40,1,'2017-06-29 21:59:49',5360,NULL,NULL,'FIJO',NULL,NULL),
  (33,'3192495636',9,40,1,'2017-06-29 21:59:49',5360,NULL,NULL,'CELULAR',NULL,NULL),
  (34,'3212591586',9,40,1,'2017-06-29 21:59:49',5360,NULL,NULL,'CELULAR',NULL,NULL),
  (35,'3135079791',9,40,1,'2017-06-29 21:59:49',5361,NULL,NULL,'CELULAR',NULL,NULL),
  (37,'3118679065',9,40,1,'2017-06-29 21:59:49',5364,NULL,NULL,'CELULAR',NULL,NULL),
  (38,'3174835826',9,40,1,'2017-06-29 21:59:49',5364,NULL,NULL,'CELULAR',NULL,NULL),
  (39,'3168179979',9,40,1,'2017-06-29 21:59:49',5364,NULL,NULL,'CELULAR',NULL,NULL),
  (40,'3014144589',9,40,1,'2017-06-29 21:59:49',5365,NULL,NULL,'CELULAR',NULL,NULL),
  (41,'3226509293',9,40,1,'2017-06-29 21:59:49',5365,NULL,NULL,'CELULAR',NULL,NULL),
  (43,'7433538',16,40,1,'2017-06-29 22:04:58',5367,NULL,NULL,'CELULAR',NULL,NULL),
  (44,'6746807',9,40,1,'2017-06-29 22:04:58',5369,NULL,NULL,'CELULAR',NULL,NULL),
  (45,'2162150',9,40,1,'2017-06-29 22:04:58',5369,NULL,NULL,'FIJO',NULL,NULL),
  (46,'7407358',4,40,1,'2017-06-29 22:04:58',5370,NULL,NULL,'CELULAR',NULL,NULL),
  (47,'7851473',4,40,1,'2017-06-29 22:04:58',5371,NULL,NULL,'CELULAR',NULL,NULL),
  (48,'5744697',7,40,1,'2017-06-29 22:04:58',5374,NULL,NULL,'FIJO',NULL,NULL),
  (50,'7103344',9,40,1,'2017-06-29 22:04:58',5379,NULL,NULL,'CELULAR',NULL,NULL),
  (51,'5714051',7,40,1,'2017-06-29 22:04:58',5380,NULL,NULL,'FIJO',NULL,NULL),
  (52,'3194024875',7,40,1,'2017-06-29 22:04:58',5380,NULL,NULL,'FIJO',NULL,NULL),
  (53,'3215397290',7,40,1,'2017-06-29 22:04:58',5380,NULL,NULL,'FIJO ',NULL,NULL),
  (54,'5823269',7,40,1,'2017-06-29 22:04:58',5381,NULL,NULL,'CELULAR',NULL,NULL),
  (55,'8808645',NULL,40,1,'2017-06-29 22:04:58',5382,NULL,NULL,'CELULAR',NULL,NULL),
  (56,'3730530',NULL,40,1,'2017-06-29 22:04:58',5382,NULL,NULL,'FIJO',NULL,NULL),
  (59,'3046245003',9,40,1,'2017-06-29 22:04:58',5384,NULL,NULL,'CELULAR',NULL,NULL),
  (61,'3176462942',12,40,1,'2017-06-29 22:16:58',5386,NULL,NULL,'CELULAR',NULL,NULL),
  (62,'KELLY JOHANNA PEREA CAJAL',12,40,2,'2017-06-29 22:16:58',5386,'CASA GRANDE','REPRESENTANTE LEGAL',NULL,NULL,NULL),
  (63,'AMOZO78@HOTMAIL.COM',NULL,40,3,'2017-06-29 22:16:58',5386,NULL,NULL,NULL,'ALBERTO ESPOSO',NULL),
  (64,'3146046522',7,40,1,'2017-06-29 22:16:58',5387,NULL,NULL,'CELULAR',NULL,NULL),
  (65,'5887274',7,40,1,'2017-06-29 22:16:58',5387,NULL,NULL,'FIJO',NULL,NULL),
  (67,'ERNESTO MORA MEJIA',7,40,2,'2017-06-29 22:16:58',5387,'COMPROMSO PARA EL 15 01 16 PDT ACUERDO DE PAGO','REPRESENTANTE LEGAL',NULL,NULL,NULL),
  (68,'3185926380',9,40,1,'2017-06-29 23:35:24',5388,NULL,NULL,'CELULAR',NULL,NULL),
  (69,'4518414',9,40,1,'2017-06-29 23:35:24',5389,NULL,NULL,'FIJO',NULL,NULL),
  (70,'3142510436',9,40,1,'2017-06-29 23:35:24',5390,NULL,NULL,'CELULAR',NULL,NULL),
  (71,'2796417',9,40,1,'2017-06-29 23:35:24',5391,NULL,NULL,'FIJO',NULL,NULL),
  (72,'3206887237',9,40,1,'2017-06-29 23:35:24',5392,NULL,NULL,'CELULAR',NULL,NULL),
  (73,'4422762',9,40,1,'2017-06-29 23:35:24',5393,NULL,NULL,'FIJO',NULL,NULL),
  (74,'3124111813',9,40,1,'2017-06-29 23:35:24',5394,NULL,NULL,'CELULAR',NULL,NULL),
  (75,'3208107011',9,40,1,'2017-06-29 23:35:24',5395,NULL,NULL,'CELULAR',NULL,NULL),
  (76,'3142288813',9,40,1,'2017-06-29 23:35:24',5396,NULL,NULL,'CELULAR',NULL,NULL),
  (77,'3719866',9,40,1,'2017-06-29 23:35:24',5397,NULL,NULL,'FIJO',NULL,NULL),
  (78,'3215471092',9,40,1,'2017-06-29 23:35:24',5398,NULL,NULL,'CELULAR',NULL,NULL),
  (79,'3172952267',9,40,1,'2017-06-29 23:35:24',5399,NULL,NULL,'CELULAR',NULL,NULL),
  (80,'3153463429',9,40,1,'2017-06-29 23:35:24',5400,NULL,NULL,'CELULAR',NULL,NULL),
  (81,'3157879213',9,40,1,'2017-06-29 23:35:24',5401,NULL,NULL,'CELULAR',NULL,NULL),
  (82,'2622604',9,40,1,'2017-06-29 23:35:24',5402,NULL,NULL,'FIJO',NULL,NULL),
  (83,'8787364',9,40,1,'2017-06-29 23:35:24',5403,NULL,NULL,'FIJO',NULL,NULL),
  (84,'3173027810',9,40,1,'2017-06-29 23:35:24',5404,NULL,NULL,'CELULAR',NULL,NULL),
  (85,'4747756',9,40,1,'2017-06-29 23:35:24',5405,NULL,NULL,'FIJO',NULL,NULL),
  (86,'6442938',9,40,1,'2017-06-29 23:35:24',5406,NULL,NULL,'FIJO',NULL,NULL),
  (87,'4018514',9,40,1,'2017-06-29 23:35:24',5407,NULL,NULL,'FIJO',NULL,NULL),
  (89,'3165788899',9,40,1,'2017-06-29 23:35:24',5409,NULL,NULL,'CELULAR',NULL,NULL),
  (90,'3204155647',9,40,1,'2017-06-29 23:35:24',5410,NULL,NULL,'CELULAR',NULL,NULL),
  (91,'3103043677',9,40,1,'2017-06-29 23:35:24',5411,NULL,NULL,'CELULAR',NULL,NULL),
  (92,'3157879213',9,40,1,'2017-06-29 23:35:24',5412,NULL,NULL,'CELULAR',NULL,NULL),
  (93,'3118903892',9,40,1,'2017-06-29 23:35:24',5413,NULL,NULL,'CELULAR',NULL,NULL),
  (94,'2622604',9,40,1,'2017-06-29 23:35:24',5414,NULL,NULL,'FIJO',NULL,NULL),
  (95,'8787364',9,40,1,'2017-06-29 23:35:24',5415,NULL,NULL,'FIJO',NULL,NULL),
  (96,'6543653',9,40,1,'2017-06-29 23:35:24',5416,NULL,NULL,'FIJO',NULL,NULL),
  (97,'3134619697',9,40,1,'2017-06-29 23:35:24',5417,NULL,NULL,'CELULAR',NULL,NULL),
  (98,'323755240',9,40,1,'2017-06-29 23:35:24',5418,NULL,NULL,'CELULAR',NULL,NULL),
  (99,'3173027810',9,40,1,'2017-06-29 23:35:24',5419,NULL,NULL,'CELULAR',NULL,NULL),
  (100,'3132454778',9,40,1,'2017-06-29 23:35:24',5420,NULL,NULL,'CELULAR',NULL,NULL),
  (101,'3132847226',9,40,1,'2017-06-29 23:35:24',5421,NULL,NULL,'CELULAR',NULL,NULL),
  (102,'7493737',9,40,1,'2017-06-29 23:35:24',5422,NULL,NULL,'FIJO',NULL,NULL),
  (103,'3134522597',9,40,1,'2017-06-29 23:35:24',5423,NULL,NULL,'CELULAR',NULL,NULL),
  (104,'2773918',9,40,1,'2017-06-29 23:35:24',5424,NULL,NULL,'FIJO',NULL,NULL),
  (105,'3114881640',9,40,1,'2017-06-29 23:35:24',5425,NULL,NULL,'CELULAR',NULL,NULL),
  (106,'3138310536',9,40,1,'2017-06-29 23:35:24',5426,NULL,NULL,'CELULAR',NULL,NULL),
  (107,'3185713439',9,40,1,'2017-06-29 23:35:24',5427,NULL,NULL,'CELULAR',NULL,NULL),
  (108,'4483500',9,40,1,'2017-06-29 23:35:24',5428,NULL,NULL,'FIJO',NULL,NULL),
  (109,'3178142749',9,40,1,'2017-06-29 23:35:24',5429,NULL,NULL,'CELULAR',NULL,NULL),
  (110,'3113098191',9,40,1,'2017-06-29 23:35:24',5430,NULL,NULL,'CELULAR',NULL,NULL),
  (111,'3117023736',9,40,1,'2017-06-29 23:35:24',5431,NULL,NULL,'CELULAR',NULL,NULL),
  (112,'4747756',9,40,1,'2017-06-29 23:35:24',5432,NULL,NULL,'FIJO',NULL,NULL),
  (113,'323956101',9,40,1,'2017-06-29 23:35:24',5433,NULL,NULL,'CELULAR',NULL,NULL),
  (114,'3134630063',9,40,1,'2017-06-29 23:35:24',5434,NULL,NULL,'CELULAR',NULL,NULL),
  (115,'3145435814',9,40,1,'2017-06-29 23:35:24',5435,NULL,NULL,'CELULAR',NULL,NULL),
  (116,'3219212237',9,40,1,'2017-06-29 23:35:24',5436,NULL,NULL,'CELULAR',NULL,NULL),
  (117,'3115296170',9,40,1,'2017-06-29 23:35:24',5437,NULL,NULL,'CELULAR',NULL,NULL),
  (118,'6442938',9,40,1,'2017-06-29 23:35:24',5438,NULL,NULL,'FIJO',NULL,NULL),
  (119,'3142600603',9,40,1,'2017-06-29 23:35:24',5439,NULL,NULL,'CELULAR',NULL,NULL),
  (120,'4747756',9,40,1,'2017-06-29 23:35:24',5440,NULL,NULL,'FIJO',NULL,NULL),
  (121,'3125380410',9,40,1,'2017-06-29 23:35:24',5441,NULL,NULL,'CELULAR',NULL,NULL),
  (122,'3154815568',9,40,1,'2017-06-29 23:35:24',5442,NULL,NULL,'CELULAR',NULL,NULL),
  (123,'3218425628',9,40,1,'2017-06-29 23:35:24',5443,NULL,NULL,'CELULAR',NULL,NULL),
  (124,'3168832734',9,40,1,'2017-06-29 23:35:24',5444,NULL,NULL,'CELULAR',NULL,NULL),
  (125,'4018514',9,40,1,'2017-06-29 23:35:24',5445,NULL,NULL,'FIJO',NULL,NULL),
  (126,'3202023704',9,40,1,'2017-06-29 23:35:24',5446,NULL,NULL,'CELULAR',NULL,NULL),
  (127,'3103389399',9,40,1,'2017-06-29 23:35:24',5447,NULL,NULL,'CELULAR',NULL,NULL),
  (128,'3142510436',9,40,1,'2017-06-29 23:35:24',5448,NULL,NULL,'CELULAR',NULL,NULL),
  (129,'3104178546',9,40,1,'2017-06-29 23:35:24',5449,NULL,NULL,'CELULAR',NULL,NULL),
  (130,'3015844385',9,40,1,'2017-06-29 23:35:24',5450,NULL,NULL,'CELULAR',NULL,NULL),
  (131,'310889601',9,40,1,'2017-06-29 23:35:24',5451,NULL,NULL,'CELULAR',NULL,NULL),
  (132,'3118488257',9,40,1,'2017-06-29 23:35:24',5452,NULL,NULL,'CELULAR',NULL,NULL),
  (133,'3012323703',9,40,1,'2017-06-29 23:35:24',5453,NULL,NULL,'CELULAR',NULL,NULL),
  (134,'3125721456',9,40,1,'2017-06-29 23:35:24',5454,NULL,NULL,'CELULAR',NULL,NULL),
  (135,'3185149086',9,40,1,'2017-06-29 23:35:24',5455,NULL,NULL,'CELULAR',NULL,NULL),
  (136,'5941935',9,40,1,'2017-06-29 23:35:24',5456,NULL,NULL,'FIJO',NULL,NULL),
  (137,'6311392',9,40,1,'2017-06-29 23:35:24',5457,NULL,NULL,'FIJO',NULL,NULL),
  (138,'3208029263',9,40,1,'2017-06-29 23:35:24',5458,NULL,NULL,'CELULAR',NULL,NULL),
  (139,'3202224701',9,40,1,'2017-06-29 23:35:24',5459,NULL,NULL,'CELULAR',NULL,NULL),
  (140,'3103342781',9,40,1,'2017-06-29 23:35:24',5460,NULL,NULL,'CELULAR',NULL,NULL),
  (141,'2092506',9,40,1,'2017-06-29 23:35:24',5461,NULL,NULL,'FIJO',NULL,NULL),
  (142,'3186992377',9,40,1,'2017-06-29 23:35:24',5462,NULL,NULL,'CELULAR',NULL,NULL),
  (143,'3716734',9,40,1,'2017-06-29 23:35:24',5463,NULL,NULL,'FIJO',NULL,NULL),
  (144,'3166981988',9,40,1,'2017-06-29 23:35:24',5464,NULL,NULL,'CELULAR',NULL,NULL),
  (145,'3215953731',9,40,1,'2017-06-29 23:35:24',5465,NULL,NULL,'CELULAR',NULL,NULL),
  (146,'8892572',9,40,1,'2017-06-29 23:35:24',5466,NULL,NULL,'FIJO',NULL,NULL),
  (147,'3108399007',9,40,1,'2017-06-29 23:35:24',5467,NULL,NULL,'CELULAR',NULL,NULL),
  (148,'3217415722',9,40,1,'2017-06-29 23:35:24',5468,NULL,NULL,'CELULAR',NULL,NULL),
  (149,'3156484930',9,40,1,'2017-06-29 23:35:24',5469,NULL,NULL,'CELULAR',NULL,NULL),
  (150,'3144608909',9,40,1,'2017-06-29 23:35:24',5470,NULL,NULL,'CELULAR',NULL,NULL),
  (151,'3154028003',9,40,1,'2017-06-29 23:35:24',5471,NULL,NULL,'CELULAR',NULL,NULL),
  (152,'3044890594',9,40,1,'2017-06-29 23:35:24',5472,NULL,NULL,'CELULAR',NULL,NULL),
  (153,'3118435886',9,40,1,'2017-06-29 23:35:24',5473,NULL,NULL,'CELULAR',NULL,NULL),
  (154,'6844691',9,40,1,'2017-06-29 23:35:24',5474,NULL,NULL,'FIJO',NULL,NULL),
  (155,'4511920',9,40,1,'2017-06-29 23:35:24',5475,NULL,NULL,'FIJO',NULL,NULL),
  (156,'3115544597',9,40,1,'2017-06-29 23:35:24',5476,NULL,NULL,'CELULAR',NULL,NULL),
  (157,'3115134494',9,40,1,'2017-06-29 23:35:24',5477,NULL,NULL,'CELULAR',NULL,NULL),
  (158,'3124423599',9,40,1,'2017-06-29 23:35:24',5478,NULL,NULL,'CELULAR',NULL,NULL),
  (159,'3214903039',9,40,1,'2017-06-29 23:35:24',5479,NULL,NULL,'CELULAR',NULL,NULL),
  (160,'4864268',9,40,1,'2017-06-29 23:35:24',5480,NULL,NULL,'FIJO',NULL,NULL),
  (161,'3322110',9,40,1,'2017-06-29 23:35:24',5481,NULL,NULL,'FIJO',NULL,NULL),
  (162,'3116796430',9,40,1,'2017-06-29 23:35:24',5482,NULL,NULL,'CELULAR',NULL,NULL),
  (163,'5791937',9,40,1,'2017-06-29 23:35:24',5483,NULL,NULL,'CELULAR',NULL,NULL),
  (164,'3123724702',9,40,1,'2017-06-29 23:35:24',5484,NULL,NULL,'CELULAR',NULL,NULL),
  (165,'4735428',9,40,1,'2017-06-29 23:35:24',5485,NULL,NULL,'FIJO',NULL,NULL),
  (166,'7688415',9,40,1,'2017-06-29 23:35:24',5486,NULL,NULL,'FIJO',NULL,NULL),
  (167,'3108098755',9,40,1,'2017-06-29 23:35:24',5487,NULL,NULL,'CELULAR',NULL,NULL),
  (168,'3138320572',9,40,1,'2017-06-29 23:35:24',5488,NULL,NULL,'CELULAR',NULL,NULL),
  (169,'3173803260',9,40,1,'2017-06-29 23:35:24',5489,NULL,NULL,'CELULAR',NULL,NULL),
  (170,'3142692530',9,40,1,'2017-06-29 23:35:24',5490,NULL,NULL,'CELULAR',NULL,NULL),
  (171,'3044331793',9,40,1,'2017-06-29 23:35:24',5491,NULL,NULL,'CELULAR',NULL,NULL),
  (172,'3158527150',9,40,1,'2017-06-29 23:35:24',5492,NULL,NULL,'CELULAR',NULL,NULL),
  (173,'2633492',9,40,1,'2017-06-29 23:35:24',5493,NULL,NULL,'FIJO',NULL,NULL),
  (174,'3114403474',9,40,1,'2017-06-29 23:35:24',5494,NULL,NULL,'CELULAR',NULL,NULL),
  (175,'2645582',9,40,1,'2017-06-29 23:35:24',5495,NULL,NULL,'FIJO',NULL,NULL),
  (176,'5718804',9,40,1,'2017-06-29 23:35:24',5496,NULL,NULL,'FIJO',NULL,NULL),
  (177,'3167409797',9,40,1,'2017-06-29 23:35:24',5497,NULL,NULL,'CELULAR',NULL,NULL),
  (178,'3218573599',9,40,1,'2017-06-29 23:35:24',5498,NULL,NULL,'CELULAR',NULL,NULL),
  (179,'7796916',9,40,1,'2017-06-29 23:35:24',5499,NULL,NULL,'FIJO',NULL,NULL),
  (180,'3138869966',9,40,1,'2017-06-29 23:35:24',5500,NULL,NULL,'CELULAR',NULL,NULL),
  (181,'3103115350',9,40,1,'2017-06-29 23:35:24',5501,NULL,NULL,'CELULAR',NULL,NULL),
  (182,'5833700',9,40,1,'2017-06-29 23:35:24',5502,NULL,NULL,'FIJO',NULL,NULL),
  (183,'3132857834',9,40,1,'2017-06-29 23:35:24',5503,NULL,NULL,'CELULAR',NULL,NULL),
  (184,'3134202331',9,40,1,'2017-06-29 23:35:24',5504,NULL,NULL,'CELULAR',NULL,NULL),
  (185,'3254125478',9,40,1,'2017-06-29 23:35:24',5505,NULL,NULL,'CELULAR',NULL,NULL),
  (186,'2830742',9,40,1,'2017-06-29 23:35:24',5506,NULL,NULL,'FIJO',NULL,NULL),
  (187,'3113440312',9,40,1,'2017-06-29 23:35:24',5507,NULL,NULL,'CELULAR',NULL,NULL),
  (188,'3827670',9,40,1,'2017-06-29 23:35:24',5508,NULL,NULL,'FIJO',NULL,NULL),
  (189,'8137748',9,40,1,'2017-06-29 23:35:24',5509,NULL,NULL,'FIJO',NULL,NULL),
  (190,'3132847226',9,40,1,'2017-06-29 23:35:24',5510,NULL,NULL,'CELULAR',NULL,NULL),
  (191,'3600896',9,40,1,'2017-06-29 23:35:24',5511,NULL,NULL,'FIJO',NULL,NULL),
  (192,'3164726124',9,40,1,'2017-06-29 23:35:24',5512,NULL,NULL,'CELULAR',NULL,NULL),
  (193,'313112312',9,40,1,'2017-06-29 23:35:24',5513,NULL,NULL,'CELULAR',NULL,NULL),
  (194,'3720855',9,40,1,'2017-06-29 23:35:24',5514,NULL,NULL,'FIJO',NULL,NULL),
  (195,'4732661',9,40,1,'2017-06-29 23:35:24',5515,NULL,NULL,'FIJO',NULL,NULL),
  (196,'325542244',9,40,1,'2017-06-29 23:35:24',5516,NULL,NULL,'CELULAR',NULL,NULL),
  (197,'3155398189',9,40,1,'2017-06-29 23:35:24',5517,NULL,NULL,'CELULAR',NULL,NULL),
  (198,'7234251',9,40,1,'2017-06-29 23:35:24',5518,NULL,NULL,'FIJO',NULL,NULL),
  (199,'3124110888',9,40,1,'2017-06-29 23:35:24',5519,NULL,NULL,'CELULAR',NULL,NULL),
  (200,'3204951897',9,40,1,'2017-06-29 23:35:24',5520,NULL,NULL,'CELULAR',NULL,NULL),
  (201,'3154028003',9,40,1,'2017-06-29 23:35:24',5521,NULL,NULL,'CELULAR',NULL,NULL),
  (202,'3112813811',9,40,1,'2017-06-29 23:35:24',5522,NULL,NULL,'CELULAR',NULL,NULL),
  (203,'3183067178',9,40,1,'2017-06-29 23:35:24',5523,NULL,NULL,'CELULAR',NULL,NULL),
  (204,'3182480938',9,40,1,'2017-06-29 23:35:24',5524,NULL,NULL,'CELULAR',NULL,NULL),
  (205,'3008662814',9,40,1,'2017-06-29 23:35:24',5525,NULL,NULL,'CELULAR',NULL,NULL),
  (206,'2600987',9,40,1,'2017-06-29 23:35:24',5526,NULL,NULL,'FIJO',NULL,NULL),
  (207,'3165200369',9,40,1,'2017-06-29 23:35:24',5527,NULL,NULL,'CELULAR',NULL,NULL),
  (208,'3174339592',9,40,1,'2017-06-29 23:35:24',5528,NULL,NULL,'CELULAR',NULL,NULL),
  (209,'6801219',9,40,1,'2017-06-29 23:35:24',5529,NULL,NULL,'FIJO',NULL,NULL),
  (210,'3186322613',9,40,1,'2017-06-29 23:35:24',5530,NULL,NULL,'CELULAR',NULL,NULL),
  (211,'3108810699',9,40,1,'2017-06-29 23:35:24',5531,NULL,NULL,'CELULAR',NULL,NULL),
  (212,'3203134655',9,40,1,'2017-06-29 23:35:24',5532,NULL,NULL,'CELULAR',NULL,NULL),
  (213,'32145789521',9,40,1,'2017-06-29 23:35:24',5533,NULL,NULL,'CELULAR',NULL,NULL),
  (214,'6649853',9,40,1,'2017-06-29 23:35:24',5534,NULL,NULL,'FIJO',NULL,NULL),
  (215,'3205458745',9,40,1,'2017-06-29 23:35:24',5535,NULL,NULL,'CELULAR',NULL,NULL),
  (297,'6452187',17,40,1,'2017-06-30 00:08:20',5559,NULL,NULL,'FIJO',NULL,NULL),
  (298,'6453419',17,40,1,'2017-06-30 00:08:20',5559,NULL,NULL,'FIJO',NULL,NULL),
  (299,'3134576729',NULL,40,1,'2017-06-30 00:44:33',5560,NULL,NULL,'CELULAR',NULL,NULL),
  (300,'7455700',NULL,40,1,'2017-06-30 00:44:33',5561,NULL,NULL,'FIJO',NULL,NULL),
  (301,'3138041502',9,40,1,'2017-06-30 00:54:34',5567,NULL,NULL,'CELULAR',NULL,NULL),
  (302,'6687100',9,40,1,'2017-06-30 00:54:34',5569,NULL,NULL,'FIJO',NULL,NULL),
  (303,'3118119361',9,40,1,'2017-06-30 00:54:34',5570,NULL,NULL,'CELULAR',NULL,NULL),
  (304,'3139013',9,40,1,'2017-06-30 00:54:34',5573,NULL,NULL,'FIJO',NULL,NULL),
  (305,'3102234942',9,40,1,'2017-06-30 00:54:34',5575,NULL,NULL,'FIJO',NULL,NULL),
  (306,'3153234210',9,40,1,'2017-06-30 00:54:34',5577,NULL,NULL,'CELULAR',NULL,NULL),
  (307,'3157868449',9,40,1,'2017-06-30 00:54:34',5579,NULL,NULL,'CELULAR',NULL,NULL),
  (308,'3103120387',9,40,1,'2017-06-30 00:54:34',5580,NULL,NULL,'CELULAR',NULL,NULL),
  (309,'6786717',9,40,1,'2017-06-30 00:54:34',5581,NULL,NULL,'FIJO',NULL,NULL),
  (310,'318699902',9,40,1,'2017-06-30 00:54:34',5583,NULL,NULL,'CELULAR',NULL,NULL),
  (311,'5131199',9,40,1,'2017-06-30 00:54:34',5584,NULL,NULL,'FIJO',NULL,NULL),
  (312,'jrhoteles@gmail.com',NULL,40,3,'2017-06-30 00:54:34',5584,NULL,NULL,NULL,'JESUS GALLARDO',NULL),
  (313,'2114279',9,40,1,'2017-06-30 00:54:34',5585,NULL,NULL,'FIJO',NULL,NULL),
  (314,'7460960',9,40,1,'2017-06-30 00:54:34',5587,NULL,NULL,'FIJO',NULL,NULL),
  (315,'3138787472',9,40,1,'2017-06-30 00:54:34',5588,NULL,NULL,'CELULAR',NULL,NULL),
  (316,'8285918',9,40,1,'2017-06-30 00:54:34',5589,NULL,NULL,'FIJO',NULL,NULL),
  (317,'7482020',9,40,1,'2017-06-30 00:54:34',5590,NULL,NULL,'FIJO',NULL,NULL),
  (318,'tesoreria@frayco.com.co',NULL,40,3,'2017-06-30 00:54:34',5590,NULL,NULL,NULL,'RODOLFO MARTINEZ',NULL),
  (319,'aux_tesoreria@frayco.com.co',NULL,40,3,'2017-06-30 00:54:34',5590,NULL,NULL,NULL,'TESORERIA',NULL),
  (320,'7416759',9,40,1,'2017-06-30 00:54:34',5591,NULL,NULL,'FIJO',NULL,NULL),
  (321,'3176210',9,40,1,'2017-06-30 00:54:34',5595,NULL,NULL,'FIJO',NULL,NULL),
  (322,'3108193296',9,40,1,'2017-06-30 00:54:34',5597,NULL,NULL,'CELULAR',NULL,NULL),
  (323,'6358588',9,40,1,'2017-06-30 00:54:34',5599,NULL,NULL,'FIJO',NULL,NULL),
  (324,'6193567',9,40,1,'2017-06-30 00:54:34',5601,NULL,NULL,'FIJO',NULL,NULL),
  (325,'8697777',9,40,1,'2017-06-30 00:54:34',5602,NULL,NULL,'FIJO',NULL,NULL),
  (326,'3112303446',9,40,1,'2017-06-30 00:54:34',5603,NULL,NULL,'FIJO',NULL,NULL),
  (327,'3103480764',9,40,1,'2017-06-30 00:54:34',5605,NULL,NULL,'CELULAR',NULL,NULL),
  (328,'8628821',9,40,1,'2017-06-30 00:54:34',5606,NULL,NULL,'FIJO',NULL,NULL),
  (329,'5603909',9,40,1,'2017-06-30 00:54:34',5607,NULL,NULL,'FIJO',NULL,NULL),
  (330,'3413053',9,40,1,'2017-06-30 00:54:34',5609,NULL,NULL,'FIJO',NULL,NULL),
  (331,'msi@marweltda.com',NULL,40,3,'2017-06-30 00:54:34',5609,NULL,NULL,NULL,'MANUEL ANTONIO ALARCON',NULL),
  (332,'3003941',9,40,1,'2017-06-30 00:54:34',5611,NULL,NULL,'FIJO',NULL,NULL),
  (333,'5169999',9,40,1,'2017-06-30 00:54:34',5612,NULL,NULL,'FIJO',NULL,NULL),
  (334,'3208498786',9,40,1,'2017-06-30 00:54:34',5613,NULL,NULL,'CELULAR',NULL,NULL),
  (335,'2847035',9,40,1,'2017-06-30 00:54:34',5615,NULL,NULL,'FIJO',NULL,NULL),
  (336,'3219736788',9,40,1,'2017-06-30 00:54:34',5616,NULL,NULL,'CELULAR',NULL,NULL),
  (337,'6112277',9,40,1,'2017-06-30 00:54:34',5617,NULL,NULL,'FIJO',NULL,NULL),
  (338,'3107634381',9,40,1,'2017-06-30 00:54:34',5618,NULL,NULL,'CELULAR',NULL,NULL),
  (339,'3102883914',9,40,1,'2017-06-30 00:54:34',5619,NULL,NULL,'CELULAR',NULL,NULL),
  (340,'2322224',9,40,1,'2017-06-30 00:54:34',5620,NULL,NULL,'FIJO',NULL,NULL),
  (341,'3203843342',9,40,1,'2017-06-30 00:54:34',5621,NULL,NULL,'CELULAR',NULL,NULL),
  (342,'6242449',9,40,1,'2017-06-30 00:54:34',5623,NULL,NULL,'FIJO',NULL,NULL),
  (343,'7431824',9,40,1,'2017-06-30 00:54:34',5624,NULL,NULL,'FIJO',NULL,NULL),
  (344,'3001010',9,40,1,'2017-06-30 00:54:34',5625,NULL,NULL,'FIJO',NULL,NULL),
  (345,'3125876885',9,40,1,'2017-06-30 00:54:34',5626,NULL,NULL,'CELULAR',NULL,NULL),
  (346,'2573614',9,40,1,'2017-06-30 00:54:34',5629,NULL,NULL,'FIJO',NULL,NULL),
  (347,'4640531',9,40,1,'2017-06-30 00:54:34',5630,NULL,NULL,'FIJO',NULL,NULL),
  (348,'2873077',9,40,1,'2017-06-30 00:54:34',5631,NULL,NULL,'FIJO',NULL,NULL),
  (349,'CL 25F  85C 58 PISO 2',9,40,4,'2017-06-30 00:54:34',5631,NULL,NULL,NULL,NULL,'OFICINA'),
  (350,'6910708',9,40,1,'2017-06-30 00:54:34',5632,NULL,NULL,'FIJO',NULL,NULL),
  (351,'7506145',9,40,1,'2017-06-30 00:54:34',5633,NULL,NULL,'FIJO',NULL,NULL),
  (352,'8795373',9,40,1,'2017-06-30 00:54:34',5635,NULL,NULL,'FIJO',NULL,NULL),
  (353,'3156255048',9,40,1,'2017-06-30 00:54:34',5638,NULL,NULL,'CELULAR',NULL,NULL),
  (354,'7447558',9,40,1,'2017-06-30 00:54:34',5639,NULL,NULL,'FIJO',NULL,NULL),
  (355,'3113118467',9,40,1,'2017-06-30 00:54:34',5640,NULL,NULL,'CELULAR',NULL,NULL),
  (356,'3148734820',9,40,1,'2017-06-30 00:54:34',5641,NULL,NULL,'CELULAR',NULL,NULL),
  (357,'6711359',9,40,1,'2017-06-30 00:54:34',5642,NULL,NULL,'FIJO',NULL,NULL),
  (358,'3122387309',9,40,1,'2017-06-30 00:54:34',5644,NULL,NULL,'CELULAR',NULL,NULL),
  (359,'3207975491',9,40,1,'2017-06-30 00:54:34',5645,NULL,NULL,'CELULAR',NULL,NULL),
  (360,'3156393074',19,40,1,'2017-06-30 13:14:29',5646,NULL,NULL,'CELULAR',NULL,NULL),
  (361,'3126263867',19,40,1,'2017-06-30 13:14:29',5646,NULL,NULL,'CELULAR',NULL,NULL),
  (362,'3208510003',19,40,1,'2017-06-30 13:14:29',5646,NULL,NULL,'CELULAR',NULL,NULL),
  (363,'EDUARDO CRODERO',19,40,2,'2017-06-30 13:14:29',5646,'ES SOLO AMIGO ','AMIGO',NULL,NULL,NULL),
  (364,'CR 16  31 17',19,40,4,'2017-06-30 13:14:29',5646,NULL,NULL,NULL,NULL,'CASA'),
  (952,'3107913931',9,40,1,'2017-06-30 16:19:54',6065,NULL,NULL,'FIJO',NULL,NULL),
  (953,'3115747495',9,40,1,'2017-06-30 16:19:54',6065,NULL,NULL,'CELULAR',NULL,NULL),
  (954,'3124567854',9,40,1,'2017-06-30 16:19:54',6065,NULL,NULL,'CELULAR',NULL,NULL),
  (955,'PILAR TAMAYO RINCON',9,40,2,'2017-06-30 16:19:54',6065,'ESTA PARA EMBARCO','REPRESENTANTE  LEGAL',NULL,NULL,NULL),
  (956,'FONTIBON  CR 96BIS  24C 32',9,40,4,'2017-06-30 16:19:54',6065,NULL,NULL,NULL,NULL,'CASA'),
  (957,'PAQUE INDUSTRIAL GRAN SABANA LOTE 47',9,40,4,'2017-06-30 16:19:54',6065,NULL,NULL,NULL,NULL,'LOTE'),
  (958,'PARQUE INDUSTRIAL GRAN SABANA UNIDAD 7 TOCANC',9,40,4,'2017-06-30 16:19:54',6065,NULL,NULL,NULL,NULL,'BODEGA'),
  (959,'7847012',9,40,1,'2017-06-30 16:19:54',6066,NULL,NULL,'FIJO',NULL,NULL),
  (960,'3153362134',9,40,1,'2017-06-30 16:19:54',6066,NULL,NULL,'FIJO',NULL,NULL),
  (961,'3166165818',9,40,1,'2017-06-30 16:19:54',6066,NULL,NULL,'CELULAR',NULL,NULL),
  (962,'ELVIRA CAMACHO@CONSULTECNICA.COM.CO',NULL,40,3,'2017-06-30 16:19:54',6066,NULL,NULL,NULL,'ELVIRA CAMACHO',NULL),
  (963,'CR 71C   16A 23',9,40,4,'2017-06-30 16:19:54',6066,NULL,NULL,NULL,NULL,'CASA'),
  (964,'3153458756',9,40,1,'2017-06-30 16:19:54',6067,NULL,NULL,'CELULAR',NULL,NULL),
  (965,'3108740677',9,40,1,'2017-06-30 16:19:54',6067,NULL,NULL,'CELULAR',NULL,NULL),
  (966,'2770596',9,40,1,'2017-06-30 16:19:54',6067,NULL,NULL,'CELULAR',NULL,NULL),
  (967,'CR 26   12B 68',9,40,4,'2017-06-30 16:19:54',6067,NULL,NULL,NULL,NULL,'CASA'),
  (968,'CLL 63   3 20 CHAPINERO',9,40,4,'2017-06-30 16:19:54',6067,NULL,NULL,NULL,NULL,'CASA'),
  (975,'3172124791',9,40,1,'2017-06-30 18:59:32',6077,NULL,NULL,'CELULAR',NULL,NULL),
  (976,'3003465779',9,40,1,'2017-06-30 18:59:32',6078,NULL,NULL,'CELULAR',NULL,NULL),
  (977,'3016164983',9,40,1,'2017-06-30 18:59:32',6080,NULL,NULL,'CELULAR',NULL,NULL),
  (978,'3107782590',9,40,1,'2017-06-30 18:59:32',6081,NULL,NULL,'CELULAR',NULL,NULL),
  (979,'3103044295',9,40,1,'2017-06-30 18:59:32',6082,NULL,NULL,'CELULAR',NULL,NULL),
  (980,'3205800214',9,40,1,'2017-06-30 18:59:32',6083,NULL,NULL,'CELULAR',NULL,NULL),
  (981,'3142708868',9,40,1,'2017-06-30 18:59:32',6084,NULL,NULL,'CELULAR',NULL,NULL),
  (982,'3124326966',9,40,1,'2017-06-30 18:59:32',6085,NULL,NULL,'CELULAR',NULL,NULL),
  (983,'3202748195',9,40,1,'2017-06-30 18:59:32',6088,NULL,NULL,'CELULAR',NULL,NULL),
  (984,'7113943',9,40,1,'2017-06-30 18:59:32',6089,NULL,NULL,'FIJO',NULL,NULL),
  (985,'6427412',9,40,1,'2017-06-30 18:59:32',6090,NULL,NULL,'FIJO',NULL,NULL),
  (986,'3146764416',9,40,1,'2017-06-30 18:59:32',6091,NULL,NULL,'CELULAR',NULL,NULL),
  (987,'3127602502',9,40,1,'2017-06-30 18:59:32',6093,NULL,NULL,'CELULAR',NULL,NULL),
  (988,'8280178',9,40,1,'2017-06-30 18:59:32',6094,NULL,NULL,'FIJO',NULL,NULL),
  (989,'3205771372',9,40,1,'2017-06-30 18:59:32',6095,NULL,NULL,'CELULAR',NULL,NULL),
  (990,'4110447',9,40,1,'2017-06-30 18:59:32',6096,NULL,NULL,'FIJO',NULL,NULL),
  (991,'5386329',9,40,1,'2017-06-30 18:59:32',6097,NULL,NULL,'FIJO',NULL,NULL),
  (993,'8746723',9,40,1,'2017-06-30 18:59:32',6100,NULL,NULL,'FIJO',NULL,NULL),
  (994,'8746722',9,40,1,'2017-06-30 18:59:32',6101,NULL,NULL,'FIJO',NULL,NULL),
  (995,'7446338',9,40,1,'2017-06-30 18:59:32',6103,NULL,NULL,'FIJO',NULL,NULL),
  (996,'3212258316',9,40,1,'2017-06-30 18:59:32',6105,NULL,NULL,'CELULAR',NULL,NULL),
  (997,'7498553',9,40,1,'2017-06-30 18:59:32',6107,NULL,NULL,'FIJO',NULL,NULL),
  (1007,'3444484',9,40,1,'2017-06-30 20:27:56',6180,NULL,NULL,'FIJO',NULL,NULL),
  (1008,'3610361',9,40,1,'2017-06-30 20:27:56',6181,NULL,NULL,'FIJO',NULL,NULL),
  (1009,'3108832339',9,40,1,'2017-06-30 20:27:56',6194,NULL,NULL,'CELULAR',NULL,NULL),
  (1010,'4055469',9,40,1,'2017-06-30 20:27:56',6200,NULL,NULL,'FIJO',NULL,NULL),
  (1011,'6062942',9,40,1,'2017-06-30 20:27:56',6202,NULL,NULL,'FIJO',NULL,NULL),
  (1012,'asesorias_zory@hotmail.com',NULL,42,3,'2017-06-30 16:25:06',6090,NULL,NULL,NULL,'Garcia Gomez Blanca',NULL),
  (1013,'asesorias_zory@hotmail.com',NULL,42,3,'2017-06-30 16:28:04',6090,NULL,NULL,NULL,'Garcia Gomez Blanca',NULL),
  (1014,'3119042017',9,40,1,'2017-07-02 17:49:41',6203,NULL,NULL,'CELULAR',NULL,NULL),
  (1015,'3133688168',9,40,1,'2017-07-02 17:49:41',6203,NULL,NULL,'CELULAR',NULL,NULL),
  (1016,'3105063491',9,40,1,'2017-07-02 17:49:41',6203,NULL,NULL,'CELULAR',NULL,NULL),
  (1017,'3163534372',9,40,1,'2017-07-02 17:49:41',6204,NULL,NULL,'CELULAR',NULL,NULL),
  (1018,'6799805',9,40,1,'2017-07-02 17:49:41',6204,NULL,NULL,'FIJO',NULL,NULL),
  (1019,'INGIASERIBARRA@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6204,NULL,NULL,NULL,'JOSE RAMON IBARRA ALBARRACIN',NULL),
  (1020,'MYRIAMRICAURTEG@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6204,NULL,NULL,NULL,'MYRIAM RICAURTE GONZALEZ',NULL),
  (1021,'CLL 170  17B  80 T 13 AO 104',9,40,4,'2017-07-02 17:49:41',6204,NULL,NULL,NULL,NULL,'CASA'),
  (1022,'CLL97 A  58 19',9,40,4,'2017-07-02 17:49:41',6204,NULL,NULL,NULL,NULL,'CASA'),
  (1023,'3138746897',9,40,1,'2017-07-02 17:49:41',6205,NULL,NULL,'CELULAR',NULL,NULL),
  (1024,'3004148354',9,40,1,'2017-07-02 17:49:41',6205,NULL,NULL,'CELULAR',NULL,NULL),
  (1025,'CLL 35  66A 69 BCONQUISTADORES',1,40,4,'2017-07-02 17:49:41',6205,NULL,NULL,NULL,NULL,'CASA'),
  (1026,'3115893710',9,40,1,'2017-07-02 17:49:41',6206,NULL,NULL,'CELULAR',NULL,NULL),
  (1027,'6405155',9,40,1,'2017-07-02 17:49:41',6206,NULL,NULL,'FIJO',NULL,NULL),
  (1028,'3138799739',NULL,40,1,'2017-07-02 17:49:41',6206,NULL,NULL,'CELULAR',NULL,NULL),
  (1029,'VALENTINA CASTRO BASANTE',9,40,2,'2017-07-02 17:49:41',6206,'PENSION FUERZA AEREA','ALUMNO',NULL,NULL,NULL),
  (1030,'ME_BASANTE@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6206,NULL,NULL,NULL,'MARIA ESPERANZA BASANTE',NULL),
  (1031,'3202251818',9,40,1,'2017-07-02 17:49:41',6207,NULL,NULL,'CELULAR',NULL,NULL),
  (1032,'VICTOR MANUEL ARDILA BECERRA',9,40,2,'2017-07-02 17:49:41',6207,'PENSION POR VEJEZ','ALUMNO',NULL,NULL,NULL),
  (1033,'3124103711',9,40,1,'2017-07-02 17:49:41',6208,NULL,NULL,'CELULAR',NULL,NULL),
  (1034,'4334768',9,40,1,'2017-07-02 17:49:41',6208,NULL,NULL,'FIJO',NULL,NULL),
  (1035,'CLL175 17B 80 IN5 AP204',9,40,4,'2017-07-02 17:49:41',6208,NULL,NULL,NULL,NULL,'CASA'),
  (1036,'4652114',9,40,1,'2017-07-02 17:49:41',6209,NULL,NULL,'FIJO',NULL,NULL),
  (1037,'KARIOKA_26@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6209,NULL,NULL,NULL,'DIAZ ORDOÄ„EZ LISETH KARINA',NULL),
  (1038,'CR 20A   173A 03',9,40,4,'2017-07-02 17:49:41',6209,NULL,NULL,NULL,NULL,'CASA'),
  (1039,'5849354',9,40,1,'2017-07-02 17:49:41',6210,NULL,NULL,'FIJO',NULL,NULL),
  (1040,'3043632027',9,40,1,'2017-07-02 17:49:41',6210,NULL,NULL,'CELULAR',NULL,NULL),
  (1041,'3056835',9,40,1,'2017-07-02 17:49:41',6210,NULL,NULL,'FIJO',NULL,NULL),
  (1042,'CR 38  2B  42 T2 APTO 108',9,40,4,'2017-07-02 17:49:41',6210,NULL,NULL,NULL,NULL,'CASA'),
  (1043,'3124236602',9,40,1,'2017-07-02 17:49:41',6211,NULL,NULL,'CELULAR',NULL,NULL),
  (1044,'3138739404',9,40,1,'2017-07-02 17:49:41',6211,NULL,NULL,'CELULAR',NULL,NULL),
  (1045,'6704410',9,40,1,'2017-07-02 17:49:41',6211,NULL,NULL,'FIJO',NULL,NULL),
  (1046,'SANTIAGO ACERO CORTES',9,40,2,'2017-07-02 17:49:41',6211,'YA PAGO DEUDA DEL CARRO','ALUMNO',NULL,NULL,NULL),
  (1047,'3163856856',9,40,1,'2017-07-02 17:49:41',6212,NULL,NULL,'CELULAR',NULL,NULL),
  (1048,'2142271423',9,40,1,'2017-07-02 17:49:41',6212,NULL,NULL,'CELULAR',NULL,NULL),
  (1049,'3142271423',9,40,1,'2017-07-02 17:49:41',6212,NULL,NULL,'CELULAR',NULL,NULL),
  (1050,'CLL 160  72 64 INT 70',9,40,4,'2017-07-02 17:49:41',6212,NULL,NULL,NULL,NULL,'CASA'),
  (1051,'3204982351',9,40,1,'2017-07-02 17:49:41',6213,NULL,NULL,'CELULAR',NULL,NULL),
  (1052,'4746550',9,40,1,'2017-07-02 17:49:41',6213,NULL,NULL,'FIJO',NULL,NULL),
  (1053,'YINETHRA@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6213,NULL,NULL,NULL,'YINETH AMPARO RAMIREZ REYES',NULL),
  (1054,'3102072822',9,40,1,'2017-07-02 17:49:41',6214,NULL,NULL,'CELULAR',NULL,NULL),
  (1055,'6738739',9,40,1,'2017-07-02 17:49:41',6214,NULL,NULL,'FIJO',NULL,NULL),
  (1056,'MIGUEL ALBAREZ BENAVIDES',9,40,2,'2017-07-02 17:49:41',6214,'FRENTA AL C.C. SANTAFE','ALUMNO',NULL,NULL,NULL),
  (1057,'PAOLABENAVIDES19@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6214,NULL,NULL,NULL,'PAOLA BENAVIDES',NULL),
  (1058,'3138132189',9,40,1,'2017-07-02 17:49:41',6215,NULL,NULL,'CELULAR',NULL,NULL),
  (1059,'3142101053',9,40,1,'2017-07-02 17:49:41',6215,NULL,NULL,'CELULAR',NULL,NULL),
  (1060,'TV 60 115 58 BL6 AP 303',9,40,4,'2017-07-02 17:49:41',6215,NULL,NULL,NULL,NULL,'CASA'),
  (1061,'3002775713',9,40,1,'2017-07-02 17:49:41',6216,NULL,NULL,'CELULAR',NULL,NULL),
  (1062,'3002775716',9,40,1,'2017-07-02 17:49:41',6216,NULL,NULL,'CELULAR',NULL,NULL),
  (1063,'3007775716',9,40,1,'2017-07-02 17:49:41',6216,NULL,NULL,'CELULAR',NULL,NULL),
  (1064,'AURORABELLA21@GMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6216,NULL,NULL,NULL,'GLADIS ARORA ABELLA SANDOVAL',NULL),
  (1065,'3188205800',9,40,1,'2017-07-02 17:49:41',6217,NULL,NULL,'CELULAR',NULL,NULL),
  (1066,'4883741',9,40,1,'2017-07-02 17:49:41',6217,NULL,NULL,'FIJO',NULL,NULL),
  (1067,'3591588',9,40,1,'2017-07-02 17:49:41',6217,NULL,NULL,'FIJO',NULL,NULL),
  (1068,'2514734',9,40,1,'2017-07-02 17:49:41',6218,NULL,NULL,'FIJO',NULL,NULL),
  (1069,'5261968',9,40,1,'2017-07-02 17:49:41',6218,NULL,NULL,'FIJO',NULL,NULL),
  (1070,'2514734',9,40,1,'2017-07-02 17:49:41',6218,NULL,NULL,'FIJO',NULL,NULL),
  (1071,'3142852739',9,40,1,'2017-07-02 17:49:41',6219,NULL,NULL,'CELULAR',NULL,NULL),
  (1072,'3132827683',9,40,1,'2017-07-02 17:49:41',6219,NULL,NULL,'CELULAR',NULL,NULL),
  (1073,'7020747',9,40,1,'2017-07-02 17:49:41',6219,NULL,NULL,'FIJO',NULL,NULL),
  (1074,'JUAN CMILO VASQUEZ FIGUEREDO',9,40,2,'2017-07-02 17:49:41',6219,'SE ENVIO CARTA DE NOTIFICACION AL CORREO','ALUMNO',NULL,NULL,NULL),
  (1075,'ELENA MILENA FIGUEREDO GONZALEZ',9,40,2,'2017-07-02 17:49:41',6219,'TIENE INMUEBLE EN VILLAVICENCIO','MAMA',NULL,NULL,NULL),
  (1076,'ELIANF@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6219,NULL,NULL,NULL,'ELENA MILENA FIGUEREDO GONZALEZ',NULL),
  (1077,'3208307461',9,40,1,'2017-07-02 17:49:41',6220,NULL,NULL,'CELULAR',NULL,NULL),
  (1078,'3124347129',9,40,1,'2017-07-02 17:49:41',6220,NULL,NULL,'CELULAR',NULL,NULL),
  (1079,'3164329491',9,40,1,'2017-07-02 17:49:41',6220,NULL,NULL,'CELULAR',NULL,NULL),
  (1080,'JUAN ALEXANDER BECERRA TRUJILLO',9,40,2,'2017-07-02 17:49:41',6220,'ICBF-TRASLADO SOCIAL','ALUMNO',NULL,NULL,NULL),
  (1081,'3205217068',9,40,1,'2017-07-02 17:49:41',6221,NULL,NULL,'CELULAR',NULL,NULL),
  (1082,'2056489',9,40,1,'2017-07-02 17:49:41',6221,NULL,NULL,'FIJO',NULL,NULL),
  (1083,'20564645',9,40,1,'2017-07-02 17:49:41',6221,NULL,NULL,'FIJO',NULL,NULL),
  (1084,'PALACIOS CASTILLO SANTIAGO',9,40,2,'2017-07-02 17:49:41',6221,'REMANENTES','R. LEGAL',NULL,NULL,NULL),
  (1085,'ALUCASTILLO@YAHOO.ES',NULL,40,3,'2017-07-02 17:49:41',6221,NULL,NULL,NULL,'ALBA CASTILLO PASTRANA ALBA',NULL),
  (1086,'6788070',9,40,1,'2017-07-02 17:49:41',6222,NULL,NULL,'FIJO',NULL,NULL),
  (1087,'3175737011',9,40,1,'2017-07-02 17:49:41',6222,NULL,NULL,'CELULAR',NULL,NULL),
  (1088,'3178616924',9,40,1,'2017-07-02 17:49:41',6222,NULL,NULL,'CELULAR',NULL,NULL),
  (1089,'CASTILLO RODRIGUEZ NATALIA ANDREA',9,40,2,'2017-07-02 17:49:41',6222,'TRABAJA EN EL COLEGIO VERMONT','MAMA',NULL,NULL,NULL),
  (1090,'NATALIASTRSS@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6222,NULL,NULL,NULL,'CASTILLO RODRIGUEZ NATALIA ANDREA',NULL),
  (1091,'CR 45  88 65 AP 2',9,40,4,'2017-07-02 17:49:41',6222,NULL,NULL,NULL,NULL,'CASA'),
  (1092,'TV 61A  41C 60 SUR',9,40,4,'2017-07-02 17:49:41',6222,NULL,NULL,NULL,NULL,'CASA'),
  (1093,'3187827570',9,40,1,'2017-07-02 17:49:41',6223,NULL,NULL,'CELULAR',NULL,NULL),
  (1094,'8794152',9,40,1,'2017-07-02 17:49:41',6223,NULL,NULL,'FIJO',NULL,NULL),
  (1095,'3012829950',9,40,1,'2017-07-02 17:49:41',6223,NULL,NULL,'CELULAR',NULL,NULL),
  (1096,'JUDITH GUALDRON VALDERRAMA',9,40,2,'2017-07-02 17:49:41',6223,'CAJICA ALCAPARRO CASA 70 RICARDO ALVARADO NOTARIA 29 CR 13#33','MAMA',NULL,NULL,NULL),
  (1097,'CLL 3  13160 IN 2 AP 206 CAJICA',9,40,4,'2017-07-02 17:49:41',6223,NULL,NULL,NULL,NULL,'CASA'),
  (1098,'3138727370',9,40,1,'2017-07-02 17:49:41',6224,NULL,NULL,'CELULAR',NULL,NULL),
  (1099,'3132534155',9,40,1,'2017-07-02 17:49:41',6224,NULL,NULL,'CELULAR',NULL,NULL),
  (1100,'5967766',9,40,1,'2017-07-02 17:49:41',6224,NULL,NULL,'FIJO',NULL,NULL),
  (1101,'MILENITARODRIGUEZ.GOMEZ@HOTMAIL.COM',NULL,40,3,'2017-07-02 17:49:41',6224,NULL,NULL,NULL,'ALBA MILENA RODRIGUEZ GOMEZ',NULL),
  (1102,'CLL 70A  8157',9,40,4,'2017-07-02 17:49:41',6224,NULL,NULL,NULL,NULL,'CASA'),
  (1104,'3142882270',9,40,1,'2017-07-02 17:49:41',6225,NULL,NULL,'CELULAR',NULL,NULL),
  (1105,'7797103',9,40,1,'2017-07-02 17:49:41',6225,NULL,NULL,'FIJO',NULL,NULL),
  (1106,'CLL 168 9 71 T3 APTO 301',9,40,4,'2017-07-02 17:49:41',6225,NULL,NULL,NULL,NULL,'CASA'),
  (1107,'CLL 18A  161 A 17 OF 201',9,40,4,'2017-07-02 17:49:41',6225,NULL,NULL,NULL,NULL,'OFICINA'),
  (1108,'3103155060',9,42,1,'2017-07-04 08:52:29',6099,NULL,NULL,'CELULAR ',NULL,NULL),
  (1109,'yusseff.1@hotmail.com',NULL,42,3,'2017-07-04 16:51:21',5373,NULL,NULL,NULL,'CORREO',NULL),
  (1110,'yusseff.1@hotmail.com',NULL,42,3,'2017-07-04 16:51:59',5373,NULL,NULL,NULL,'CORREO',NULL),
  (1111,'piolo8900@hotmail.com',NULL,42,3,'2017-07-04 17:13:11',5368,NULL,NULL,NULL,'CORREO',NULL),
  (1115,'pantera1318@hotmail.com',NULL,42,3,'2017-07-04 17:15:11',5368,NULL,NULL,NULL,'CORREO PERSONAL',NULL),
  (1116,'3146389423',1,40,1,'2017-07-05 08:39:02',5362,NULL,NULL,'CELULAR',NULL,NULL),
  (1117,'5897575',9,40,1,'2017-07-05 14:02:01',6227,NULL,NULL,'fijo',NULL,NULL),
  (1118,'8883257',9,40,1,'2017-07-05 14:02:01',6227,NULL,NULL,'fijo',NULL,NULL),
  (1120,'6003414',18,42,1,'2017-07-05 10:13:09',5368,NULL,NULL,'FIJO',NULL,NULL),
  (1121,'diagonal 34 No 5-43',9,41,4,'2017-07-05 10:13:52',6180,NULL,NULL,NULL,NULL,'oficina'),
  (1123,'3105761523',9,40,1,'2017-07-06 08:59:26',5365,NULL,NULL,'CELULAR',NULL,NULL),
  (1124,'2315020',9,42,1,'2017-07-06 11:17:52',5378,NULL,NULL,'FIJO',NULL,NULL),
  (1125,'3122598432',NULL,42,1,'2017-07-06 16:14:46',6094,NULL,NULL,'CELULAR',NULL,NULL),
  (1126,'3234499444',9,42,1,'2017-07-07 09:04:44',5367,NULL,NULL,'CELULAR',NULL,NULL),
  (1127,'3132490129',9,42,1,'2017-07-07 09:18:04',5379,NULL,NULL,'celular',NULL,NULL),
  (1128,'2753255',1,40,1,'2017-07-07 15:14:37',6229,NULL,NULL,'FIJO',NULL,NULL),
  (1129,'4449101',1,40,1,'2017-07-07 15:14:37',6229,NULL,NULL,'FIJO',NULL,NULL),
  (1130,'4517726',1,40,1,'2017-07-07 15:14:37',6229,NULL,NULL,'FIJO',NULL,NULL),
  (1131,'3137466380',1,40,1,'2017-07-07 17:20:52',6230,NULL,NULL,'CELULAR',NULL,NULL),
  (1133,'3183774935',9,42,1,'2017-07-07 13:32:56',5372,NULL,NULL,'celular',NULL,NULL),
  (1134,'3124804983',9,42,1,'2017-07-10 11:54:49',5570,NULL,NULL,'CELULAR ',NULL,NULL),
  (1135,'bboterof@gmail.com',NULL,42,3,'2017-07-11 09:37:04',5643,NULL,NULL,NULL,'BERNARDO BOTERO',NULL),
  (1136,'bboterof@gmail.com',NULL,42,3,'2017-07-11 09:37:26',5643,NULL,NULL,NULL,'BERNARDO BOTERO',NULL),
  (1138,'3013135142',1,40,1,'2017-07-11 09:45:34',5339,NULL,NULL,'CELULAR',NULL,NULL),
  (1139,'EDERMREC@HOTMAIL.COM',NULL,40,3,'2017-07-11 09:46:20',5339,NULL,NULL,NULL,'EDGAR EMILIO REMINCIO ',NULL),
  (1140,'2780868',20,42,1,'2017-07-11 09:53:09',5563,NULL,NULL,'FIJO',NULL,NULL),
  (1141,'LJSG.JOHANA@LIVE.COM',NULL,40,3,'2017-07-11 09:54:48',5354,NULL,NULL,NULL,'LUIS ARMANDO LOPEZ GIL ',NULL),
  (1143,'JHONJAIRO136@HOTMAIL.COM',NULL,40,3,'2017-07-11 10:08:23',5337,NULL,NULL,NULL,'JHON JAIRO TORRES ',NULL),
  (1144,'JHONJAIRO136@HOTMAIL.COM',NULL,40,3,'2017-07-11 10:08:23',5337,NULL,NULL,NULL,'JHON JAIRO TORRES ',NULL),
  (1145,'3134182078',20,42,1,'2017-07-11 10:09:50',5563,NULL,NULL,'CELULAR',NULL,NULL),
  (1147,'3418028',2,40,1,'2017-07-11 10:11:55',5353,NULL,NULL,'FIJO',NULL,NULL),
  (1148,'8691771',1,40,1,'2017-07-11 10:18:19',5335,NULL,NULL,'FIJO',NULL,NULL),
  (1149,'3106260196',1,40,1,'2017-07-11 10:26:12',5350,NULL,NULL,'CELULAR',NULL,NULL),
  (1154,'J10AVILA@GMAIL.COM',NULL,40,3,'2017-07-11 10:29:50',5350,NULL,NULL,NULL,'EYDIM JOHANA LOPEZ ',NULL),
  (1155,'8357470',1,40,1,'2017-07-11 10:38:26',5355,NULL,NULL,'FIJO',NULL,NULL),
  (1156,'CACG19@HOTMAIL.COM',NULL,40,3,'2017-07-11 10:40:15',5355,NULL,NULL,NULL,'CARLOS ANDRES CORREAN ',NULL),
  (1157,'CACG19@HOTMAIL.COM',NULL,40,3,'2017-07-11 10:40:15',5355,NULL,NULL,NULL,'CARLOS ANDRES CORREAN ',NULL),
  (1159,'ROGERLO19@HOTMAIL.COM',NULL,40,3,'2017-07-11 10:49:22',5365,NULL,NULL,NULL,'ROGER FRANCISCO LORA ',NULL),
  (1162,'7268318',1,40,1,'2017-07-11 10:53:06',5347,NULL,NULL,'FIJO',NULL,NULL),
  (1164,'3174327132',1,40,1,'2017-07-11 10:58:47',5364,NULL,NULL,'CELULAR ',NULL,NULL),
  (1166,'CARLOSMANUELGONZALEZ@HOTMAIL.COM',NULL,40,3,'2017-07-11 11:00:07',5364,NULL,NULL,NULL,'LA GRAN TIENDA DISTRIBUCIONES ',NULL),
  (1167,'3204610057',1,40,1,'2017-07-11 11:15:54',5363,NULL,NULL,'CELULAR',NULL,NULL),
  (1168,'ELIZABETH NIÑO ',1,40,2,'2017-07-11 11:05:28',5363,NULL,'REPRESENTANTE LEGAL ',NULL,NULL,NULL),
  (1170,'SISTEMASYNEGOCIOS@YAHOO.ES',NULL,40,3,'2017-07-11 11:08:53',5345,NULL,NULL,NULL,'MARIA TERESA PAMPLONA ',NULL),
  (1171,'4448777',1,40,1,'2017-07-11 11:12:45',5362,NULL,NULL,'FIJO',NULL,NULL),
  (1173,'DIRECCIONCOMERCIAL@TRANSPORTEELTESORO.COM',NULL,40,3,'2017-07-11 11:14:27',5362,NULL,NULL,NULL,'COMERCIALIZADORA EL TESORO',NULL),
  (1175,'PAULA1730@OUTLOOK.ES',NULL,40,3,'2017-07-11 11:18:46',5344,NULL,NULL,NULL,'ANA DILIA GONZALES ',NULL),
  (1177,'3205316567',1,40,1,'2017-07-11 11:22:40',5361,NULL,NULL,'CELULAR ',NULL,NULL),
  (1178,'LAAERENOSADISTRIBUIDORADELACOSTA@HOTMAIL.COM',NULL,40,3,'2017-07-11 11:24:20',5361,NULL,NULL,NULL,'CELK MERCADEO INVERSIONES ',NULL),
  (1180,'WERNEY1804@HOTMAIL.COM',NULL,40,3,'2017-07-11 11:31:19',5360,NULL,NULL,NULL,'HENRY WERNEY  ACEVEDO ',NULL),
  (1181,'4022237',9,40,1,'2017-07-11 11:33:01',5360,NULL,NULL,'FIJO ',NULL,NULL),
  (1182,'elibuitrago@gmail.com',NULL,42,3,'2017-07-11 16:38:04',5596,NULL,NULL,NULL,'correo ',NULL),
  (1183,'mvasquez@caribbeanresources.co',NULL,42,3,'2017-07-11 16:57:11',5582,NULL,NULL,NULL,'CORREO',NULL),
  (1184,'mvasquez@caribbeanresources.co',NULL,42,3,'2017-07-11 16:57:28',5582,NULL,NULL,NULL,'CORREO',NULL),
  (1186,'centalssas@gmail.com',NULL,42,3,'2017-07-11 17:15:24',5623,NULL,NULL,NULL,'CORREO ',NULL),
  (1187,'avivamientosiglo21@yahoo.com',NULL,42,3,'2017-07-11 17:15:39',5623,NULL,NULL,NULL,'CORREO2',NULL),
  (1188,'6242449',2,42,1,'2017-07-11 17:16:10',5623,NULL,NULL,'FIJO',NULL,NULL),
  (1191,'CL 19 10 15 BRR MORICHAL',13,42,4,'2017-07-11 17:17:27',5623,NULL,NULL,NULL,NULL,'DIRECCION '),
  (1192,'CARR 11 21 30 ',13,42,4,'2017-07-11 17:18:13',5623,NULL,NULL,NULL,NULL,'DIRECCION'),
  (1193,'johannalp14@hotmail.com',NULL,42,3,'2017-07-12 11:57:34',6082,NULL,NULL,NULL,'CORREO',NULL),
  (1194,'5983685',9,40,1,'2017-07-12 15:39:52',5354,NULL,NULL,'fijo',NULL,NULL),
  (1195,'3043979613',9,40,1,'2017-07-12 16:22:53',5349,NULL,NULL,'CELULAR ',NULL,NULL),
  (1196,'YBALVARADOM@HOTMAIL.COM',NULL,40,3,'2017-07-12 16:23:41',5349,NULL,NULL,NULL,'ALVARADO MEJIA YOLETH BRATIZ ',NULL),
  (1198,'CROWNLUISS@HOTMAIL.COM',NULL,40,3,'2017-07-12 16:24:09',5349,NULL,NULL,NULL,'ALVARADO MEJIA YOLETH BRATIZ ',NULL),
  (1199,'CLL 51 N 46-75 APTO 201',1,40,4,'2017-07-12 16:43:28',6229,NULL,NULL,NULL,NULL,'APARTAMENTO '),
  (1200,'2065175',1,40,1,'2017-07-12 16:45:12',6229,NULL,NULL,'FIJO',NULL,NULL),
  (1201,'3008595879',9,40,1,'2017-07-13 15:34:42',6231,NULL,NULL,'CELULAR',NULL,NULL),
  (1202,'6351055',9,40,1,'2017-07-13 15:34:42',6231,NULL,NULL,'FIJO',NULL,NULL),
  (1203,'2913111',NULL,40,1,'2017-07-13 15:34:42',6231,NULL,NULL,'FIJO',NULL,NULL),
  (1204,'WILLIAM BUSTOS ACERO',NULL,40,2,'2017-07-13 15:34:42',6231,'ESPOSO DE LA DEUDORA','ESPOSO ',NULL,NULL,NULL),
  (1208,'ISABELL CORREA ',9,40,2,'2017-07-13 10:56:45',6227,'MADRE DEL DEUDOR MANIFIESTA QUE NO TIENE NADA QUE VER CON LA DEUDA, PERO QUE HARÁ LO POSIBLE PARA COMUNICARLE AL HIJO Y QUE CANCEL LA DEUDA PENDIENTE. ','MADRE ',NULL,NULL,NULL),
  (1209,'4764916',9,40,1,'2017-07-13 16:30:31',6232,NULL,NULL,'FIJO',NULL,NULL),
  (1210,'4674916',9,40,1,'2017-07-13 16:30:31',6232,NULL,NULL,'FIJO',NULL,NULL),
  (1211,'5678633',9,40,1,'2017-07-13 16:30:31',6232,NULL,NULL,'FIJO',NULL,NULL),
  (1212,'2958675',9,40,1,'2017-07-13 16:30:31',6233,NULL,NULL,'FIJO',NULL,NULL),
  (1213,'3052333295',9,40,1,'2017-07-13 16:30:31',6233,NULL,NULL,'CELULAR',NULL,NULL),
  (1215,'OVIDIO CANACUE ',9,40,2,'2017-07-13 16:30:31',6233,'CONYUGUE DE LA CODEUDORA ','ESPOSO ',NULL,NULL,NULL),
  (1216,'6474468',9,40,1,'2017-07-13 16:30:31',6234,NULL,NULL,'FIJO',NULL,NULL),
  (1217,'3112312970',9,40,1,'2017-07-13 16:30:31',6234,NULL,NULL,'CELULAR',NULL,NULL),
  (1218,'3430430',9,40,1,'2017-07-13 16:30:31',6234,NULL,NULL,'FIJO',NULL,NULL),
  (1219,'RAFAEOL SANABRIA',9,40,2,'2017-07-13 16:30:31',6234,'ESPOSO DE LA DEUDORA','ESPOSO ',NULL,NULL,NULL),
  (1220,'6698766',9,40,1,'2017-07-13 16:30:31',6235,NULL,NULL,'FIJO',NULL,NULL),
  (1221,'3153070023',9,40,1,'2017-07-13 16:30:31',6235,NULL,NULL,'CELULAR',NULL,NULL),
  (1222,'JAIRO NELSON MARTINEZ ',9,40,2,'2017-07-13 16:30:31',6235,'PAREJA DE LA CODEUDORA ','ESPOSO ',NULL,NULL,NULL),
  (1223,'2728777',NULL,40,1,'2017-07-13 17:02:48',6236,NULL,NULL,'FIJO',NULL,NULL),
  (1224,'2629613',NULL,40,1,'2017-07-13 17:17:04',6237,NULL,NULL,'FIJO',NULL,NULL),
  (1225,'GENAROPINILLA@GMAIL.COM',NULL,40,3,'2017-07-13 17:17:04',6237,NULL,NULL,NULL,'MERCADO ZAPATOCA S.A ',NULL),
  (1226,'3145373680',9,40,1,'2017-07-13 16:53:45',5351,NULL,NULL,'CELULAR ',NULL,NULL);
COMMIT;

#
# Data for the `demographics` table  (LIMIT 500,500)
#

INSERT INTO `demographics` (`idDemographic`, `value`, `idCity`, `idAdviser`, `idType`, `dCreation`, `idWallet`, `comment`, `relationshipType`, `phoneType`, `contactName`, `addressType`) VALUES 
  (1228,'3128839692',9,40,1,'2017-07-13 16:58:00',5351,NULL,NULL,'CELULAR',NULL,NULL),
  (1230,'GILMEYUGAKY@HOTMAIL.COM',NULL,40,3,'2017-07-13 16:59:51',5351,NULL,NULL,NULL,'MINI MERCADO SPRES',NULL),
  (1231,'3611028',1,40,1,'2017-07-14 13:53:41',6238,NULL,NULL,'FIJO',NULL,NULL),
  (1232,'3661489',1,40,1,'2017-07-14 13:53:41',6238,NULL,NULL,'FIJO',NULL,NULL),
  (1233,'jthm93@gmail.com',NULL,42,3,'2017-07-14 09:00:11',5370,NULL,NULL,NULL,'CORREO',NULL),
  (1234,'jthm93@gmail.com',NULL,42,3,'2017-07-14 09:00:37',5370,NULL,NULL,NULL,'CORREO',NULL),
  (1235,'320202370',9,41,1,'2017-07-14 09:19:46',5421,NULL,NULL,'CELULAR',NULL,NULL),
  (1236,'DOTACIONESVELANDIA@HOTMAIL.COM',NULL,41,3,'2017-07-14 09:50:35',5524,NULL,NULL,NULL,'DOTACIONES VELANDIA ',NULL),
  (1239,'6593453',9,41,1,'2017-07-14 10:11:10',5527,NULL,NULL,'FIJO',NULL,NULL),
  (1240,'CARRERA  17 # 35-51 PLAZA CENTRO LOCAL 167',9,41,4,'2017-07-14 10:12:24',5527,NULL,NULL,NULL,NULL,'CASA DE DONDE VIVE EL DEUDOR '),
  (1241,'CARRERA  17 # 35-51 PLAZA CENTRO LOCAL 167',9,41,4,'2017-07-14 10:12:24',5527,NULL,NULL,NULL,NULL,'CASA DE DONDE VIVE EL DEUDOR '),
  (1243,'5847510',15,41,1,'2017-07-14 10:23:19',5504,NULL,NULL,'FIJO',NULL,NULL),
  (1245,'2015121',15,41,1,'2017-07-14 10:24:02',5504,NULL,NULL,'FIJO',NULL,NULL),
  (1246,'MAKANO_2297@HOTMAIL.COM',NULL,41,3,'2017-07-14 10:25:50',5504,NULL,NULL,NULL,'BONILLA FERNANDO ',NULL),
  (1247,'MAKANO_2297@HOTMAIL.COM',NULL,41,3,'2017-07-14 10:25:50',5504,NULL,NULL,NULL,'BONILLA FERNANDO ',NULL),
  (1249,'8843503',9,41,1,'2017-07-14 10:40:30',5465,NULL,NULL,'FIJO',NULL,NULL),
  (1250,'3218009464',9,41,1,'2017-07-14 10:41:06',5465,NULL,NULL,'CELULAR',NULL,NULL),
  (1251,'CALLE 13 N 6-73 CALI',21,41,4,'2017-07-14 10:42:10',5465,NULL,NULL,NULL,NULL,'RESIDENCIA '),
  (1252,'4000450',9,41,1,'2017-07-14 10:48:55',5422,NULL,NULL,'FIJO',NULL,NULL),
  (1253,'4000450',9,41,1,'2017-07-14 10:48:55',5422,NULL,NULL,'FIJO',NULL,NULL),
  (1254,'3208251312',9,41,1,'2017-07-14 10:56:20',6233,NULL,NULL,'celular',NULL,NULL),
  (1255,'3204111107',9,41,1,'2017-07-14 11:01:24',6234,NULL,NULL,'celular',NULL,NULL),
  (1256,'3057103483',9,41,1,'2017-07-14 12:15:02',6225,NULL,NULL,'celular',NULL,NULL),
  (1257,'3214517234',9,40,1,'2017-07-14 17:46:20',6239,NULL,NULL,'CELULAR ',NULL,NULL),
  (1258,'3118811466',9,40,1,'2017-07-14 17:46:20',6239,NULL,NULL,'CELULAR',NULL,NULL),
  (1259,'MARIA DEL ROSARIO GAVIRIA',9,40,2,'2017-07-14 17:46:20',6239,'ESPOSA DEL DEUDOR','ESPOSA',NULL,NULL,NULL),
  (1260,'3214517234',9,40,1,'2017-07-14 17:46:20',6240,NULL,NULL,'CELULAR ',NULL,NULL),
  (1261,'3118811466',9,40,1,'2017-07-14 17:46:20',6240,NULL,NULL,'CELULAR',NULL,NULL),
  (1262,'MARIA DEL ROSARIO GAVIRIA',9,40,2,'2017-07-14 17:46:20',6240,'ESPOSA DEL DEUDOR','ESPOSA',NULL,NULL,NULL),
  (1263,'3214517234',9,40,1,'2017-07-14 17:50:26',6241,NULL,NULL,'CELULAR ',NULL,NULL),
  (1264,'3118811466',9,40,1,'2017-07-14 17:50:26',6241,NULL,NULL,'CELULAR',NULL,NULL),
  (1265,'MARIA DEL ROSARIO GAVIRIA',9,40,2,'2017-07-14 17:50:26',6241,'ESPOSA DEL DEUDOR','ESPOSA',NULL,NULL,NULL),
  (1266,'3214517234',9,40,1,'2017-07-14 17:50:26',6242,NULL,NULL,'CELULAR ',NULL,NULL),
  (1267,'3118811466',9,40,1,'2017-07-14 17:50:26',6242,NULL,NULL,'CELULAR',NULL,NULL),
  (1268,'MARIA DEL ROSARIO GAVIRIA',9,40,2,'2017-07-14 17:50:26',6242,'ESPOSA DEL DEUDOR','ESPOSA',NULL,NULL,NULL),
  (1269,'3214517234',9,40,1,'2017-07-14 17:53:56',6243,NULL,NULL,'CELULAR ',NULL,NULL),
  (1270,'3118811466',9,40,1,'2017-07-14 17:53:56',6243,NULL,NULL,'CELULAR',NULL,NULL),
  (1271,'MARIA DEL ROSARIO GAVIRIA',9,40,2,'2017-07-14 17:53:56',6243,'ESPOSA DEL DEUDOR','ESPOSA',NULL,NULL,NULL),
  (1272,'73336082',15,40,1,'2017-07-17 09:34:38',5408,NULL,NULL,'FIJO',NULL,NULL),
  (1273,'WAIMEAL5880@GMAIL.COM',NULL,40,3,'2017-07-17 09:35:37',5408,NULL,NULL,NULL,'PEREZ MORENO WAYNE ALBERTO  ',NULL),
  (1274,'WAIMEAL5880@GMAIL.COM',NULL,40,3,'2017-07-17 09:35:37',5408,NULL,NULL,NULL,'PEREZ MORENO WAYNE ALBERTO  ',NULL),
  (1275,'3008099677',9,40,1,'2017-07-17 10:13:02',5463,NULL,NULL,'celular ',NULL,NULL),
  (1277,'3163228733',21,40,1,'2017-07-17 10:21:30',5463,NULL,NULL,'CELULAR ',NULL,NULL),
  (1278,'3188159145',18,40,1,'2017-07-17 10:52:14',5528,NULL,NULL,'CELULAR ',NULL,NULL),
  (1280,'danipente75@yahoo.es',NULL,40,3,'2017-07-17 10:53:38',5528,NULL,NULL,NULL,'DANIEL RIVERO ',NULL),
  (1281,'MSDA132607@GMAIL.COM',NULL,40,3,'2017-07-17 11:35:14',5526,NULL,NULL,NULL,'DOTASUROESTE',NULL),
  (1283,'2627312',9,40,1,'2017-07-17 11:45:21',5526,NULL,NULL,'FIJO',NULL,NULL),
  (1284,'KR 68 4 SUR 49',9,40,4,'2017-07-17 11:56:41',5526,NULL,NULL,NULL,NULL,'ESTACION COMERCIAL '),
  (1285,'KR 68 4 SUR 49',9,40,4,'2017-07-17 11:56:41',5526,NULL,NULL,NULL,NULL,'ESTACION COMERCIAL '),
  (1286,'dotacionesdelsuroeste@hotmail.com',NULL,40,3,'2017-07-17 11:58:48',5526,NULL,NULL,NULL,'DOTASUROESTE SAS',NULL),
  (1287,'3182095879',1,40,1,'2017-07-18 19:59:08',6247,NULL,NULL,'CELULAR',NULL,NULL),
  (1288,'4065142',9,40,1,'2017-07-19 09:01:30',5478,NULL,NULL,'FIJO',NULL,NULL),
  (1289,'3122449809',1,40,1,'2017-07-19 15:23:55',6248,NULL,NULL,'CELULAR',NULL,NULL),
  (1290,'KR 68 4 SUR 49',9,40,4,'2017-07-19 12:00:38',5429,NULL,NULL,NULL,NULL,'CASA'),
  (1291,'dotacionesdelsuroeste@hotmail.com',NULL,40,3,'2017-07-19 12:01:25',5429,NULL,NULL,NULL,'LEON AZA GRACIELA',NULL),
  (1292,'CALLE 41 6-86 EN IBAGUE',20,40,4,'2017-07-19 12:33:32',5412,NULL,NULL,NULL,NULL,'CASA'),
  (1293,'3042081658',9,40,1,'2017-07-19 14:31:28',5466,NULL,NULL,'CELULAR',NULL,NULL),
  (1294,'5954911',9,40,1,'2017-07-19 19:36:44',6257,NULL,NULL,'FIJO',NULL,NULL),
  (1295,'MANUEL ESPEJO ',NULL,40,2,'2017-07-19 19:36:44',6257,'3174035732','REPRESENTANTE LEGAL ',NULL,NULL,NULL),
  (1296,'6374766',NULL,40,1,'2017-07-19 19:36:44',6258,NULL,NULL,'FIJO',NULL,NULL),
  (1297,'OLGA DISLEY ',NULL,40,2,'2017-07-19 19:36:44',6258,'3108025797','REPRESENTANTE LEGAL ',NULL,NULL,NULL),
  (1298,'contabilidadvvc@hotmail.com',NULL,40,3,'2017-07-19 19:36:44',6258,NULL,NULL,NULL,'REPRESENTANTE LEGAL',NULL),
  (1299,'3015197000',9,42,1,'2017-07-19 16:28:10',6251,NULL,NULL,'CALULAR',NULL,NULL),
  (1300,'2306565',9,40,1,'2017-07-21 14:25:43',5493,NULL,NULL,'FIJO',NULL,NULL),
  (1301,'3202337164',9,42,1,'2017-07-21 15:20:18',5368,NULL,NULL,'celular',NULL,NULL),
  (1302,'levs-77@hotmail.com',NULL,40,3,'2017-07-21 17:12:27',5409,NULL,NULL,NULL,'RAUL SUAREZ',NULL),
  (1304,'6919504',1,40,1,'2017-07-24 09:29:20',5494,NULL,NULL,'FIJO',NULL,NULL),
  (1305,'3203723127',9,44,1,'2017-07-24 09:34:08',5369,NULL,NULL,'CELULAR ',NULL,NULL),
  (1306,'COMERCIALIZADORA.YA@HOTMAIL.COM',NULL,44,3,'2017-07-24 09:34:42',5369,NULL,NULL,NULL,'CARLOS PADILLA',NULL),
  (1307,'6824456',21,40,1,'2017-07-24 10:17:02',5416,NULL,NULL,'FIJO',NULL,NULL);
COMMIT;

#
# Data for the `wallets_tempo` table  (LIMIT 0,500)
#

INSERT INTO `wallets_tempo` (`id`, `idNumber`, `capitalValue`, `legalName`, `address`, `phone`, `email`, `ciudad`, `idStatus`, `product`, `idAdviser`, `validThrough`, `accountNumber`, `idCampaign`, `migrate`, `lote`, `titleValue`, `typePhone1`, `countryPhone1`, `cityPhone1`, `phone1`, `typePhone2`, `countryPhone2`, `cityPhone2`, `phone2`, `typePhone3`, `countryPhone3`, `cityPhone3`, `phone3`, `nameReference1`, `relationshipReferenc1`, `countryReference1`, `cityReference1`, `commentReference1`, `nameReference2`, `relationshipReference2`, `countryReference2`, `cityReference2`, `commentReference2`, `nameReference3`, `relationshipReference3`, `countryReference3`, `cityReference3`, `commentReference3`, `nameEmail1`, `email1`, `nameEmail2`, `email2`, `nameEmail3`, `email3`, `typeAddress1`, `address1`, `countryAdrress1`, `cityAddress1`, `typeAddress2`, `address2`, `countryAddress2`, `cityAddress2`, `typeAddress3`, `address3`, `countryAddress3`, `cityAddress3`, `typeAsset1`, `nameAsset1`, `commentAsset1`, `typeAsset2`, `nameAsset2`, `commentAsset2`, `typeAsset3`, `nameAsset3`, `commentAsset3`) VALUES 
  (1,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',94,0,'1505493535',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (2,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',95,0,'1505504708',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (3,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',96,0,'1505508025',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (4,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',97,0,'1505508483',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (5,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',98,0,'1505508491',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (6,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',101,0,'1505510171',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (7,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',102,0,'1505510225',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (8,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',103,0,'1505744563',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (9,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',104,0,'1505745617',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (10,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',106,0,'1505746776',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (11,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',109,0,'1505747207',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (12,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',110,0,'1505747213',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (13,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',111,0,'1505747363',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (14,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',112,0,'1505747423',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (15,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',113,0,'1505748195',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (16,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',114,0,'1505748303',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (17,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',115,0,'1505748697',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (18,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',116,0,'1505748748',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (19,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',117,0,'1505765658',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (20,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',94,0,'1505493535',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (21,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',95,0,'1505504708',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (22,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',96,0,'1505508025',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (23,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',97,0,'1505508483',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (24,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',98,0,'1505508491',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (25,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',101,0,'1505510171',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (26,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',102,0,'1505510225',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (27,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',103,0,'1505744563',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (28,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',104,0,'1505745617',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (29,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',106,0,'1505746776',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (30,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',109,0,'1505747207',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (31,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',110,0,'1505747213',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (32,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',111,0,'1505747363',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (33,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',112,0,'1505747423',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (34,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',113,0,'1505748195',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (35,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',114,0,'1505748303',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (36,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',115,0,'1505748697',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (37,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',116,0,'1505748748',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (38,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',117,0,'1505765658',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (39,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',118,0,'1505842833',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (40,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',118,0,'1505842833',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (41,'100',120000000,'winlmar andres','k10','312 123 2332','wilmar.ig@gmail.com','cartago',1,'plan movil',0,'0000-00-00','',119,0,'1505850616',NULL,'212','1233','1231','1221','12','123','121','1122','123','232','23','233','22','mama','co','va','nin','wi','papa','co','va','bnib','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (42,'123',855000,'andrers','Cll 4','312 785 2526','andres@email.com','cartago',1,'plan movil',0,'0000-00-00','',119,0,'1505850616',NULL,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (110,'1058228762',18919097,'MAYERLY ANDREA ARREDONDO','CARRERA 13 No 4 25','8598030','mayerly589@gmail.com','Bogota',1,'BIENES',99,'2015-05-25','18119',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (111,'1094905106',3570000,'JULIO CESAR OCAMPO','ETAPA5 MZ P CASA406B','7343719','juliocastro.1905@outlook.es','Bogota',1,'BIENES',99,'2016-05-17','18063',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (112,'15621888',4096516,'GOMEZ ZULUAGA CARLOS ADRIAN','CL 4 6 95 SEC EL CENTRO','3148789616','AYGX100PRE22 @HOTMAIL.COM','Bogota',1,'BIENES',99,'2015-01-08','17845',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (113,'24727469',18671861,'ANA DILIA GONZALEZ','CRR 17 No 12 10','3215675455','comercialocomed@gmail.com','Bogota',1,'BIENES',99,'2015-11-05','18038',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (114,'35262461',3130112,'MARIA TERESA PAMPLONA','CLL 2B N 34 30 CASA','3142180011','','Bogota',1,'BIENES',99,'2015-03-26','18075',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (115,'36181353',40032785,'RINCON CUARTAS AMPARO DEL SOCORRO','CRA 21 N13 21','5200734','MARIA.TRIJULLO@ALIANZAFARMACEUTICA.COM','Bogota',5,'BIENES',99,'2016-03-02','12450',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (116,'3906324',30486578,'JONATHAN DAVID MARTINEZ CORREA','CR 22 No 17 32','3017661890','jonathan_siervo@hotmail.com?','Bogota',5,'BIENES',99,'2015-04-13','14398',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (117,'40341277',4790083,'SILVA QUICENO LAURA HELENA','CL 9 20 26','3105761523','cato.73@hotmail.com','Bogota',1,'BIENES',99,'2015-10-31','16027',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (118,'55304037',39814528,'EYDIM JOHANA LOPEZ','CARRERA 15 No 10 15','3005280134','JHONL2324@HOTMAIL.COM','Bogota',1,'BIENES',99,'2016-05-12','18060',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (119,'63252389',12984261,'HERNANDEZ LEMA MARIA EUGENIA','CARRERA 4a No 28 32','3206668115','frutifreshna@gmail.com','Bogota',5,'BIENES',99,'2016-04-29','18064',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (120,'70290904',5041685,'LUIS ARMANDO LOPEZ GIL','CRA 42A N 296A SUR  168 INT 301','3007114880','','Bogota',1,'BIENES',99,'2016-05-24','18024',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (121,'71363170',10396425,'CARLOS ANDRES CORREAN','CLL 21  21 31 SAN CARLOS','3174596915','EWILADU84@YAHOO.ES','Bogota',2,'BIENES',99,'2015-11-23','12045',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (122,'71767082',3912231,'TOBON PUERTA DUVIAN MANUEL','CLL 56 N 50 145','2310924','','Bogota',1,'BIENES',99,'2015-05-05','17189',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (123,'72040948',2366290,'MIGUEL ANGEL GIRALDO QUINTERO','CLL 17 N 4 49','3165268853','VELMAR_711@GMAIL.COM','Bogota',1,'BIENES',99,'2016-04-19','18023',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (124,'73548726',51530891,'JHON JAIRO BUELVAS MALO','FUNDACION','3126955201','','Bogota',1,'BIENES',99,'2015-04-30','18071',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (125,'77181497',19800000,'CARLOS SILVA DISTRIBUCIONES','CRA 166 N 23 32 BRR SIMON BOLIVAR  CLL 16B CRA 8','3116829528','CARLOSSOLVAZULETA@HOTMAIL.COM','Bogota',5,'BIENES',99,'2015-08-13','10256',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (126,'80236620',5885735,'HENRY WERNEY ACEVEDO CASTELLANOS','CALLE 54 C SUR 95 A 18','3114844664','PAPELERIAUNIMAGIC@HOTMAIL.COM','Bogota',1,'BIENES',99,'2016-12-31','14344',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (127,'900206882',54257127,'CELK MERCADEO INVERSIONES E U','CLL 12B 1661 APTO 1','3205316568','CELKHERNANDEO@HOTMAIL.COM','Bogota',5,'BIENES',99,'2016-12-31','18033',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (128,'900333984',2000000,'TRANSPORTES EL TESORO SAS','CLL 40 E SUR 32 26','3217278014','LEIDYC.LAR@GMAIL.COM','Bogota',1,'BIENES',99,'2015-12-26','12356',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (129,'900439707',110831798,'COMERCIALIZADORA ICE CITY','AVENIDA 42 N 30 B 21','6829492','comercializadoraicecity@hotmail.com','Bogota',2,'BIENES',99,'2016-02-01','18132',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (130,'900872915',45116164,'LA GRAN TIENDA DISTRUBUCIONES SAS','KILIMETRO 7 VIA GIRON  CRR 13 N5779','6199174','','Bogota',5,'BIENES',99,'2015-12-31','17007',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (131,'92521535',17450155,'LORA ALVAREZ ROGER FRANCISCO','CLL  30 27 08','3226509223','','Bogota',1,'BIENES',99,'2016-04-07','17087',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (132,'1020802265',1710137,'SANCHEZ GOMEZ YULI KATHERIN','CRA 65 57F 51 SUR','3103446771','katerins23@hotmail.com','Bogota',1,'BIENES',99,'2015-11-28','24020675',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (133,'10544341',12371031,'VELASCO MU¾OZ JOHN CARLOS','CRA 27 No. 35 33','3173430578','jamolina @uniquindio.edu.co','Bogota',5,'BIENES',99,'2014-02-21','50780',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (134,'1073151191',714373,'JHON FREDY VIZCAINO MORALES','CRA 30 74 -64','3202337169','','Bogota',1,'BIENES',99,'2015-09-12','27020110',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (135,'11408647',9725543,'CARLOS HUMBERTO PADILLA NEIRA','CRA 13 N 14 60 LOCAL 1','3203723127','','Bogota',5,'BIENES',99,'2014-01-25','24020476',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (136,'19287321',5034338,'ESTUPI¾AN ROJAS JOSE ANTONIO','CL 43 No. 6 12','3212326383','paniicadorasanantoniotunja@yahoo.es','Bogota',1,'BIENES',99,'2016-12-18','24020368',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (137,'23810227',1743285,'RINCON YARA ELIZABETH','CL 23 No. 05 L 01','3142296339','','Bogota',1,'BIENES',99,'2015-04-27','24020723',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (138,'63558582',1469096,'ARGUELLO CERPA ERIKA','CR 22 NO 46 B-08','6942412','ecosandeliciosopan@yahoo.com','Bogota',1,'BIENES',99,'2016-01-10','27020223',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (139,'7456345',27270861,'VARGAS ESPINOSA JAIME ARTURO','CRA 6 No. 19 A 48','301686356','distribucionesjr@hotmail.com','Bogota',5,'BIENES',99,'2016-07-14','436142',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (140,'79209103',3572794,'VASQUEZ LADINO PABLO CESAR','CL 57B No. 68A 29 SUR','3126699411','carmeng710@hotmail.com','Bogota',1,'BIENES',99,'2015-08-30','24020038',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (141,'80450756',649431,'MARTINEZ GIL HILDA','CR 68B 67 01 BELLAVISTA','3115810218','nelsonbarbosa276@gmail.com','Bogota',1,'BIENES',99,'2015-08-25','24020253',99,0,'NOW',NULL,'3','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (142,'900173510',7551500,'DISTRIBUIDORA BOGOTA TCB LTDA','CL 03 No. C 9 76','3132490129','pabloemendezt@hotmail.com','Bogota',1,'BIENES',99,'2014-12-30','884301',99,0,'NOW',NULL,'4','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (143,'9002785927',25483827,'JHON ARLISON CHAPPARRO LEON','CR 7 No.19A-40','5714051','inversionesfavipan@hotmail.com','Bogota',1,'BIENES',99,'2016-07-13','14273',99,0,'NOW',NULL,'2','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (144,'900353794',19439608,'INDUSTRIAS INDUPAN SAS','CL 44 No. 18D 100','3135446629','inversionesfavipan@hotmail.com','Bogota',5,'BIENES',99,'2012-01-21','50020030',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (145,'900412995',5570588,'TYS PET SAS','CRA 7 No. 16 78 LC 1021','3155564764','amesotom@hotmail.com','Bogota',1,'BIENES',99,'2014-10-01','50791',99,0,'NOW',NULL,'4','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (146,'94529101',2500000,'JOSE RAUL HENAO SOTO','CRA 10 No. 1 295','3113512484','','Bogota',1,'BIENES',99,'2016-04-29','25020065',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (147,'22518962',7071000,'COMERCIALIZADORA GAMOPE SAS','MZ F CASA 14 URB VILLA DEL MAR','3008426790','kjperea45@hotmail.com','Bogota',1,'BIENES',99,'2014-09-15','14439',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (148,'900240160',2000000,'CORPORACION AGENCIA DE DESARROLLO ECONOMICO LOCAL DEL COMPLEJO CENAGOSO DE LA ZAPATOSA','CRA 19  A2  10 20','3205112555','njudithramirez@hotmail.com','Bogota',1,'BIENES',99,'2015-09-16','14472',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (149,'1013598482',8751034,'DIEGO ARMANDO ROCHA MORCOTE','CL 58 SUR 19 A 15 IN 9','4518414','','Bogota',1,'SERVICIO',99,'2013-07-28','14587',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (150,'1020420118',11424768,'MESA GALVIS DIOVER JOHAN','CALLE 33 F No 19 63','2796417','','Bogota',1,'SERVICIO',99,'2015-06-15','14822',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (151,'10262979',1178239,'FRANCISCO JAVIER BERNAL','CALLE 34 No 11 37 43','3142510436','luzkarina-310@hotmail com','Bogota',1,'SERVICIO',99,'2012-02-24','14612',99,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (152,'1033688233',11665825,'CORDOBA  MORENO  ANDERSON STEVEN','CL 22  12 12','4422762','','Bogota',1,'SERVICIO',99,'2015-06-15','14809',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (153,'106260265',48562412,'ANDRES FELIPE RENDON RAMIREZ','CALLE 12 No   13 69 LC 107','3106196420','','Bogota',1,'SERVICIO',99,'2014-07-22','14645',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (154,'1089479999',3548206,'CARLOS ALBERTO MUOZ MARTINEZ','CL 16 No 4 12','3166549351','','Bogota',1,'SERVICIO',99,'2013-03-30','14589',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (155,'1090399095',3137416,'SUAREZ CHACON RICARDO ANDRES','CALLE 22  No 3 9','3208107011','','Bogota',1,'SERVICIO',99,'2015-06-15','14889',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (156,'1090415807',6664346,'ANYI VANESA GRIMALDO COLLANTES','CLL 65B   4C 09 L 08 09','5873283','','Bogota',1,'SERVICIO',99,'2013-05-12','14750',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (157,'1093763522',5899588,'BOTERO RINCON JOSE AICARDO','CLL 7   11   63','6489526','','Bogota',1,'SERVICIO',99,'2015-06-15','14878',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (158,'1094893614',31168874,'ARBELAEZ  OSPINA QUELIN JULIETH','CALLE 45 No 1 0  CASA 10','6523342','','Bogota',1,'SERVICIO',99,'2015-06-15','14832',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (159,'1095816722',3717398,'CALDERON CASTELLANOS RICARDO ANDRES','CALLE 90 No 21 87   CALLE 105A No 21 30','6943680','','Bogota',2,'SERVICIO',99,'2013-10-05','13958',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (160,'1095909642',749000,'ERICKA PAOLA REMOLINA FLORES','MZ 1 CA 1 LOS MANDARINOS','2778261','','Bogota',1,'SERVICIO',99,'2013-09-26','14622',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (161,'1098648945',9792254,'VILLAMIZAR JULIO CESAR','CL 59  49 55','3014818314','','Bogota',1,'SERVICIO',99,'2013-03-15','14024',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (162,'12229677',2000001,'ARBEY SARRIA GOMEZ','CARRERA 1 No 74 36','3107876627','ESKNDALO2005@HOTMAIL COM','Bogota',1,'SERVICIO',99,'2014-11-16','14613',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (163,'12277317',11005398,'CARLOS ARTURO SANCHEZ CERQUERA','CRA 12 No 1B 41','2735975','dianita1023@hotmail com','Bogota',1,'SERVICIO',99,'2014-07-22','14644',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (164,'13259470',6828874,'CARDENAS JESUS MARIA','AV 5 No 18 40','3145559670','wayneal5880@gmail com','Bogota',1,'SERVICIO',99,'2014-01-20','14827',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (165,'13364909',33425799,'AREVALO RINCON LUIS ENRRIQUE','AV 7 No 15 36','3106139132','dgconfeccionesjz@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14896',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (166,'13387168',15241252,'PEDRO ANTONIO BOLIVAR OMAóA','CALLE 32 No 6B 46  CALLE 12 No 8 81  ETAPA ATALAYA','5787931','SAMUEL02029@HOTMAIL COM','Bogota',5,'SERVICIO',99,'2013-08-26','14510',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (167,'13458678',35852945,'GALVIS  VARGAS  JOSE NEFTALI','CALLE 12 No 3 47 COMUNEROS','5796628','danielfer10@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14895',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (168,'13489433',19760610,'JULIAN RODRIGUEZ LINDARTE','CALLE 76 No 16A 37','5820457','gracielaleon49@gmail com','Bogota',1,'SERVICIO',99,'2013-06-17','14509',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (169,'13508842',1904201,'PEREZ MORENO WAYNE ALBERTO','CARRERA 72A No 23F 36 Torre a Apartamento 203','3203264862','nalcionaldeherragesaristi@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14900',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (170,'13717286',58307670,'RAUL GERARDO SUAREZ ROJAS','CARRERA 39 No 42 78','6352293','laimperialarciniegas@yahoo','Bogota',1,'SERVICIO',99,'2013-12-25','14585',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (171,'13925430',8798832,'JAIRO RAVELO','CALLE 45 No 21 48  MANZANA A CASA 6 URBENIZACION ALAMEDA','6570841','elidamendozas2727@hotmail com','Bogota',1,'SERVICIO',99,'2013-09-28','14621',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (172,'14206878',7659882,'LEVID MORENO CORTES','CALLE 23 No 3 31','3103043677','Ingris2020@hotmail com','Bogota',1,'SERVICIO',99,'2012-04-25','14626',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (173,'14240126',1671949,'QUINTERO RAMIREZ ADALBER','CARRERA 4C No 25 65 piso 2','3157879213','kafejeans@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14903',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (174,'14319443',93970799,'ZAMUDIO CORTAZAR JOSE ALI','DG 45 SUR 49 90','312301486','luzaydaperez@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14790',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (175,'14398972',3342793,'ACERO  JULIAN ANDRES','CARRERA 11 No 13 13','2622604','miguel noriega@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14843',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (176,'14398981',17846492,'DANIEL FELIPE CUELLAR','MANZANA D CASA 20B CORDOBA','8787364','dotacruzazul@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14625',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (177,'14838530',40752611,'BUSTAMANTE  HERNANDEZ YONNY ALBERTH','CR 7  13 70 L 1 CC EL TESORO','3163103479','goyi3000@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14792',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (178,'16076493',33495488,'FABIO NELSON GIRALDO GOMEZ','CALLE 13 No 13 38    CALLE 12 No 13 69','5621395','yeskala 03@hotmail com','Bogota',1,'SERVICIO',99,'2013-10-06','14580',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (179,'16475788',13472950,'SALAZAR PRECIADO GONZALO','CR 44 11 78 APT 101','325535876','milenabautista20@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14803',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (180,'16709224',5365378,'COLLAZOS PEREZ CARLOS ALBERTO','CR 96 A 45 64','3173027810','lovelygil @hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14885',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (181,'17122174',5881988,'GERMAN ARISTIZABAL GOMEZ','CALLE 24 A No 44 28','3681639','lineamedicamayitos@hotmail com','Bogota',1,'SERVICIO',99,'2014-07-22','14632',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (182,'17445151',5389898,'ALIRIO PE¾A','CLL 74 SUR    92 71','4001035','johnnyacl@hotmail com','Bogota',2,'SERVICIO',99,'2014-07-22','14610',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (183,'19268645',45423570,'GOMEZ  GUTIERREZ MANUEL LUCRECIO','CRA 78    36A   42 SUR','2934440','cabrerafranklin@hotmail com','Bogota',1,'SERVICIO',99,'2012-02-06','13978',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (184,'19346035',21747198,'HERNANDO AVILA PAEZ','AV 68 No   12 54 SUR','2603166','jgarcia646@yahoo com ar','Bogota',1,'SERVICIO',99,'2014-07-22','14617',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (185,'19400019',2305200,'BARRERACALDERON CARLOS ALBERTO','CR 20 8 53 LC 125','3204620442','c fajardon@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14857',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (186,'19491532',24823412,'AREVALO MENDEZ  HERNAN JAVIER','CR 40 B    24 11','4723614','JMALAVER2009@HOTMAIL COM','Bogota',5,'SERVICIO',99,'2013-10-07','14686',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (187,'20504765',5500000,'TRIANA MATIZ VIRGINIA','CARRERA 34A No 27A 54 SUR','7275854','luis jaimecp@hotmail com','Bogota',2,'SERVICIO',99,'2014-06-07','14685',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (188,'22515559',8032217,'BIURYCK JEANS','CALLE 35 No 41 18 piso 3','3720423','jpcerquera@gmail com','Bogota',1,'SERVICIO',99,'2011-09-12','14012',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (189,'31155777',1959983,'GARCIA  QUINTERO NOHRA','CL 28 31 11 APT','2755021','josedanielgomezmunoz@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14899',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (190,'31584406',2291594,'QUINTERO  MARIA ANGELICA','CR 9  15 63 LC 104 CC PETECUY','3117023736','frimport@hotmail com','Bogota',1,'SERVICIO',99,'2016-06-15','14892',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (191,'31847638',3693961,'ARCINIEGASLIBIA','CALLE 18B  DG 23 58','4747756','lelayo-11@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14888',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (192,'31971511',4954907,'BEJARANO  AVENDA','CR 66 A 6 186','324747756','chaconnelson 69@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14837',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (193,'37179640',4000797,'MENDOZA EDIDA','AV 7 No 12 47 LA ESTRELLA','3134630063','d animar16@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14887',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (194,'37276757',4067693,'LINDARTE FONSECA MARLY','AV 21 NO 12 42','5710458','makano 229@hotmail com','Bogota',1,'SERVICIO',99,'2016-06-15','14886',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (195,'37279631',7255887,'CHURIO PATINO INGRID YURLEY','MX 36 LT 11 CLARET','3219212237','gaposita68@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14824',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (196,'37294243',1187818,'ORTIZ MORENO DAYRA TATIANA','AV 7  12 31','3115296170','danipente75@yahoo es','Bogota',1,'SERVICIO',99,'2015-05-16','14863',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (197,'37843351',77881001,'PEREZ MEJIA LUZ AIDA','CALLE 43 No 8 74','6442938','ferley084@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14867',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (198,'39632420',5769581,'ANA LUCELIDA AVILA TORRES','CALLE 6 BIS No    80 C  62','4112588','MAERKS@GMAIL COM','Bogota',1,'SERVICIO',99,'2014-07-22','14637',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (199,'39719201',2690044,'GAMBA  MARIA ANDREA','CL 51A 82C 37 SUR','2733105','LOTOXJEANS@GMAIL COM','Bogota',1,'SERVICIO',99,'2015-06-15','14852',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (200,'39801675',3306000,'DERLY MAITET RAMIREZ MUNOZ','TV 2  48I 65 MZH','5697183','notificacionesbosque@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14844',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (201,'42102531',1639950,'BERMUDEZ QUIMBAYA DIANA MARIA','CR 15  23 15 CENTENARIO','3243446','guantesvalleltda@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14904',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (202,'43595970',11643299,'FERNANDEZ SANCHEZ YOLIMA A','TV 45B  84 55','6126064','cimaxis textil@hotmail com?','Bogota',1,'SERVICIO',99,'2015-06-15','14808',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (203,'52251791',18197528,'GLORIA ISABLE PERDOMO CUASPUD','CALLE 8 BIS F No   88F 58','4018514','gerencia@coraza com co','Bogota',1,'SERVICIO',99,'2014-07-22','14627',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (204,'52271474',7404393,'GRACIELA VELANDIA OTALORA','CALLE 2 No 89 36  BLOQUE C CASA 9 PATIO BONITO','3202023704','shamaltda@hotmail com','Bogota',2,'SERVICIO',99,'2016-01-20','14568',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (205,'52745793',30500000,'AURA EDILMA MU¾OZ SANABRIA','CRA 19 No    54 66','2051892','abrahamdini@hotmail com','Bogota',1,'SERVICIO',99,'2014-07-22','14604',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (206,'5471901',32925634,'BALLESTEROS  ALVAREZ CARLOS DANIEL','AV 5 No 17N 06','3114441214','oxigem0523@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14793',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (207,'59823201',8880596,'ESTRADA BETANCOURT LILIANA DEL ROSARIO','CR 3  21B 67','7321905','surtiuniformes@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14821',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (208,'60259298',2694605,'CASTILLO SANDOVAL GLORIA','CL 1  11 57','3124816104','coindotsas@gmail com  maria trujillop@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14891',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (209,'60285068',2291191,'VARGAS RINCON NELLY DEL CARMEN','CALLE 2 No 7E 196 BARRIO QUINTE ORIENTAL','5744021','yepesunidos@hotmail com','Bogota',1,'SERVICIO',99,'2012-05-14','14022',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (210,'60288756',19926805,'PACHECO PARADA RAMONA DELIA','CL 12  3 13','5714405','amparocriv@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14799',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (211,'60337594',6920990,'ROZO RINCON BERTHA CONSUELO','CL 7  4 98','5720458','protextil@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14876',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (212,'60357966',2786112,'RODRIGUEZ MARQUEZ MARIA INES','CL 10 AV 7 LOCAL 3 14','3114756842','coserycoser@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14850',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (213,'60383225',100172684,'EDITH TERESA GUILLIN SALAZAR','MANZANA 4 LOTE 27 URBANIZACION LAS AMERICAS','3045903633','gruporiof@gmail com','Bogota',1,'SERVICIO',99,'2013-09-05','14660',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (214,'60443681',6911226,'BAUTISTA ZAMBRANO SANDRA MILENA','AV 9E  11 73','6829094','dotacionesdelsuroeste@hotmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14877',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (215,'63326650',7090000,'RODRIGUEZ PRADA GLADYS','CR 35  107 40','3208029263','diovermg23@gmail com','Bogota',1,'SERVICIO',99,'2015-06-15','14825',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (216,'63513421',10547112,'RODRIGUEZ DURAN GLADYS','PEATONAL 7AE No 27A 33','6213116','haconricardo039@gmail com','Bogota',1,'SERVICIO',99,'2013-10-05','14013',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (217,'63518633',9231795,'BADILLO ORTIZ MYRIAM','CALLE 52 No 14 41','6991290','andreita705@hotmailcom','Bogota',5,'SERVICIO',99,'2012-11-27','14684',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (218,'63539797',4974341,'AVILA BLANCO LENY YISETH','TRANSV 154 No 24 141 local 8 EL BOSQUE','4450299','icardo botero@hotmail com','Bogota',1,'SERVICIO',99,'2012-08-31','13952',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (219,'65715164',5842882,'GUARANGA  BLANCA FLOR','CL  11B 16 10 SUR','2701662','DREAN WQA2@HORMAIL COM','Bogota',1,'SERVICIO',99,'2015-06-15','14833',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (220,'65747207',16700045,'MORENO GUIZA CLAUDIA PATRICIA','CALLE 26A No 5 21 p 2','3716734','juliocevi 20@hotmail com','Bogota',1,'SERVICIO',99,'2012-10-17','14682',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (221,'66682156',5878468,'LIX KATHERINE PALACIO RIVERA','CRA 24 No 30 153','2873957','','Bogota',2,'SERVICIO',99,'2014-01-21','14597',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (222,'66780260',29556230,'ISABEL CRISTINA MONTOYA GALINDO','CALLE 44 No 32 A 76','3108488272','','Bogota',1,'SERVICIO',99,'2013-12-10','14591',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (223,'66992933',1898528,'RODRIGUEZ ARENAS CLAUDIA LEVIS','CL 13    6 73','8892572','','Bogota',1,'SERVICIO',99,'2015-06-15','14901',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (224,'66995606',5384489,'FRANCIA SILVA OSORIO','CRA 13 No 10 22','2609549','','Bogota',1,'SERVICIO',99,'2013-12-26','14595',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (225,'70952165',12541549,'GARCIA GARCIA GERMAN DE JESUS','CALLE 48D No 65a 15 OF 202','5962652','','Bogota',1,'SERVICIO',99,'2012-09-14','13977',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (226,'71213886',14991386,'MORA EUSE GABRIEL ANGEL','CR 46C  74SUR 58','5887607','','Bogota',1,'SERVICIO',99,'2013-10-05','13996',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (227,'71315762',1835320,'CARVAJAL  LOPEZ JHONY ALBERTO','CL 28  84 195','4028852','','Bogota',1,'SERVICIO',99,'2015-06-15','14902',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (228,'74347141',11304596,'HELMER DIAZ SUAREZ','CRA 82 No    0   23','6739671','','Bogota',5,'SERVICIO',99,'2014-07-22','14603',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (229,'77186311',6621586,'MAESTRE MU¾OZ CARLOS ALFONSO','CARRERA 23 No 54N 89 COLORADO','2018853','','Bogota',1,'SERVICIO',99,'2013-11-28','14681',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (230,'79265584',3175622,'FRANKLIN CABRERA RUBIO','CC PROVIDENCIA LC 23A','3484176','','Bogota',1,'SERVICIO',99,'2015-09-17','14641',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (231,'79311887',9506581,'SANABRIA  VARGAS  RICARDO','CL 53  15 86 OF 402','316844691','','Bogota',1,'SERVICIO',99,'2015-06-15','14819',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (232,'79345411',25812783,'GARCIA  PEREZ JUAN CARLOS','CL 148 95 97','2645582','','Bogota',2,'SERVICIO',99,'2015-06-15','14868',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (233,'79408913',19827207,'FAJARDO CARLOS EDUARDO','AV BOYACA 36 88 SUR','7110052','','Bogota',1,'SERVICIO',99,'2015-10-13','14688',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (234,'79412065',8596370,'ORLANDO BUSTOS GARCIA','CL 39BIS 68L 71 SUR','3115134494','','Bogota',5,'SERVICIO',99,'2011-12-07','11468',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (235,'79446956',11968569,'JAVIER ENRIQUE MALAVER ESPEJO','CLL 173    40 32','4065142','','Bogota',1,'SERVICIO',99,'2014-07-22','14611',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (236,'79691022',60622507,'CARLOS ERNESTO SAAVEDRA PUENTES','CL 70A BIS  111D 29','2810874','','Bogota',5,'SERVICIO',99,'2013-11-14','14075',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (237,'79732635',20669753,'CASTRO  PARDO  LUIS JAIME','CL 186 No 54D 73 C42','3322110','','Bogota',1,'SERVICIO',99,'2013-10-01','14798',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (238,'800013093',2691282,'COOPERATIVA DE CREDITO EL BOSQUE LTDA','AV JIMENEZ 7 25 OF 812 813','314864268','','Bogota',1,'SERVICIO',99,'2015-06-15','14851',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (239,'80016311',9473173,'LUIS FABIAN FORERO RAMIREZ','CALLE 25  No 20 130 CALLE 21 No 22 19 apto 302','3132922003','','Bogota',1,'SERVICIO',99,'2014-06-16','14583',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (240,'800232926',19456919,'GUANTES VALLE LTDA','CL 60 27 A 18 AP 804 TO 3 CON BOSQUES DE LAS MERCEDES','322744315','','Bogota',1,'SERVICIO',99,'2015-06-15','14870',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (241,'80057214',18727794,'LUIS ANTONIO CASTILLO','CR 45 45 52','3123724702','','Bogota',1,'SERVICIO',99,'2015-09-17','14605',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (242,'80065650',10576630,'CERQUERA MONTEALEGRE JUAN PABLO','CL 29 6 66 LAS GRNAJAS','3115924938','','Bogota',1,'SERVICIO',99,'2015-06-15','14811',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (243,'80211139',16819558,'JAIRO ANTONIO CRISTRANCHO TOVAR','CRA 3  9 74 SUR','7688415','','Bogota',1,'SERVICIO',99,'2014-07-22','14616',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (244,'80254985',36526614,'ORTIZ  SANCHEZ JHON','CL 92A BIS SUR  1 15','2732815','','Bogota',1,'SERVICIO',99,'2015-06-15','14894',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (245,'80271596',11525975,'ACEVEDO BOHORQUEZ GIOVANNY MAURICIO','CR 10  9 39 LOCAL 1210','5221318','','Bogota',1,'SERVICIO',99,'2015-06-15','14874',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (246,'80413403',4039728,'GUERRERO MONTA¾O JOSE ALFREDO','CLL 128B    51   19','4247049','','Bogota',1,'SERVICIO',99,'2013-04-03','13981',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (247,'805030692',26499303,'SOCIEDAD DE COMERCIALIZACION INTE','CRA 49 13B 24','3350793','','Bogota',1,'SERVICIO',99,'2014-07-22','14629',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (248,'80831507',15090991,'MURCIA  PINZON CARLOS ARTURO','CR 34 4B 42 CASA 102  CL 8 C 78 C 13','7652279','','Bogota',1,'SERVICIO',99,'2015-06-15','14802',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (249,'811041841',255360857,'CI MAXIS TEXTIL SA','CALLE 11 CARRERA 10 38  EL LLANO   CALLE 9 No 6 54 LOCAL B','5724943','','Bogota',1,'SERVICIO',99,'2011-12-13','13954',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (250,'830048947',99505086,'CONFECCIONES JESSUA  LTDA','CL 37 SUR  68H 90','4037476','','Bogota',5,'SERVICIO',99,'2012-01-17','11617',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (251,'830094239',3272687,'PROINTEXCOL','CR 68 C 37 B 23 SUR','312633492','','Bogota',1,'SERVICIO',99,'2015-06-15','14845',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (252,'830104637',13472873,'DISGUANTES LTDA','CL 12A  26 24','7036192','','Bogota',1,'SERVICIO',99,'2015-06-15','14873',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (253,'830135871',40388412,'TEX INC INVERSIONES EU','AV 8 No 10 77','4511920','','Bogota',1,'SERVICIO',99,'2015-06-15','14893',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (254,'830504375',8529665,'METROTEXTILES SA','CR 9 15 35 LC 24','6702425','','Bogota',1,'SERVICIO',99,'2013-10-11','13995',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (255,'830513423',20341130,'CORAZA LTDA','CALLE 68    30   66 CASA B','8959444','','Bogota',1,'SERVICIO',99,'2015-06-15','14869',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (256,'84035445',61280000,'FREDY JULIAN RIOS','CALLE 107 No 22a 58','4202734','','Bogota',1,'SERVICIO',99,'2014-02-28','14530',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (257,'86003623',7952550,'URIEL ANTONIO VILLADA VALBUENA','TRANSV    80 A 65J 24','3102112727','','Bogota',1,'SERVICIO',99,'2014-07-22','14602',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (258,'88167462',23819643,'TARAZONA  GONZALO','CL 19A 12A SUR','6563622','','Bogota',1,'SERVICIO',99,'2015-06-15','14795',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (259,'88197750',39299169,'ORTEGA  QUINTERO JOSE LEONIDAS','CALLE 30 No 2 137 CASA 6 BARRIO ACUARELA','3108027637','','Bogota',1,'SERVICIO',99,'2012-01-19','14003',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (260,'88199811',2553388,'CHACON SANTANDER NELSON ENRIQUE','CL 12 7 31 LC I 31 I 03 CC LA ESTRELLA','5822121','','Bogota',1,'SERVICIO',99,'2015-06-15','14855',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (261,'88208569',6025191,'MARTINEZ BAYONA ERWIN ANTONIO','CALLE 18 No 40 2','3134202331','','Bogota',1,'SERVICIO',99,'2015-06-15','14831',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (262,'88212513',11786139,'BONILLA MEDINA FERNANDO ANTONIO','CALLE  10  No 7 59','3766365','','Bogota',1,'SERVICIO',99,'2014-02-14','14807',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (263,'88223661',17277736,'CASTILLA SANTIAGO ISNEL','CL 24A  30B 05','6520370','','Bogota',1,'SERVICIO',99,'2013-10-05','13959',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (264,'900032093',20226297,'FABRICA DE ARTICULOS PARA SEGURIDAD','CLL 12 B   3 51 CANDELARIA','2725494','','Bogota',1,'SERVICIO',99,'2013-07-16','14673',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (265,'900062898',11248073,'CONFECCIONES CAROYCO BOGOTA E','CR 24 A 61 05','3103364762','','Bogota',1,'SERVICIO',99,'2012-05-28','13963',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (266,'900177735',18035061,'SHAMA COMERCIAL LTDA','CR 12B 22 15','8137748','','Bogota',1,'SERVICIO',99,'2011-12-07','11462',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (267,'900238074',5554541,'GALLARDINI TEXTILES COLOMBIANOS LTDA','CL 65  46 20','3600896','','Bogota',1,'SERVICIO',99,'2015-09-17','14882',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (268,'900283988',2679870,'SURTIUNIFORMES DE LA COSTA LTDA','AV 68 No    60 81','7049161','','Bogota',1,'SERVICIO',99,'2015-06-15','14853',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (269,'900299944',10170729,'CSI CONFECCIONES DE SEGURIDAD','CR 24    75A 47','315476514','','Bogota',1,'SERVICIO',99,'2013-12-17','14590',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (270,'900323622',5766182,'COMPANIA INTEGRAL DE DOTACIONES COINDOT SAS','CALLE 31 No 42 25','3720855','','Bogota',1,'SERVICIO',99,'2015-06-15','14880',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (271,'900326223',10531832,'YEPES UNIDOS SOCIEDAD POR ACCIONES SIMPLIFICADA','CL 15 SUR  18 46 P4','4732661','','Bogota',1,'SERVICIO',99,'2015-06-15','14814',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (272,'900351293',3188123,'DOTARTE CON ESTILO SAS','CR 23 A 8 A 30','5542244','','Bogota',1,'SERVICIO',99,'2015-06-15','14847',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (273,'900352194',3462841,'PROTEXTIL DE OCCIDENTE S A S','CALLE 44 No 1CW 70','3155398189','','Bogota',1,'SERVICIO',99,'2015-06-15','14890',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (274,'900382017',8665492,'DISTRIBUCIONES INDUSTRIALES','CR 23  16 79','7234251','','Bogota',1,'SERVICIO',99,'2012-12-15','14615',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (275,'900386178',4740417,'INSUMOS COSER Y COSER SAS','CLL 9    36   80 OF    603','3008998847','','Bogota',1,'SERVICIO',99,'2015-06-15','14838',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (276,'900387891',8748462,'NEW START COMPANY SAS','CL 16 SUR No    18 49 OF 346B','3664485','','Bogota',1,'SERVICIO',99,'2013-10-31','13998',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (277,'900405647',17780989,'BASE TEXTILES SAS','CARRERA 22A No 110 27','6853179','','Bogota',1,'SERVICIO',99,'2013-04-29','14687',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (278,'900416722',43756873,'COLOMBIANA EN SEGURIDAD INDUSTRIAL','CR 52 C    39B 22 SUR','3125830923','','Bogota',1,'SERVICIO',99,'2014-04-03','14582',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (279,'900442908',25694681,'DENIM WKSAS','CALLE 52 No 24 84','6112325','','Bogota',5,'SERVICIO',99,'2012-11-04','14683',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (280,'900456189',9781371,'ZOE DOTACIONES SAS','AV CL 68    4 51 SUR','2627483','','Bogota',1,'SERVICIO',99,'2013-07-29','14026',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (281,'900487029',108574860,'DOTACIONES VELANDIA','CL 29C SUR  44A 60','6943591','','Bogota',1,'SERVICIO',99,'2013-06-25','14703',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (282,'900498015',5526573,'GRUPO RIOFF SAS','CALLE 12 No 13 73','3719866','','Bogota',1,'SERVICIO',99,'2013-12-15','14522',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (283,'900590236',14024574,'DOTASUROESTE SAS','CR 52 D CL 81 17','2467728','','Bogota',1,'SERVICIO',99,'2015-06-15','14883',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (284,'91259772',34034377,'GABRIEL PORTILLA SANABRIA','CL 20  17 10','3174339592','','Bogota',1,'SERVICIO',99,'2015-09-17','14584',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (285,'91476956',10313528,'RIVERO  DANIEL','CL 43 No 26 57','6801219','','Bogota',1,'SERVICIO',99,'2015-06-15','14817',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (286,'91529044',3148813,'RAMIREZ MANTILLA LUIS FERLEY','CR 16  35 11 LC 8 9','3186322613','','Bogota',1,'SERVICIO',99,'2015-06-15','14848',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (287,'93384756',13092236,'SANCHEZ SAAVEDRA CARLOS ARTURO','CARRERA 4 No 17 25','3511725','','Bogota',1,'SERVICIO',99,'2015-06-15','14805',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (288,'94367385',6490468,'OSORIO  MANUEL ANTONIO','CL 22 7A 6','3001255466','','Bogota',1,'SERVICIO',99,'2015-06-15','14897',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (289,'94398892',19848460,'JORGE ENTIQUE CRUZ GUZMAN','CALLE 43 No   2F  48','6649853','','Bogota',1,'SERVICIO',99,'2014-07-22','14628',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (290,'9455505',5425898,'CASTILLO FERNANDEZ JOHNY','CRA 3A NORTE N 3 BIS   09 B MADRIGAL YUMBO','3146540774','zuelitas17@hotmail com','Bogota',1,'SERVICIO',99,'2014-08-16','14836',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (291,'76267910',137856367,'GUSTAVO ADOLFO AGUILAR VIVAS','CARRERA 7 No 23 27','6452187','INGANDRIS08@GMAIL.COM','Bogota',1,'BIENES',99,'2013-10-28','14',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (292,'51854766',718904225,'EDNA PIEDAD CUBILLOS CAICEDO','CALLE 6 SUR No 15a 24','7455700','','Bogota',1,'BIENES',99,'2016-07-02','12',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (293,'22518962',13824789,'CHAPARRO VERGARA OLGA LUCIA','TRANSVERSAL 11 NO 27 C 05','3145682033','NASLYSOFIA@HOTMAIL.COM','Bogota',1,'BIENES',99,'2014-12-10','14347',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (294,'800200232',3135458,'INVERSIONES LOS SAMANES LTDA','CALLE 14 NO 16 17','2243551','','Bogota',1,'BIENES',99,'2016-01-26','59',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (295,'800200232',6663218,'COMERCIALIZADORA JO AGRO S A S','CR 28 46 48','2753290','','Bogota',1,'BIENES',99,'2007-09-26','51',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (296,'830049122',9127170,'PT INGENIERIA DE PROYECTOS SA','CRA 51   102A   68','6110701','','Bogota',5,'BIENES',99,'2014-06-12','14352',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (297,'860001330',43698921,'CONSULTECNICA SA','CARRERA 82B No 54a 03 sur','7841024','financiero@consultecnica.com.co','Bogota',5,'BIENES',99,'2014-06-10','14320',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (298,'860048529',11655424,'HIDROAGRICOLAS REPA Y GALLO LTDA','FUNZA VIA A LA ARGENTINA KM 1','3123823952','MAURICIOGALLO61@HOTMAIL.COM','Bogota',1,'BIENES',99,'2014-06-11','14453',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (299,'10957883581',1901712,'DROGUERIA PHARMA PAZ','CR 50 W 49 A 03 BRR RINCON DE LA PAZ','6769098','','Bogota',1,'BIENES',99,'2015-12-09','27615',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (300,'11240128919',2041380,'DROG  BARRANQUILLA DE ORO','CR 17   12 10','3116795395','','Bogota',1,'BIENES',99,'2013-04-19','34592',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (301,'134910375',19310067,'BODEGA SANTANDERANA','GLP A LOCAL 21 CENABASTOS','3107782590','ALFREDOQUINDU13@HOTMAIL.COM','Bogota',1,'BIENES',99,'2016-05-06','23147',119,0,'NOW',NULL,'4','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (302,'161886130',16449942,'GRANERO MERCATODO J C','CR 33 47 74','6475532','fiestasin15@hotmail.com','Bogota',1,'BIENES',99,'2015-12-04','24768',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (303,'31730479',4247684,'ALARCON YEPES PEDRO JOSE','CR 9   7 52','3124326966','nutrifor47@gmail.com','Bogota',1,'BIENES',99,'2014-05-03','25487',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (304,'400197845',1805644,'PA¥ALERAS TUTYS','CRA 102   131 70','6862208','','Bogota',1,'BIENES',99,'2015-05-03','58745',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (305,'52116722',2572014,'SUPER MERCADFO BARATODO','CRA 7 N 21 33','321492081','miriamhernnadez_73@yahoo.es','Bogota',1,'BIENES',99,'2012-04-05','21345',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (306,'63324317',5189333,'GARCIA GOMEZ BLANCA','CL 55 17 C 06 LC 806 08 P 1','376427412','acastiltda@hotmail.com','Bogota',1,'BIENES',99,'2015-01-05','35641',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (307,'716210139',29469101,'GRANOS Y ENLATADOS LA GRAN CICALOTA','CRA 14   104 33','3146764416','','Bogota',1,'BIENES',99,'2016-02-03','89553',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (308,'76986870',7868885,'DISTRIB  DE QUESO CAQUETA JHON','CR 5 26 73','6725992','JHONCARD123@HOTMAIL.COM','Bogota',1,'BIENES',99,'2016-03-27','67819',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (309,'8000408831',44026151,'SUPERVENTAS LTDA','CARRERA 100 No 97 57','8281018','SUPERVENTAS@EDATEL.NET.COM','Bogota',1,'BIENES',99,'2016-05-31','14419',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (310,'8300649783',44765379,'IMPORT  Y DIST  CRISTIAN S A','CALLE 35 SUR   70   14','7444344','','Bogota',5,'BIENES',99,'2014-12-01','33169',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (311,'8911000249',64284356,'ALMACENES YEP S A','KILOMETRO 3 VIA FUNZA   SIBERIA PARQ  IND GALICIA BOD  11 Y 12','8259775','','Bogota',5,'BIENES',99,'2014-12-15','30837',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (312,'9003595545',13493844,'PA¥ALERIA Y CACHARRERIA EL DESCUENTO S A S','CLL 52  12C 25','3014511545','ELDESCUENTO.PANALERA@GMAIL.COM','Bogota',1,'BIENES',99,'2016-03-02','27614',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (313,'9005075493',38131518,'SERVI EXPRESS PLAZA SAS','CALLE 8 No 42c 22 LOCAL 2','3797272','distribucionesserviexpressplaza@hotmail.com','Bogota',1,'BIENES',99,'2016-11-08','32815',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (314,'7186191',515084,'JOSE HERACLIO MERCHAN GAONA','cra 5  10 49 apto 404','3102318805','josemercha08@gmail.com','Bogota',1,'SERVICIOS',99,'2017-11-21','900145780',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (315,'800090968',1486636,'ESTACION DE SERVICIO ZONA FRANCA SAS','Barrio Mnaga calle  29 27 05','6607853','lsolana@districandelaria.com','Bogota',2,'SERVICIOS',99,'2017-03-12','800090968',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (316,'800201668',712983,'SEGURIDAD ONCOR LTDA','carrera 49 C 93 08','6211605','','Bogota',1,'SERVICIOS',99,'2017-01-06','800201668',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (317,'800216303',9471223,'HOSPITAL SAN BLAS','trasversal 5 este  19 52 sur','3280969','','Bogota',2,'SERVICIOS',99,'2017-08-16','800216303',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (318,'802008914',11572634,'HOTEL BARRANQUILLA PLAZA S A','Avenida Alberto Assa  79 246','3610000','tesoreria@hbp.com.co','Bogota',2,'SERVICIOS',99,'2017-08-14','802008914',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (319,'802023443',3129286,'NVERSIONES T  DURAN & CIA  SAS','Carrera 32 30 15 Soledad','3634141','danieltarud@hotmail.com','Bogota',2,'SERVICIOS',99,'2017-08-25','802023443',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (320,'805017907',6060118,'J  Y P  LTDA','Calle 10 43 11','6807296','jypltda@une.net.co','Bogota',2,'SERVICIOS',99,'2017-09-18','805017907',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (321,'830109503',2120795,'INVERSIONES COMBITA LIMITADA','carvajal kennedy  calle 26 A sur No 64 A 39','2702201','invercomltda@hotmail.com','Bogota',2,'SERVICIOS',99,'2017-09-21','830109503',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (322,'860005140',5513046,'SURTIDORA DE AVES SUCURSAL LTDA','Calle 22  14 50','6000949','','Bogota',2,'SERVICIOS',99,'2017-09-20','860005140',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (323,'890901177',206693,'COOFINEP YOLOMBO','carrera 7  35 27','6076565','','Bogota',1,'SERVICIOS',99,'2017-09-25','890901177',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (324,'890906033',1324100,'COOP DE TRANSPORTADORES SAN ANTONIO','Calle 42 S 74 04 Medell­n','4440468','juridica@cootrasana.com.co','Bogota',1,'SERVICIOS',99,'2017-09-14','890906033',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (325,'890906465',497858,'JUANBE CENTRO MUNDIAL DE LLANTAS LTDA','Calle  8 B 65 281 Medell­n','4488011','','Bogota',1,'SERVICIOS',99,'2017-11-23','890906465',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (326,'900026211',1215065,'DISTRIBUCIONES SANTA MARTA S A S','carrera 10 9 A 36 Santa Marta','4200068','maryury.prada@disan.co','Bogota',1,'SERVICIOS',99,'2017-09-09','900026211',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (327,'900043796',3208385,'GAS NATURAL VEHICULAR SAN BUENAVENTURA  S A','Carrera 4 32 84 soacha','5797194','p.gas.snbuenaventura@etb.net.co','Bogota',2,'SERVICIOS',99,'2017-05-24','900043796',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (328,'900120482',3823961,'INVERSIONES JR & A','Av Cr  9 103 39?','6121088','estacionbiomax103@hotmail.com','Bogota',2,'SERVICIOS',99,'2017-09-23','900120482',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (329,'900425332',1221003,'EDS SANTA ELENA VALLE S A S','carrera santa elena la blanquita  el cerrito  valle','2557401','estacion_santahelena@hotmail.com','Bogota',1,'SERVICIOS',99,'2017-07-14','900425332',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (330,'900449021',907497,'HERCUR SAS','Calle 132 94 F 52','6862698','dicol.ltda@hotmail.com','Bogota',2,'SERVICIOS',99,'2117-03-12','900449021',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (331,'900464256',2152163,'EL PARAISO DE ROZO S A S','kilometro 7 via palma seca rozo palmira valle','3188273812','rozo@yahoo.com','Bogota',2,'SERVICIOS',99,'2017-06-27','900464256',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (332,'900513317',6739525,'KNOW HOW CONSULTING SAS','Carrera 7 BIS A 124 45','6942244','nelson.4cabrera@gmail.com','Bogota',1,'SERVICIOS',99,'2017-08-17','900513317',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (333,'900952494',10261951,'ADMINISTRACI?N DE ESTACIONES LA UNION S A S','CALLE 68 19 84','6062942','franciscogomez@outlook.com','Bogota',1,'SERVICIOS',99,'2017-08-15','900952494',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (334,'11522356',8480626,'JUAN CARLOS RUIZ','KR 50A No 1174b 06 in 3ap 201','3005070765','INDESJC@HOTMAIL.COM','Bogota',2,'PRODUCTO',99,'2014-04-15','16079',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (335,'13488429',21958259,'IBARRA ALBARRACIN JOSE RAMON','AVDA KR 15 No 17065 TR 4 AP315','3156363681','tecdimec@gmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14433',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (336,'16666395',4744172,'CASTRO SALAZAR MARIO','Cll 85 No 60 13 casa 154','3138799739','mariocasal2003@yahoo.es','Bogota',1,'PRODUCTO',99,'2014-04-15','14432',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (337,'19217871',7681620,'JOSE ARMANDO DIAZ','Krr 50 134 32','3123092311','JOSEARMANDO-52@HOTMAIL.COM','Bogota',2,'PRODUCTO',99,'2014-04-15','17088',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (338,'52055274',8261499,'PATRICIA CORTES AGUIRRE','CLL 159  56 75 AP 703 T3','3115607434','patriciacortesag@hotmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','13925',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (339,'5934320',1845129,'SAENZ NESTOR HUGO','KR 62 No171 41 IN8','3142442181','asaenz44@hotmail.com','Bogota',1,'PRODUCTO',99,'2012-04-15','14435',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (340,'71692775',5893036,'ALVAREZ ALDANA JOSE LUIS','CL 182 No 45  45  AP1101 TR 5','3105669251','joseluisalvarez67@hotmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14430',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (341,'79217122',7053944,'ROZO ESCOBAR DAVID RICARDO','Tranversal 76 No 130-48 bloque 8 apt 502','5330852','davidehijo@hotmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14434',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (342,'79486888',6072632,'QUILAGUY CORREDOR WILSON','CL 181C No9 30 IN2 AP 504','3158799665','cahetosa@yahoo.es','Bogota',2,'PRODUCTO',99,'2014-04-15','14429',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (343,'79509027',10181151,'LONDO ANGEL FRANK','KR76B No 89 69','3013501780','','Bogota',5,'PRODUCTO',99,'2014-04-15','12269',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (344,'79869570',4352625,'VASQUEZ JAIME JUAN CARLOS','CL 175 No 17B   80 TR 5 AP 502','3132827683','vas_juan@hotmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14436',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (345,'80089324',10369350,'JUAN GUILLERMO BECERRA','CARRERA 5 No 185c 21 Int 11 APTO 303','5161632','JUANGBR7@HOTMAIL.COM','Bogota',2,'PRODUCTO',99,'2014-04-15','16004',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (346,'8740041',533036,'WALDEMAR STRUSS FRANCO','CL173A No 20A 32 IN2 AP 308','3186086820','strussw@hotmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','13370',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (347,'88210242',5041385,'TORRES NOVOA NESTOR ALEXANDER','VIA CAJICA TABIO 2 05 TORRE 2 AP 502','3185895303','ntorres@petrologyc.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14104',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (348,'91488546',9870800,'GOMEZ GUALDRON ROY STEPHEN','CL 159 No 56 75 TR 3 AP 302','3002501681','roygomez1976@gmail.com','Bogota',1,'PRODUCTO',99,'2014-04-15','14251',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (349,'92513434',9083160,'FRANCISCO CERRA ARROYO','CRR 8A  159B 27 AP 601','5276200','','Bogota',2,'PRODUCTO',99,'2014-04-15','16086',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (350,'80086173',80086173,'CLAUDIO ANDRES MEJIA CORRALES','DIRECCION  CALLE 74 No 11-21 APTO 201','5897575','corrales.mac@gmail.com','Bogota',1,'bienes',99,'2017-04-26','71',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (351,'70288258',17823964,'INVERSIONES ARIAS ALZATE','CR 49 48 17 P 4','5312153','BANQUETESCASABLANCA08@HOTMAIL.COM','Bogota',1,'BIENES',99,'2017-02-11','80',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (352,'1032440642',7820373,'MARIA CAMILA BERNAL RODRIGEZ','CALLE 51 N 56A 70','3132490474','MCBR02173@YAHOO.ES','Bogota',2,'SERVICIOS',99,'2016-05-13','84',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (353,'20995581',6547394,'BLANCA YANNETH VILLAREAL','TRANSVERSAL 85 N 52C 19','3004272794','YANETHVILLAREAL2013@GMAIL.COM','Bogota',2,'SERVICOS',99,'2017-05-26','86',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (354,'52146760',1474796,'SANDRA PATRICIA MELO CARMONA','CARRERA  74 N 138 69 TORRE 3 APTO 201','3204111107','SENDYMELO3@HOTMAIL.COM','Bogota',2,'SERVICIOS',99,'2017-11-26','88',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (355,'8001067740',281900000,'MERCADO ZAPATOCA S.S','CARRERA 60 N 4 24','2629610','GARCHA409@HOTMAIL.COM','Bogota',5,'SERVICIOS',99,'2014-01-20','122',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (356,'9007134545',18719470,'IRON COOPER COMPANY SAS','CALLE 10 N 34-11 OF 3  CALLE 45 SUR NO 39 22','3661489','KPATINO@QICCOMSAS.COM','Bogota',1,'SERVICIOS',99,'2017-02-28','123',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (357,'79361601',6997036,'WILLIAM CAICEDO BARAHONA','CARRERA 56B N 127 04 APTO 118','2264543','WILLIAMCAI55@HOTMAIL.COM','Bogota',1,'SERVICIOS',99,'2015-02-20','16038',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (358,'284784630',1947306,'AUTOSERVICIO LA RIVERA MBB','CL 70 C 111 C 47 BRR LA RIVIERA','3142708868','creminda70@hotmail.com','Bogota',1,'BIENES',99,'2017-10-05','291209',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (359,'8110153335',24418957,'NUTRINORTE','CARRERA 13 11 54','3104639708','','Bogota',5,'SERVICIOS',99,'2010-07-13','9942',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (360,'2677336',15997070,'FELIX ANTONIO ARIAS VALENCIA','CR 21 27 55','2245471','felixarias123@hotmail.com','Bogota',5,'BIENES',99,'2010-08-20','84',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (361,'900296178',8623380,'URGENCIAS VITALES DEL CASANARE','TRANSV 7 B 32 03','6345727','','Bogota',1,'SERVICIOS',99,'2014-01-20','14152',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (362,'1091658969',5679504,'ROPERO ORTEGA MARIA CAMILA','Calle 7  29 214','5697332','mcamila1088@hotmail.com','Bogota',1,'Producto',99,'2013-10-09','15960',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (363,'1098633438',316880,'CARCAMO PARRA ALBA CAROLINA','CALLE 17  14 103','5750272','karito37@hotmail.com','Bogota',1,'Producto',99,'2011-12-12','15979',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (364,'11231729',365980,'URREGO BEJARANO JOSE RICARDO','CL 18 8 81','2866778','','Bogota',1,'Producto',99,'2012-02-16','15977',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (365,'16271074',267400,'CASTAO ORTIZ CESAR NORBERTO','Calle 36  29 46','2706604','clinigafascolombia@hotmail.com','Bogota',1,'Producto',99,'2007-09-10','15980',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (366,'27091308',2249240,'MORAN MEJIA MARIA MERCEDES','Centro comercial Galerias L 110','7226793','','Bogota',1,'Producto',99,'2011-11-03','15967',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (367,'30323655',670256,'MURILLO MUOZ NORA VIRLEY  MIGUEL MEDINA','Cra 23  26 11 Loc 12','8846708','','Bogota',1,'Producto',99,'2006-07-12','15975',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (368,'37729276',1164120,'OSORIO SERRANO ANGELA PAOLA','Calle 11  15 79','5694074','','Bogota',1,'Producto',99,'2009-12-18','15971',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (369,'49764487',1532360,'ARIAS SEQUEDA NELSY MARGARITA','carrera 9  16B 72','5744009','lacasadeldeportevalledupar@hotmail.com','Bogota',1,'Producto',99,'2014-03-20','15969',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (370,'52316640',328040,'SERNA ALVAREZ LUZ ANGELA','CL 51  16 09','4872823','','Bogota',1,'Producto',99,'2013-07-08','15978',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (371,'52326463',259520,'BAYONA ROA DIANA MARCELA','Cra 15  11 49','7272901','','Bogota',1,'Producto',99,'2006-01-20','15981',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (372,'52394485',1348570,'PARRA YEPES MARGARITA','Calle 129  54 75','2262486','','Bogota',1,'Producto',99,'2015-05-15','15970',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (373,'52583986',190000,'ALCIRA ANGEL','Carrera 15  50 96','2129202','alcira-angel@hotmail.com','Bogota',1,'Producto',99,'2010-01-28','15983',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (374,'52788367',1975240,'ESPINDOLA MARTINEZ ELIZETH YOHANNA','Carrera 94  72A 77','3214996581','','Bogota',1,'Producto',99,'2013-09-30','15968',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (375,'70106569',3723686,'ALVARO ESCOBAR MONTOYA','calle 49B  65 81','5130902','','Bogota',1,'Producto',99,'2016-12-13','15964',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (376,'74182011',3039240,'RODRIGUEZ GALAN CESAR LEONEL','CRA 4  78 12','3192259796','ce-galan@hotmail.com','Bogota',1,'Producto',99,'2011-11-21','15966',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (377,'79686023',219332,'SEGURA ARANGON DAMIAN RENE','Cra 13 55 30','2350001','','Bogota',1,'Producto',99,'2012-06-26','15982',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (378,'79800461',1122680,'NOVA CORREDOR WILLIAM ARMANDO','Calle 43  22 98 Giron Poblado','6446816','','Bogota',1,'Producto',99,'2010-05-13','15972',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (379,'813008841',10745052,'DRA OFELIA DAZA','Calle 10 6 85','8714907','','Bogota',1,'Producto',99,'2008-04-02','15959',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (380,'815000021',3052900,'CLAUDIA PINILLA','Cra 12  5 63','2387620','','Bogota',1,'Producto',99,'2017-02-20','15965',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (381,'830127699',15788860,'FREDY SALGUERO','CRA 9   49 42 OF 503','6081132','','Bogota',1,'Producto',99,'2011-06-01','15957',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (382,'900116096',546320,'LA OPTICA CONSULTORIO VISUAL SAS','carrera 53  76 57 Loc 1 2','3683483','laopticacv@hotmail.com','Bogota',1,'Producto',99,'2006-01-26','15976',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (383,'900156172',4093840,'JAIRO SERRANO STA MARTA','centro comercial plaza mayales loc 11','3175862232','joyeriayrelojeriapanama@hotmail.com','Bogota',1,'Producto',99,'2014-09-18','15962',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (384,'900463050',5201620,'PILI MIRANI','CRA 66B  34A 71 IN 334 CC UNICENTRO','2350672','pilimirani@yahoo.es','Bogota',1,'Producto',99,'2014-08-04','15961',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (385,'900568208',3961516,'HUMANA DEL LLANO IPS SERVICIOS INTEGRALES DE SALUD SAS','Calle 10  17B 14 20','6625425','humanadellanoips@gmail.com','Bogota',1,'Producto',99,'2013-02-27','15963',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (386,'900659805',1039360,'CENTRAL MEDICAL GROUP SAS','CLL 33  74B  130','4116012','centralmedicalgroupsas@hotmail.com','Bogota',1,'Producto',99,'2013-11-28','15973',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (387,'91471781',899970,'RINCON CEDIEL FABIAN','Calle 36  22 82','6457437','','Bogota',1,'Producto',99,'2010-05-27','15974',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (388,'93413355',10978260,'CASTRO MENESES CARLOS ENRIQUE','Cra 6  7 17','8722099','viglassg@hotmail.com','Bogota',1,'Producto',99,'2011-04-19','15958',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (389,'900101462',4042122,'TOPEN OIL & GAS SERVICES S A EN REORGANIZACION','CARRERA 14 99 33 OFI 502','3795555','CTRUJILLO@TOPENSA.COM','Bogota',1,'SERVICIOS',99,'2010-03-09','12302',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (390,'900140469',168299595,'SAR ENERGY','CARRERA 7 71 52 TORRE A PISO 10','3269555','dpaez@sarenergy.com','Bogota',5,'SERVICIOS',99,'2012-12-31','14345',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (391,'900311842',282106401,'BETA ENERGY CORP SUCURSAL','CALLE 97 A 9 A 50','6219930','info@atinaenergy.com','Bogota',1,'SERVICIOS',99,'2010-07-16','11085',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (392,'900325892',80979865,'CONSORCIO MK ECOPETROL','AV 40 24 A 71 PISO 2','7434373','luz.carrillo@ecopetrol.com.co','Bogota',1,'SERVICIOS',99,'2014-04-20','14102',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (394,'171777088',73508000,'PINTO PINTO RICARDO','AUT MEDELLIN 20 61 u','3118110963','rpintoguerrero@gmail.com','Bogota',1,'DEVOLUCION',99,'2016-12-29','72',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (395,'241633216',33066000,'SARMIENTO ROMERO LUZ HERMINDA','VDA BULOCAIMA FCA LA PRIMAVERA','6749340','contablesasesorias2017@hotmail.com','Bogota',1,'DEVOLUCION',99,'2013-09-30','22',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (396,'28962546',42962000,'MARTINEZ MENDOZA JOSE VICENTE','CR 17 122 58 AP 407 ED VIOLONCHELO','3102692099','jvmartinezd@gmail.com','Bogota',1,'DEVOLUCION',99,'2014-11-25','27',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (397,'438649316',50820000,'RUIZ RESTREPO MONICA ELIANA','CARRERA 48 A 10 SUR 9','4658958','','Bogota',1,'DEVOLUCION',99,'2015-11-09','116',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (398,'7000183146',138367000,'LANG ALLAN JOSEPH','CL 72 10 07 AP 1302','5871014','rmedina@drummondltd.com','Bogota',1,'DEVOLUCION',99,'2016-12-15','66',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (399,'8000166373',51733000,'FOTO SEXTA LIMITADA EN LIQUIDACION','AV 5 23 B N 65','6079912','ygaviria@fotojapon.com','Bogota',1,'DEVOLUCION',99,'2013-09-25','87',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (400,'8000513194',213520000,'ENERGIA Y POTENCIA SA','CR 45 A 66 A 100','3786100','contabilidad@energiaypotencia.com','Bogota',1,'DEVOLUCION',99,'2016-06-07','101',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (401,'8000800272',35625000,'CI EXPOFARO SOCIEDAD ABSORBENTE','CL 72 44 185 N','5209400','diana.hurtado@farogroup.com.co','Bogota',1,'DEVOLUCION',99,'2013-10-15','98',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (402,'8000800272',35626000,'CI EXPOFARO SAS SOCIEDAD ABSORBENTE','CL 72 44 185','5209400','diana.hurtado@farogroup.com.co','Bogota',1,'DEVOLUCION',99,'2013-10-15','99',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (403,'8001410211',221105000,'HELM FIDUCIARIA SA ADMINISTRADORA DE HELM FIDUCI','CR 7 27 18 P 19','5818181','edwin.reyes@itau.co','Bogota',1,'DEVOLUCION',99,'2016-12-22','17',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (404,'8001410211',325886000,'HELM FIDUCIARIA SA','CR 7 27 18 P 19','5818181','edwin.reyes@itau.co','Bogota',1,'DEVOLUCION',99,'2016-12-22','16',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (405,'8001552914',135071000,'CONSTRUCTORA NORBERTO ODEBRECHT SA','CL 93 N 11 A 28 OF 301','6216218','lbf@odebrecht.com','Bogota',1,'DEVOLUCION',99,'2016-04-06','5',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (406,'8001585381',205393000,'ISRARIEGO S A S','VDA YERBABUENA CRT CENTRAL DEL NORTE KM 24 COSTADO ORIENTAL','6760022','representante.legal@israriego.com.co','Bogota',1,'DEVOLUCION',99,'2016-09-02','52',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (407,'8001852951',876229453,'AMARILO SAS','CR 19 A 90 12','6363626','josehernan.arias@amarilo.com','Bogota',1,'DEVOLUCION',99,'2016-12-19','15',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (408,'8001887021',804687000,'YARA INTERNATIONAL SAS','AV CIRCUNVALAR CI METROPARQUE BODEGA MC 11','3289380','GONZALO.QUIJANO@YARA.COM','Bogota',1,'DEVOLUCION',99,'2016-06-07','79',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (409,'8001966328',41741000,'ARTESA SAS','CR 41 46 115','4482674','bosi02@mybosi.com','Bogota',1,'DEVOLUCION',99,'2015-12-29','100',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (410,'8002118834',98610000,'MINA LA MARGARITA SAS','KM 3 VIA AL SUR PRIMAVERA CARR CALDAS AMAGA','2916139','asepulveda@minalamargarita.com','Bogota',1,'DEVOLUCION',99,'2016-11-01','84',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (411,'8002325632',162021000,'COMPAÑIA CELL NET TECNOLOGIA CELULAR S A','AV 19 139 02','7564480','contabilidad@cellnet.com.co','Bogota',1,'DEVOLUCION',99,'2015-08-21','31',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (412,'8002418105',99261000,'INDUSTRIA DE ELECTRODOMESTICOS SAS INDUSEL SAS','AUT AVENIDA CALLE 57 R SUR 67 59','7245169','','Bogota',1,'DEVOLUCION',99,'2016-02-15','82',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (413,'8002500620',29293000,'INSTITUTO DE INVESTIGACIONES MARINAS Y COSTERAS JO','CL 25 2 55 BRR RODADERO SUR PLAYA SALGUERO','4328600','angy.lora@invemar.org.co','Bogota',1,'DEVOLUCION',99,'2015-11-06','130',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (414,'8002507216',97276000,'MICROHARD S A S','AV CL 72 20 03 OF 503','2102564','contabilidad@microhard.com.co','Bogota',1,'DEVOLUCION',99,'2016-06-13','44',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (415,'8020039315',72301000,'HERRAJES ANDINA SAS','CR 53 42 08','3490864','contabilidad@herrajesandina.com','Bogota',1,'DEVOLUCION',99,'2014-02-14','77',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (416,'8020193394',140036000,'ADAMA ANDINA BV SUCURSAL COLOMBIA','CL 1 C 7 53 IN ZF','3799772','contact.us@adama.com','Bogota',1,'DEVOLUCION',99,'2016-11-02','80',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (417,'8060055649',66600000,'COMERCIALIZADORA INTERNACIONAL CASA IBANEZ ESPANA','CALLE 145  50 29 PRADO PINZON','6262815','rhumanos@casaibanez.com','Bogota',1,'DEVOLUCION',99,'2016-06-06','81',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (418,'8060083947',135024000,'ASOCIACION MUTUAL SER EMPRESA SOLIDARIA DE SALUD E','BRR LA CONCEPCION CARR TRONCAL 71 B 105','6502525','mutualser@mutualser.org','Bogota',1,'DEVOLUCION',99,'2016-12-30','89',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (419,'8080012976',64134000,'SERVIHOTELES S A','CALLE 58B No 17 35','4006868','contador@servihoteles.com.co','Bogota',1,'DEVOLUCION',99,'2015-03-11','1',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (420,'8110119099',81763381,'IGB MOTORCYCLE PARTS SAS','CL 98 SUR 48 225 BG 114','4442025','contabilidad@igbcolombia.com','Bogota',1,'DEVOLUCION',99,'2016-05-17','103',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (421,'8110229175',63892000,'SUMICAR SAS','CR 48  37   26 SAN DIEGO','3125203298','milenacontabilidad@sumicar.com.co','Bogota',1,'DEVOLUCION',99,'2015-05-28','113',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (422,'8110246306',249312356,'VIVIENDAS FINANCIADAS CONSTRUCTORA DE OBRAS SA','Carrera 54A Número 11F sur   01','3621260','obraguayabal4@epm.net.co','Bogota',1,'DEVOLUCION',99,'2013-02-11','105',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (423,'8110367449',157143000,'COSMOTRANS SAS','Cr68A 43 13 Of 307','3102235004','rmartin@cosmotrans.com.co','Bogota',1,'DEVOLUCION',99,'2016-12-20','122',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (424,'8110375913',48493000,'COMERCIALIZADORA INTERNACIONAL FLORES DE LA VICTOR','KM 4 VIA RIONEGRO EL CARMEN','5666660','lavictoria@une.net.co','Bogota',1,'DEVOLUCION',99,'2015-02-24','92',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (425,'8110401420',73032000,'SAVINO DEL BENE COLOMBIA SAS','CL 26 69 D 91 TO PEATONAL OF 603','4296069','anderson.bermudez@savinodelbene.com','Bogota',1,'DEVOLUCION',99,'2015-11-27','37',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (426,'8130027726',243142524,'ARGECO SAS','CR 47 6 41 CA 41 BRR IPANEMA','8736445','java0108@hotmail.com','Bogota',1,'DEVOLUCION',99,'2016-11-02','124',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (427,'8160038450',36865000,'AS INGENIERIA PUNTUAL SAS','CL 76 53 51','3113955','sandrabolanos@ipuntual.com','Bogota',1,'DEVOLUCION',99,'2015-10-05','33',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (428,'8190016678',33208000,'PETROLEOS DEL MILENIO SA S','VIA MAMONAL KM 9 EN ZN FRANCA LA CANDELARIA PLANTA PETROMIL SEC COSPIQUE','6424764','secretaria@petromilsa.com','Bogota',1,'DEVOLUCION',99,'2016-12-21','91',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (429,'8300023979',3668250919,'AGENCIA DE ADUANAS DHL GLOBAL FORWARDING COLOMBIA','AV CL 26 102 20 PISO 5','7469696','legales.co@dhl.com','Bogota',1,'DEVOLUCION',99,'2016-10-12','57',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (430,'8300062653',61338000,'CA SOFTWARE DE COLOMBIA SAS','CL 116 7 15 OF 1501 TO CUSEZAR','6326000','margarita.jaramilloperez@ca.com','Bogota',1,'DEVOLUCION',99,'2016-12-05','14',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (431,'8300070730',78646000,'OBCIPOL LTDA','CR 14 B 112 81 BRR SANTA BARBARA','6297896','sf.consultores@yahoo.es','Bogota',1,'DEVOLUCION',99,'2015-12-22','4',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (432,'8300201090',522645000,'VARICHEM DE COLOMBIA G ENVIRONMENTAL PROTECCION SE','CL 87 15 23 OF 304','6912870','SALES@VARICHEM.COM','Bogota',1,'DEVOLUCION',99,'2016-10-25','59',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (433,'8300288600',57722000,'L V COLOMBIA S A','CR 11 82 71 LC 147','6168573','gloria.arias@co.pwc.com','Bogota',1,'DEVOLUCION',99,'2016-12-20','67',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (434,'8300463620',38911000,'BALBOA VANDER DE COLOMBIA S A','CL 118 19 09 P 5 OF 302 BRR SANTA BARBARA','6023555','balboaco@une.net.co','Bogota',1,'DEVOLUCION',99,'2016-11-22','26',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (435,'8300486545',238088000,'SAS INSTITUTE COLOMBIA SAS','CL 116 7 15 IN 2 OF 902 ED CUSEZAR','6580888','andres.rincon@sas.com','Bogota',1,'DEVOLUCION',99,'2016-08-16','48',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (436,'8300523521',193348000,'INTERSARE S A','TV 95 BIS A 25 D 41','3264242','margarita.rubio@codere.com','Bogota',1,'DEVOLUCION',99,'2016-05-17','42',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (437,'8300567357',51978000,'MADERAS GORGONZOLA SAS','CL 12 46 07','2685496','financiero@maderasgorgonzola.com','Bogota',1,'DEVOLUCION',99,'2016-12-30','73',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (438,'8300603310',95033000,'SERVICIO TECNICO PALAS HIDRAULICAS S A S','CL 30 26 12','3751555','angel.sanchez@komatsu.com.co','Bogota',1,'DEVOLUCION',99,'2016-06-07','131',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (439,'8300731453',86850000,'ADMINISTRADORA DE HOTELES NUEVA GRANADA SA','CL 74 15 60','3175959','adriana.ortiz@ghlhoteles.com','Bogota',1,'DEVOLUCION',99,'2013-12-26','24',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (440,'8300828480',60220000,'FLUICONNECTO SERVICIOS HIDRAULICOS SAS','CR 63 4 G 29','4202184','nromero@man-par.com','Bogota',1,'DEVOLUCION',99,'2016-11-01','60',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (441,'8300913829',654637000,'HEALTHFOOD SA','CL 94 B 56 24','5932727','dmguataquirab@healthfood.com.co','Bogota',1,'DEVOLUCION',99,'2016-10-10','56',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (442,'8300932622',3988540000,'SOUTHEAST INVESTMENT CORPORATION','AV CL 82 10 33 P 7 Y 6','5934141','impuestos@vetragroup.com','Bogota',1,'DEVOLUCION',99,'2016-12-02','13',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (443,'8300932622',7047168000,'SOUTHEAST INVESTMENT','AV CL 82 10 33 P 7 Y 6','5934141','impuestos@vetragroup.com','Bogota',1,'DEVOLUCION',99,'2016-10-03','9',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (444,'8301193467',405299000,'BRIGHTSTAR COLOMBIA SAS','CR 106 15 25 MZ 9 BG 19','4046919','nidia.espitiavelandia@brighstarcorp.com','Bogota',1,'DEVOLUCION',99,'2015-12-21','3',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (445,'8301193822',72972000,'BOEING INTERNATIONAL CORPORATION','AV CL 26 103 08 IN 1 PISO 2 OFICINAS AVIANCA TERMINAL AEREO SIMON BOLIVAR HANGARES','5877700','bfsbog@boeing.com','Bogota',1,'DEVOLUCION',99,'2016-12-05','63',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (446,'8301321536',228889000,'INTCOMEX COLOMBIA SAS','AUT MEDELLIN CL 80 KM 2 PAR EMPRESARIAL TECNOLOGICO','8766700','jaime.moreno@nexsysla.com','Bogota',1,'DEVOLUCION',99,'2016-10-26','10',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (447,'8301454798',60922000,'IMETEX LTDA','CL 22 C 4 10 SUR','7592925','rreneromeros@hotmail.com','Bogota',1,'DEVOLUCION',99,'2016-06-22','45',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (448,'8320103203',35985000,'FLORES ALIANZA SA','CR 23 124 70 OF 305','8623967','infocamara@floresalianza.com.co','Bogota',1,'DEVOLUCION',99,'2013-12-04','23',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (449,'8600021538',493099000,'ALMACENES GENERALES DE DEPOSITO ALMAVIVA SA','CR 13 A 34 72 P 11','7448500','notificaciones@almaviva.com.co','Bogota',1,'DEVOLUCION',99,'2015-11-11','2',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (450,'8600024596',970238000,'CONSORCIO METALURGICO NACIONAL LTDA','CL 45 A SUR 60 57','7280211','conta@tuboscolmena.com','Bogota',1,'DEVOLUCION',99,'2013-06-17','83',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (451,'8600029644',29662000,'BANCO DE BOGOTA S A','CALLE 10 A  3 45 PISO 6','2770202','1bancodebogota@hotmail.com','Bogota',1,'DEVOLUCION',99,'2013-08-26','95',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (452,'8600048559',160653000,'GOODYEAR DE COLOMBIA SA','Km 10 vía Cali Yumbo','3147908704','angelica_bedoya@goodyear.com','Bogota',1,'DEVOLUCION',99,'2015-06-26','132',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (453,'8600107999',62350000,'ISTITUZIONE LEONARDO DA VINCI','CR 21 127 23','2586295','istituzione@cable.net.co','Bogota',1,'DEVOLUCION',99,'2016-07-13','47',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (454,'8600501460',904975000,'INGECONTROL SA','CR 14 B 109 45','6295564','ingecontrol@ingecontrol.com.co','Bogota',1,'DEVOLUCION',99,'2015-11-18','36',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (455,'8600561508',36361000,'BASF QUIMICA COLOMBIANA S A','CL 99 69 C 32 BRR MORATO','3208668705','alberto.zuniga@basf.co','Bogota',1,'DEVOLUCION',99,'2016-10-03','8',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (456,'8901109850',490587000,'SATOR SAS','CARRERA 43 A 1 A SUR 143 TORRE NORTE PISO 1','3137591937','','Bogota',1,'DEVOLUCION',99,'2016-03-16','117',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (457,'8903010334',70106000,'TECNOPLAST SAS','CR 5 N 40 07 BRR POPULAR','4313232','graciela_vera@tecnoplast.com.co','Bogota',1,'DEVOLUCION',99,'2015-11-20','88',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (458,'8903154306',33351930,'AGRICOLA COLOMBIANA SA','CR 100 16 20 OF 801 ED AVENIDA 100','3333445','contabilidad@agricol.com.co','Bogota',1,'DEVOLUCION',99,'2015-06-05','86',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (459,'8904005141',32569271,'AGRINAL COLOMBIA SAS','CR 42 33 80','4448411','impuestos@solla.com','Bogota',1,'DEVOLUCION',99,'2015-08-20','97',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (460,'8909001619',2065651000,'PRODUCTOS FAMILIA SA','Cr50 8 S 117 ','3609534','','Bogota',1,'DEVOLUCION',99,'2016-11-17','119',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (461,'8909002323',27597000,'INDUSTRIAS METALURGICAS APOLO SA','Cra 41 No 69 D 25 Local 6','3184813731','petraruidiaz@apolo.net.co','Bogota',1,'DEVOLUCION',99,'2014-08-27','111',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (462,'8909002663',47309000,'GRUPO ARGOS SA','Cr43 A 1 A S 143 ',' 3198700','','Bogota',1,'DEVOLUCION',99,'2014-05-22','110',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (463,'8909006089',37116044,'ALMACENES EXITO SA','CR 48 CL 32 B SUR 139','3396565','clara.angel@grupo-exito.com','Bogota',1,'DEVOLUCION',99,'2015-03-16','93',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (464,'8909039388',36734000,'BANCOLOMBIA SA','Cr48 26 85','3430000','1gerente761@bancolombia.com.co','Bogota',1,'DEVOLUCION',99,'2013-03-15','107',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (465,'8909039388',36801000,'BANCOLOMBIA','Cr48 26 85 N','3430000','1gerente761@bancolombia.com.co','Bogota',1,'DEVOLUCION',99,'2013-03-15','106',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (466,'8909149797',36812000,'PROQUIDENT SA','CL 48 C SUR 43 A 249','2886055','PROQUIDENT@UNE.NET.CO','Bogota',1,'DEVOLUCION',99,'2016-12-30','94',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (467,'8909291719',114616000,'FLORES DEL LAGO SAS CI','VEREDA EL TABLAZO','5616181','gerencia@floresdellago.com','Bogota',1,'DEVOLUCION',99,'2013-06-18','128',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (468,'8909298771',157731000,'COMPASS GROUP SERVICES COLOMBIA S A','AUT NORTE 235 71','5082424','cgscolombia@compass-group.com.co','Bogota',1,'DEVOLUCION',99,'2015-11-11','12',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (469,'8909300221',30540000,'COMPLEMENTOS HUMANOS SA','Cra 43b  16 95','4441281','','Bogota',1,'DEVOLUCION',99,'2016-09-08','134',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (470,'8909300221',74984000,'COMPLEMENTOS HUMANOS','Cra 43b  16 95 N','4441281','','Bogota',1,'DEVOLUCION',99,'2016-09-06','133',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (471,'8909350858',105821000,'TRANSPORTADORA DE CARGA ANTIOQUIA SAS','CL 79 SUR 47 E 10','3128974162','contabilidad@carga.com.co','Bogota',1,'DEVOLUCION',99,'2016-08-19','129',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (472,'8911004456',2352298000,'ORGANIZACION ROA FLORHUILA SA','CR 10 97 A 13 P 4 TO B','6449420','impuestos@orf.com.co','Bogota',1,'DEVOLUCION',99,'2016-11-03','11',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (473,'8913015496',33804850,'NUTRIENTES AVICOLAS SA','Cl 64 N 5 B 146 Trr A Of 403 ','3174409181','','Bogota',1,'DEVOLUCION',99,'2014-10-14','85',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (474,'9000194603',59908000,'JURISCOOP SERVICIOS JURIDICOS SA HOY SERVICIOS J','CL 70 A 11 83','5439850','laguadogiraldo@yahoo.com','Bogota',1,'DEVOLUCION',99,'2015-05-07','30',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (475,'9000374126',132752000,'PROMOTORA A J SEGUROS LTDA','CL 85 A 21 70','6349021','rromerola@sura.com.co','Bogota',1,'DEVOLUCION',99,'2016-11-22','62',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (476,'9000531981',106844000,'ALEXANDRA FARMS','CR 7 113 43 OF 1507 N','6294145','ALEXANDRAFARMS@GMAIL.COM','Bogota',1,'DEVOLUCION',99,'2016-12-07','64',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (477,'9000531981',121742000,'ALEXANDRA FARMS S A S','CR 7 113 43 OF 1507','6294145','ALEXANDRAFARMS@GMAIL.COM','Bogota',1,'DEVOLUCION',99,'2016-12-09','65',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (478,'9000559171',26859000,'FOCO URBANO SAS','CR 4 B 26 A 39 OF 404','2571144','PASTRANA@FOCOURBANO.COM','Bogota',1,'DEVOLUCION',99,'2013-02-13','18',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (479,'9000592385',67345000,'MAKRO SUPERMAYORISTA SAS','CL 192 19 12','6782169','notificaciones@makro.com.co','Bogota',1,'DEVOLUCION',99,'2016-04-21','6',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (480,'9000617375',45818000,'SELECTO EXPORTADORES SA CI','KM 14 VIA MAGDALENA CENTRO LOGISTICO TESORITO BODEGA 1','8742068','admon@selectocoffee.com','Bogota',1,'DEVOLUCION',99,'2014-12-18','104',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (481,'9000723031',519075000,'AGUAS REGIONALES EPM SA ESP','CALLE 97 A 104 13','8286657','','Bogota',1,'DEVOLUCION',99,'2016-10-18','74',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (482,'9000951326',161849000,'COMERCIALIZADORA INTERNACIONAL EQUITRONICA SAS','COMPLEJO INDUSTRIAL CELTA TRADE PARK LT 147 KM 7 1 AUT BO','7562457','VORKOM@EQUITRONICA.COM.CO','Bogota',1,'DEVOLUCION',99,'2016-10-03','54',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (483,'9000963721',31833000,'INVERSIONES LIBOS AUTOMOVILES Y CIA LTDA','CL 99 11 26','2187899','constructoratomina@gmail.com','Bogota',1,'DEVOLUCION',99,'2013-06-08','43',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (484,'9000989855',76646000,'ORGANIZACION VIHONCO IPS SOCIEDAD POR ACCIONES SIM','CARRERA 48A SUR 10  9','6046769','','Bogota',1,'DEVOLUCION',99,'2015-09-23','115',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (485,'9001095622',27515560,'LATINAGRO SA EN REORGANIZACION EMPRESARIAL','CALLE 81   48 91 BLOQUE 5 LOCAL 14','2851222','eacosta@latinagro.com.co','Bogota',1,'DEVOLUCION',99,'2014-12-30','96',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (486,'9001260275',82000000,'FENWAL COLOMBIA LTDA','CL 99 10 19 OF 701','7560404','javier.davila@fresenius-kabi.com','Bogota',1,'DEVOLUCION',99,'2014-10-17','25',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (487,'9001266550',60730000,'GANADERIA ALTAMIRA SA','CALLE 11 SUR   50 50','2850755','asa.inmobiliaria@navitrans.com.co','Bogota',1,'DEVOLUCION',99,'2016-12-16','121',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (488,'9001345707',1703777000,'TELEFONICA INTERNATIONAL WHOLESALE SERVICES COLOMB','TV 60 114 A 55','7051741','cesar.parrap@telxius.com','Bogota',1,'DEVOLUCION',99,'2015-06-29','29',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (489,'9001387568',280807000,'INVERSIONES JAIBU SAS','CALLE 50   53   57','5113903','flurycita@gmail.com','Bogota',1,'DEVOLUCION',99,'2013-06-11','108',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (490,'9001509832',57749000,'INCUBADORA DEL SUR LIMITADA','VEREDA CAMPO ALEGRE','7316324','incubadoradelsur@gmail.com','Bogota',1,'DEVOLUCION',99,'2016-12-05','126',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (491,'9001549887',731465000,'K C ANTIOQUIA GLOBAL LTDA','VDA CANAAN','4547600','','Bogota',1,'DEVOLUCION',99,'2013-06-09','114',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (492,'9001549887',1143122000,'K C ANTIOQUIA GLOBAL','VDA CANAAN N','4547600','','Bogota',1,'DEVOLUCION',99,'2013-11-26','109',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (493,'9001628148',29774000,'HULTEC NSA','CL 77 B 57 141 CENTRO EMPRESARIAL AMERICAS I OFC 601','3569307','hultecnsa@hultec.com','Bogota',1,'DEVOLUCION',99,'2013-11-15','75',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (494,'9001628148',32109000,'HULTEC NSA LTDA','CL 77 B 57 141 CENTRO EMPRESARIAL LAS AMERICAS I OFC 601','3569307','hultecnsa@hultec.com','Bogota',1,'DEVOLUCION',99,'2013-11-15','76',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (495,'9001647550',52552000,'ZONA FRANCA ARGOS SAS','ZN INDUSTRIAL MAMONAL KM 7','6689200','sleon@argos.com.co','Bogota',1,'DEVOLUCION',99,'2016-10-03','90',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (496,'9001755268',110954000,'INFOPRINT SOLUTIONS COMPANY LLC SUCURSAL COLOMBIA','CR 85 K 46 A 66 ED SAN CAYETANO 2 P 5','4578999','jacqueline.fique@ricoh.com.co','Bogota',1,'DEVOLUCION',99,'2016-02-23','40',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (497,'9001847223',2331835000,'ALFACER DEL CARIBE SA','ZF LA CAYENA KM 8 VIA BARRANQUILLA  TUBARA','3361000','lilibeth.ojeda@alfa.com.co','Bogota',1,'DEVOLUCION',99,'2014-09-19','78',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (498,'9002073681',88336000,'MILENIUM ASESORES INTEGRALES DE SEGUROS BOGOTA LIM','CR 7 70 A 21 OF 303','3123535','administracionbogota@mileniumasesores.com.co','Bogota',1,'DEVOLUCION',99,'2016-10-20','58',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (499,'9002342869',71899000,'MCAFEE COLOMBIA LTDA','AK 45 108 27 TO 2 OF 1303','5111700','antonioduartea@duartenet.com','Bogota',1,'DEVOLUCION',99,'2016-06-14','28',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (500,'9002418953',34841000,'HEPTA CONSULTORES SAS','KM 8 VIA LLANOGRANDE LC 43 COMPLEX','4447737','','Bogota',1,'DEVOLUCION',99,'2016-09-01','127',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (501,'9002561500',53935000,'ICON HOLDINGS CLINICAL RESEARCH INTERNATIONAL LIMI','CR 7 73 55 P 9','5893700','alejandro.infante@iconplc.com','Bogota',1,'DEVOLUCION',99,'2016-12-21','68',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (502,'9002561500',104864000,'ICON HOLDINGS CLINICAL RESEARCH INTERNATIONAL','CR 7 73 55 P 9','5893700','alejandro.infante@iconplc.com','Bogota',1,'DEVOLUCION',99,'2015-11-12','35',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (503,'9002561500',107957000,'ICON HOLDINGS CLINICAL RESEARCH INTERNATIONAL LIMITADA','CR 7 73 55 P 9 N','5893700','alejandro.infante@iconplc.com','Bogota',1,'DEVOLUCION',99,'2015-12-09','38',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (504,'9002825234',26950000,'AGROMAYO  LTDA','CR 28 49 A 66','3588781','agromayo.2009@gmail.com','Bogota',1,'DEVOLUCION',99,'2013-07-30','21',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (505,'9003067623',34068000,'PRODUCCIONES RTI SAS','CL 80 11 42 TO SUR OF 501','6406247','yvalencia@rtitv.com','Bogota',1,'DEVOLUCION',99,'2016-09-09','7',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (506,'9003278320',29829000,'CONAUTOS COLOMBIA S A S EN LIQUIDACION','AK 72 170 51 IN 8','7427362','bibiana.rojas@casatoro.com','Bogota',1,'DEVOLUCION',99,'2016-02-10','39',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (507,'9003660575',144622000,'CONTOURGLOBAL MANAGEMENT SERVICES COLOMBIA SAS E','KM 3 VIA CENCAR AEROPUERTO','6905910','correspondenciate@contourgloblal.com','Bogota',1,'DEVOLUCION',99,'2016-11-18','125',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (508,'9003766205',60574000,'INVERSIONES INMOBILIARIAS EL PRADO SAS EN LIQUIDAC','CR 19 A 90 12','6340000','lyda.mahecha@amarilo.com','Bogota',1,'DEVOLUCION',99,'2016-12-27','70',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (509,'9004005518',33848000,'UPS SERVICIOS EXPRESOS SAS','AC 26 106 81 BG 88 97','4238775','olgaconstanzagonzalez@ups.com','Bogota',1,'DEVOLUCION',99,'2015-09-21','32',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (510,'9004286951',443718000,'PAUTEFACILCOM SAS','CR 15 92 36 OF 402 B','3212337641','rubianomorales@hotmail.com','Bogota',1,'DEVOLUCION',99,'2016-12-28','71',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (511,'9004297528',33823000,'UNION TEMPORAL INDUINT','AV CR 24 39 09','8053696','info@interamericana.com.co','Bogota',1,'DEVOLUCION',99,'2013-07-12','20',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (512,'9004343604',28901000,'CONSORCIO MURESP','CR 8 A 99 51 TO A OF 206','2187709','efrain.torres@murcia.com.co','Bogota',1,'DEVOLUCION',99,'2013-05-22','19',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (513,'9004773472',29804000,'VITOL COLOMBIA CI S A S','CR 11 77 A 49 OF 201','7495116','SRG@vitol.com','Bogota',1,'DEVOLUCION',99,'2016-12-27','69',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (514,'9004819072',30081000,'XANGO COLOMBIA SAS','CL 74 15 80 TO 2 OF 718','2553024','CONTABILIDAD@EFYC.COM.CO','Bogota',1,'DEVOLUCION',99,'2016-03-31','41',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (515,'9005050605',121140000,'EMPRESA INDUSTRIAL Y COMERCIAL DEL ESTADO','CR 11 93 A 85','7423368','mgallo@coljuegos.gov.co','Bogota',1,'DEVOLUCION',99,'2016-08-29','50',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (516,'9005050605',164879000,'EMPRESA INDUSTRIAL Y COMERCIAL DEL ESTADO ADMINIST','CR 11 93 A 85','7423368','mgallo@coljuegos.gov.co','Bogota',1,'DEVOLUCION',99,'2016-09-16','53',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (517,'9005114129',50216000,'METATRON PRODUCCIONES SAS','TV 1 84 A 87 AP 601','6107429','dianapao_1209@hotmail.com','Bogota',1,'DEVOLUCION',99,'2016-08-22','49',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (518,'9005243696',78431000,'ACEROS Y FIGURACION SAS','CARRERA 42 46 293','4486360','','Bogota',1,'DEVOLUCION',99,'2016-10-26','102',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (519,'9005519191',31848000,'GRUPO PROMOTOR AVENIDA SAS','CARRERA 43 B 16 95 PISO 8','5603990','','Bogota',1,'DEVOLUCION',99,'2016-08-02','118',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (520,'9005691432',166945000,'THE BOSTON CONSULTING GROUP SAS','CL 90 11 13 P 7','3221500','firavitoba.hector@bcg.com','Bogota',1,'DEVOLUCION',99,'2016-06-28','46',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (521,'9005747051',43755000,'FELGUERA I H I S A SUCURSAL COLOMBIA','CR 11 B 97 56 OF 201 ED APICE 97','6188000','manuel.jurado@felguera-ihi.com','Bogota',1,'DEVOLUCION',99,'2016-09-01','51',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (522,'9005837454',566139000,'HOLCREST SAS','CARRERA 52 67 A 15','3209362','','Bogota',1,'DEVOLUCION',99,'2016-12-13','120',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (523,'9006154022',34536000,'LIVIT S A S','CL 94 11 30 P 12','7463737','joel.medina@grupolivit.com','Bogota',1,'DEVOLUCION',99,'2016-11-09','61',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (524,'9006213534',33878000,'JARAMILLO RUENDES & ASOCIADOS SAS','CARRERA 43 A 1 SUR 31 OF 209','3522087','','Bogota',1,'DEVOLUCION',99,'2015-02-03','112',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (525,'9006351213',45292000,'BETA INVESTMENTS SAS','CR 7 71 52 TO B OF 1101','7431142','info@venturacapital.co','Bogota',1,'DEVOLUCION',99,'2016-10-06','55',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (526,'9007088831',106249000,'GRUPO VIVELL SAS',' Calle 30  69 252','4480750','','Bogota',1,'DEVOLUCION',99,'2016-12-28','123',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (527,'822002491',138000,'ASOLLANOS LTDA','CL 15 37 J 16 BRR OCTAVA ETAPA ESPERANZA','6705302','gerencia@asollanos.com','Bogota',1,'SERVICIO',99,'2016-06-24','168',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (528,'830122276',525000,'COOPERATIVA DE TRABAJO ASOCIADO SERVICOPAVA','CR 20 39 A 20','3188219192','contabilidad@coopava.com','Bogota',1,'SERVICIO',99,'2015-12-25','160',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (529,'860002400',1595000,'SEGUROS LA PREVISORA SA','CL 57 9 07','3485757','tributaria@previsora.gov.co','Bogota',1,'SERVICIO',99,'2014-01-10','157',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (530,'860009578',553000,'SEGUROS DEL ESTADO','CARRERA 11 no 90 20','2186977','jesus.camacho@segurosdelestado.com','Bogota',1,'SERVICIO',99,'2015-12-11','161',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (531,'860013683',140000,'COOPERATIVA DE TRABAJADOR DE AVIANCA COOPAVA','CR 20 39 A 20 N','3176362286','contabilidad@coopava.com.co','Bogota',1,'SERVICIO',99,'2016-05-22','167',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (532,'860037013',304540,'SEGUROS MUNDIAL','CLL 33 No  6 B 24 P 2 Y 3','2855600','jgonzalez@segurosmundial.com.co','Bogota',1,'SERVICIO',99,'2015-12-10','162',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (533,'890200148',1500000,'CLUB DEL COMERCIO DE BUCARAMANGA SA','CR 20 35 35','6331871','direccioncontable@clubdelcomercio.com','Bogota',1,'SERVICIO',99,'2017-05-04','159',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (534,'890903407',711000,'SEGUROS GENERALES SURAMERICANA S A','Carrera 11 No  93 46 Piso 7','3105610801','wdiaz@sura.com.co','Bogota',1,'SERVICIO',99,'2011-05-06','154',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (535,'900157348',1629000,'CONSTRUCTORA ARSEN S A S','CR 45 A 93 40','4707841','carolinagarcia@constructoraarsen.com','Bogota',1,'SERVICIO',99,'2016-07-21','169',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (536,'900170405',2194500,'MEDICAL PROTECTION LTDA SALUD OCUPACIONAL','CR 12 71 19','7953260','medicalprotection@gmail.com','Bogota',1,'SERVICIO',99,'2016-05-31','156',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (537,'900264088',26038996,'HERSQ ASESORIAS Y CONSULTORIAS EMPRESARIALES SAS','CR 50 96 97','3194608233','grozo@hersq.com','Bogota',1,'SERVICIO',99,'2016-09-12','155',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (538,'900451544',2854000,'PETROMAC INGENIERIA SAS','CR 15 68 31 BRR LA VICTORIA','6953922','petromac.ingenieria@gmail.com','Bogota',1,'SERVICIO',99,'2016-05-02','164',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (539,'900547375',422000,'QS1 SOCIEDAD POR ACCIONES SIMPLIFICADAS SAS','CALLE 36 N  31 39 OFI 316 PISO 3 CENTRO EMPRESARIAL','3102871898','gerencia@qs1.com.co','Bogota',1,'SERVICIO',99,'2017-12-09','163',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (540,'900646196',16710992,'ALAR CONSTRUCCIONES SAS','CL 3 A N 8 150 MZ B 01 CA 4 BRR LA RIOJA','3203838320','lamado15@gmail.com','Bogota',1,'SERVICIO',99,'2015-09-24','158',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (541,'900728470',777000,'MEDICALGROUP ESPECIALISTAS EN SALUD OCUPACIONAL IPS SAS','CARRERA 24 N  45 16','3400335','gerencianacional@medicalgroupss.com','Bogota',1,'SERVICIO',99,'2016-05-01','165',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (542,'91495988',3976000,'LUIS ERNESTO RINCON MANTILLA','CR 5 8 03 BRR SANTA ANA','3145474048','luisener2009@hotmail.com','Bogota',1,'SERVICIO',99,'2016-05-23','166',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (543,'830058286',331680583,'ANTEK','NA','NA','NA','Bogota',5,'NA',99,'2015-02-20','AVSAFETECNOLOGY',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (544,'80421169',19684420,'SANDRA PARTICIA SANCHEZ','KM 1.5 VARIANTE COTA-CHIAPAO DE AGUA CASA 44','3188217773','SANDRAPATRICIA1974@HOTMAIL.COM','Bogota',2,'BIENES',99,'2016-02-02','CALAZANS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (545,'900206882',54257127,'CELK MERCADEO INVERSIONES E.U (CONGELADORES)','CLL 12B 1661 APTO 1','3205316568','CELKHERNANDEO@HOTMAIL.COM','Bogota',5,'BIENES',99,'2015-12-31','COLOMBINA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (546,'4168860',50639941,'SAEL HERNANDO SALCEDO BONILLA','CALLE 24 No 25-41','3108602043','boyacadistribuciones1@hotmail.com','Bogota',2,'BIENES',99,'2017-06-17','COLOMBINA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (547,'900698911',37050000,'RENAL MEDICARE SAS','NA','NA','NA','Bogota',5,'NA',99,'2016-04-23','DISCLINICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (548,'900394177',913000000,'MASIVO CAPITAL S.A.S','Av. Calle 26 N° 59-51 Torre 3 Oficina 504','3134576729 ','NA','Bogota',5,'BIENES',99,'2016-07-03','EUROPARTES',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (549,'830048947',89412436,'CONFECCIONES JESSUA  LTDA','CL 37 SUR  68H 90','4037476','NA','Bogota',5,'TELAS',99,'2012-01-17','FABRICATO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (550,'1110480914',9792254,'RODRIGUEZ HERNANDEZ SINDY LORENA','MZ 1 CA 1 LOS MANDARINOS','2778261','sindylo10@hotmail.com','Bogota',2,'TELAS',99,'2015-06-15','FABRICATO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (551,'1140835674',2637109,'CERA CEPEDA MARLON DAVID','CL 59  49 55','3014818314','NA','Bogota',2,'TELAS',99,'2015-06-15','FABRICATO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (552,'20201779',18000000,'LUCRECIA GAITAN','NA','NA','NA','Bogota',5,'NA',99,'2015-06-15','FIDECOMISO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (553,'900023731',116000000,'AVALLTECH S.A','CALLE 4 No 6AN-10','6658583','NA','Bogota',5,'Servicio',99,'2011-04-11','HECTOR MANCHOLA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (554,'93297347',15000000,'GABRIEL ALEXANDER VARON','NA','NA','NA','Bogota',5,'NA',99,'2015-10-01','HECTOR RAFAEL RUBIANO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (555,'860058303',1403671,'CEP CONSTRUCTORES ASOCIADOS SA','CALLE 22 B  32 B 22','2695566','cep@cepconstructores.com','Bogota',2,'Servicio',99,'2017-07-18','IGNACIO REINA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (556,'80009707',5498300,'VACA MUU SAS EN LIQUIDACION','NA','NA','NA','Bogota',5,'NA',99,'2014-10-06','IVAN RICARDO MARTINEZ GARCIA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (557,'7165704',8000000,'JOSE ORLANDO GARCIA','NA','NA','NA','Bogota',5,'NA',99,'2011-10-01','JUAN PABLO IBARRA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (558,'71621012',22808818,'WILLIAN ORLANDO ESCOBAR','NA','NA','NA','Bogota',5,'NA',99,'2009-12-05','MANUFACTURAS ELIOT',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (559,'828002013',8000000,'LA CORPORACION OZONO','CALLE 16A No 6g-55','4357621','NA','Bogota',2,'Servicio',99,'2017-06-01','MARIO RAMIREZ',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (560,'80091859',150000000,'LUIS FERNANDO MARTINEZ','NA','NA','NA','Bogota',5,'NA',99,'2012-09-28','MAURO PETRUCHELI',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (561,'817000248',137856367,'ASMET SALUD','CARRERA 7 No 23 27','6452187','NA','Bogota',5,'BIENES',99,'2016-04-01','MEDICAL HEAL CARE',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (562,'93369187',60000000,'CESAR AUGUSTO LONGAS','NA','NA','NA','Bogota',5,'NA',99,'2015-07-17','MIGUEL ANGEL CASTILLO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (563,'8305020890',80000000,'INVERSIONES MORENO TAMAYO','NA','NA','NA','Bogota',5,'NA',99,'2008-11-27','NESTLE DE COLOMBIA S.A.',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (564,'19144356',49000000,'JESUS HUMBERTO RICARDO ROJAS (CLIENTE COJUNAL)','NA','NA','NA','Bogota',5,'NA',99,'2008-11-27','NUBIA ESPERANZA CABEZAS -MARIA STELLA HERNANDEZ DE CABE',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (565,'8300741845',573667283,'SALUD VIDA EPS','NA','3274141','NA','Bogota',5,'BIENES',99,'2015-10-16','PHARMACEUTICAL HEAL',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (566,'830074194',368515640,'SALUD VIDA','NA','NA','NA','Bogota',5,'NA',99,'2009-03-31','SIES CLINICA CANDELARIA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (567,'860062020',37768484,'ILAM SAS','NA','NA','NA','Bogota',5,'NA',99,'2013-01-17','SOLSIN',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (568,'51880456',591082,'BUITRAGO JIMENEZ LIDA','CRA 26A N 41A 09 SUR','7676560','tropicalgel@hotmail.com','Bogota',5,'BIENES',99,'2014-11-24','TEAM',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
COMMIT;

#
# Data for the `wallets_tempo` table  (LIMIT 500,500)
#

INSERT INTO `wallets_tempo` (`id`, `idNumber`, `capitalValue`, `legalName`, `address`, `phone`, `email`, `ciudad`, `idStatus`, `product`, `idAdviser`, `validThrough`, `accountNumber`, `idCampaign`, `migrate`, `lote`, `titleValue`, `typePhone1`, `countryPhone1`, `cityPhone1`, `phone1`, `typePhone2`, `countryPhone2`, `cityPhone2`, `phone2`, `typePhone3`, `countryPhone3`, `cityPhone3`, `phone3`, `nameReference1`, `relationshipReferenc1`, `countryReference1`, `cityReference1`, `commentReference1`, `nameReference2`, `relationshipReference2`, `countryReference2`, `cityReference2`, `commentReference2`, `nameReference3`, `relationshipReference3`, `countryReference3`, `cityReference3`, `commentReference3`, `nameEmail1`, `email1`, `nameEmail2`, `email2`, `nameEmail3`, `email3`, `typeAddress1`, `address1`, `countryAdrress1`, `cityAddress1`, `typeAddress2`, `address2`, `countryAddress2`, `cityAddress2`, `typeAddress3`, `address3`, `countryAddress3`, `cityAddress3`, `typeAsset1`, `nameAsset1`, `commentAsset1`, `typeAsset2`, `nameAsset2`, `commentAsset2`, `typeAsset3`, `nameAsset3`, `commentAsset3`) VALUES 
  (569,'900656744',10801865,'D´NEYLA REPOSTERIA SAS','CRA 68 H2 C 77 PISO 1 LC 3','310301850','dneylasas@hotmail.com','Bogota',5,'BIENES',99,'2014-10-01','TEAM',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (570,'8911000249',65131397,'Almacenes Yep Neiva','NA','NA','NA','Bogota',5,'NA',99,'2014-09-25','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (571,'9003187585',29133156,'Pharmaceutical Health Care SAS','NA','NA','NA','Bogota',5,'NA',99,'2015-07-01','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (572,'220588378',51381304,'Agencia de Abarrotes MR','NA','NA','NA','Bogota',2,'NA',99,'2017-03-08','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (573,'986621599',21894777,'Distribucol','NA','NA','NA','Bogota',2,'NA',99,'2016-10-21','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (574,'9000273963',31365614,'Los Chagualos Prado','NA','NA','NA','Bogota',2,'NA',99,'2016-10-21','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (575,'9004251480',7699811,'Nutriendo y Conservando S.A.S.','NA','NA','NA','Bogota',2,'Na',99,'2016-11-08','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (576,'9004934288',4658093,'INVERSIONES FONSECA GARCIA S.A.S.','NA','NA','NA','Bogota',2,'NA',99,'2016-11-08','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (577,'9005210555',34866177,'Soluciones para Empaques S.A.S','NA','NA','NA','Bogota',2,'NA',99,'2017-03-24','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (578,'10386263681',6538746,'El Mundo del Bebe Supia','NA','NA','NA','Bogota',2,'NA',99,'2017-03-07','TECNOQUIMICAS',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (579,'11201185',17100000,'JUAN RICARDO MOYA CASTILLO','CALLE 2 SUR 5 -96','3102654076','yamidgama@hotmail.com','Bogota',1,'BIENES',99,'2016-11-30','8',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (580,'900068853',111800000,'LOGINET INTERNACIONAL','CARRERA 73 No 53 - 04','3112740066','JCASTELLANOS@LOGINETLTDA.COM','Bogota',1,'CONTRATO',99,'2016-06-01','18059',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (581,'881977350',5603929,'ABASTO CAMILO ORLANDO','MODULO 2 BODEGA 17 LA NUEVA SEXTA CENTRAL MAYORISTA URB GARCIA HERREROS','3103155060','jreyesvillan@hotmail.com','Bogota',1,'factura',99,'2012-02-20','635946',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (582,'2,16E+11',18888870,'DYSTOY S.A.','CALLE SOLANO GARCIA 2559 MONTEVIDEO CHILE','27125554','carteraroflex@gmail.com','Bogota',2,'18888870',99,'2011-09-08','171',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (583,'52503386',2085680,'MORENO SUBIETA MARTA ALEXANDRA','CALLE 23 No 66 - 46 CONS 820','2202700 - 7820','alexandramz@hotmail.com','Bogota',2,'FACTURA',99,'2015-05-23','172',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (584,'52962727',813440,'LORENA MERCEDES CARVAJAL BELTRAN','CALLE 6 No 9A - 17','3115178560','locabel10@hotmail.com','Bogota',1,'FACTURA',99,'2011-10-20','173',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (585,'830093104',11238157,'CI EXPOCOLOMBIA LIMITADA','AC 13 CALLE 133 No 104 - 7','3015197000','EXPOCOLOMBIA@HOTMAIL.COM','Bogota',1,'FACTURA',99,'2015-07-17','9',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (586,'830096315',121192252,'AIR FLOWER C I LTDA','CARRERA 13 No 5A - 20 BDG 26A','3108192821','account@airflowerci.com','Bogota',1,'121192252',99,'2013-04-14','10',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (587,'986621599',14528409,'DISTRIBUCOL','CALLE 93 No 96A - 69','3183058492','comprasdistribucol@gmail.com','Bogota',1,'FACTURA',99,'2017-05-18','121',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (588,'900054711',11447307,'EPK KIDS SMART SAS','CALLE 82 No 55 - 55 OF 101','3822889','info@shopek.com.co','Bogota',2,'FACTURA',99,'2017-09-01','FAMOSO',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (589,'900843210',8000000,'GOLDEN PLATINO SAS','CARRERA  80ANo 32 EE - 72 OF 1009','2506438','alba.cecilia@goldenplatinocolombia.com','Bogota',1,'FACTURAS',99,'2017-03-31','170',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (590,'32894444',1800000,'SANDOVAL MOLINA SANDRA MILENA','TV 2 B SUR D 76 57','3042417023','yotevoyamar01@hotmail.com','Bogota',1,'CONGELADORES',99,'2017-01-01','COLOMBINA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (591,'52397114',9764104,'DIANA PATRICIA CORREA','CARRERA 93 No 132 - 62','3008595879','dianacorrea79@yahoo.com','Bogota',1,'PENSION',99,'2016-02-01','85',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (592,'900590927',65000290,'TEXTYBRANDS S.A.S.','CR 62 12 50','7462665','isaoulet@hotmail.com','Bogota',1,'FACTURA',99,'2017-03-01','175',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (593,'900574224',31171897,'LA GLORIETA BELLO','CALLE 51 No 45 -59','3136126953','laglorietabello@gmail.com','Bogota',1,'FACTURA',99,'2017-04-30','COLOMBINA',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (594,'1407395',23863458,'EUTIMIO ANTONIO ADARBE VARGAS','carrera 7 No 13 - 98','3348129','claligilo@hotmail.com','Bogota',1,'BIENES',99,'2016-04-16','18073',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (595,'900501552',22567623,'EQUIPOS Y TERRATEST S A S','CARREA 7 No 114 - 33 OF 605','3101331','contabilidad@equiposyterratest.com','Bogota',1,'FACTURA',99,'2016-03-02','118',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (623,'72040948',2366290,'MIGUEL ANGEL GIRALDO QUINTERO','CLL 17 N 4 49','3165268853','VELMAR_711@GMAIL.COM','Bogota',1,'BIENES',99,'2018-04-19','18023',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (624,'73548726',51530891,'JHON JAIRO BUELVAS MALO','FUNDACION','3126955201','','Bogota',1,'BIENES',99,'2017-04-30','18071',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (625,'77181497',19800000,'CARLOS SILVA DISTRIBUCIONES','CRA 166 N 23 32 BRR SIMON BOLIVAR  CLL 16B CRA 8','3116829528','CARLOSSOLVAZULETA@HOTMAIL.COM','Bogota',5,'BIENES',99,'2017-08-13','10256',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (626,'80236620',5885735,'HENRY WERNEY ACEVEDO CASTELLANOS','CALLE 54 C SUR 95 A 18','3114844664','PAPELERIAUNIMAGIC@HOTMAIL.COM','Bogota',1,'BIENES',99,'2018-12-31','14344',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (627,'900206882',54257127,'CELK MERCADEO INVERSIONES E U','CLL 12B 1661 APTO 1','3205316568','CELKHERNANDEO@HOTMAIL.COM','Bogota',5,'BIENES',99,'2018-12-31','18033',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (628,'900333984',2000000,'TRANSPORTES EL TESORO SAS','CLL 40 E SUR 32 26','3217278014','LEIDYC.LAR@GMAIL.COM','Bogota',1,'BIENES',99,'2017-12-26','12356',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (629,'900439707',110831798,'COMERCIALIZADORA ICE CITY','AVENIDA 42 N 30 B 21','6829492','comercializadoraicecity@hotmail.com','Bogota',2,'BIENES',99,'2018-02-01','18132',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (630,'900872915',45116164,'LA GRAN TIENDA DISTRUBUCIONES SAS','KILIMETRO 7 VIA GIRON  CRR 13 N5779','6199174','','Bogota',5,'BIENES',99,'2017-12-31','17007',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (631,'92521535',17450155,'LORA ALVAREZ ROGER FRANCISCO','CLL  30 27 08','3226509223','','Bogota',1,'BIENES',99,'2018-04-07','17087',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (632,'1020802265',1710137,'SANCHEZ GOMEZ YULI KATHERIN','CRA 65 57F 51 SUR','3103446771','katerins23@hotmail.com','Bogota',1,'BIENES',99,'2017-11-28','24020675',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (633,'10544341',12371031,'VELASCO MU¾OZ JOHN CARLOS','CRA 27 No. 35 33','3173430578','jamolina @uniquindio.edu.co','Bogota',5,'BIENES',99,'2016-02-21','50780',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (634,'1073151191',714373,'JHON FREDY VIZCAINO MORALES','CRA 30 74 -64','3202337169','','Bogota',1,'BIENES',99,'2017-09-12','27020110',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (635,'11408647',9725543,'CARLOS HUMBERTO PADILLA NEIRA','CRA 13 N 14 60 LOCAL 1','3203723127','','Bogota',5,'BIENES',99,'2016-01-25','24020476',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (636,'19287321',5034338,'ESTUPI¾AN ROJAS JOSE ANTONIO','CL 43 No. 6 12','3212326383','paniicadorasanantoniotunja@yahoo.es','Bogota',1,'BIENES',99,'2018-12-18','24020368',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (637,'23810227',1743285,'RINCON YARA ELIZABETH','CL 23 No. 05 L 01','3142296339','','Bogota',1,'BIENES',99,'2017-04-27','24020723',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (638,'63558582',1469096,'ARGUELLO CERPA ERIKA','CR 22 NO 46 B-08','6942412','ecosandeliciosopan@yahoo.com','Bogota',1,'BIENES',99,'2018-01-10','27020223',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (639,'7456345',27270861,'VARGAS ESPINOSA JAIME ARTURO','CRA 6 No. 19 A 48','301686356','distribucionesjr@hotmail.com','Bogota',5,'BIENES',99,'2018-07-14','436142',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (640,'79209103',3572794,'VASQUEZ LADINO PABLO CESAR','CL 57B No. 68A 29 SUR','3126699411','carmeng710@hotmail.com','Bogota',1,'BIENES',99,'2017-08-30','24020038',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (641,'80450756',649431,'MARTINEZ GIL HILDA','CR 68B 67 01 BELLAVISTA','3115810218','nelsonbarbosa276@gmail.com','Bogota',1,'BIENES',99,'2017-08-25','24020253',119,0,'NOW',NULL,'3','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (642,'900173510',7551500,'DISTRIBUIDORA BOGOTA TCB LTDA','CL 03 No. C 9 76','3132490129','pabloemendezt@hotmail.com','Bogota',1,'BIENES',99,'2016-12-30','884301',119,0,'NOW',NULL,'4','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (643,'9002785927',25483827,'JHON ARLISON CHAPPARRO LEON','CR 7 No.19A-40','5714051','inversionesfavipan@hotmail.com','Bogota',1,'BIENES',99,'2018-07-13','14273',119,0,'NOW',NULL,'2','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (644,'900353794',19439608,'INDUSTRIAS INDUPAN SAS','CL 44 No. 18D 100','3135446629','inversionesfavipan@hotmail.com','Bogota',5,'BIENES',99,'2014-01-21','50020030',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (645,'900412995',5570588,'TYS PET SAS','CRA 7 No. 16 78 LC 1021','3155564764','amesotom@hotmail.com','Bogota',1,'BIENES',99,'2016-10-01','50791',119,0,'NOW',NULL,'4','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (646,'94529101',2500000,'JOSE RAUL HENAO SOTO','CRA 10 No. 1 295','3113512484','','Bogota',1,'BIENES',99,'2018-04-29','25020065',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (647,'22518962',7071000,'COMERCIALIZADORA GAMOPE SAS','MZ F CASA 14 URB VILLA DEL MAR','3008426790','kjperea45@hotmail.com','Bogota',1,'BIENES',99,'2016-09-15','14439',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (648,'900240160',2000000,'CORPORACION AGENCIA DE DESARROLLO ECONOMICO LOCAL DEL COMPLEJO CENAGOSO DE LA ZAPATOSA','CRA 19  A2  10 20','3205112555','njudithramirez@hotmail.com','Bogota',1,'BIENES',99,'2017-09-16','14472',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (649,'1013598482',8751034,'DIEGO ARMANDO ROCHA MORCOTE','CL 58 SUR 19 A 15 IN 9','4518414','','Bogota',1,'SERVICIO',99,'2015-07-28','14587',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (650,'1020420118',11424768,'MESA GALVIS DIOVER JOHAN','CALLE 33 F No 19 63','2796417','','Bogota',1,'SERVICIO',99,'2017-06-15','14822',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''),
  (651,'10262979',1178239,'FRANCISCO JAVIER BERNAL','CALLE 34 No 11 37 43','3142510436','luzkarina-310@hotmail com','Bogota',1,'SERVICIO',99,'2014-02-24','14612',119,0,'NOW',NULL,'1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
COMMIT;

#
# Data for the `paymentypes` table  (LIMIT 0,500)
#

INSERT INTO `paymentypes` (`idPaymentType`, `paymentTypeName`) VALUES 
  (1,'Capital'),
  (2,'Intereses'),
  (3,'Honorarios');
COMMIT;

#
# Data for the `payments` table  (LIMIT 0,500)
#

INSERT INTO `payments` (`idPayment`, `value`, `dPayment`, `dCreation`, `idWallet`, `idAdviser`, `idPaymentType`, `timer`) VALUES 
  (2,800,'2017-10-03','2017-10-03 11:27:34',1,40,1,'00:10:00'),
  (3,8900,'2017-10-03','2017-10-03 11:27:57',2,40,1,'00:10:00'),
  (4,1200,'2017-10-01','2017-10-03 12:00:02',20,40,1,'00:10:00'),
  (5,7000,'2017-10-01','2017-10-03 18:38:33',1,40,1,'00:10:00'),
  (7,789600,'2017-10-04','2017-10-04 19:56:29',8,67,1,'00:10:00'),
  (8,875000,'2017-10-04','2017-10-04 19:56:29',27,40,1,'00:10:00'),
  (9,78000,'2017-10-04','2017-10-04 19:57:30',9,40,3,'00:10:00'),
  (10,780700,'2017-10-04','2017-10-04 19:57:30',28,68,1,'00:10:00'),
  (11,56000,'2017-10-04','2017-10-04 19:58:05',10,69,2,'00:10:00'),
  (12,78900,'2017-10-04','2017-10-04 19:58:05',29,66,1,'00:10:00');
COMMIT;

#
# Data for the `promises` table  (LIMIT 0,500)
#

INSERT INTO `promises` (`idPromise`, `value`, `dPromise`, `dCreation`, `idWallet`, `idAdviser`, `timer`) VALUES 
  (1,3097142,'2017-07-10','2017-07-06 14:47:18',6199,41,'00:16:08'),
  (2,1784447,'2017-07-10','2017-07-06 15:41:09',6185,41,'00:01:28'),
  (3,120000,'2017-07-10','2017-07-07 13:44:20',5372,42,'00:11:04'),
  (4,612000,'2017-07-25','2017-07-21 12:40:03',6190,41,'00:01:03');
COMMIT;

#
# Data for the `remisiones` table  (LIMIT 0,500)
#

INSERT INTO `remisiones` (`id`, `fecha`, `idWalletByCampaign`, `idPayments`, `intereses`, `honorarios`, `comision`, `monto`, `recaudo`, `idCliente`, `hora`) VALUES 
  (1017,'2016-03-06',119,'2',22,22,22,22,22,72,'05:20:20'),
  (1019,'2017-10-04',94,'2,4,5',0.3,0.5,0.1,120855000,9000,72,'15:49:59'),
  (1020,'2017-10-09',95,'3',0,0,0,120855000,8900,74,'20:18:35'),
  (1021,'2017-10-09',106,'11,12',12000,150000,10,120855000,134900,82,'20:24:39'),
  (1022,'2017-10-18',104,'9,10',12000,150000,10,120855000,858700,82,'14:11:48');
COMMIT;

#
# Data for the `serializeCampaign` table  (LIMIT 0,500)
#

INSERT INTO `serializeCampaign` (`id`, `idCampaign`, `name`, `data`, `createdAt`, `aprovedAt`, `estatus`) VALUES 
  (1,72,'hgchg','kjhvjhk','2017-09-06 17:56:21',NULL,1),
  (2,72,'Cartera marzo 2010','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";a:4:{s:18:\"idNotificationType\";s:1:\"1\";s:4:\"name\";s:7:\"Mensual\";s:11:\"description\";s:426:\"Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.\";s:9:\"crerateAt\";s:19:\"2017-09-01 16:04:31\";}s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504720083.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:18:\"Cartera marzo 2010\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:8:\"1,000.00\";}','2017-09-06 18:04:16',NULL,1),
  (3,72,'Cartera marzo 2010','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";a:4:{s:18:\"idNotificationType\";s:1:\"1\";s:4:\"name\";s:7:\"Mensual\";s:11:\"description\";s:426:\"Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.\";s:9:\"crerateAt\";s:19:\"2017-09-01 16:04:31\";}s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504720083.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:18:\"Cartera marzo 2010\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:8:\"1,000.00\";}','2017-09-06 18:05:10',NULL,1),
  (4,72,'edrgt','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";a:4:{s:18:\"idNotificationType\";s:1:\"1\";s:4:\"name\";s:7:\"Mensual\";s:11:\"description\";s:426:\"Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.\";s:9:\"crerateAt\";s:19:\"2017-09-01 16:04:31\";}s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504721355.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:5:\"edrgt\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:8:\"1,000.00\";}','2017-09-06 18:09:16',NULL,1),
  (5,72,'edrgt','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";a:4:{s:18:\"idNotificationType\";s:1:\"1\";s:4:\"name\";s:7:\"Mensual\";s:11:\"description\";s:426:\"Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.\";s:9:\"crerateAt\";s:19:\"2017-09-01 16:04:31\";}s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504721574.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:5:\"edrgt\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:8:\"1,000.00\";}','2017-09-06 18:12:56',NULL,1),
  (6,72,'fdd','a:11:{s:6:\"emails\";a:1:{i:0;s:11:\"%correo 1% \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:6:\"Diaria\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504722159.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:3:\"fdd\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"3\";s:11:\"valor_pagar\";s:8:\"1,600.00\";}','2017-09-06 18:22:46',NULL,1),
  (7,72,'werf','a:11:{s:6:\"emails\";a:1:{i:0;s:11:\"%correo 1% \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504722801.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:4:\"werf\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:8:\"1,000.00\";}','2017-09-06 20:52:19',NULL,1),
  (8,72,'Cartera marzo 2010','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504732111.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:18:\"Cartera marzo 2010\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:8:\"1,600.00\";}','2017-09-06 21:09:21',NULL,1),
  (9,72,'Cartera marzo 2010','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,121,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504733608.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:18:\"Cartera marzo 2010\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:8:\"1,600.00\";}','2017-09-06 21:33:29',NULL,1),
  (10,72,'fg','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504881392.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:2:\"fg\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:6:\"500.00\";}','2017-09-08 14:36:38',NULL,1),
  (11,72,'qp','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1504889872.csv\";s:14:\"valor_servicio\";s:3:\"500\";s:12:\"campana_name\";s:2:\"qp\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:6:\"500.00\";}','2017-09-08 17:05:59','2017-09-10 21:18:19',2),
  (12,72,'pepe','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505134604.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:4:\"pepe\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:04:59','2017-09-11 14:05:22',2),
  (13,72,'pepe','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505134604.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:4:\"pepe\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:47:35',NULL,1),
  (14,72,'pepe','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505134604.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:4:\"pepe\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:47:38',NULL,1),
  (15,72,'pepe','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505134604.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:4:\"pepe\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:47:42',NULL,1),
  (16,72,'pepe','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@email.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505134604.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:4:\"pepe\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:48:47',NULL,1),
  (17,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:49:45',NULL,1),
  (18,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:50:05',NULL,1),
  (19,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:51:03',NULL,1),
  (20,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:52:55',NULL,1),
  (21,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:54:05','2017-09-11 14:54:57',2),
  (22,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:56:40',NULL,1),
  (23,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:57:05',NULL,1),
  (24,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:57:44','2017-09-11 14:57:56',2),
  (25,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:58:35','2017-09-11 16:26:16',2),
  (26,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 14:59:34',NULL,1),
  (27,72,'probando ohh','a:11:{s:6:\"emails\";a:2:{i:0;s:17:\"wilmar@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505141374.csv\";s:14:\"valor_servicio\";s:3:\"800\";s:12:\"campana_name\";s:12:\"probando ohh\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:6:\"800.00\";}','2017-09-11 15:01:43','2017-09-11 15:01:55',2),
  (28,72,'Campaña_001','a:11:{s:6:\"emails\";a:1:{i:0;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505337960.csv\";s:14:\"valor_servicio\";s:2:\"57\";s:12:\"campana_name\";s:12:\"Campaña_001\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:5:\"57.00\";}','2017-09-13 21:26:04','2017-09-13 21:26:14',2),
  (29,72,'Campaña C_001','a:11:{s:6:\"emails\";a:2:{i:0;s:21:\"wilmar.ibg@gmail.com \";i:1;s:28:\"programaticaexcel@gmail.com \";}s:13:\"cant_deudores\";s:1:\"1\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"programaticaexcel@gmail.com\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505492860.csv\";s:14:\"valor_servicio\";s:1:\"7\";s:12:\"campana_name\";s:14:\"Campaña C_001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"7.00\";}','2017-09-15 16:28:01','2017-09-15 16:38:55',2),
  (30,74,'WilmarQuentek_001','a:11:{s:6:\"emails\";a:2:{i:0;s:21:\"wilmar.ibg@gmail.com \";i:1;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505504582.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:17:\"WilmarQuentek_001\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 19:44:29','2017-09-15 19:45:08',2),
  (31,74,'Campaña_003w','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505507759.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:13:\"Campaña_003w\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:36:06','2017-09-15 20:40:25',2),
  (32,74,'Campaña_003w','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505507759.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:13:\"Campaña_003w\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:36:43',NULL,1),
  (33,74,'Campaña_003w','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505507759.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:13:\"Campaña_003w\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:39:00',NULL,1),
  (34,74,'Cartera marzo 2010','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508341.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:18:\"Cartera marzo 2010\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:45:46',NULL,1),
  (35,74,'Cartera marzo 2010 001','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508431.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:22:\"Cartera marzo 2010 001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:47:13','2017-09-15 20:48:03',2),
  (36,74,'Cartera marzo 2010 001','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508431.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:22:\"Cartera marzo 2010 001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 20:48:09','2017-09-15 20:48:11',2),
  (37,74,'Cartera marzo 2010 001','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508431.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:22:\"Cartera marzo 2010 001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 21:15:11',NULL,1),
  (38,74,'Cartera marzo 2010 001','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508431.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:22:\"Cartera marzo 2010 001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 21:15:31','2017-09-15 21:16:11',2),
  (39,74,'Cartera marzo 2010 001','a:11:{s:6:\"emails\";a:1:{i:0;s:27:\"wilmar.ibarguen@qentek.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:27:\"wilmar.ibarguen@qentek.com \";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505508431.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:22:\"Cartera marzo 2010 001\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-15 21:17:03','2017-09-15 21:17:05',2),
  (40,82,'CamUscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505743889.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:11:\"CamUscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:12:01',NULL,1),
  (41,82,'CamUscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505743889.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:11:\"CamUscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:12:44',NULL,1),
  (42,82,'Cam2UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:12:\"1,000,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505744164.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam2UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:16:10',NULL,1),
  (43,82,'Campana_1000_W','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505744552.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:14:\"Campana_1000_W\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:22:38','2017-09-18 14:22:43',2),
  (44,82,'Cam3UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505744998.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam3UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:30:04',NULL,1),
  (45,82,'Cam3UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505745538.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam3UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:39:20',NULL,1),
  (46,82,'Campana_1000_W','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505744552.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:14:\"Campana_1000_W\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:40:13','2017-09-18 14:40:17',2),
  (47,82,'Cam4UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505745722.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam4UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:42:05',NULL,1),
  (48,82,'Cam4UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505745848.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam4UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:44:10',NULL,1),
  (49,82,'Cam4UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505745848.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam4UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:45:56',NULL,1),
  (50,82,'Campana_1000_W','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Semanal\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505744552.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:14:\"Campana_1000_W\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"2\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:46:18',NULL,1),
  (51,82,'Cam5UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746100.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam5UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:48:28',NULL,1),
  (52,82,'a','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746439.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:1:\"a\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:54:01',NULL,1),
  (53,82,'a','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746472.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:1:\"a\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:54:33',NULL,1),
  (54,82,'a','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746472.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:1:\"a\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:56:40',NULL,1),
  (55,82,'a','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746615.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:1:\"a\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:56:56',NULL,1),
  (56,82,'Cam6UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505746701.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam6UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 14:58:24','2017-09-18 14:59:36',2),
  (57,82,'ad','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505747093.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:2:\"ad\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:04:54','2017-09-18 15:06:47',2),
  (58,82,'ad','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505747093.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:2:\"ad\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:06:51','2017-09-18 15:06:53',2),
  (59,82,'ad','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505747360.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:2:\"ad\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:09:22','2017-09-18 15:09:23',2),
  (60,82,'Camp001Wil18Sept','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:6:\"Diaria\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505747419.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:16:\"Camp001Wil18Sept\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"3\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:10:20','2017-09-18 15:10:23',2),
  (61,82,'Cam8UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505748189.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam8UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:23:12','2017-09-18 15:23:15',2),
  (62,82,'Cam9UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505748298.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:12:\"Cam9UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:25:01','2017-09-18 15:25:03',2),
  (63,82,'Cam10UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505748688.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:13:\"Cam10UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:31:35','2017-09-18 15:31:37',2),
  (64,82,'Cam10UscSep18','a:11:{s:6:\"emails\";a:1:{i:0;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505748688.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:13:\"Cam10UscSep18\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 15:32:26','2017-09-18 15:32:28',2),
  (65,82,'Camp004Wil18Sept','a:11:{s:6:\"emails\";a:2:{i:0;s:21:\"wilmar.ibg@gmail.com \";i:1;s:35:\"cesar.lombana@unisoftsystem.com.co \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:34:\"cesar.lombana@unisoftsystem.com.co\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505765624.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:16:\"Camp004Wil18Sept\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-18 20:14:13','2017-09-18 20:14:18',2),
  (66,84,'CampSep19','a:11:{s:6:\"emails\";a:1:{i:0;s:26:\"josediaz78963@hotmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:25:\"josediaz78963@hotmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505842795.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:9:\"CampSep19\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-19 17:40:27','2017-09-19 17:40:33',2),
  (67,85,'CampSep19-2','a:11:{s:6:\"emails\";a:1:{i:0;s:26:\"josediaz78964@hotmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:25:\"josediaz78964@hotmail.com\";s:24:\"notificacion_description\";s:6:\"Diaria\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1505850165.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:11:\"CampSep19-2\";s:12:\"service_name\";s:10:\"SERVICIO 2\";s:12:\"notificacion\";s:1:\"3\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-19 19:50:01','2017-09-19 19:50:16',2),
  (68,86,'Octubre2017','a:11:{s:6:\"emails\";a:1:{i:0;s:24:\"josediaz78965@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:23:\"josediaz78965@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1506442125.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:11:\"Octubre2017\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-26 16:08:48',NULL,1),
  (69,86,'Cmp-1Sep 26','a:11:{s:6:\"emails\";a:1:{i:0;s:24:\"josediaz78965@gmail.com \";}s:13:\"cant_deudores\";s:1:\"2\";s:13:\"total_campana\";s:14:\"120,855,000.00\";s:13:\"email_usuario\";s:23:\"josediaz78965@gmail.com\";s:24:\"notificacion_description\";s:7:\"Mensual\";s:12:\"archivo_temp\";s:32:\"./uploadCampaigns/1506446385.csv\";s:14:\"valor_servicio\";s:1:\"0\";s:12:\"campana_name\";s:11:\"Cmp-1Sep 26\";s:12:\"service_name\";s:10:\"SERVICIO 1\";s:12:\"notificacion\";s:1:\"1\";s:11:\"valor_pagar\";s:4:\"0.00\";}','2017-09-26 17:19:46',NULL,1);
COMMIT;

#
# Data for the `supports` table  (LIMIT 0,500)
#

INSERT INTO `supports` (`idsupports`, `idWallet`, `fileName`, `fileType`, `dFile`, `dCreation`, `file`) VALUES 
  (1,6088,'PAZ Y SALVO','jpeg','2017-06-15','2017-06-30 17:14:51','https://storage.googleapis.com/cojunal-148320.appspot.com/6088/PAZ Y SALVO.jpeg'),
  (2,6088,'PAZ Y SALVO','jpeg','2017-06-15','2017-06-30 17:22:58','https://storage.googleapis.com/cojunal-148320.appspot.com/6088/PAZ Y SALVO.jpeg'),
  (4,6194,'consignacion','PNG','2017-06-27','2017-07-05 09:42:25','https://storage.googleapis.com/cojunal-148320.appspot.com/6194/consignacion.PNG'),
  (5,6201,'confirmacion','jpg','2017-06-15','2017-07-05 10:25:24','https://storage.googleapis.com/cojunal-148320.appspot.com/6201/confirmacion.jpg'),
  (6,6186,'confirmacion','PNG','2017-07-21','2017-07-05 10:32:53','https://storage.googleapis.com/cojunal-148320.appspot.com/6186/confirmacion.PNG'),
  (7,6190,'consignacion','pdf','2017-06-15','2017-07-05 10:38:57','https://storage.googleapis.com/cojunal-148320.appspot.com/6190/consignacion.pdf'),
  (8,6190,'consignacion','pdf','2017-06-20','2017-07-05 10:39:20','https://storage.googleapis.com/cojunal-148320.appspot.com/6190/consignacion.pdf'),
  (9,6191,'transferencia','pdf','2016-04-18','2017-07-05 16:40:53','https://storage.googleapis.com/cojunal-148320.appspot.com/6191/transferencia.pdf'),
  (10,6191,'transferencia antes de la asignacion','pdf','2016-04-18','2017-07-07 14:06:26','https://storage.googleapis.com/cojunal-148320.appspot.com/6191/transferencia antes de la asignacion.pdf'),
  (11,5566,'pago valor cuota','png','2017-07-11','2017-07-10 16:42:09','https://storage.googleapis.com/cojunal-148320.appspot.com/5566/pago valor cuota.png'),
  (12,5566,'pago','png','2017-07-10','2017-07-10 16:43:05','https://storage.googleapis.com/cojunal-148320.appspot.com/5566/pago.png'),
  (13,6185,'consignacion','jpg','2017-07-10','2017-07-11 15:26:01','https://storage.googleapis.com/cojunal-148320.appspot.com/6185/consignacion.jpg'),
  (14,6235,'consignacion','jpeg','2017-05-31','2017-07-14 10:21:44','https://storage.googleapis.com/cojunal-148320.appspot.com/6235/consignacion.jpeg'),
  (16,6220,'consignacion','jpeg','2016-07-18','2017-07-14 11:40:44','https://storage.googleapis.com/cojunal-148320.appspot.com/6220/consignacion.jpeg'),
  (18,6220,'consignacion','jpeg','2016-07-11','2017-07-14 11:44:07','https://storage.googleapis.com/cojunal-148320.appspot.com/6220/consignacion.jpeg'),
  (19,5372,'ABONO','jpeg','2017-07-10','2017-07-14 13:37:22','https://storage.googleapis.com/cojunal-148320.appspot.com/5372/ABONO.jpeg'),
  (20,5379,'CUOTA','jpeg','2017-07-12','2017-07-14 13:39:33','https://storage.googleapis.com/cojunal-148320.appspot.com/5379/CUOTA.jpeg'),
  (21,5367,'ABONO','jpeg','2017-07-07','2017-07-14 13:41:18','https://storage.googleapis.com/cojunal-148320.appspot.com/5367/ABONO.jpeg'),
  (22,5366,'VISITA ','jpg','2017-07-15','2017-07-17 08:24:20','https://storage.googleapis.com/cojunal-148320.appspot.com/5366/VISITA .jpg'),
  (23,5377,'VISITA','jpg','2017-07-15','2017-07-17 10:24:52','https://storage.googleapis.com/cojunal-148320.appspot.com/5377/VISITA.jpg'),
  (24,5377,'VISITA','jpg','2017-07-15','2017-07-17 10:25:05','https://storage.googleapis.com/cojunal-148320.appspot.com/5377/VISITA.jpg'),
  (25,5375,'pago','jpeg','2017-07-18','2017-07-18 11:18:32','https://storage.googleapis.com/cojunal-148320.appspot.com/5375/pago.jpeg');
COMMIT;

#
# Data for the `sysparams` table  (LIMIT 0,500)
#

INSERT INTO `sysparams` (`idSysparam`, `feeRate`, `interestRate`, `appName`) VALUES 
  (1,20.00,2.50,'Cojunal');
COMMIT;

#
# Data for the `tasks` table  (LIMIT 0,500)
#

INSERT INTO `tasks` (`idTasks`, `idWallet`, `idAction`, `dTask`, `dCreation`, `idAdviser`, `timer`) VALUES 
  (1,6090,2,'2017-07-04','2017-06-30 16:26:13',42,'00:01:06'),
  (2,6099,1,'2017-07-04','2017-06-30 17:03:27',42,'00:01:54'),
  (3,6088,1,'2017-06-30','2017-06-30 17:21:55',42,'00:01:55'),
  (4,6086,1,'2017-07-05','2017-07-04 08:49:00',42,'00:09:25'),
  (5,6099,1,'2017-07-04','2017-07-04 09:02:02',42,'00:08:29'),
  (6,6096,1,'2017-07-04','2017-07-04 09:10:24',42,'00:07:10'),
  (7,6095,1,'2017-07-05','2017-07-04 09:59:30',42,'00:13:36'),
  (8,5335,1,'2017-07-04','2017-07-04 10:13:32',40,'00:04:24'),
  (9,5352,1,'2017-07-16','2017-07-04 10:28:30',40,'00:04:16'),
  (10,5336,1,'2017-07-07','2017-07-04 10:40:25',40,'00:09:07'),
  (11,5336,1,'2017-07-08','2017-07-04 10:42:53',40,'00:02:26'),
  (12,5336,1,'2017-07-08','2017-07-04 10:42:53',40,'00:02:26'),
  (13,5336,1,'2017-07-08','2017-07-04 10:43:26',40,'00:00:32'),
  (14,5337,1,'2017-07-08','2017-07-04 10:50:17',40,'00:02:50'),
  (15,6104,1,'2017-07-04','2017-07-04 10:56:59',42,'00:08:56'),
  (16,5338,1,'2017-07-08','2017-07-04 11:31:12',40,'00:27:14'),
  (17,5339,1,'2017-07-08','2017-07-04 12:16:04',40,'00:22:54'),
  (18,6099,1,'2017-07-04','2017-07-04 12:22:09',42,'00:00:49'),
  (19,5356,1,'2017-07-08','2017-07-04 12:36:21',40,'00:07:52'),
  (20,5356,1,'2017-07-08','2017-07-04 12:39:04',40,'00:02:41'),
  (21,5340,1,'2017-07-08','2017-07-04 12:57:09',40,'00:17:13'),
  (22,5357,1,'2017-07-08','2017-07-04 14:25:32',40,'00:50:16'),
  (23,6102,2,'2017-07-04','2017-07-04 14:50:39',42,'00:01:40'),
  (24,6102,1,'2017-07-18','2017-07-04 14:51:32',42,'00:00:51'),
  (25,5341,1,'2017-07-08','2017-07-04 14:54:17',40,'00:26:00'),
  (26,6081,1,'2017-07-11','2017-07-04 14:59:10',42,'00:03:19'),
  (27,5358,1,'2017-07-08','2017-07-04 15:01:46',40,'00:07:04'),
  (28,5358,1,'2017-07-08','2017-07-04 15:09:03',40,'00:07:16'),
  (29,5342,1,'2017-07-08','2017-07-04 15:18:37',40,'00:08:44'),
  (30,5359,1,'2017-07-08','2017-07-04 15:27:56',40,'00:08:44'),
  (31,5360,1,'2017-07-06','2017-07-04 15:45:13',40,'00:11:51'),
  (32,5344,1,'2017-07-08','2017-07-04 15:56:06',40,'00:09:59'),
  (33,5361,1,'2017-07-11','2017-07-04 16:04:15',40,'00:07:18'),
  (34,5369,1,'2017-07-05','2017-07-04 16:38:16',42,'00:07:13'),
  (35,5379,1,'2017-07-05','2017-07-04 16:45:02',42,'00:04:06'),
  (36,5370,1,'2017-07-05','2017-07-04 16:47:00',42,'00:01:32'),
  (37,5381,1,'2017-07-05','2017-07-04 17:09:55',42,'00:07:04'),
  (38,5345,1,'2017-07-08','2017-07-05 08:14:14',40,'00:13:00'),
  (39,6194,1,'2017-07-05','2017-07-05 09:39:07',41,'00:03:37'),
  (40,6200,1,'2017-07-05','2017-07-05 09:48:14',41,'00:01:15'),
  (41,6181,1,'2017-07-05','2017-07-05 09:50:01',41,'00:00:44'),
  (42,5362,1,'2017-07-08','2017-07-05 09:53:12',40,'00:02:54'),
  (43,6181,1,'2017-07-06','2017-07-05 09:55:28',41,'00:05:26'),
  (44,6202,6,'2017-07-06','2017-07-05 09:57:07',41,'00:00:41'),
  (45,6202,4,'2017-07-05','2017-07-05 09:59:32',41,'00:02:23'),
  (46,5368,2,'2017-07-12','2017-07-05 10:02:52',42,'00:09:34'),
  (47,6180,6,'2017-07-07','2017-07-05 10:04:28',41,'00:00:57'),
  (48,5346,1,'2017-07-08','2017-07-05 10:12:43',40,'00:15:29'),
  (49,6180,6,'2017-07-07','2017-07-05 10:12:58',41,'00:01:50'),
  (50,6198,1,'2017-07-07','2017-07-05 10:17:36',41,'00:01:25'),
  (51,5363,1,'2017-07-08','2017-07-05 10:19:59',40,'00:04:13'),
  (52,6183,1,'2017-07-07','2017-07-05 10:20:25',41,'00:00:56'),
  (53,6201,7,'2017-07-07','2017-07-05 10:24:19',41,'00:02:55'),
  (54,5347,2,'2017-07-05','2017-07-05 10:26:45',40,'00:04:00'),
  (55,6186,1,'2017-07-05','2017-07-05 10:31:31',41,'00:01:14'),
  (56,5364,1,'2017-07-05','2017-07-05 10:32:08',40,'00:01:58'),
  (57,6190,1,'2017-07-05','2017-07-05 10:36:59',41,'00:02:23'),
  (58,5377,1,'2017-07-05','2017-07-05 10:37:55',42,'00:13:22'),
  (59,6190,1,'2017-07-06','2017-07-05 10:45:40',41,'00:06:19'),
  (60,6065,3,'2017-07-05','2017-07-05 10:45:48',40,'00:02:07'),
  (61,5384,3,'2017-07-05','2017-07-05 10:45:55',42,'00:07:10'),
  (62,6066,2,'2017-07-05','2017-07-05 10:47:59',40,'00:01:39'),
  (63,6193,1,'2017-07-05','2017-07-05 10:50:32',41,'00:02:04'),
  (64,6067,1,'2017-07-05','2017-07-05 10:53:00',40,'00:03:49'),
  (65,6193,1,'2017-07-05','2017-07-05 10:59:10',41,'00:08:36'),
  (66,6067,1,'2017-07-11','2017-07-05 11:02:29',40,'00:08:47'),
  (67,6192,6,'2017-07-07','2017-07-05 11:03:28',41,'00:02:33'),
  (68,6182,1,'2017-07-06','2017-07-05 13:00:23',41,'00:01:45'),
  (69,6199,1,'2017-07-06','2017-07-05 13:06:49',41,'00:05:23'),
  (70,6197,6,'2017-07-07','2017-07-05 13:11:07',41,'00:01:26'),
  (71,6184,1,'2017-07-05','2017-07-05 13:45:37',41,'00:02:15'),
  (72,6185,1,'2017-07-06','2017-07-05 13:48:25',41,'00:01:59'),
  (73,6178,1,'2017-07-05','2017-07-05 13:50:26',41,'00:00:33'),
  (74,6188,1,'2017-07-05','2017-07-05 14:08:12',41,'00:07:16'),
  (75,6188,1,'2017-07-06','2017-07-05 14:08:48',41,'00:00:35'),
  (76,6195,1,'2017-07-07','2017-07-05 14:10:13',41,'00:00:31'),
  (77,6191,1,'2017-07-05','2017-07-05 14:14:08',41,'00:02:52'),
  (78,6228,1,'2017-07-25','2017-07-05 14:24:22',40,'00:11:05'),
  (79,6196,1,'2017-07-05','2017-07-05 14:45:57',41,'00:00:35'),
  (80,5353,1,'2017-07-05','2017-07-05 14:47:05',40,'00:02:20'),
  (81,6196,1,'2017-07-16','2017-07-05 15:00:41',41,'00:14:43'),
  (82,5363,1,'2017-07-05','2017-07-05 15:02:29',40,'00:07:37'),
  (83,5354,1,'2017-07-05','2017-07-05 15:06:42',40,'00:03:02'),
  (84,6196,1,'2017-07-07','2017-07-05 15:07:21',41,'00:03:59'),
  (85,5354,1,'2017-07-08','2017-07-05 15:07:57',40,'00:01:14'),
  (86,5338,7,'2017-07-05','2017-07-05 15:41:16',40,'00:00:57'),
  (87,6178,1,'2017-07-10','2017-07-05 16:14:43',41,'00:42:34'),
  (88,5375,1,'2017-07-10','2017-07-05 16:18:59',42,'00:26:11'),
  (89,5348,1,'2017-07-08','2017-07-05 16:31:12',40,'00:11:32'),
  (90,5365,1,'2017-07-06','2017-07-05 16:35:49',40,'00:04:03'),
  (91,5374,1,'2017-07-06','2017-07-05 16:36:16',42,'00:02:45'),
  (92,6191,1,'2017-07-07','2017-07-05 16:38:30',41,'00:22:53'),
  (93,6179,1,'2017-07-07','2017-07-05 16:55:15',41,'00:00:43'),
  (94,6177,1,'2017-07-10','2017-07-05 17:01:08',41,'00:04:16'),
  (95,5343,7,'2017-07-05','2017-07-05 17:01:38',40,'00:08:25'),
  (96,6189,1,'2017-07-06','2017-07-05 17:04:12',41,'00:01:18'),
  (97,6187,1,'2017-07-10','2017-07-05 17:07:13',41,'00:01:22'),
  (98,6203,1,'2017-07-05','2017-07-05 17:19:48',41,'00:03:47'),
  (99,6203,1,'2017-07-07','2017-07-05 17:21:16',41,'00:00:31'),
  (100,5365,1,'2017-07-06','2017-07-06 09:03:46',40,'00:04:10'),
  (101,6200,6,'2017-07-10','2017-07-06 09:16:20',41,'00:07:20'),
  (102,5349,7,'2017-07-06','2017-07-06 09:22:32',40,'00:17:55'),
  (103,6194,1,'2017-07-06','2017-07-06 09:32:29',41,'00:14:38'),
  (104,5350,1,'2017-06-10','2017-07-06 09:37:27',40,'00:02:01'),
  (105,6181,1,'2017-07-11','2017-07-06 09:43:10',41,'00:09:15'),
  (106,5350,1,'2017-07-07','2017-07-06 09:44:10',40,'00:06:41'),
  (107,5351,1,'2017-06-10','2017-07-06 09:56:32',40,'00:03:36'),
  (108,5351,1,'2017-06-10','2017-07-06 09:56:32',40,'00:03:36'),
  (109,5335,1,'2017-07-06','2017-07-06 10:50:56',40,'00:51:07'),
  (110,5378,1,'2017-07-06','2017-07-06 11:17:24',42,'00:24:07'),
  (111,5371,1,'2017-07-06','2017-07-06 11:37:06',42,'00:18:16'),
  (112,5353,1,'2017-07-06','2017-07-06 11:54:17',40,'00:15:13'),
  (113,5336,1,'2017-07-11','2017-07-06 12:27:53',40,'00:17:48'),
  (114,5337,1,'2017-07-06','2017-07-06 13:57:30',40,'01:25:53'),
  (115,6193,1,'2017-07-07','2017-07-06 14:05:16',41,'00:03:34'),
  (116,5366,1,'2017-07-17','2017-07-06 14:16:13',42,'02:38:40'),
  (117,6182,1,'2017-07-07','2017-07-06 14:30:21',41,'00:12:49'),
  (118,5354,1,'2017-07-11','2017-07-06 14:36:46',40,'00:24:54'),
  (119,5354,1,'2017-07-11','2017-07-06 14:36:46',40,'00:24:54'),
  (120,6199,1,'2017-07-10','2017-07-06 14:47:18',41,'00:16:08'),
  (121,6184,1,'2017-07-07','2017-07-06 15:11:25',41,'00:13:28'),
  (122,5355,1,'2017-07-07','2017-07-06 15:18:20',40,'00:20:31'),
  (123,5357,1,'2017-07-07','2017-07-06 15:37:34',40,'00:04:22'),
  (124,6185,1,'2017-07-10','2017-07-06 15:41:09',41,'00:01:28'),
  (125,5340,1,'2017-07-07','2017-07-06 15:50:53',40,'00:10:11'),
  (126,5340,1,'2017-07-07','2017-07-06 15:50:53',40,'00:10:11'),
  (127,5376,1,'2017-07-07','2017-07-06 15:58:23',42,'00:14:29'),
  (128,5363,1,'2017-07-13','2017-07-06 16:20:07',40,'00:19:17'),
  (129,5363,1,'2017-07-13','2017-07-06 16:20:07',40,'00:19:17'),
  (130,5367,1,'2017-07-11','2017-07-07 09:04:08',42,'00:01:04'),
  (131,5379,1,'2017-07-13','2017-07-07 09:19:33',42,'00:01:27'),
  (132,6200,1,'2017-07-11','2017-07-07 09:22:20',41,'00:06:37'),
  (133,5369,1,'2017-07-28','2017-07-07 09:39:29',42,'00:18:44'),
  (134,5373,1,'2017-07-11','2017-07-07 10:33:38',42,'00:09:04'),
  (135,6186,1,'2017-07-11','2017-07-07 10:41:05',41,'00:01:50'),
  (136,6190,1,'2017-07-13','2017-07-07 11:05:43',41,'00:00:38'),
  (137,5355,1,'2017-07-14','2017-07-07 11:14:03',40,'00:17:09'),
  (138,5355,1,'2017-07-14','2017-07-07 11:14:03',40,'00:17:09'),
  (139,6193,1,'2017-07-12','2017-07-07 11:23:04',41,'00:04:34'),
  (140,5381,1,'2017-07-07','2017-07-07 11:52:09',42,'00:00:40'),
  (141,6230,1,'2017-07-07','2017-07-07 12:41:51',40,'00:00:50'),
  (142,5372,1,'2017-07-10','2017-07-07 13:44:20',42,'00:11:04'),
  (143,6188,1,'2017-07-10','2017-07-07 13:58:35',41,'00:00:31'),
  (144,6230,1,'2017-07-13','2017-07-07 14:13:33',40,'01:31:41'),
  (145,6196,1,'2017-07-10','2017-07-07 14:21:58',41,'00:00:13'),
  (146,5348,1,'2017-07-12','2017-07-07 14:41:19',40,'00:16:02'),
  (147,5348,1,'2017-07-12','2017-07-07 14:41:19',40,'00:16:02'),
  (148,5621,1,'2017-07-10','2017-07-10 11:00:20',42,'00:59:11'),
  (149,5618,1,'2017-07-14','2017-07-10 11:13:26',42,'00:12:39'),
  (150,5618,1,'2017-07-14','2017-07-10 11:14:38',42,'00:00:31'),
  (151,5589,1,'2017-07-10','2017-07-10 11:43:44',42,'00:26:04'),
  (152,5570,1,'2017-07-12','2017-07-10 11:54:20',42,'00:10:07'),
  (153,5362,1,'2017-07-14','2017-07-10 12:26:04',40,'00:08:50'),
  (154,5386,1,'2017-07-10','2017-07-10 15:20:00',40,'00:00:15'),
  (155,5566,1,'2017-07-11','2017-07-10 15:22:14',42,'00:28:26'),
  (156,5387,1,'2017-07-10','2017-07-10 15:22:37',40,'00:01:39'),
  (157,5566,1,'2017-07-11','2017-07-10 16:36:36',42,'00:04:19'),
  (158,5566,1,'2017-07-10','2017-07-10 16:44:07',42,'00:00:59'),
  (159,5643,1,'2017-07-10','2017-07-10 17:03:46',42,'00:00:51'),
  (160,6227,1,'2017-07-11','2017-07-10 17:33:07',40,'00:10:19'),
  (161,6229,1,'2017-07-14','2017-07-11 08:17:27',40,'00:01:43'),
  (162,5643,1,'2017-07-11','2017-07-11 09:36:46',42,'00:54:26'),
  (163,5563,1,'2017-07-11','2017-07-11 10:00:35',42,'00:07:24'),
  (164,5563,1,'2017-07-11','2017-07-11 10:50:51',42,'00:01:12'),
  (165,5564,1,'2017-07-12','2017-07-11 11:13:52',42,'00:19:02'),
  (166,6191,1,'2017-07-14','2017-07-11 13:00:45',41,'00:00:50'),
  (167,5361,1,'2017-07-31','2017-07-11 14:52:25',40,'00:08:40'),
  (168,5361,1,'2017-07-31','2017-07-11 14:52:26',40,'00:08:40'),
  (169,6185,1,'2017-07-11','2017-07-11 15:25:25',41,'00:01:00'),
  (170,5563,1,'2017-07-15','2017-07-11 16:12:09',42,'00:00:20'),
  (171,5564,1,'2017-07-15','2017-07-11 16:21:14',42,'00:00:35'),
  (172,5563,1,'2017-07-12','2017-07-11 16:25:25',42,'00:03:04'),
  (173,5596,1,'2017-07-12','2017-07-11 16:37:41',42,'00:10:51'),
  (174,5582,1,'2017-07-12','2017-07-11 17:05:55',42,'00:08:26'),
  (175,6106,1,'2017-07-12','2017-07-12 11:04:47',42,'00:28:00'),
  (176,5348,1,'2017-07-14','2017-07-12 11:38:23',40,'00:04:25'),
  (177,5348,1,'2017-07-14','2017-07-12 11:38:23',40,'00:04:25'),
  (178,6093,1,'2017-07-12','2017-07-12 11:51:39',42,'00:01:11'),
  (179,6082,1,'2017-07-12','2017-07-12 11:59:30',42,'00:01:55'),
  (180,6227,1,'2017-07-19','2017-07-12 14:15:40',40,'00:05:53'),
  (181,5350,1,'2017-07-21','2017-07-12 14:36:33',40,'00:15:39'),
  (182,5350,1,'2017-07-21','2017-07-12 14:36:33',40,'00:15:39'),
  (183,6083,1,'2017-07-12','2017-07-12 15:00:07',42,'00:31:37'),
  (184,6101,1,'2017-07-12','2017-07-12 16:13:39',42,'00:05:29'),
  (185,6101,1,'2017-07-13','2017-07-13 07:48:56',42,'00:12:37'),
  (186,6102,1,'2017-07-13','2017-07-13 08:58:45',42,'00:12:56'),
  (187,5358,1,'2017-07-25','2017-07-13 09:04:02',40,'00:08:43'),
  (188,6227,1,'2017-07-20','2017-07-13 10:51:43',40,'00:03:29'),
  (189,6182,1,'2017-07-17','2017-07-13 11:49:22',41,'00:02:35'),
  (190,5341,1,'2017-07-20','2017-07-13 14:21:36',40,'00:03:01'),
  (191,5341,1,'2017-07-20','2017-07-13 14:21:36',40,'00:03:01'),
  (192,5359,1,'2017-07-20','2017-07-13 14:29:24',40,'00:07:18'),
  (193,5342,1,'2017-07-20','2017-07-13 14:32:03',40,'00:02:29'),
  (194,5344,1,'2017-07-20','2017-07-13 14:59:06',40,'00:03:21'),
  (195,5446,1,'2017-07-17','2017-07-13 15:37:34',41,'00:07:36'),
  (196,5362,1,'2017-07-13','2017-07-13 15:38:04',40,'00:36:36'),
  (197,5362,1,'2017-07-13','2017-07-13 15:38:04',40,'00:36:36'),
  (198,5363,1,'2017-07-19','2017-07-13 15:58:35',40,'00:15:48'),
  (199,5463,1,'2017-07-10','2017-07-13 15:59:42',41,'00:00:43'),
  (200,5346,1,'2017-07-13','2017-07-13 16:05:01',40,'00:02:45'),
  (201,5346,1,'2017-07-13','2017-07-13 16:05:01',40,'00:02:45'),
  (202,5350,1,'2017-07-13','2017-07-13 16:23:55',40,'00:00:54'),
  (203,5398,1,'2017-07-11','2017-07-13 16:49:10',41,'00:40:53'),
  (204,5421,1,'2017-07-18','2017-07-13 17:02:45',41,'00:02:56'),
  (205,5370,1,'2017-07-14','2017-07-14 09:17:23',42,'00:16:44'),
  (206,5421,1,'2017-07-14','2017-07-14 09:21:19',41,'00:01:20'),
  (207,5421,1,'2017-07-14','2017-07-14 09:21:19',41,'00:01:20'),
  (208,5524,1,'2017-07-14','2017-07-14 09:49:48',41,'00:12:50'),
  (209,5524,1,'2017-07-14','2017-07-14 09:49:48',41,'00:12:50'),
  (210,5527,1,'2017-07-14','2017-07-14 10:08:31',41,'00:05:07'),
  (211,6235,1,'2017-07-18','2017-07-14 10:19:12',41,'00:04:02'),
  (212,5504,1,'2017-07-14','2017-07-14 10:20:52',41,'00:06:18'),
  (213,5504,1,'2017-07-14','2017-07-14 10:20:52',41,'00:06:18'),
  (214,6235,1,'2017-07-19','2017-07-14 10:21:04',41,'00:01:51'),
  (215,6232,1,'2017-07-19','2017-07-14 10:24:29',41,'00:01:03'),
  (216,6232,1,'2017-08-01','2017-07-14 10:34:39',41,'00:10:08'),
  (217,6233,1,'2017-07-14','2017-07-14 10:36:40',41,'00:00:35'),
  (218,5465,1,'2017-07-14','2017-07-14 10:36:49',41,'00:06:21'),
  (219,5422,1,'2017-07-14','2017-07-14 10:47:19',41,'00:02:59'),
  (220,5422,1,'2017-07-14','2017-07-14 10:47:20',41,'00:02:59'),
  (221,6233,1,'2017-07-24','2017-07-14 10:55:18',41,'00:18:37'),
  (222,6234,1,'2017-07-14','2017-07-14 11:07:30',41,'00:00:20'),
  (223,6234,1,'2017-07-19','2017-07-14 11:09:23',41,'00:01:51'),
  (224,6203,1,'2017-07-14','2017-07-14 11:29:46',41,'00:13:34'),
  (225,6220,1,'2017-07-14','2017-07-14 11:37:00',41,'00:02:09'),
  (226,6220,1,'2017-07-17','2017-07-14 11:39:08',41,'00:02:07'),
  (227,6210,1,'2017-07-14','2017-07-14 11:47:35',41,'00:01:44'),
  (228,6225,1,'2017-07-14','2017-07-14 12:13:03',41,'00:10:07'),
  (229,6225,1,'2017-07-11','2017-07-14 12:14:07',41,'00:01:02'),
  (230,6209,1,'2017-07-14','2017-07-14 12:35:30',41,'00:00:54'),
  (231,6209,1,'2017-07-17','2017-07-14 12:43:32',41,'00:08:02'),
  (232,5372,1,'2017-07-14','2017-07-14 13:36:46',42,'00:01:34'),
  (233,5379,1,'2017-07-14','2017-07-14 13:38:51',42,'00:01:04'),
  (234,5367,1,'2017-07-14','2017-07-14 13:40:47',42,'00:00:42'),
  (235,5368,1,'2017-07-14','2017-07-14 14:05:18',42,'00:10:52'),
  (236,5385,1,'2017-07-14','2017-07-14 14:28:13',42,'00:12:26'),
  (237,5384,1,'2017-07-14','2017-07-14 14:45:40',42,'00:16:40'),
  (238,5375,1,'2017-07-14','2017-07-14 16:51:45',42,'02:03:29'),
  (239,5366,1,'2017-07-17','2017-07-17 08:23:17',42,'00:17:13'),
  (240,5408,1,'2017-07-19','2017-07-17 09:32:54',40,'00:27:19'),
  (241,5408,1,'2017-07-19','2017-07-17 09:32:54',40,'00:27:19'),
  (242,5463,1,'2017-07-18','2017-07-17 10:29:03',40,'00:07:22'),
  (243,5528,1,'2017-07-21','2017-07-17 11:15:18',40,'00:06:55'),
  (244,5526,1,'2017-07-19','2017-07-17 11:53:07',40,'00:07:46'),
  (245,5406,1,'2017-07-19','2017-07-17 12:35:13',40,'00:31:26'),
  (246,5398,1,'2017-07-18','2017-07-17 14:31:55',41,'00:01:05'),
  (247,5474,1,'2017-07-26','2017-07-17 14:34:49',41,'00:01:49'),
  (248,6217,1,'2017-07-17','2017-07-17 17:08:15',41,'00:03:00'),
  (249,6244,1,'2017-07-18','2017-07-18 10:28:51',42,'00:01:20'),
  (250,6244,1,'2017-07-18','2017-07-18 10:52:16',42,'00:23:23'),
  (251,5375,1,'2017-07-18','2017-07-18 11:10:10',42,'00:02:59'),
  (252,5375,1,'2017-07-18','2017-07-18 11:13:46',42,'00:03:35'),
  (253,5375,1,'2017-07-18','2017-07-18 11:15:28',42,'00:01:40'),
  (254,6218,1,'2017-07-19','2017-07-18 14:16:08',41,'00:05:43'),
  (255,6235,1,'2017-07-21','2017-07-18 14:32:00',41,'00:01:09'),
  (256,5478,1,'2017-07-22','2017-07-19 09:05:27',40,'00:03:56'),
  (257,5359,1,'2017-07-25','2017-07-19 09:29:08',44,'00:03:54'),
  (258,5387,1,'2017-07-25','2017-07-19 09:56:41',40,'00:01:41'),
  (259,6227,1,'2017-07-26','2017-07-19 10:44:52',40,'00:04:41'),
  (260,6227,1,'2017-07-26','2017-07-19 10:44:52',40,'00:04:41'),
  (261,5363,1,'2017-07-26','2017-07-19 11:00:25',40,'00:06:55'),
  (262,5526,1,'2017-07-26','2017-07-19 11:37:07',40,'00:19:39'),
  (263,5429,2,'2017-07-25','2017-07-19 12:22:00',40,'00:11:37'),
  (264,5412,3,'2017-07-19','2017-07-19 12:34:51',40,'00:00:50'),
  (265,5412,3,'2017-07-19','2017-07-19 12:34:51',40,'00:00:50'),
  (266,5352,1,'2017-07-21','2017-07-19 12:35:09',44,'00:04:04'),
  (267,5347,1,'2017-07-28','2017-07-19 12:58:10',44,'00:01:38'),
  (268,5466,1,'2017-07-21','2017-07-19 14:28:33',40,'00:10:15'),
  (269,5466,1,'2017-07-21','2017-07-19 14:28:34',40,'00:10:15'),
  (270,6251,1,'2017-07-21','2017-07-19 16:31:45',42,'00:03:34'),
  (271,5345,1,'2017-07-21','2017-07-21 10:59:12',40,'00:08:12'),
  (272,6186,1,'2017-07-24','2017-07-21 11:39:04',41,'00:01:30'),
  (273,6190,1,'2017-07-25','2017-07-21 12:40:03',41,'00:01:03'),
  (274,5434,1,'2017-07-27','2017-07-21 12:48:45',40,'00:09:00'),
  (275,6199,1,'2017-07-26','2017-07-21 12:52:02',41,'00:01:23'),
  (276,5361,1,'2017-07-28','2017-07-21 13:54:04',44,'00:04:47'),
  (277,5524,1,'2017-07-27','2017-07-21 14:39:07',40,'00:01:50'),
  (278,5368,1,'2017-07-21','2017-07-21 15:19:50',42,'00:01:51'),
  (279,6251,1,'2017-07-21','2017-07-21 16:00:25',42,'00:27:19'),
  (280,5378,1,'2017-07-21','2017-07-21 16:03:01',42,'00:02:12'),
  (281,5373,1,'2017-07-21','2017-07-21 16:14:57',42,'00:10:19'),
  (282,5466,1,'2017-07-26','2017-07-21 16:28:29',40,'00:01:23'),
  (283,5442,1,'2017-07-26','2017-07-21 16:41:12',40,'00:07:31'),
  (284,5409,1,'2017-07-25','2017-07-21 17:07:45',40,'00:10:54'),
  (285,5409,1,'2017-07-25','2017-07-21 17:07:45',40,'00:10:54'),
  (286,5369,1,'2017-07-26','2017-07-24 09:30:05',44,'00:08:36'),
  (287,5369,1,'2017-07-26','2017-07-24 09:33:40',44,'00:03:33'),
  (288,5367,1,'2017-08-14','2017-07-24 10:35:33',44,'00:04:17'),
  (289,6254,1,'2017-07-31','2017-07-24 11:53:15',44,'00:02:00'),
  (290,5385,1,'2017-07-24','2017-07-24 11:53:30',42,'00:00:37'),
  (291,5381,1,'2017-07-24','2017-07-24 12:17:50',44,'00:10:19'),
  (292,5344,1,'2017-07-25','2017-07-24 14:18:45',40,'00:09:49'),
  (293,5344,1,'2017-07-25','2017-07-24 14:18:45',40,'00:09:49'),
  (294,5345,1,'2017-07-26','2017-07-24 14:23:12',40,'00:03:57'),
  (295,5348,1,'2017-07-31','2017-07-24 14:36:59',40,'00:10:07'),
  (296,5349,1,'2017-07-24','2017-07-24 14:49:50',40,'00:04:23'),
  (297,5349,1,'2017-07-24','2017-07-24 14:49:50',40,'00:04:23');
COMMIT;

#
# Data for the `token` table  (LIMIT 0,500)
#

INSERT INTO `token` (`idToken`, `permision_key`, `date`) VALUES 
  (1,'10c6a1c26bb2d369502aeeb779042bbc','2016-07-09 14:07:46'),
  (4,'c6c309a170c3800d2d009108b2a20741','2016-07-09 14:07:26'),
  (11,'f5d270723a1b66332f57e9ddb0787e88','2016-07-09 17:07:10'),
  (12,'7b931e6f53af1791d6ec0f877fdc4093','2016-07-09 17:07:25'),
  (17,'18f6783e7dabbf92f83b38090a07797b','2016-07-13 06:07:16'),
  (18,'78acfbc27ab0fc1a9cd87f78592ece03','2016-07-13 06:07:23'),
  (19,'3611ae0672b4edd7ad0cd7bfdebef913','2016-07-13 07:07:23'),
  (20,'c6685bb69bcba6f29a40c499baec3ec4','2016-07-13 07:07:32'),
  (21,'cd6d13c5302779c4873644aeb880009e','2016-07-13 07:07:12'),
  (22,'4cb2d843a89d3296205b60d488fa8dff','2016-07-13 07:07:53'),
  (23,'3611ae0672b4edd7ad0cd7bfdebef913','2016-07-13 07:07:23'),
  (32,'0fda399cf3ed5727c7ed21994007e742','2016-07-14 15:07:10'),
  (33,'fa53fe2fa17a9e4c1d0bc5d87804f6f7','2016-07-14 15:07:20'),
  (34,'fa3eb902f80b858e8ecd7b0a505ff795','2016-07-14 15:07:45'),
  (37,'d0eb3d7f28ecf7167b0904d7a2f8bcd3','2016-07-14 23:07:16'),
  (38,'daa8e26556734010666e7d9dafdd9e65','2016-07-14 23:07:57'),
  (39,'d9aaf8ef30428380b2e8ae483f31d572','2016-07-14 23:07:31'),
  (40,'ff188d1c479d2e4f9ba4d3c023418beb','2016-07-14 23:07:33'),
  (41,'df31d5a67f87d2b869b6a6e62c3b8df1','2016-07-14 23:07:14'),
  (62,'a763994d98eba9d2e668e64d3914e225','2016-12-07 13:12:53'),
  (64,'ae8d66ae8191cf9e786a0cbf3389557c','2017-02-20 16:02:29'),
  (113,'f549565fb4c9671b613500efdb967d6a','2017-06-07 17:06:08'),
  (117,'43a2cf352110825fe5363d5859913d32','2017-06-29 17:06:56'),
  (165,'2306f1cc4b0bbb3c5981a14bedce1604','2017-07-10 16:07:29'),
  (166,'41f019738c969c01c42f5168b55e15d8','2017-07-10 16:07:52'),
  (167,'c6701bb069d93b95eada8434e6279d74','2017-07-10 16:07:12'),
  (168,'b91d929fb14d2c94542dca7438cedffe','2017-07-10 17:07:51'),
  (185,'49617fe4cd29789c5833901e3d6b408c','2017-07-19 11:07:49'),
  (194,'b648b0ab5b584f464a9b7196b8b0fcda','2017-08-15 16:08:32'),
  (195,'015d69826e3cb0df9ce46b67787a1068','2017-08-15 16:08:05'),
  (196,'caad458b46ea141087b8b7f5cdabecad','2017-08-15 17:08:15'),
  (197,'5601915e1c451abc33f155d3186739dd','2017-08-15 17:08:46'),
  (198,'39f628b9af702cd0f605fec11f3bdf6b','2017-08-15 17:08:13'),
  (199,'96ceb9cd0a5861c8ff315dd104f4c293','2017-08-15 17:08:25'),
  (200,'2343aac1bc68e2bda5612d93e1d02108','2017-08-15 17:08:23'),
  (201,'f06f9f4d27ca156dd3f0a2c52829c771','2017-08-15 17:08:09'),
  (202,'c0af7c34c5813ad2992b956c750b7ffc','2017-08-16 08:08:10'),
  (203,'dd56f12f57a86b53b3ad68f6efcc3a94','2017-08-16 08:08:57'),
  (216,'b5a43866568683173fefeab81f6eb698','2017-08-17 16:08:12'),
  (226,'6595966ef381038ef416a6d3efcad46a','2017-08-29 09:08:52'),
  (232,'4831d5c6e64b5ae2efdedf7fbf340dad','2017-08-31 10:08:15'),
  (239,'e4f1949170a1da08642eed24c03220db','2017-09-05 12:09:43'),
  (240,'afac2fac2cf4496760e09614e5fb0f0a','2017-09-05 12:09:12'),
  (241,'96b2f78ff388ee483383b10813e29682','2017-09-05 12:09:19'),
  (244,'77892e2deacc396d407150bba34bc47e','2017-09-05 12:09:35'),
  (245,'99d0a4914f8f3bd97ec1246bbb8d79f0','2017-09-05 13:09:58'),
  (246,'99ae3332398cfe261b594e2bb7eea336','2017-09-05 13:09:48'),
  (247,'30e3a0929ab5f0e89b027d79f2cae19b','2017-09-05 13:09:34'),
  (248,'e0424d2b8af3734b8a2390e54ba82dab','2017-09-05 13:09:24'),
  (250,'d9ba80f6df678e91dd6fb116ef54d882','2017-09-05 13:09:14'),
  (252,'816923ad71bc2d28cb7643535c47407a','2017-09-05 13:09:04'),
  (254,'f9e54ae3192948dff4d53485fe84b54e','2017-09-05 13:09:39'),
  (255,'d9b50f91612979c6a65364f3af104a0e','2017-09-05 13:09:40'),
  (256,'67365a76fb0a2a1145b13c8210d6a830','2017-09-05 13:09:41'),
  (258,'45bf053bd6a250a5fd9ad2290b4b1af6','2017-09-05 13:09:35'),
  (261,'633d8ad6eb273c4afd76e2e33d6ac1d0','2017-09-05 13:09:45'),
  (262,'f9e54ae3192948dff4d53485fe84b54e','2017-09-05 13:09:39'),
  (272,'2bd53e3f31e5986f81d868657702ded9','2017-09-05 18:09:47'),
  (287,'d51df68062d63d523b96a7d1bfa616c3','2017-09-06 16:09:58');
COMMIT;

#
# Data for the `wallets_has_campaigns` table  (LIMIT 0,500)
#

INSERT INTO `wallets_has_campaigns` (`idWallet`, `idCampaign`, `idWalletsHasCampaigns`) VALUES 
  (5335,15,1),
  (6259,119,2);
COMMIT;

#
# Data for the `wallets_of_coordinators_juridic` table  (LIMIT 0,500)
#

INSERT INTO `wallets_of_coordinators_juridic` (`idCampaign`, `idWalletTempo`, `idCoordinatorJuridic`) VALUES 
  (94,5,45),
  (103,8,82),
  (104,9,84),
  (112,14,85),
  (94,1,86),
  (96,3,89),
  (98,5,89),
  (95,2,90);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;