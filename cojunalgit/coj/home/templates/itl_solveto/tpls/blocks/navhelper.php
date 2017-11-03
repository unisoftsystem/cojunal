<?php
/**
 * @package   T3 Blank
 * @copyright Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license   GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;
?>

<?php if ($this->countModules('navhelper')) : ?>
	<!-- NAV HELPER -->
	<nav class="wrap t3-navhelper <?php $this->_c('navhelper') ?>">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<jdoc:include type="modules" name="<?php $this->_p('page-title') ?>" />
				</div>
				<div class="col-md-8">
					<jdoc:include type="modules" name="<?php $this->_p('navhelper') ?>" />
				</div>
			</div>
		</div>
	</nav>
	<!-- //NAV HELPER -->
<?php endif ?>

<?php if ($this->countModules('mass-head')) : ?>
    <!-- MASS HEAD -->
    <div class="mass-head <?php $this->_c('mass-head') ?>">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <jdoc:include type="modules" name="<?php $this->_p('mass-head') ?>" style="raw" />
                </div>
            </div>
        </div>
    </div>
    <!-- //MASS HEAD -->
<?php endif ?>
