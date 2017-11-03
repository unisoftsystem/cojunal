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

<?php if ($this->checkSpotlight('main-bottom-header', 'main-bottom-header')) : ?>
	<!-- main-bottom -->
	<div class="main-bottom-header">
		<div class="container">
			<?php $this->spotlight('main-bottom-header', 'main-bottom-header') ?>
		</div>
	</div>
	<!-- //main-bottom -->
<?php endif ?>