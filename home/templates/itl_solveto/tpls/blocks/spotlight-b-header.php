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

<?php if ($this->countModules('spotlight-b-header')) : ?>
	<!-- spotlight-b-header -->
	<div class="spotlight-b-header <?php $this->_c('spotlight-b-header') ?>">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<jdoc:include type="modules" name="<?php $this->_p('spotlight-b-header') ?>" style="raw" />
				</div>
			</div>
		</div>
	</div>
	<!-- //spotlight-b-header -->
<?php endif ?>


