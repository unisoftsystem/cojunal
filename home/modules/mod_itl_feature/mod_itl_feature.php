<?php
	/**
	* @package  ITL Feature
	* @author    iThemesLab http://www.ithemeslab.com
	* @copyright Copyright (C) 2014 iThemesLab
	* @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2
	*/


	// no direct access
	defined( '_JEXEC' ) or die( 'Restricted access' );
	//add helper files
	require_once ( dirname(__FILE__) . '/helper.php' );


	//get params from module back-end.
	$feature_icon = $params->get('feature_icon');
	$font_size = $params->get('font_size');
	$feature_title = $params->get('feature_title');
	$feature_description = $params->get('feature_description');
	$read_more = $params->get('read_more');
	$moduleclass_sfx = $params->get('moduleclass_sfx');


	require( JModuleHelper::getLayoutPath( 'mod_itl_feature', $params->get('layout', 'default') ) );
?>