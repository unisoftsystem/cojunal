<?php

/**
 * This is the model base class for the table "sysparams".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Sysparams".
 *
 * Columns in table "sysparams" available as properties of the model,
 * and there are no model relations.
 *
 * @property integer $idSysparam
 * @property double $feeRate
 * @property double $interestRate
 * @property string $appName
 *
 */
abstract class BaseSysparams extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'sysparams';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Sysparams|Sysparams', $n);
	}

	public static function representingColumn() {
		return 'appName';
	}

	public function rules() {
		return array(
			array('feeRate, interestRate', 'numerical'),
			array('appName', 'length', 'max'=>45),
			array('feeRate, interestRate, appName', 'default', 'setOnEmpty' => true, 'value' => null),
			array('idSysparam, feeRate, interestRate, appName', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'idSysparam' => Yii::t('app', 'Id Sysparam'),
			'feeRate' => Yii::t('app', 'Fee Rate'),
			'interestRate' => Yii::t('app', 'Interest Rate'),
			'appName' => Yii::t('app', 'App Name'),
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idSysparam', $this->idSysparam);
		$criteria->compare('feeRate', $this->feeRate);
		$criteria->compare('interestRate', $this->interestRate);
		$criteria->compare('appName', $this->appName, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}