<?php

Yii::import('application.models._base.BaseAdvisers');

class AdvisersBase extends BaseAdvisers
{
	// NO BORRAR ESTA FUNCION
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public static function listCampanas($id=""){
		$connection = Yii::app()->db;
		$sql = "SELECT 
												`advisers`.`name` AS `coordinador`,
												`campaigns`.`name` AS `campana`,
												`campaigns`.`companyName`,
												`campaigns`.`fCreacion`,
												`advisers1`.`name` as asesor,
												(SELECT `paymentypes`.`paymentTypeName` FROM `paymentypes` INNER JOIN `viewlistdebtors` ON (`paymentypes`.`idPaymentType` = `viewlistdebtors`.`type`) WHERE `viewlistdebtors`.`idCampaign` = `campaigns`.`idCampaign` GROUP BY viewlistdebtors.type) AS `type`,
												(SELECT SUM(`viewlistdebtors`.`capitalValue`) AS `FIELD_1` FROM `viewlistdebtors` WHERE `viewlistdebtors`.`idCampaign` = `campaigns`.`idCampaign` GROUP BY viewlistdebtors.type) AS `total_campa`,
												`advisers_campaigns`.`idAdvisers`,
												campaigns.idCampaign
												FROM
												`campaigns`
												INNER JOIN `advisers_campaigns` ON (`campaigns`.`idCampaign` = `advisers_campaigns`.`idCampaign`)
												INNER JOIN `advisers` ON (`advisers_campaigns`.`idAdvisers` = `advisers`.`idAdviser`)
												INNER JOIN `advisers` `advisers1` ON (`campaigns`.`idAdviser` = `advisers1`.`idAdviser`)
												WHERE
												`advisers_campaigns`.`idAdvisers` = '".$id."'";
		$listado = Yii::app()->db->createCommand($sql)->queryAll();
		return $listado;
	}


