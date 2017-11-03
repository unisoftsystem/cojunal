<?php
/**
 * @subpackage	mod_ts_team
 * @copyright	Copyright (C) 2013 - 2014 Themewinter. All rights reserved.
 * @license		GNU General Public License version 2 or later; 
 */

// no direct access
defined('_JEXEC') or die;

$data = array();

//client 1
if( $params->get('client1_img') ){
	$data[0][ 'img' ] 				= $params->get('client1_img');
}

//client 2
if( $params->get('client2_img') ){
	$data[1][ 'img' ] 				= $params->get('client2_img');
}

//client 3
if( $params->get('client3_img') ){
	$data[2][ 'img' ] 				= $params->get('client3_img');
}

//client 4
if( $params->get('client4_img') ){
	$data[3][ 'img' ] 				= $params->get('client4_img');
}

//client 5
if( $params->get('client5_img') ){
	$data[4][ 'img' ] 				= $params->get('client5_img');
}

//client 6
if( $params->get('client6_img') ){
	$data[5][ 'img' ] 				= $params->get('client6_img');
}

//client 7
if( $params->get('client7_img') ){
	$data[6][ 'img' ] 				= $params->get('client7_img');
}

//client 8
if( $params->get('client8_img') ){
	$data[7][ 'img' ] 				= $params->get('client8_img');
}

//client 9
if( $params->get('client9_img') ){
	$data[8][ 'img' ] 				= $params->get('client9_img');
}

//client 10
if( $params->get('client10_img') ){
	$data[9][ 'img' ] 				= $params->get('client10_img');
}

//client 11
if( $params->get('client11_img') ){
	$data[10][ 'img' ] 				= $params->get('client11_img');
}

//client 12
if( $params->get('client12_img') ){
	$data[11][ 'img' ] 				= $params->get('client12_img');
}

require JModuleHelper::getLayoutPath('mod_itl_clients', $params->get('layout'));