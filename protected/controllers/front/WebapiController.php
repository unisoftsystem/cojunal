<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include realpath('./') . '/vendor/autoload.php';

use Box\Spout\Writer\WriterFactory;
use Box\Spout\Common\Type;

class WebapiController extends GxController {

	function actionIndex()
	{
		echo "string";
	}

	function setHeader()
	{
    	header('Access-Control-Allow-Origin: *');
    	header('Content-Type: application/json');
	}
	/**
     * [apiResponse description]
     * @param  [type] $data [description]
     * @return [type]       [description]
     */
    function apiResponse($data)
    {
    	$this->setHeader();
    	echo json_encode($data);
    }

	/******************************************************
	 *                      API
	 *****************************************************/
	/**
	 * Coordinador Cojunal bandeja entrada
	 */
	function actionGetCoordinadorBandejaEntrada()
	{
		$parentAdviser = 82;
		if(empty($parentAdviser)) return $this->apiResponse(['message' => 'Acceso denegado']);

		$validate = ' ';
		$validate .= (!empty($_POST['name'])) ? sprintf(' AND campaigns.name LIKE "%%%s%%"', $_POST['name']) : "";
		$validate .= (!empty($_POST['campanas'])) ? sprintf(' AND campanas LIKE "%%%s%%"', $_POST['campanas']) : "";
		$validate .= (!empty($_POST['total'])) ? sprintf(' AND total LIKE "%%%s%%"', $_POST['total']) : "";
		$validate .= (!empty($_POST['saldo'])) ? sprintf(' AND saldo LIKE "%%%s%%"', $_POST['saldo']) : "";
		$validate .= (!empty($_POST['recaudo'])) ? sprintf(' AND recaudo LIKE "%%%s%%"', $_POST['recaudo']) : "";
		$validate .= (!empty($_POST['init_deudores'])) ? sprintf(' AND deudores >= "%s"', $_POST['init_deudores']) : "";		
		$validate .= (!empty($_POST['end_deudores'])) ? sprintf(' AND deudores <= "%s"', $_POST['end_deudores']) : "";		

		$sql = sprintf('SELECT campaigns.name, campaigns.idCampaign, wallets_by_campaign.campaignName, wallets_by_campaign.idWalletByCampaign, wallets_tempo.idCampaign, COUNT(DISTINCT wallets_by_campaign.IdCampaign) AS "campanas", SUM(wallets_tempo.capitalValue) AS "total", (SELECT "total" - ( SELECT SUM(VALUE) FROM payments WHERE idWallet = wallets_tempo.id)) AS "saldo", (SELECT ("saldo" / "total") * 100 ) AS "recaudo", COUNT(wallets_tempo.id) AS "deudores" FROM wallets_by_campaign INNER JOIN wallets_tempo ON wallets_tempo.idCampaign = wallets_by_campaign.idWalletByCampaign INNER JOIN campaigns ON campaigns.idCampaign = wallets_by_campaign.IdCampaign WHERE wallets_by_campaign.idCoordinador = "%s" GROUP BY campaigns.name', $parentAdviser);
		 
		// $sql = sprintf('SELECT name, idCampaign, ( SELECT COUNT(IdCampaign) FROM wallets_by_campaign WHERE IdCampaign = campaigns.idCampaign ) AS campanas, ( SELECT SUM(capitalValue) FROM wallets_tempo WHERE idCampaign IN ( SELECT idWalletByCampaign FROM wallets_by_campaign WHERE IdCampaign = campaigns.idCampaign )) AS "total", ( SELECT "total" - ( SELECT SUM(VALUE) FROM payments WHERE idWallet IN ( SELECT id FROM wallets_tempo WHERE idCampaign IN ( SELECT idWalletByCampaign FROM wallets_by_campaign WHERE IdCampaign = campaigns.idCampaign )))) AS "saldo", ( SELECT ("saldo" / "total") * 100 ) AS recaudo, ( SELECT COUNT(id) FROM wallets_tempo WHERE idCampaign IN ( SELECT idWalletByCampaign FROM wallets_by_campaign WHERE IdCampaign = campaigns.idCampaign )) AS deudores FROM campaigns WHERE idCampaign IN ( SELECT IdCampaign FROM wallets_by_campaign WHERE idWalletByCampaign IN ( SELECT idCampaign FROM wallets_tempo WHERE idAdviser IN ( SELECT idAdviser FROM advisers WHERE parentAdviser = "%s") OR idAdviser = "%s" GROUP BY (idCampaign))) ', $parentAdviser, $parentAdviser);
		
		$sql .= ' HAVING 1 ' . $validate;
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Obtener las campanas por cliente
	 */
	function actionGetCampanasPorCliente()
	{
		$validate = ' ';
		$validate .= (!empty($_POST['campana'])) ? sprintf(' AND campana LIKE "%%%s%%"', $_POST['campana']) : "";
		$validate .= (!empty($_POST['legalName'])) ? sprintf(' AND legalName LIKE "%%%s%%"', $_POST['legalName']) : "";
		$validate .= (!empty($_POST['idNumber'])) ? sprintf(' AND idNumber LIKE "%%%s%%"', $_POST['idNumber']) : "";
		$validate .= (!empty($_POST['ciudad'])) ? sprintf(' AND ciudad LIKE "%%%s%%"', $_POST['ciudad']) : "";
		$validate .= (!empty($_POST['estado'])) ? sprintf(' AND estado LIKE "%%%s%%"', $_POST['estado']) : "";
		$validate .= (!empty($_POST['clasificacion'])) ? sprintf(' AND clasificacion LIKE "%%%s%%"', $_POST['clasificacion']) : "";
		$validate .= (!empty($_POST['idAdviser'])) ? sprintf(' AND idAdviser = "%s"', $_POST['idAdviser']) : "";
		$validate .= (!empty($_POST['estado_juri_prej'])) ? sprintf(' AND estado_juri_prej LIKE "%%%s%%"', $_POST['estado_juri_prej']) : "";
		$validate .= (!empty($_POST['init_capitalValue'])) ? sprintf(' AND capitalValue >= "%s"', $_POST['init_capitalValue']) : "";
		$validate .= (!empty($_POST['end_capitalValue'])) ? sprintf(' AND capitalValue <= "%s"', $_POST['end_capitalValue']) : "";
		$validate .= (!empty($_POST['init_saldo'])) ? sprintf(' AND saldo >= "%s"', $_POST['init_saldo']) : "";
		$validate .= (!empty($_POST['end_saldo'])) ? sprintf(' AND saldo <= "%s"', $_POST['end_saldo']) : "";
		$validate .= (!empty($_POST['init_edad'])) ? sprintf(' AND edad >= "%s"', $_POST['init_edad']) : "";
		$validate .= (!empty($_POST['end_edad'])) ? sprintf(' AND edad <= "%s"', $_POST['end_edad']) : "";
		$validate .= (!empty($_POST['init_fechaAsignacion'])) 
			? sprintf(' AND fechaAsignacion >= "%s"', date('Y-m-d', strtotime($_POST['init_fechaAsignacion']))) 
			: "";
		$validate .= (!empty($_POST['end_fechaAsignacion'])) 
			? sprintf(' AND fechaAsignacion <= "%s"', date('Y-m-d', strtotime($_POST['end_fechaAsignacion']))) 
			: "";
		
		if(empty($_REQUEST['idCampaing'])) return $this->apiResponse(['message' => 'Falta idCampaign']);
		$idCampaing = $_REQUEST['idCampaing'];
		
		$sql = sprintf('SELECT wallets_tempo.id, wallets_tempo.legalName, wallets_tempo.idCampaign, wallets_tempo.idNumber, wallets_tempo.ciudad, wallets_tempo.capitalValue, wallets_tempo.idAdviser, wallets_by_campaign.idWalletByCampaign, wallets_tempo.estado_juri_prej, wallets_by_campaign.campaignName AS campana, SUM(payments.value) AS saldo, status.description AS estado, status.description AS clasificacion, wallets_by_campaign.createAt AS fechaAsignacion, (SELECT DATEDIFF(NOW(), wallets_by_campaign.createAt)) AS edad FROM wallets_tempo LEFT JOIN wallets_by_campaign ON wallets_by_campaign.idWalletByCampaign = wallets_tempo.idCampaign LEFT JOIN payments ON payments.idWallet = wallets_tempo.id LEFT JOIN status ON status.idStatus = wallets_tempo.idStatus WHERE wallets_tempo.idCampaign = "%s" GROUP BY wallets_tempo.legalName, wallets_by_campaign.idWalletByCampaign', $idCampaing);

		$sql .= ' HAVING 1 ' . $validate;
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Obtener os deudores por asesor
	 */
	function actionGetCampanasPorAsesor()
	{
		$validate = ' ';
		$validate .= (!empty($_POST['campana'])) ? sprintf(' AND campana LIKE "%%%s%%"', $_POST['campana']) : "";
		$validate .= (!empty($_POST['legalName'])) ? sprintf(' AND legalName LIKE "%%%s%%"', $_POST['legalName']) : "";
		$validate .= (!empty($_POST['idNumber'])) ? sprintf(' AND idNumber LIKE "%%%s%%"', $_POST['idNumber']) : "";
		$validate .= (!empty($_POST['ciudad'])) ? sprintf(' AND ciudad LIKE "%%%s%%"', $_POST['ciudad']) : "";
		$validate .= (!empty($_POST['estado'])) ? sprintf(' AND estado LIKE "%%%s%%"', $_POST['estado']) : "";
		$validate .= (!empty($_POST['clasificacion'])) ? sprintf(' AND clasificacion LIKE "%%%s%%"', $_POST['clasificacion']) : "";
		$validate .= (!empty($_POST['idAdviser'])) ? sprintf(' AND idAdviser = "%s"', $_POST['idAdviser']) : "";
		$validate .= (!empty($_POST['estado_juri_prej'])) ? sprintf(' AND estado_juri_prej LIKE "%%%s%%"', $_POST['estado_juri_prej']) : "";
		$validate .= (!empty($_POST['init_capitalValue'])) ? sprintf(' AND capitalValue >= "%s"', $_POST['init_capitalValue']) : "";
		$validate .= (!empty($_POST['end_capitalValue'])) ? sprintf(' AND capitalValue <= "%s"', $_POST['end_capitalValue']) : "";
		$validate .= (!empty($_POST['init_saldo'])) ? sprintf(' AND saldo >= "%s"', $_POST['init_saldo']) : "";
		$validate .= (!empty($_POST['end_saldo'])) ? sprintf(' AND saldo <= "%s"', $_POST['end_saldo']) : "";
		$validate .= (!empty($_POST['init_edad'])) ? sprintf(' AND edad >= "%s"', $_POST['init_edad']) : "";
		$validate .= (!empty($_POST['end_edad'])) ? sprintf(' AND edad <= "%s"', $_POST['end_edad']) : "";
		$validate .= (!empty($_POST['init_fechaAsignacion'])) 
			? sprintf(' AND fechaAsignacion >= "%s"', date('Y-m-d', strtotime($_POST['init_fechaAsignacion']))) 
			: "";
		$validate .= (!empty($_POST['end_fechaAsignacion'])) 
			? sprintf(' AND fechaAsignacion <= "%s"', date('Y-m-d', strtotime($_POST['end_fechaAsignacion']))) 
			: "";
		
		if(empty($_REQUEST['idAdviser'])) return $this->apiResponse(['message' => 'Falta idAdviser']);
		$idAdviser = $_REQUEST['idAdviser'];
		
		$sql = sprintf('SELECT wallets_tempo.id, wallets_tempo.legalName, wallets_tempo.idCampaign, wallets_tempo.idNumber, wallets_tempo.ciudad, wallets_tempo.capitalValue, wallets_tempo.idAdviser, wallets_by_campaign.idWalletByCampaign, wallets_tempo.estado_juri_prej, wallets_by_campaign.campaignName AS campana, SUM(payments.value) AS saldo, status.description AS estado, status.description AS clasificacion, wallets_by_campaign.createAt AS fechaAsignacion, (SELECT DATEDIFF(NOW(), wallets_by_campaign.createAt)) AS edad FROM wallets_tempo LEFT JOIN wallets_by_campaign ON wallets_by_campaign.idWalletByCampaign = wallets_tempo.idCampaign LEFT JOIN payments ON payments.idWallet = wallets_tempo.id LEFT JOIN status ON status.idStatus = wallets_tempo.idStatus WHERE wallets_tempo.idAdviser = "%s" GROUP BY wallets_tempo.legalName, wallets_by_campaign.idWalletByCampaign', $idAdviser);

		$sql .= ' HAVING 1 ' . $validate;
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Obtener los asesores para llenar un select
	 */
	function actionGetSelectAsesores()
	{
		$parentAdviser = 72;
		if(empty($parentAdviser)) return $this->apiResponse(['message' => 'Acceso denegado']);

		$sql = sprintf('SELECT * FROM advisers WHERE parentAdviser = "%s" AND idAuthAssignment IN (SELECT idAuthAssignment FROM authassignment WHERE itemname LIKE "%Asesor%") AND idAdviser > 0', $parentAdviser);
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Asignar asesor a campaña
	 */
	function actionAsignarAsesorCampana()
	{

		$sql = sprintf('UPDATE wallets_tempo SET idAdviser = "%s", updateAt = NOW() WHERE idCampaign = "%s"', $_POST['idAdviser'], $_POST['idCampaign']);
		Yii::app()->db->createCommand($sql)->execute();

		$sql = sprintf('UPDATE wallets_by_campaign SET idAdviser = "%s" WHERE idWalletByCampaign = "%s"', $_POST['idAdviser'], $_POST['idCampaign']);
		$res = Yii::app()->db->createCommand($sql)->execute();
		$this->apiResponse($res);
	}
	/**
	 * Obtener asesores para el listado
	 */
	function actionGetAsesores()
	{
		// coordinador 77
		$validate = ' ';
		$validate .= (!empty($_POST['name'])) ? sprintf(' AND name LIKE "%%%s%%"', $_POST['name']) : "";
		$validate .= (!empty($_POST['init_campanas'])) ? sprintf(' AND campanas >= "%s"', $_POST['init_campanas']) : "";
		$validate .= (!empty($_POST['end_campanas'])) ? sprintf(' AND campanas <= "%s"', $_POST['end_campanas']) : "";
		$validate .= (!empty($_POST['init_recuperado'])) ? sprintf(' AND recuperado >= "%s"', $_POST['init_recuperado']) : "";
		$validate .= (!empty($_POST['end_recuperado'])) ? sprintf(' AND recuperado <= "%s"', $_POST['end_recuperado']) : "";
		$validate .= (!empty($_POST['init_porcentaje'])) ? sprintf(' AND porcentaje >= "%s"', $_POST['init_porcentaje']) : "";
		$validate .= (!empty($_POST['end_saldoAsignado'])) ? sprintf(' AND saldoAsignado <= "%s"', $_POST['end_saldoAsignado']) : "";
		$validate .= (!empty($_POST['init_deudores'])) ? sprintf(' AND deudores >= "%s"', $_POST['init_deudores']) : "";
		$validate .= (!empty($_POST['end_porcentaje'])) ? sprintf(' AND porcentaje <= "%s"', $_POST['end_porcentaje']) : "";
		$validate .= (!empty($_POST['init_dCreation'])) 
			? sprintf(' AND dCreation >= "%s"', date('Y-m-d', strtotime($_POST['init_dCreation']))) 
			: "";
		$validate .= (!empty($_POST['end_dCreation'])) 
			? sprintf(' AND dCreation <= "%s"', date('Y-m-d', strtotime($_POST['end_dCreation']))) 
			: "";
		
		$parentAdviser = 72;
		if(empty($parentAdviser)) return $this->apiResponse(['message' => 'Falta parentAdviser']);

		$sql = sprintf('SELECT advisers.idAdviser, advisers.parentAdviser, advisers.name, advisers.email, advisers.dCreation, advisers.dUpdate, advisers.active, COUNT(wallets_tempo.idAdviser) AS campanas, SUM(payments.value) AS "recuperado", SUM(wallets_tempo.capitalValue) AS "saldoAsignado", COUNT(wallets_tempo.idAdviser) AS deudores, ((SUM(capitalValue) / "recuperado") * 100) AS porcentaje FROM advisers LEFT JOIN authassignment ON authassignment.idAuthAssignment = advisers.idAuthAssignment LEFT JOIN wallets_by_campaign ON wallets_by_campaign.idAdviser = advisers.idAdviser LEFT JOIN payments ON payments.idAdviser = advisers.idAdviser LEFT JOIN wallets_tempo ON wallets_tempo.idAdviser = advisers.idAdviser WHERE advisers.parentAdviser = "%s" AND authassignment.itemname LIKE "%%%s%%" GROUP BY advisers.idAdviser', $parentAdviser, 'Asesor');

		$sql .= ' HAVING 1 ' . $validate;
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Obtener listado de deudores de una campaña para actualizar el asesor
	 */
	function actionGetDeudoresByCampaing($dowload = false)
	{
		$_POST['q']         = (!empty($_POST['q'])) ? $_POST['q']: '';
		$nombre             = (!empty($_POST['nombre'])) ? $_POST['nombre'] : $_POST['q'];
		$nit                = (!empty($_POST['nit'])) ? $_POST['nit'] : $_POST['q'];
		$ciudad             = (!empty($_POST['ciudad'])) ? $_POST['ciudad'] : $_POST['q'];
		$fecha              = (!empty($_POST['fecha'])) ? $_POST['fecha'] : '';
		$capitalValue       = (!empty($_POST['capitalValue'])) ? $_POST['capitalValue'] : '';
		$saldo              = (!empty($_POST['saldo'])) ? $_POST['saldo'] : '';
		$estado             = (!empty($_POST['estado'])) ? $_POST['estado'] : '';
		$edad               = (!empty($_POST['edad'])) ? $_POST['edad'] : '';
		$clasificación      = (!empty($_POST['clasificación'])) ? $_POST['clasificación'] : '';
		$idAdviser          = (!empty($_POST['idAdviser'])) ? $_POST['idAdviser'] : '';
		$idWalletByCampaign = (!empty($_POST['idWalletByCampaign'])) ? $_POST['idWalletByCampaign'] : $_GET['idWalletByCampaign'];

		// coordinador 77
		$sql = sprintf('SELECT id, idCampaign, updateAt as "fecha", legalName as nombre, idNumber as nit, ciudad as ciudad, capitalValue as "capitalValue", (SELECT effectName FROM effects WHERE idEffect = (SELECT idEffect FROM agendas WHERE idWallet = wallets_tempo.id ORDER BY idAgenda LIMIT 1)) as "clasificación", (SELECT DATEDIFF(NOW(), dCreation) FROM agendas WHERE idWallet = wallets_tempo.id ORDER BY idAgenda LIMIT 1) as "edad", (SELECT "capitalValue" - SUM(value) FROM payments WHERE idWallet = wallets_tempo.id) as "saldo", (SELECT description FROM status WHERE idStatus = wallets_tempo.idStatus) as "estado", (SELECT idAdviser FROM advisers WHERE idAdviser = wallets_tempo.idAdviser) as asesor FROM wallets_tempo WHERE idCampaign = "%s" AND (legalName LIKE "%%%s%%" OR idNumber LIKE "%%%s%%" OR ciudad LIKE "%%%s%%")', $idWalletByCampaign, $nombre, $nit, $ciudad);
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		if ($dowload) return $res;
		$this->apiResponse($res);
	}
	/**
	 * Actualizar el asesor de un deudor
	 */
	function actionUpdateAsesorDeudor()
	{
		// coordinador 77
		$sql = sprintf('UPDATE wallets_tempo SET idAdviser = "%s" WHERE id = "%s"', $_POST['idAdviser'], $_POST['id']);
		$res = Yii::app()->db->createCommand($sql)->execute();
		$this->apiResponse($res);
	}
	/**
	 * Descargar excel con informacion de deudores de una campaña todos los campos (Sin campana)
	 */
	 function actionDowloadDBDeudores()
	{
		$idCampaign = (!empty($_POST['idCampaign'])) ? $_POST['idCampaign'] : $_GET['idCampaign'];
		$sql = sprintf('SELECT idNumber, capitalValue, legalName, address, phone, email, ciudad, product, validThrough, accountNumber, titleValue, typePhone1, countryPhone1, cityPhone1, phone1, typePhone2, countryPhone2, cityPhone2, phone2, typePhone3, countryPhone3, cityPhone3, phone3, nameReference1, relationshipReferenc1, countryReference1, cityReference1, commentReference1, nameReference2, relationshipReference2, countryReference2, cityReference2, commentReference2, nameReference3, relationshipReference3, countryReference3, cityReference3, commentReference3, nameEmail1, email1, nameEmail2, email2, nameEmail3, email3, typeAddress1, address1, countryAdrress1, cityAddress1, typeAddress2, address2, countryAddress2, cityAddress2, typeAddress3, address3, countryAddress3, cityAddress3, typeAsset1, nameAsset1, commentAsset1, typeAsset2, nameAsset2, commentAsset2, typeAsset3, nameAsset3, commentAsset3 FROM wallets_tempo WHERE idCampaign = "%s"', $idCampaign);
		
		$sqlNameCampana = sprintf('SELECT campaignName FROM wallets_by_campaign WHERE idWalletByCampaign = "%s"', $idCampaign);
		$name = Yii::app()->db->createCommand($sqlNameCampana)->queryAll();
		$_name = $name[0]['campaignName'];
		$_fecha = date('d-m-Y');
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$filePath = 'Reporte Campaña '.$_name.'_'.$_fecha.'.xlsx';
		$writer = WriterFactory::create(Type::XLSX);
		$multipleRows = $res;
		$singleRow = ['NIT - Cedula','Monto', ',Nombre', 'Direccion', 'Telefono', 'Correo', 'Ciudad', 'Producto', 'Fecha de Vencimiento', 'Cuenta del Cliente', 'Titulo Valor', 'Tipo telefono 1', 'Pais Telefono 1', 'Departamento Telefono 1', 'Numero Telefono 1', 'Tipo telefono 2', 'Pais Telefono 2', 'Departamento Telefono 2', 'Numero Telefono 2', 'Tipo telefono 3', 'Pais Telefono 3', 'Departamento Telefono 3', 'Numero Telefono 3', 'Nombre Referencia 1', 'Parentesco Referencia 1', 'Pais Referencia 1', 'Departamento Referencia 1', 'Comentarios Referencia 1', 'Nombre Referencia 2', 'Parentesco Referencia 2', 'Pais Referencia 2', 'Departamento Referencia 2', 'Comentarios Referencia 2', 'Nombre Referencia 3', 'Parentesco Referencia 3', 'Pais Referencia 3', 'Departamento Referencia 3', 'Comentarios Referencia 3', 'Nombre Correo 1', 'Corrreo 1', 'Nombre Correo 2', 'Corrreo 2', 'Nombre Correo 3', 'Corrreo 3', 'Tipo Direccion 1', 'Direccion 1', 'Pais Direccion 1', 'Departamento Direccion 1', 'Tipo Direccion 2', 'Direccion 2', 'Pais Direccion 2', 'Departamento Direccion 2', 'Tipo Direccion 3', 'Direccion 3', 'Pais Direccion 3', 'Departamento Direccion 3', 'Tipo Bien 1', 'Nombre Bien 1', 'Comentarios Bien 1', 'Tipo Bien 2', 'Nombre Bien 2', 'Comentarios Bien 2', 'Tipo Bien 3', 'Nombre Bien 3', 'Comentarios Bien 3'];
		$writer->openToBrowser($filePath);
		$writer->addRow([$_fecha]);
		$writer->addRow(['Campana: ', $_name]);
		$writer->addRow(['']);
		$writer->addRow($singleRow);
		$writer->addRows($multipleRows);
		$writer->close();
	}
	/**
	 * Descargar excel con informacion de deudores de una campaña todos los campos (Con campaña)
	 */
	 function actionDowloadDBDeudoresConCampana()
	{
		$multipleRows = [];
		$idCampaign = (!empty($_POST['idCampaign'])) ? $_POST['idCampaign'] : $_GET['idCampaign'];
		$sql = sprintf('SELECT idNumber, capitalValue, legalName, address, phone, email, ciudad, product, validThrough, accountNumber, titleValue, typePhone1, countryPhone1, cityPhone1, phone1, typePhone2, countryPhone2, cityPhone2, phone2, typePhone3, countryPhone3, cityPhone3, phone3, nameReference1, relationshipReferenc1, countryReference1, cityReference1, commentReference1, nameReference2, relationshipReference2, countryReference2, cityReference2, commentReference2, nameReference3, relationshipReference3, countryReference3, cityReference3, commentReference3, nameEmail1, email1, nameEmail2, email2, nameEmail3, email3, typeAddress1, address1, countryAdrress1, cityAddress1, typeAddress2, address2, countryAddress2, cityAddress2, typeAddress3, address3, countryAddress3, cityAddress3, typeAsset1, nameAsset1, commentAsset1, typeAsset2, nameAsset2, commentAsset2, typeAsset3, nameAsset3, commentAsset3 FROM wallets_tempo WHERE idCampaign = "%s"', $idCampaign);
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		
		$sqlNameCampana = sprintf('SELECT campaignName FROM wallets_by_campaign WHERE idWalletByCampaign = "%s"', $idCampaign);
		$name = Yii::app()->db->createCommand($sqlNameCampana)->queryAll();
		$_name = $name[0]['campaignName'];
		$_fecha = date('d-m-Y');
		$filePath = 'Reporte Campaña '.$_name.'_'.$_fecha.'.xlsx';
		
		$writer = WriterFactory::create(Type::XLSX);
		$singleRow = ['Campaña', 'NIT - Cedula','Monto', ',Nombre', 'Direccion', 'Telefono', 'Correo', 'Ciudad', 'Producto', 'Fecha de Vencimiento', 'Cuenta del Cliente', 'Titulo Valor', 'Tipo telefono 1', 'Pais Telefono 1', 'Departamento Telefono 1', 'Numero Telefono 1', 'Tipo telefono 2', 'Pais Telefono 2', 'Departamento Telefono 2', 'Numero Telefono 2', 'Tipo telefono 3', 'Pais Telefono 3', 'Departamento Telefono 3', 'Numero Telefono 3', 'Nombre Referencia 1', 'Parentesco Referencia 1', 'Pais Referencia 1', 'Departamento Referencia 1', 'Comentarios Referencia 1', 'Nombre Referencia 2', 'Parentesco Referencia 2', 'Pais Referencia 2', 'Departamento Referencia 2', 'Comentarios Referencia 2', 'Nombre Referencia 3', 'Parentesco Referencia 3', 'Pais Referencia 3', 'Departamento Referencia 3', 'Comentarios Referencia 3', 'Nombre Correo 1', 'Corrreo 1', 'Nombre Correo 2', 'Corrreo 2', 'Nombre Correo 3', 'Corrreo 3', 'Tipo Direccion 1', 'Direccion 1', 'Pais Direccion 1', 'Departamento Direccion 1', 'Tipo Direccion 2', 'Direccion 2', 'Pais Direccion 2', 'Departamento Direccion 2', 'Tipo Direccion 3', 'Direccion 3', 'Pais Direccion 3', 'Departamento Direccion 3', 'Tipo Bien 1', 'Nombre Bien 1', 'Comentarios Bien 1', 'Tipo Bien 2', 'Nombre Bien 2', 'Comentarios Bien 2', 'Tipo Bien 3', 'Nombre Bien 3', 'Comentarios Bien 3'];

		foreach ($res as $value) {
			array_unshift($value, $_name);
			$multipleRows[] = $value;
		}
		$writer->openToBrowser($filePath);
		$writer->addRow([$_fecha]);
		$writer->addRow(['']);
		$writer->addRow($singleRow);
		$writer->addRows($multipleRows);
		$writer->close();
	}
	/**
	 * Descargar excel con informacion de deudores de una campaña con filtros
	 */
	function actionDownloadExcelDeudodresCampanas()
	{
		$filePath = 'campanas.xlsx';
		$writer = WriterFactory::create(Type::XLSX);
		$multipleRows = $this->actionGetDeudoresByCampaing(true);
		$singleRow = ['Nombre/Razón Social', 'Cedula/Nit', 'Ciudad', 'Fecha de Asignación', 'Capital', 'Saldo', 'Estado', 'Edad', 'Clasificación', 'Asesor'];
		$writer->openToBrowser($filePath);
		$writer->addRow($singleRow);
		$writer->addRows($multipleRows);
		$writer->close();
	}
	/**
	 * Obtner listado de acciones para llenar select
	 */
	function actionGetSelectActions()
	{
		$sql = 'SELECT * FROM action';
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Obtner listado de efectos segun la accion
	 */
	function actionGetSelectEfects()
	{
		$sql = sprintf('SELECT effects.effectName, effects.idEffect, actions_has_effects.idAction FROM actions_has_effects LEFT JOIN effects ON effects.idEffect = actions_has_effects.idEffect');
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Mostrar tareas
	 */
	function actionGetTareas()
	{
		$parentAdviser = 72;
		if(empty($parentAdviser)) return $this->apiResponse(['message' => 'Falta parentAdviser']);
		$sql = sprintf('SELECT agendas.* FROM agendas INNER JOIN advisers ON advisers.idAdviser = agendas.idAdviser WHERE advisers.parentAdviser = "%s"', $parentAdviser);
		$res = Yii::app()->db->createCommand($sql)->queryAll();
		$this->apiResponse($res);
	}
	/**
	 * Asognar tarea
	 */
	function actionAsignarTarea()
	{
		$sql = sprintf("INSERT INTO agendas (idAgenda, idAction, dAction, dCreation, idWallet, idAdviser, idEffect, comment, timer) VALUES (NULL, '%s', '%s', CURRENT_TIMESTAMP, '%s', '%s', '%s', '%s', '%s')", $_POST['action'], date('Y-m-d', strtotime($_POST['date'])), $_POST['idWallet'], $_POST['idAdviser'], $_POST['efects'], $_POST['comments'], date('H:i:s', time()));
		
		// var_dump($sql);
		// exit();

		$res = Yii::app()->db->createCommand($sql)->execute();
		$this->apiResponse($res);
	}

	
}