	public static function lista_asesores(){
		$connection = Yii::app()->db;
		$sql = 'SELECT DISTINCT 
												  advisers.name,
												  SUM(wallets.capitalValue) AS total,
												  COUNT(campaigns.name) AS num_campana
												FROM
												  advisers
												  INNER JOIN advisers_campaigns ON (advisers.idAdviser = advisers_campaigns.idAdvisers)
												  INNER JOIN campaigns ON (advisers_campaigns.idCampaign = campaigns.idCampaign)
												  INNER JOIN wallets_has_campaigns ON (campaigns.idCampaign = wallets_has_campaigns.idCampaign)
												  INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet)
												WHERE
												  advisers.status_idStatus = 2
												GROUP BY
												  advisers.name';
		$listado = Yii::app()->db->createCommand($sql)->queryAll();
		return $listado;
	}
	
	
	public static function actionSaveComment(){
		$idWallet = $_REQUEST['idWallet'];
		$idAdviser = $_REQUEST['idAdviser'];
		$comment = $_REQUEST['comment'];
		
		$model = new Comments;
		$model->idWallet = $idWallet;
		$model->idAdviser = $idAdviser;
		$model->comment = $comment;
		
		if(!$model->save()){                
				Yii::log("Error Campaign", "error", "actionSaveComment");
		}else{
				Yii::app()->user->setFlash('success', "Registros actualizados con éxito");
		}
}

	public function add_coordi_campana($idCampaign,$idCoordinator){
		$connection = Yii::app()->db;
		$sql = "INSERT INTO 
				  `advisers_campaigns`
				(
				  `idAdvisers`,
				  `idCampaign`
				) 
				VALUE (				 
				  :idAdvisers,
				  :idCampaign
				);";
		$parameters = array(":idAdvisers" 	=> $idCoordinator,
							":idCampaign" 	=> $idCampaign);
		Yii::app()->db->createCommand($sql)->execute($parameters);		
	}
	
		public static function lista_deudores(){
		$connection = Yii::app()->db;
		$sql = 'SELECT 
												  wallets.idWallet,
												  wallets.legalName,
												  wallets.idStatus,
												  `status`.description,
												  wallets.email,
												  wallets.capitalValue
												FROM
												  `status`
												  INNER JOIN wallets ON (`status`.idStatus = wallets.idStatus)
												WHERE
												  `status`.idStatus = 5';
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}
	
	
	public static function lista_user_juridicos(){
		$connection = Yii::app()->db;
		$sql = 'SELECT 
						advisers.name,
						advisers.idAdviser
					FROM
						advisers
					WHERE
						advisers.status_idStatus = 5';
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}
	


	public function update_wallets($idWallet,$idAdviser){

		$connection = Yii::app()->db;
		$idWallet = $_REQUEST['idWallet'];
		$idAdviser = $_REQUEST['idAdviser'];
	
		// $command = Yii::app()->db->createCommand()->update('wallets', 
		// 	array('idAdviser' => $idAdviser), 
		// 	'idWallet=:idWallet', 
		// 	array(':idWallet'=> $idWallet);				
		
		return Yii::app()->db->createCommand()->update(
			'wallets', 
			['idAdviser' => $idAdviser], 
			'idWallet=:idWallet',
			[':idWallet' => $idWallet]
		);
	}


	public static function listado_estados(){
		$connection = Yii::app()->db;
		$sql = 'SELECT 
					`status`.idStatus,
					`status`.description,
					`status`.dCreation
				FROM
					`status`';
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}
	
	
	public function add_estados(){
		$connection = Yii::app()->db;
		$descripction = $_REQUEST['description'];
		$idCampaing = $_REQUEST['idCampaing'];
		//$creacion = $_REQUEST['dCreation'];

		$sql = "INSERT INTO `status` (`description`, `idCampaing`, `dCreation` ) 
			VALUES (:description, :idCampaing, :dCreation);";
		$parameters = [
			":description" 	=> $descripction,
			":idCampaing" 	=> $idCampaing,
			":dCreation" 	=> date('Y-m-d')
		];
		return Yii::app()->db->createCommand($sql)->execute($parameters);		
	}
	
	public function get_status(){
		$idCampaing = $_REQUEST['idCampaing'];
		$sql = sprintf('SELECT * FROM `status` WHERE idCampaing = "%s"', $idCampaing);
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}
	
	
		public function update_status(){

		$connection = Yii::app()->db;
		$descripcion = $_REQUEST['descripcion'];
		$idStatus = $_REQUEST['idStatus'];
	
		$command = Yii::app()->db->createCommand()->update(
			'status', 
			array('description'=>$descripcion), 
			'idStatus=:idStatus', 
			array(':idStatus'=>$idStatus)
		);
		return $command;
	}	
	
	public function listado_campanas_coordinador(){
		$sql = 'SELECT DISTINCT 
				  campaigns.name,
				  campaigns.companyName,
				  COUNT(campaigns.name) AS campanas,
				  COUNT(wallets.idWallet) AS num_deudores,
				  SUM(wallets.capitalValue) AS saldo
				FROM
				  wallets_has_campaigns
				  INNER JOIN campaigns ON (wallets_has_campaigns.idCampaign = campaigns.idCampaign)
				  INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet)
				GROUP BY
				  campaigns.name,
				  campaigns.companyName';
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}			
	

	public function lista_clientes_editar(){
		$idcampana = $_REQUEST['idcampaight'];
		$sql = 'SELECT 
				campaigns.idCampaign,
				campaigns.name,
				campaigns.contactEmail,
				campaigns.fCreacion,
				campaigns.idNumber,
				campaigns.valueService1,
				campaigns.valueService2,
				campaigns.interest,
				campaigns.percentageCommission,
				campaigns.fees
			FROM
				campaigns
			WHERE
				campaigns.idCampaign = '.$idcampana;
		$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
		return $listado;
	}	


	public function update_clientes(){
		
		
				$connection = Yii::app()->db;
				//$nombre 	= $_POST['Campaigns']['name'];
				//$email 		= $_POST['Campaigns']['contactEmail'];
				//$nit 		= $_POST['Campaigns']['idNumber'];
				$value1 	= $_POST['Campaigns']['valueService1'];
				$value2 	= $_POST['Campaigns']['valueService2'];
				$interes 	= $_POST['Campaigns']['interest'];
				$com 		= $_POST['Campaigns']['percentageCommission'];
				$hono 		= $_POST['Campaigns']['fees'];
				$id			= $_POST['Campaigns']['idAdviser'];

				

			return Yii::app()->db->createCommand()->update(
				'campaigns', 
				['valueService1' => $value1], 
				'idCampaign=:idCampaign',
				[':idCampaign' => $id]
			);
	}

	
	function asigna_campana(){
		
				/*$sql = "INSERT INTO wallets_by_campaign (idCampaign, campaignName, serviceType, notificationType, createAt) 
				VALUES (:idCampaign, :campaignName, :serviceType, :notificationType, CURRENT_TIMESTAMP)";
				$parameters = [
					':idCampaign' => $data['idCampaign'], 
					':campaignName' => $data['campaignName'], 
					':serviceType' => $data['serviceType'], 
					':notificationType' => $data ['notificationType']
				];
				return Yii::app()->db->createCommand($sql)->execute($parameters);*/
		
				return "jj";
		
			}


			public function lista_remisiones(){
				$idcliente = $_REQUEST['idCliente'];
				$sql = 'SELECT 
						campaigns.name,
						remisiones.hora,
						remisiones.fecha,
						remisiones.id
						FROM
						remisiones
						INNER JOIN campaigns ON (remisiones.idCliente = campaigns.idCampaign)
						WHERE
						campaigns.idCampaign = '.$idcliente;
				$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
				return $listado;
			}	

			public function lista_deudores_wallets($id){
				
				$sql = 'SELECT 
						wallets.legalName,
						remisiones.intereses,
						remisiones.honorarios,
						remisiones.comision,
						remisiones.monto,
						remisiones.recaudo,
						remisiones.hora,
						remisiones.idCliente,
						remisiones.id,
						remisiones.idPayments,
						remisiones.idWalletByCampaign
						FROM
						wallets_has_campaigns
						INNER JOIN remisiones ON (wallets_has_campaigns.idCampaign = remisiones.idWalletByCampaign)
						INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet)
						WHERE
						remisiones.idWalletByCampaign  =  '.$id;
				$listado = Yii::app()->db->createCommand($sql)->queryAll($sql);
				return $listado;
			}			

	public function search_ordenes_servicio($busqueda){			
			$sql = "SELECT 
						campaigns.name,
						remisiones.hora,
						remisiones.fecha,
						remisiones.id
						FROM
						remisiones
						INNER JOIN campaigns ON (remisiones.idCliente = campaigns.idCampaign)
						WHERE
						remisiones.id = {$busqueda}";			
			$listado = Yii::app()->db->createCommand($sql)->queryAll();
			return $listado;
		
	}


	public function search_clientes($busqueda){
		$sql = "SELECT * FROM campanas_asignadas where name like '%{$busqueda}%' ORDER BY name limit 20";
		//$sql .= sprintf(" LIMIT %d, %d", ($limit * $records), $records);
		$listado = Yii::app()->db->createCommand($sql)->queryAll();
		return $listado;		
	}

	function wallets_payment($wallet){
		$sql = "SELECT 
		payments.value,
		payments.dPayment,
		payments.idWallet,
		paymentypes.paymentTypeName
	  FROM
		payments
		INNER JOIN paymentypes ON (payments.idPaymentType = paymentypes.idPaymentType)
	  WHERE
		payments.idWallet = $wallet";		
		$listado = Yii::app()->db->createCommand($sql)->queryAll();
		return $listado;
	}
	
	function reporte_campanas_clientes (){
		$sql = "SELECT DISTINCT 
				c.companyName AS empresa,
				c.name AS campana,
				advisers.name AS asesor,
				w.legalName AS deudor,
				sum(((((w.capitalValue * (select sysparams.feeRate from sysparams)) / 100) + (((w.capitalValue * (select sysparams.interestRate from sysparams)) / 100) * (select timestampdiff(MONTH, w.dAssigment, curdate())))) + w.capitalValue)) AS saldoAsignado,
				sum(w.capitalValue) AS totalRecuperado,
				c.fCreacion
			FROM
				wallets_has_campaigns whc
				INNER JOIN wallets w ON (whc.idWallet = w.idWallet)
				INNER JOIN campaigns c ON (c.idCampaign = whc.idCampaign)
				INNER JOIN advisers ON (w.idAdviser = advisers.idAdviser)
			GROUP BY
				c.companyName,
				c.name,
				advisers.name,
				w.legalName,
				c.fCreacion";

		$listado = Yii::app()->db->createCommand($sql)->queryAll();
		return $listado;				

	}


