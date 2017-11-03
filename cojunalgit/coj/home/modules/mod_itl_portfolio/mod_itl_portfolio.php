<?php
/**
 * @subpackage	mod_ts_team
 * @copyright	Copyright (C) 2013 - 2014 Themewinter. All rights reserved.
 * @license		GNU General Public License version 2 or later; 
 */

// no direct access
defined('_JEXEC') or die;

$data = array();

//Item 1
if( $params->get('item1_img') ){
	$data[0][ 'img' ] 				= $params->get('item1_img');
	$data[0][ 'title' ] 			= $params->get('item1_title');
	$data[0][ 'category' ]			= $params->get('item1_category');
	$data[0][ 'extlink' ] 			= $params->get('item1_extlink');
}

//Item 2
if( $params->get('item2_img') ){
	$data[1][ 'img' ] 				= $params->get('item2_img');
	$data[1][ 'title' ] 			= $params->get('item2_title');
	$data[1][ 'category' ]			= $params->get('item2_category');
	$data[1][ 'extlink' ] 			= $params->get('item2_extlink');
}

//Item 3
if( $params->get('item3_img') ){
	$data[2][ 'img' ] 				= $params->get('item3_img');
	$data[2][ 'title' ] 			= $params->get('item3_title');
	$data[2][ 'category' ]			= $params->get('item3_category');
	$data[2][ 'extlink' ] 			= $params->get('item3_extlink');
}

//Item 4
if( $params->get('item4_img') ){
	$data[3][ 'img' ] 				= $params->get('item4_img');
	$data[3][ 'title' ] 			= $params->get('item4_title');
	$data[3][ 'category' ]			= $params->get('item4_category');
	$data[3][ 'extlink' ] 			= $params->get('item4_extlink');
}

//Item 5
if( $params->get('item5_img') ){
	$data[4][ 'img' ] 				= $params->get('item5_img');
	$data[4][ 'title' ] 			= $params->get('item5_title');
	$data[4][ 'category' ]			= $params->get('item5_category');
	$data[4][ 'extlink' ] 			= $params->get('item5_extlink');
}

//Item 6
if( $params->get('item6_img') ){
	$data[5][ 'img' ] 				= $params->get('item6_img');
	$data[5][ 'title' ] 			= $params->get('item6_title');
	$data[5][ 'category' ]			= $params->get('item6_category');
	$data[5][ 'extlink' ] 			= $params->get('item6_extlink');
}

//Item 7
if( $params->get('item7_img') ){
	$data[6][ 'img' ] 				= $params->get('item7_img');
	$data[6][ 'title' ] 			= $params->get('item7_title');
	$data[6][ 'category' ]			= $params->get('item7_category');
	$data[6][ 'extlink' ] 			= $params->get('item7_extlink');
}

//Item 8
if( $params->get('item8_img') ){
	$data[7][ 'img' ] 				= $params->get('item8_img');
	$data[7][ 'title' ] 			= $params->get('item8_title');
	$data[7][ 'category' ]			= $params->get('item8_category');
	$data[7][ 'extlink' ] 			= $params->get('item8_extlink');
}

//Item 9
if( $params->get('item9_img') ){
	$data[8][ 'img' ] 				= $params->get('item9_img');
	$data[8][ 'title' ] 			= $params->get('item9_title');
	$data[8][ 'category' ]			= $params->get('item9_category');
	$data[8][ 'extlink' ] 			= $params->get('item9_extlink');
}

//Item 10
if( $params->get('item10_img') ){
	$data[9][ 'img' ] 				= $params->get('item10_img');
	$data[9][ 'title' ] 			= $params->get('item10_title');
	$data[9][ 'category' ]			= $params->get('item10_category');
	$data[9][ 'extlink' ] 			= $params->get('item10_extlink');
}

//Item 11
if( $params->get('item11_img') ){
	$data[10][ 'img' ] 				= $params->get('item11_img');
	$data[10][ 'title' ] 			= $params->get('item11_title');
	$data[10][ 'category' ]			= $params->get('item11_category');
	$data[10][ 'extlink' ] 			= $params->get('item11_extlink');
}

//Item 12
if( $params->get('item12_img') ){
	$data[11][ 'img' ] 				= $params->get('item12_img');
	$data[11][ 'title' ] 			= $params->get('item12_title');
	$data[11][ 'category' ]			= $params->get('item12_category');
	$data[11][ 'extlink' ] 			= $params->get('item12_extlink');
}


//$document = JFactory::getDocument();
//$document->addStyleSheet('modules/mod_itl_portfolio/css/owl.theme.css', array(), false);
//$document->addScript('modules/mod_itl_portfolio/js/itl_portfolio_script.js', false, false);

require JModuleHelper::getLayoutPath('mod_itl_portfolio', $params->get('layout'));