<?php

/**
 * This is the model base class for the table "management".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Management".
 *
 * Columns in table "management" available as properties of the model,
 * and there are no model relations.
 *
 * @property string $idWallet
 * @property string $idAsesor
 * @property string $asesor
 * @property string $fecha
 * @property string $action
 * @property string $effect
 * @property string $comment
 *
 */
abstract class BaseManagement extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'management';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Management|Managements', $n);
	}

	public static function representingColumn() {
		return 'asesor';
	}

	public function rules() {
		return array(
			array('idWallet, idAsesor', 'length', 'max'=>20),
			array('asesor, action, effect', 'length', 'max'=>155),
			array('fecha, comment', 'safe'),
			array('idWallet, idAsesor, asesor, fecha, action, effect, comment', 'default', 'setOnEmpty' => true, 'value' => null),
			array('idWallet, idAsesor, asesor, fecha, action, effect, comment', 'safe', 'on'=>'search'),
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
			'idWallet' => Yii::t('app', 'Id Wallet'),
			'idAsesor' => Yii::t('app', 'Id Asesor'),
			'asesor' => Yii::t('app', 'Asesor'),
			'fecha' => Yii::t('app', 'Fecha'),
			'action' => Yii::t('app', 'Action'),
			'effect' => Yii::t('app', 'Effect'),
			'comment' => Yii::t('app', 'Comment'),
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idWallet', $this->idWallet, true);
		$criteria->compare('idAsesor', $this->idAsesor, true);
		$criteria->compare('asesor', $this->asesor, true);
		$criteria->compare('fecha', $this->fecha, true);
		$criteria->compare('action', $this->action, true);
		$criteria->compare('effect', $this->effect, true);
		$criteria->compare('comment', $this->comment, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}