public function reporte_estado_deuda_campanas(){
	/*$sql = "SELECT DISTINCT 
  count(c.idCampaign) AS numCampanas,
  COUNT(w.idWallet) AS num_deudores,
  sum(w.capitalValue) AS totalRecuperado, 
  sum(((((w.capitalValue * (select sysparams.feeRate from sysparams)) / 100) + (((w.capitalValue * (select sysparams.interestRate from sysparams)) / 100) * (select timestampdiff(MONTH, w.dAssigment, curdate())))) + w.capitalValue)) AS saldoAsignado,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) BETWEEN 30 AND 45)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor45,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) BETWEEN 61 AND 90)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor90,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) BETWEEN 91 AND 120)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor120,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) BETWEEN 121 AND 180)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor180,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) BETWEEN 181 AND 360)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor360,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) < 30)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor30,
  (SELECT SUM(((to_days(curdate()) - to_days(wallets.validThrough)) > 360)) AS FIELD_1 FROM wallets_has_campaigns INNER JOIN wallets ON (wallets_has_campaigns.idWallet = wallets.idWallet) WHERE wallets_has_campaigns.idCampaign = c.idCampaign) AS menor30,
  c.idCampaign
FROM
  wallets_has_campaigns whc
  INNER JOIN wallets w ON (whc.idWallet = w.idWallet)
  INNER JOIN campaigns c ON (c.idCampaign = whc.idCampaign)
GROUP BY
  c.idCampaign";*/

  $sql = "SELECT 
  a.*,
  (SELECT SUM(recaudo) AS FIELD_1 FROM remisiones WHERE idWalletByCampaign = a.idWalletByCampaign) AS totalRecaudado,
  (SELECT remisiones.fecha FROM remisiones WHERE idWalletByCampaign = a.idWalletByCampaign ORDER BY id DESC LIMIT 1) AS fechaUltimaRemision,
  (SELECT SUM(capitalValue) AS FIELD_1 FROM wallets_tempo WHERE idCampaign = a.idWalletByCampaign) AS saldoCampana
FROM
  wallets_by_campaign a";
	$listado = Yii::app()->db->createCommand($sql)->queryAll();
	return $listado;	

}

