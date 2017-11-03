<?php

/**
 * This is the model base class for the table "action".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Action".
 *
 * Columns in table "action" available as properties of the model,
 * followed by relations of table "action" available as properties of the model.
 *
 * @property integer $idAction
 * @property string $actionName
 *
 * @property Effects[] $effects
 */
abstract class BaseAction extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'action';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Action|Actions', $n);
	}

	public static function representingColumn() {
		return 'actionName';
	}

	public function rules() {
		return array(
			array('actionName', 'length', 'max'=>155),
			array('actionName', 'default', 'setOnEmpty' => true, 'value' => null),
			array('idAction, actionName', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'effects' => array(self::MANY_MANY, 'Effects', 'actions_has_effects(idAction, idEffect)'),
		);
	}

	public function pivotModels() {
		return array(
			'effects' => 'ActionsHasEffects',
		);
	}

	public function attributeLabels() {
		return array(
			'idAction' => Yii::t('app', 'Id Action'),
			'actionName' => Yii::t('app', 'Action Name'),
			'effects' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idAction', $this->idAction);
		$criteria->compare('actionName', $this->actionName, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}