<?php
/** 
 *------------------------------------------------------------------------------
 * @package       Solveto by iThemesLab
 *------------------------------------------------------------------------------
 * @copyright     Copyright (C) 2014 iThemesLab.com. All Rights Reserved.
 * @author        iThemesLab
 * @Link:         http://ithemeslab.com 
 *------------------------------------------------------------------------------
 */

defined('_JEXEC') or die;
?>

<?php if ($this->checkSpotlight('portfolio-header', 'portfolio-header')) : ?>
	<!-- portfolio -->
	<div class="portfolio-header">
		<div class="container">
			<?php $this->spotlight('portfolio-header', 'portfolio-header') ?>
		</div>
	</div>
	<!-- //portfolio -->
<?php endif ?>