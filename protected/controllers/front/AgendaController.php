<?php 

	class AgendaController extends GxController {
	

		public function init() {
        //Yii::app()->getComponent("bootstrap");
        //Yii::app()->theme = $this->themeFront; //set theme default front
        $this->layout = 'layout_secure';
        parent::init();
        Yii::app()->errorHandler->errorAction = 'site/error';
    }

		public function actionIndex(){
			$session = Yii::app()->session;
			$sesion = Yii::app()->session;
        	$user = $sesion['cojunal'];
        	$idAdviser = $user->idAdviser;

			$sql = 'SELECT agendas.*, wallets_tempo.legalName, wallets_tempo.phone, agendas.idAdviser AS idAsesor, advisers.name AS asesor, agendas.dAction AS fecha, effects.effectName AS effect, action.actionName AS "action" FROM agendas INNER JOIN wallets_tempo ON wallets_tempo.id = agendas.idWallet INNER JOIN advisers ON advisers.idAdviser = agendas.idAdviser INNER JOIN effects ON effects.idEffect = agendas.idEffect INNER JOIN action ON action.idAction = agendas.idAction WHERE agendas.idAdviser = '.$user->idAdviser.' AND (DATEDIFF(NOW(), agendas.dAction)) = 0 AND agendas.completada = 0 GROUP BY agendas.idAgenda ORDER BY agendas.dAction DESC';
			$res = Yii::app()->db->createCommand($sql)->queryAll(); 


			$sql1 = 'SELECT agendas.*, wallets_tempo.legalName, wallets_tempo.phone, agendas.idAdviser AS idAsesor, advisers.name AS asesor, agendas.dAction AS fecha, effects.effectName AS effect, action.actionName AS "action" FROM agendas INNER JOIN wallets_tempo ON wallets_tempo.id = agendas.idWallet INNER JOIN advisers ON advisers.idAdviser = agendas.idAdviser INNER JOIN effects ON effects.idEffect = agendas.idEffect INNER JOIN action ON action.idAction = agendas.idAction WHERE agendas.idAdviser = '.$user->idAdviser.' AND (DATEDIFF(NOW(), agendas.dAction)) > 0 AND agendas.completada = 0 GROUP BY agendas.idAgenda ORDER BY agendas.dAction DESC';
			$_prevAgenda = Yii::app()->db->createCommand($sql1)->queryAll(); 

			$sql2 = 'SELECT agendas.*, wallets_tempo.legalName, wallets_tempo.phone, agendas.idAdviser AS idAsesor, advisers.name AS asesor, agendas.dAction AS fecha, effects.effectName AS effect, action.actionName AS "action" FROM agendas INNER JOIN wallets_tempo ON wallets_tempo.id = agendas.idWallet INNER JOIN advisers ON advisers.idAdviser = agendas.idAdviser INNER JOIN effects ON effects.idEffect = agendas.idEffect INNER JOIN action ON action.idAction = agendas.idAction WHERE agendas.idAdviser = '.$user->idAdviser.' AND (DATEDIFF(NOW(), agendas.dAction)) < 0 AND agendas.completada = 0 GROUP BY agendas.idAgenda ORDER BY agendas.dAction DESC';
			$_nextAgenda = Yii::app()->db->createCommand($sql2)->queryAll(); 

			$this->render('agenda', ['_newAgenda' => $res, '_nextAgenda' => $_nextAgenda, '_prevAgenda' => $_prevAgenda]);
		}

	}
?>