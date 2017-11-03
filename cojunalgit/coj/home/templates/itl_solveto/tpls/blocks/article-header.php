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

<?php if ($this->countModules('article-header')) : ?>
	<!-- article header -->
	<div class="article-header <?php $this->_c('article-header') ?>">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<jdoc:include type="modules" name="<?php $this->_p('article-header') ?>" style="raw" />
				</div>
			</div>
		</div>
		<div class="line_under_full">
			<div class="line_full">&nbsp;</div>
			<div class="full_center">&nbsp;</div>
		</div>
	</div>
	<!-- //article header -->
<?php endif ?>


