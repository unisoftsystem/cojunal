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

<?php if ($this->countModules('clients-header')) : ?>
	<!-- clients-header -->
	<div class="clients-header <?php $this->_c('clients-header') ?>">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<jdoc:include type="modules" name="<?php $this->_p('clients-header') ?>" style="raw" />
				</div>
			</div>
		</div>
	</div>
	<!-- //clients-header -->
<?php endif ?>


