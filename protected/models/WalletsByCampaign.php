<?php


class WalletsByCampaign extends GxActiveRecord
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public static function save_data($data)
	{
		$sql = "INSERT INTO wallets_by_campaign (idCampaign, campaignName, serviceType, notificationType, createAt) 
		VALUES (:idCampaign, :campaignName, :serviceType, :notificationType, CURRENT_TIMESTAMP)";
		$parameters = [
			':idCampaign' => $data['idCampaign'], 
			':campaignName' => $data['campaignName'], 
			':serviceType' => $data['serviceType'], 
			':notificationType' => $data['notificationType']
		];
		return Yii::app()->db->createCommand($sql)->execute($parameters);
	}

	public static function getLastID()
	{
		return Yii::app()->db->getLastInsertId();
	}

	/*===========================================================================================================
    	11/Sept/2017 Unisoft - Wilmar Ibarguen M.
    ===========================================================================================================*/ 

	// Esta funcion devuelve el listado de campañas con:
	// Campaña	Cliente	Fecha Creación	Tipo de servicio	
	// Saldo total asignado	Saldo total recuperado	Honorarios	
	// Intereses	% Comisión	Coordinador Asignado	Asignar estados
	public static function obtenerListadoCampanasParaAdmin()
	{
		$sql = "SELECT a.*, b.name AS nameCliente, a.comisions AS comision, 
			a.interests AS intereses, a.fee AS honorarios,
			(SELECT idCoordinator FROM campaigns_coordinator WHERE idCampaign = a.idWalletByCampaign) AS idCoordinador,
			(SELECT SUM(capitalValue) FROM wallets_tempo WHERE 	idCampaign = a.IdCampaign) AS saldoAsignado,
			(SELECT COUNT(id) FROM campaigns_status WHERE idCampaign =  a.idWalletByCampaign) AS cantEstados
			FROM wallets_by_campaign a 
			INNER JOIN campaigns b ON b.idCampaign = a.IdCampaign";

		if(isset($_POST['field']) && isset($_POST['orderBy'])) {
			$sql .= sprintf(" ORDER BY %s %s", $_POST['field'], $_POST['orderBy']);
		}

		return Yii::app()->db->createCommand($sql)->queryAll();
	}

	// Esta funcion me edita un valor financiero de la campaña
	public static function updateDatoFinaciero($campo, $valor, $idCampaign) 
	{
		$sql = sprintf("UPDATE wallets_by_campaign SET `%s` = '%s' WHERE idWalletByCampaign = '%s'",
			$campo, $valor, $idCampaign);
		return Yii::app()->db->createCommand($sql)->execute();
	}

	// Esta funcion agrega los honorario por defecto del cliente como base para la campaña
	public static function setDatosFinacieros($datos) 
	{
		$sql = "UPDATE wallets_by_campaign 
		SET fee = :fee, interests = :interests, comisions = :comisions 
		WHERE idWalletByCampaign = :idWalletByCampaign";
		
		$parameters = [
			':fee' => $datos['fee'], 
			':interests' => $datos['interests'], 
			':comisions' => $datos['comisions'], 
			':idWalletByCampaign' => $datos['idWalletByCampaign']
		];
		return Yii::app()->db->createCommand($sql)->execute($parameters);
	}

	public static function getBalanceCampaings($id)
	{
		$sql = sprintf('SELECT a.campaignName, SUM(b.capitalValue) as "saldo_asignado", COUNT(b.id) as total_deudores, COUNT(q1.idCampaign) as q1_deudores, COUNT(q2.idCampaign) as q2_deudores, COUNT(q3.idCampaign) as q3_deudores, COUNT(q4.idCampaign) as q4_deudores, COUNT(q5.idCampaign) as q5_deudores, COUNT(q6.idCampaign) as q6_deudores, COUNT(q7.idCampaign) as q7_deudores, ((SUM(c.value) / "saldo_asignado") * 100) as recuperacion, a.createAt FROM wallets_by_campaign a INNER JOIN wallets_tempo b ON b.idCampaign = a.idWalletByCampaign INNER JOIN payments c ON c.idPayment = b.id LEFT JOIN q1 ON q1.idCampaign = a.IdCampaign LEFT JOIN q2 ON q2.idCampaign = a.IdCampaign LEFT JOIN q3 ON q3.idCampaign = a.IdCampaign LEFT JOIN q4 ON q4.idCampaign = a.IdCampaign LEFT JOIN q5 ON q5.idCampaign = a.IdCampaign LEFT JOIN q6 ON q6.idCampaign = a.IdCampaign LEFT JOIN q7 ON q7.idCampaign = a.IdCampaign WHERE a.IdCampaign = "%s" GROUP BY a.idWalletByCampaign', $id);

		return Yii::app()->db->createCommand($sql)->queryAll();
	}
}