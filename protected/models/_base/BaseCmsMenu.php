<?php

/**
 * This is the model base class for the table "cms_menu".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "CmsMenu".
 *
 * Columns in table "cms_menu" available as properties of the model,
 * followed by relations of table "cms_menu" available as properties of the model.
 *
 * @property integer $idcmsmenu
 * @property integer $cms_menu_id
 * @property string $titulo
 * @property string $url
 * @property string $icono
 * @property integer $visible_header
 * @property integer $visible
 * @property integer $orden
 *
 * @property CmsMenu $cmsMenu
 * @property CmsMenu[] $cmsMenus
 */
abstract class BaseCmsMenu extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'cms_menu';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Menú|Menús', $n);
	}

	public static function representingColumn() {
		return 'titulo';
	}

	public function rules() {
		return array(
			array('titulo, url, icono', 'required'),
			array('cms_menu_id, visible_header, visible, orden', 'numerical', 'integerOnly'=>true),
			array('titulo', 'length', 'max'=>40),
			array('url', 'length', 'max'=>80),
			array('icono', 'length', 'max'=>20),
			array('cms_menu_id, visible_header, visible, orden', 'default', 'setOnEmpty' => true, 'value' => null),
			array('idcmsmenu, cms_menu_id, titulo, url, icono, visible_header, visible, orden', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'cmsMenu' => array(self::BELONGS_TO, 'CmsMenu', 'cms_menu_id'),
			'cmsMenus' => array(self::HAS_MANY, 'CmsMenu', 'cms_menu_id'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'idcmsmenu' => Yii::t('app', 'Idcmsmenu'),
			'cms_menu_id' => Yii::t('app', 'Menú Dependiente'),
			'titulo' => Yii::t('app', 'Título del Menú'),
			'url' => Yii::t('app', 'Controlador / Acción menú'),
			'icono' => Yii::t('app', 'Icono del menú'),
			'visible_header' => Yii::t('app', 'Encabezado visible para menú padre'),
			'visible' => Yii::t('app', 'Menú Visible'),
			'orden' => Yii::t('app', 'Posición del Menú'),
			'cmsMenu' => Yii::t('app', 'Menú Dependiente'),
			'cmsMenus' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('idcmsmenu', $this->idcmsmenu);
		$criteria->compare('cms_menu_id', $this->cms_menu_id);
		$criteria->compare('titulo', $this->titulo, true);
		$criteria->compare('url', $this->url, true);
		$criteria->compare('icono', $this->icono, true);
		$criteria->compare('visible_header', $this->visible_header);
		$criteria->compare('visible', $this->visible);
		$criteria->compare('orden', $this->orden);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
                        'sort' => array('defaultOrder'=>'orden')
		));
	}
}