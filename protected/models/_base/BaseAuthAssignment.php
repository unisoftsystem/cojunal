<?php

/**
 * This is the model base class for the table "AuthAssignment".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "AuthAssignment".
 *
 * Columns in table "AuthAssignment" available as properties of the model,
 * followed by relations of table "AuthAssignment" available as properties of the model.
 *
 * @property string $idAuthAssignment
 * @property string $userid
 * @property string $bizrule
 * @property string $data
 * @property string $itemname
 *
 * @property AuthItem $itemname0
 * @property Advisers[] $advisers
 */
abstract class BaseAuthAssignment extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'authassignment';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Nombre Usuario|Nombre de Usuario', $n);
	}

	public static function representingColumn() {
		return 'userid';
	}

	public function rules() {
		return array(
			array('userid, itemname', 'required'),
			array('userid, itemname', 'length', 'max'=>64),
			array('bizrule, data', 'safe'),
			array('bizrule, data', 'default', 'setOnEmpty' => true, 'value' => null),
			array('idAuthAssignment, userid, bizrule, data, itemname', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'itemname0' => array(self::BELONGS_TO, 'AuthItem', 'itemname'),
			'advisers' => array(self::HAS_MANY, 'Advisers', 'idAuthAssignment'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'idAuthAssignment' => Yii::t('app', 'Id Auth Assignment'),
			'userid' => Yii::t('app', 'Userid'),
			'bizrule' => Yii::t('app', 'Bizrule'),
			'data' => Yii::t('app', 'Data'),
			'itemname' => null,
			'itemname0' => null,
			'advisers' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idAuthAssignment', $this->idAuthAssignment, true);
		$criteria->compare('userid', $this->userid, true);
		$criteria->compare('bizrule', $this->bizrule, true);
		$criteria->compare('data', $this->data, true);
		$criteria->compare('itemname', $this->itemname);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}