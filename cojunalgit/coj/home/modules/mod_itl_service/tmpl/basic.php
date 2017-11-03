<?php
    /**
    * @author    Tripples http://www.themewinter.com
    * @copyright Copyright (C) 2013- 2014 Tripples
    * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2
    */

	// no direct access
    defined('_JEXEC') or die;
    ?>

    <div class="features-wrapper<?php echo $moduleclass_sfx ?>" <?php if ($params->get('backgroundimage')): ?> style="background-image:url(<?php echo $params->get('backgroundimage');?>)"<?php endif;?> >
        <div class="row-fluid">
            <div class="container">
            <?php foreach ($data as $key => $value): ?>
                <div class="span<?php echo round(12/count($data)); ?>">
                    <div class="feature-icon">
                        <i class="<?php echo $value['icon']; ?>"></i>
                    </div>
                    <div class="feature-content">
                        <?php if( isset($value['title']) && ($value['title'] !='') ): ?>
                            <h3><?php echo $value['title']; ?></h3>
                        <?php endif; ?>
                        <?php if( isset($value['desc']) && ($value['desc'] !='') ): ?>
                            <p><?php echo $value['desc']; ?></p>
                        <?php endif; ?>
                         <?php if( isset($value['more']) && ($value['more'] !='') ): ?>
                            <a href="<?php echo $value['more']; ?>"><?php echo JText::_('READ_MORE'); ?></a>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>
            </div>
        </div><!--row-fluid-->
    </div><!--features-->