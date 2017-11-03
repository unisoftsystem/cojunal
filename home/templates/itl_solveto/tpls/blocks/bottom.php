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
<?php if ($this->checkSpotlight('bottom', 'bottom-1, bottom-2, bottom-3, bottom-4')) : ?>
	<!-- bottom -->
	<div class="bottom">
		<div class="container">
			<?php $this->spotlight('bottom', 'bottom-1, bottom-2, bottom-3, bottom-4') ?>
		</div>
	</div>
	<!-- //bottom -->
<?php endif ?>