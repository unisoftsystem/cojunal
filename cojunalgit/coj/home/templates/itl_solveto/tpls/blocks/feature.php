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

<?php if ($this->checkSpotlight('features', 'feature-1, feature-2, feature-3, feature-4')) : ?>
	<!-- feature -->
	<div class="features-section">
		<div class="container">
			<?php $this->spotlight('features', 'feature-1, feature-2, feature-3, feature-4') ?>
		</div>
	</div>
	<!-- //feature -->
<?php endif ?>