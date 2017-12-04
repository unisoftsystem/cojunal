<?php
/**
 * @subpackage	mod_ts_team
 * @copyright	Copyright (C) 2013 - 2014 Themewinter. All rights reserved.
 * @license		GNU General Public License version 2 or later; 
 */

// no direct access
defined('_JEXEC') or die;

$count 		= count($data);

?>

<div id="itl-clients<?php echo $module->id; ?>" class="itl-clients <?php echo $params->get('moduleclass_sfx') ?>">
    	<?php foreach ($data as $key => $value):  ?>
        <div class="client-item <?php echo ($key==$count-1) ? 'last-child': ''; ?>">
          <img class="" src="<?php echo $value['img'] ?>" alt="" >
        </div>
    	<?php endforeach; ?>
</div>