public function deudores_campanas_informe($idcampa){
	$sql = "SELECT 
			wallets_tempo.accountNumber,
			wallets_tempo.idCampaign,
			wallets_tempo.legalName,
			wallets_tempo.id,
			wallets_tempo.idNumber,
			wallets_tempo.capitalValue,
			wallets_tempo.address,
			wallets_tempo.phone,
			wallets_tempo.email,
			wallets_tempo.ciudad,
			wallets_tempo.idStatus,
			wallets_tempo.product,
			wallets_tempo.idAdviser,
			wallets_tempo.validThrough,
			wallets_tempo.migrate,
			wallets_tempo.lote,
			wallets_tempo.titleValue,
			wallets_tempo.typePhone1,
			wallets_tempo.countryPhone1,
			wallets_tempo.cityPhone1,
			wallets_tempo.phone1,
			wallets_tempo.typePhone2,
			wallets_tempo.countryPhone2,
			wallets_tempo.cityPhone2,
			wallets_tempo.phone2,
			wallets_tempo.typePhone3,
			wallets_tempo.countryPhone3,
			wallets_tempo.cityPhone3,
			wallets_tempo.phone3,
			wallets_tempo.nameReference1,
			wallets_tempo.relationshipReferenc1,
			wallets_tempo.countryReference1,
			wallets_tempo.cityReference1,
			wallets_tempo.commentReference1,
			wallets_tempo.nameReference2,
			wallets_tempo.relationshipReference2,
			wallets_tempo.countryReference2,
			wallets_tempo.cityReference2,
			wallets_tempo.commentReference2,
			wallets_tempo.nameReference3,
			wallets_tempo.relationshipReference3,
			wallets_tempo.countryReference3,
			wallets_tempo.cityReference3,
			wallets_tempo.commentReference3,
			wallets_tempo.nameEmail1,
			wallets_tempo.email1,
			wallets_tempo.nameEmail2,
			wallets_tempo.email2,
			wallets_tempo.nameEmail3,
			wallets_tempo.email3,
			wallets_tempo.typeAddress1,
			wallets_tempo.address1,
			wallets_tempo.countryAdrress1,
			wallets_tempo.cityAddress1,
			wallets_tempo.typeAddress2,
			wallets_tempo.address2,
			wallets_tempo.countryAddress2,
			wallets_tempo.cityAddress2,
			wallets_tempo.typeAddress3,
			wallets_tempo.address3,
			wallets_tempo.countryAddress3,
			wallets_tempo.cityAddress3,
			wallets_tempo.typeAsset1,
			wallets_tempo.nameAsset1,
			wallets_tempo.commentAsset1,
			wallets_tempo.typeAsset2,
			wallets_tempo.nameAsset2,
			wallets_tempo.commentAsset2,
			wallets_tempo.typeAsset3,
			wallets_tempo.nameAsset3,
			wallets_tempo.commentAsset3
		FROM
			wallets_tempo
		WHERE
		wallets_tempo.idCampaign = '{$idcampa}'";
			$listado = Yii::app()->db->createCommand($sql)->queryAll();
			return $listado;	
}


function getpagosrealizadoscampa($campai){
	$sql = "SELECT 
			SUM(remisiones.recaudo) AS total
		FROM
			remisiones
		WHERE
			remisiones.idWalletByCampaign = {$campai}";
	$listado = Yii::app()->db->createCommand($sql)->queryAll();
	return $listado;		
}


}
