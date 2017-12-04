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

<?php if ($this->checkSpotlight('calltoaction', 'call-to-action')) : ?>
	<!-- call-to-action 1 -->
	<div class="call-to-action">
		<div class="container">
			<?php $this->spotlight('calltoaction', 'call-to-action') ?>
		</div>
	</div>
	<!-- //call-to-action 1 -->
<?php endif ?>