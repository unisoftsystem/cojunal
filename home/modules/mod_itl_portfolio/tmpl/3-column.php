<?php
/**
 * @subpackage  mod_ts_team
 * @copyright Copyright (C) 2013 - 2014 Themewinter. All rights reserved.
 * @license   GNU General Public License version 2 or later; 
 */

// no direct access
defined('_JEXEC') or die;

?>
<div id="itl-portfolio<?php echo $module->id; ?>" class="itl-portfolio layout2 <?php echo $params->get('moduleclass_sfx') ?>">
    <div id="portfolio-wrapper" class="portfolio-wrap row">
    <?php foreach ($data as $key => $value):  ?>
            <div class="col-md-4 portfolio-item v2 l3" data-id="1925">
                    <div class="he-wrap tpl2">
                        <img src="<?php echo $value['img'] ?>" alt="<?php echo $value['title'] ?>" class="start_animation ">

                        <div class="overlay he-view">
                            <div class="bg a0" data-animate="fadeIn">
                                <div class="center-bar v1">
                                    <div class="centered">
                                        <a href="<?php echo $value['img'] ?>" class="btn-system a1 fancybox" data-animate="fadeInUp">View Large</a>
                                        <a href="<?php echo $value['extlink'] ?>" class="btn-system second a2" data-animate="fadeInUp">Read More</a>
                                    </div>
                                    <a href="<?php echo $value['extlink'] ?>" class="title a3" data-animate="fadeInUp">
                                    <?php echo $value['title'] ?></a>
                                <span class="categories a4" data-animate="fadeInUp">
                                <?php echo $value['category'] ?></span> 
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--<div class="info">
                        <h3><a href="portfolio_2_cols.html"><?php //echo $value['title'] ?></a></h3>
                        <span class="categories"><?php //echo $value['category'] ?></span>
                    </div>-->
            </div>
    <?php endforeach ?>
    </div>
</div>