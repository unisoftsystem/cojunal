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

<?php if ($this->checkSpotlight('maintop', 'main-top-1, main-top-2, main-top-3, main-top-4')) : ?>
	<!-- maintop -->
	<div class="main-top">
		<div class="container">
			<?php $this->spotlight('maintop', 'main-top-1, main-top-2, main-top-3, main-top-4') ?>
		</div>
	</div>
	<!-- //maintop -->
<?php endif ?>