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

<?php if ($this->countModules('slideshow')) : ?>
	<!-- slideshow -->
	<div class="itl-slideshow <?php $this->_c('slideshow') ?>">
		<div class="container">
			<jdoc:include type="modules" name="<?php $this->_p('slideshow') ?>" style="raw" />
		</div>
	</div>
	<!-- //slideshow -->
<?php endif ?>