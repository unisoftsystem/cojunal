<?php

class CarteraController extends GxController {


	public function init() {
        //Yii::app()->getComponent("bootstrap");
        //Yii::app()->theme = $this->themeFront; //set theme default front
		$this->layout = 'layout_secure';
		parent::init();
		Yii::app()->errorHandler->errorAction = 'site/error';
	}

	public function actionIndex(){
		$this->actionCartera();
	}

	public function actionDashboard()
	{
		$this->actionCartera();
	}

	public function actionCartera()
	{
		$this->layout = 'layout_dashboad_profile_customers';
		$this->render('cartera');
	}
}
?>
