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

<?php if ($this->checkSpotlight('feature-top', 'feature-top-1')) : ?>
    <!-- feature-top 1 -->
    <div class="feature-top">
        <div class="container">
            <?php $this->spotlight('feature-top', 'feature-top-1') ?>
        </div>
    </div>
    <!-- //feature-top 1 -->
<?php endif ?>