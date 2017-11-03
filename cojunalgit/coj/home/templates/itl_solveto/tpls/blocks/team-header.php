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

<?php if ($this->checkSpotlight('team-header', 'team-header-1')) : ?>
	<!-- clients -->
	<div class="team-header">
		<div class="container">
			<?php $this->spotlight('team-header', 'team-header-1') ?>
		</div>
	</div>
	<!-- //clients -->
<?php endif ?>