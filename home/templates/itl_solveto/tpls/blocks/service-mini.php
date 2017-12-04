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

<?php if ($this->countModules('service-mini')) : ?>
    <!-- SERVICE MINI -->
    <div class="service-mini <?php $this->_c('service-mini') ?>">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <jdoc:include type="modules" name="<?php $this->_p('service-mini') ?>" style="raw" />
                </div>
            </div>
        </div>
    </div>
    <!-- //SERVICE MINI -->
<?php endif ?>