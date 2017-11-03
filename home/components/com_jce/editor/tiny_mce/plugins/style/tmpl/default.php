<?php

/**
 * @copyright 	Copyright (c) 2009-2017 Ryan Demmer. All rights reserved
 * @license   	GNU/GPL 2 or later - http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 * JCE is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses
 */
defined('_JEXEC') or die('RESTRICTED');

$tabs = WFTabs::getInstance();
?>
<form>
    <?php $tabs->render(); ?>
    <div class="mceActionPanel">
      <div class="uk-form-row uk-float-left">
          <input type="checkbox" id="toggle_insert_span" onclick="StyleDialog.toggleApplyAction();" />
          <label for="toggle_insert_span"><?php echo WFText::_('WF_STYLES_TOGGLE_INSERT_SPAN'); ?></label>
      </div>

        <button type="submit" id="insert"><?php echo WFText::_('WF_LABEL_UPDATE'); ?></button>
        <button type="button" id="apply"><?php echo WFText::_('WF_STYLES_APPLY'); ?></button>
        <button type="button" id="cancel"><?php echo WFText::_('WF_LABEL_CANCEL'); ?></button>
    </div>
</form>
<div style="display:none;">
    <div id="container"></div>
</div>