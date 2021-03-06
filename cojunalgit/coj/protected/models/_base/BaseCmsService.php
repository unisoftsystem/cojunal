<?php

/**
 * This is the model base class for the table "cms_service".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "CmsService".
 *
 * Columns in table "cms_service" available as properties of the model,
 * and there are no model relations.
 *
 * @property string $idService
 * @property string $title
 * @property string $description
 * @property string $image
 *
 */
abstract class BaseCmsService extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'cms_service';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'CmsService|CmsServices', $n);
	}

	public static function representingColumn() {
		return 'title';
	}

	public function rules() {
		return array(
			array('title, description, image', 'required'),
			array('title', 'length', 'max'=>100),
			array('image', 'length', 'max'=>255),
			array('idService, title, description, image', 'safe', 'on'=>'search'),
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
			'idService' => Yii::t('app', 'Id Service'),
			'title' => Yii::t('app', 'Title'),
			'description' => Yii::t('app', 'Description'),
			'image' => Yii::t('app', 'Image'),
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idService', $this->idService, true);
		$criteria->compare('title', $this->title, true);
		$criteria->compare('description', $this->description, true);
		$criteria->compare('image', $this->image, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        //'sort' => array('defaultOrder'=>'orden')
		));
	}
}