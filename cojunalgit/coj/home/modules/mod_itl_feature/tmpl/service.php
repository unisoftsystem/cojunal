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
<div class="<?php echo $moduleclass_sfx ?>">
	<div class="service-box">
		<div class="service-icon"><i class="fa fa-<?php echo $feature_icon; ?> fa-2x">&nbsp;</i></div>
		<h3><?php echo $feature_title; ?></h3>
		<p><?php echo $feature_description; ?></p>
		<?php if ($params->get('read_more') != null) { ?>
			<a href="<?php echo $read_more; ?>" class="btn btn-feature">read more</a>
		<?php }	?>
	</div>
</div>
