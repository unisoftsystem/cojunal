<?php

Yii::import('application.models._base.BaseWalletsTempo');

class WalletsTempo extends BaseWalletsTempo
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	// Guardamos los datos de los deudores
	public static function save_campaign_deudores($deudores)
	{
		$builder = Yii::app()->db->schema->commandBuilder;
		$command=$builder->createMultipleInsertCommand('wallets_tempo', $deudores);
		return $command->execute();
	}

	// Esta funcion devuelve los deudoires juridicos
	public static function getDeuduresJuridicos()
	{
		$sql = "SELECT id, idNumber, legalName, capitalValue, email, idCampaign,
				(SELECT campaignName FROM wallets_by_campaign WHERE idWalletByCampaign = a.idCampaign) AS campanaName
				FROM wallets_tempo a
				WHERE id NOT IN
				(SELECT idWalletTempo FROM wallets_of_coordinators_juridic)";
		if(isset($_POST['field']) && isset($_POST['orderBy'])) {
			$sql .= sprintf(" ORDER BY %s %s", $_POST['field'], $_POST['orderBy']);
		}
		return Yii::app()->db->createCommand($sql)->queryAll();
	}

	public function deudores_mora(){
		$res = [];
		$res['deudores_mora_30']      = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 30');
		$res['deudores_mora_30_60']   = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 30 AND DATEDIFF(NOW(), WC.createAt) <= 60');
		$res['deudores_mora_61_90']   = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 61 AND DATEDIFF(NOW(), WC.createAt) <= 90');
		$res['deudores_mora_91_120']  = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 91 AND DATEDIFF(NOW(), WC.createAt) <= 120');
		$res['deudores_mora_121_180'] = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 121 AND DATEDIFF(NOW(), WC.createAt) <= 180');
		$res['deudores_mora_181_360'] = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 181 AND DATEDIFF(NOW(), WC.createAt) <= 360');
		$res['deudores_mora_360']     = $this->deudores_mora_sql('DATEDIFF(NOW(), WC.createAt) >= 360');
		return $res;
	}

	public function deudores_mora_sql($where){
		$sql = "SELECT
							SUM(WT.capitalValue) as total,
							COUNT(WT.capitalValue) as deudores
						FROM
							wallets_by_campaign AS WC
						INNER JOIN wallets_tempo AS WT ON WT.idCampaign = WC.idWalletByCampaign
						WHERE $where";
			return Yii::app()->db->createCommand($sql)->queryAll();
	}

	//=========================================================================

	public function deudores_cartera(){
		$res = [];
		$res['cantidad_deudores'] = $this->cantidad_deudores()[0]['total'];
		$pagos = $this->pagos_deudores()[0]['total'];
		$total = $this->total_deudores()[0]['total'];
		$porcentaje = $pagos*$total/100;
		$res['porcentaje_recuperacion'] = $porcentaje;
		return $res;
	}

	public function cantidad_deudores(){
		$sql = "SELECT
							COUNT(WT.capitalValue) as total
						FROM
							wallets_by_campaign AS WC
						INNER JOIN wallets_tempo AS WT ON WT.idCampaign = WC.idWalletByCampaign";
			return Yii::app()->db->createCommand($sql)->queryAll();
	}

	public function pagos_deudores(){
		$sql = "SELECT
							SUM(P.value) as total
						FROM
							wallets_by_campaign AS WC
						INNER JOIN payments AS P ON P.idWallet = WC.idWalletByCampaign";
			return Yii::app()->db->createCommand($sql)->queryAll();
	}

	public function total_deudores(){
		$sql = "SELECT
							SUM(WT.capitalValue) as total
						FROM
							wallets_by_campaign AS WC
						INNER JOIN wallets_tempo AS WT ON WT.idCampaign = WC.idWalletByCampaign";
			return Yii::app()->db->createCommand($sql)->queryAll();
	}
	//=========================================================================
	public function rangedeudorestotal($id){
		$where;
		if($id == 1){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 30';
		}
		if($id == 2){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 30 AND DATEDIFF(NOW(), WC.createAt) <= 60';
		}
		if($id == 3){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 61 AND DATEDIFF(NOW(), WC.createAt) <= 90';
		}
		if($id == 4){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 91 AND DATEDIFF(NOW(), WC.createAt) <= 120';
		}
		if($id == 5){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 121 AND DATEDIFF(NOW(), WC.createAt) <= 180';
		}
		if($id == 6){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 181 AND DATEDIFF(NOW(), WC.createAt) <= 360';
		}
		if($id == 7){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 360';
		}

		$sql = "SELECT
							WC.campaignName,
							WT.idNumber,
							WT.legalName,
							WT.ciudad,
							WC.createAt,
							DATEDIFF(NOW(), WC.createAt) AS last,
							COALESCE(S.description, 'Sin estado') as status,
							WC.fee,
							WT.capitalValue,
							WC.interests,
							WC.comisions,
							WC.notificationType
						FROM
							wallets_by_campaign AS WC
						INNER JOIN wallets_tempo AS WT ON WT.idCampaign = WC.idWalletByCampaign
						LEFT  JOIN status AS S ON S.idStatus = WT.idStatus
						WHERE $where";

			return Yii::app()->db->createCommand($sql)->queryAll();
	}

	public function rangedeudores($id, $limit = 0, $records = 10){
		$where;
		if($id == 1){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 30';
		}
		if($id == 2){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 30 AND DATEDIFF(NOW(), WC.createAt) <= 60';
		}
		if($id == 3){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 61 AND DATEDIFF(NOW(), WC.createAt) <= 90';
		}
		if($id == 4){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 91 AND DATEDIFF(NOW(), WC.createAt) <= 120';
		}
		if($id == 5){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 121 AND DATEDIFF(NOW(), WC.createAt) <= 180';
		}
		if($id == 6){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 181 AND DATEDIFF(NOW(), WC.createAt) <= 360';
		}
		if($id == 7){
			$where = 'DATEDIFF(NOW(), WC.createAt) >= 360';
		}

		$sql = "SELECT
							WC.campaignName,
							WT.idNumber,
							WT.legalName,
							WT.ciudad,
							WC.createAt,
							DATEDIFF(NOW(), WC.createAt) AS last,
							COALESCE(S.description, 'Sin estado') as status,
							WC.fee,
							WT.capitalValue,
							WC.interests,
							WC.comisions,
							WC.notificationType
						FROM
							wallets_by_campaign AS WC
						INNER JOIN wallets_tempo AS WT ON WT.idCampaign = WC.idWalletByCampaign
						LEFT  JOIN status AS S ON S.idStatus = WT.idStatus
						WHERE $where";

			$sql .= sprintf(" LIMIT %d, %d", ($limit * $records), $records);

			return Yii::app()->db->createCommand($sql)->queryAll();
	}

}
