<?php
//Yii::import('application.models._base.BaseCoordinador');

class Campanas extends GxActiveRecord
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Campañas|Campañas', $n);
	}
	
}

