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

<?php if ($this->checkSpotlight('main-bottom', 'main-bottom-1, main-bottom-2, main-bottom-3, main-bottom-4')) : ?>
	<!-- main-bottom 1 -->
	<div class="main-bottom">
		<div class="container">
			<?php $this->spotlight('main-bottom', 'main-bottom-1, main-bottom-2, main-bottom-3, main-bottom-4') ?>
		</div>
	</div>
	<!-- //main-bottom 1 -->
<?php endif ?>