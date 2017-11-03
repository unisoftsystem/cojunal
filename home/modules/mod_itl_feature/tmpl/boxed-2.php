<?php
	/**
	* @package  ITL Feature
	* @author    iThemesLab http://www.ithemeslab.com
	* @copyright Copyright (C) 2014 iThemesLab
	* @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2
	*/
	
	//no direct access
	defined( '_JEXEC' ) or die( 'Restricted access' );
?>

<div class="services_boxed bx2<?php echo $moduleclass_sfx ?>">
	<div class="icon-wrappper">
		<i class="<?php echo $feature_icon; ?>"></i>
	</div> <!--/.icon-wrap-->
	<h4><a href="<?php echo $read_more; ?>"><?php echo $feature_title; ?></a></h2>
	<div class="line_under">
        <div class="line_left"></div>
        <div class="line_center"></div>
        <div class="line_right"></div>
    </div>
	<p><?php echo $feature_description; ?></p>
</div> <!--/.feature-wrap-->
