<?php
    /**
    * @author    Tripples http://www.themewinter.com
    * @copyright Copyright (C) 2013- 2014 Tripples
    * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2
    */

    // no direct access
    defined('_JEXEC') or die('Restricted access');
    
    $layout                 = $params->get('layout', 'default');
    $moduleclass_sfx        = $params->get('moduleclass_sfx');

      if($params->get('backgroundimage')){
        $data[0]['backgroundimage'] = $params->get('backgroundimage');
    }

    $data = array();

    //Feature 1
    if( $params->get('title1') ){
        $data[0][ 'icon' ]              = $params->get('icon1');
        $data[0][ 'title' ]             = $params->get('title1');
        $data[0][ 'desc' ]              = $params->get('desc1');
        $data[0][ 'more' ]             = $params->get('more1');
    }

    //Feature 2
    if( $params->get('title2') ){
        $data[1][ 'icon' ]              = $params->get('icon2');
        $data[1][ 'title' ]             = $params->get('title2');
        $data[1][ 'desc' ]              = $params->get('desc2');
        $data[1][ 'more' ]             = $params->get('more2');
    }

    //Feature 3
    if( $params->get('title3') ){
        $data[2][ 'icon' ]              = $params->get('icon3');
        $data[2][ 'title' ]             = $params->get('title3');
        $data[2][ 'desc' ]              = $params->get('desc3');
        $data[2][ 'more' ]             = $params->get('more3');
    }

    //Feature 4
    if( $params->get('title4') ){
        $data[3][ 'icon' ]              = $params->get('icon4');
        $data[3][ 'title' ]             = $params->get('title4');
        $data[3][ 'desc' ]              = $params->get('desc4');
        $data[3][ 'more' ]             = $params->get('more4');
    }

    require(JModuleHelper::getLayoutPath('mod_itl_service', $layout) );