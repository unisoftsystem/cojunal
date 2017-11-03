<?php

/**
 * This is the model base class for the table "cms_plans".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "CmsPlans".
 *
 * Columns in table "cms_plans" available as properties of the model,
 * and there are no model relations.
 *
 * @property string $idPlans
 * @property string $title
 * @property string $description
 * @property string $items
 *
 */
abstract class BaseCmsPlans extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'cms_plans';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'CmsPlans|CmsPlans', $n);
	}

	public static function representingColumn() {
		return 'title';
	}

	public function rules() {
		return array(
			array('title, description, items', 'required'),
			array('title', 'length', 'max'=>100),
			array('items', 'length', 'max'=>255),
			array('idPlans, title, description, items', 'safe', 'on'=>'search'),
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
			'idPlans' => Yii::t('app', 'Id Plans'),
			'title' => Yii::t('app', 'Title'),
			'description' => Yii::t('app', 'Description'),
			'items' => Yii::t('app', 'Items'),
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idPlans', $this->idPlans, true);
		$criteria->compare('title', $this->title, true);
		$criteria->compare('description', $this->description, true);
		$criteria->compare('items', $this->items, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}