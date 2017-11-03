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

<div class="services_boxed bx3<?php echo $moduleclass_sfx ?>">
	<div class="icon-wrappper">
		<i class="<?php echo $feature_icon; ?>"></i>
	</div> <!--/.icon-wrap-->
	<h4><?php echo $feature_title; ?></h2>
	<p><?php echo $feature_description; ?></p>
	<?php if ($params->get('read_more') != null) : ?>
		<a href="<?php echo $read_more; ?>" class="btn btn-system default">purchase now</a>
	<?php endif;	?>
</div> <!--/.feature-wrap-->
