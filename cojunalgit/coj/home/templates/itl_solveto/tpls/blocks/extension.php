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

<?php if ($this->checkSpotlight('extension', 'extensions-1, extensions-2, extensions-3, extensions-4')) : ?>
	<!-- extension -->
	<div class="extension">
		<div class="container">
			<?php $this->spotlight('extension', 'extensions-1, extensions-2, extensions-3, extensions-4') ?>
		</div>
	</div>
	<!-- //extension -->
<?php endif ?>