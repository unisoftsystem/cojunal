<?php
    /**
    * @author    Tripples http://www.themewinter.com
    * @copyright Copyright (C) 2013- 2014 Tripples
    * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2
    */

	// no direct access
    defined('_JEXEC') or die;
    ?>

    <div class="itl-service-wrapper <?php echo $moduleclass_sfx ?>">
        <div class="row-fluid">
            <?php foreach ($data as $key => $value): ?>
            <div class="col-sm-3 border service-item">
                <div class="service-mini-icon">
                    <i class="<?php echo $value['icon']; ?>"></i>
                </div>
                <div class="service-mini-content">
                    <?php if( isset($value['title']) && ($value['title'] !='') ): ?>
                    <a href="<?php echo $value['more']; ?>">
                        <h4><?php echo $value['title']; ?></h4>
                    </a>
                    <?php endif; ?>
                    <p><?php echo $value['desc']; ?></p>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
    <div class="divider__ big_shadow"></div>

