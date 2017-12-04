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

<?php if ($this->checkSpotlight('tweeter', 'tweeter-1')) : ?>
    <!-- clients -->
    <div class="tweet-section">
        <div class="container">
            <?php $this->spotlight('tweeter', 'tweeter-1') ?>
        </div>
    </div>
    <!-- //clients -->
<?php endif ?>