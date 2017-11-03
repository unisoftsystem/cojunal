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

<?php if ($this->checkSpotlight('portfolio', 'portfolio')) : ?>
	<!-- portfolio -->
	<div class="portfolio-section">
		<div class="container">
			<?php $this->spotlight('portfolio', 'portfolio') ?>
		</div>
	</div>
	<!-- //portfolio -->
<?php endif ?>