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


<?php if ($this->checkSpotlight('spotlight-1', 'position-1, position-2, position-3, position-4')) : ?>
	<!-- SPOTLIGHT 1 -->
	<div class="container t3-sl t3-sl-1">
		<?php $this->spotlight('spotlight-1', 'position-1, position-2, position-3, position-4') ?>
	</div>
	<!-- //SPOTLIGHT 1 -->
<?php endif ?>