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

<div id="itl-team<?php echo $module->id; ?>" class="itl-team <?php echo $params->get('moduleclass_sfx') ?>">
    <div class="row">
    	<?php foreach ($data as $key => $value):  ?>
       		<div class="col-md-<?php echo round(12/$count); ?> col-sm-<?php echo round(12/$count); ?> <?php echo ($key==$count-1) ? 'last-child': ''; ?> ">
                <div class="one-staff<?php echo ($key==$count-1) ? ' last-child': ''; ?>">
                  <div class="staff-image">
                    <img class="img" src="<?php echo $value['img'] ?>" alt="" >
                  </div>
                  
                  <div class="staff-content">
                    <?php if( isset($value['name']) && ($value['name'] !='') ): ?>
                      <h3 class="staff-name"><?php echo $value['name']; ?></h3>
                    <?php endif; ?>
                    <div class="position-title">
                      <?php if( isset($value['desg']) && ($value['desg'] !='') ): ?>
                        <?php echo $value['desg']; ?>
                      <?php endif; ?>
                    </div>
                    <?php if( isset($value['desc']) && ($value['desc'] !='') ): ?>
                      <p class="staff-description"><?php echo $value['desc']; ?></p>
                    <?php endif; ?>
                  </div>

                  <div class="social_widget"><span class="connect">Connect here:</span>
                      <ul>
                          <li class="facebook"><a href="#" title="Facebook"><i class="moon-facebook"></i></a>
                          </li>
                          <li class="twitter"><a href="#" title="Twitter"><i class="moon-twitter"></i></a>
                          </li>
                          <li class="mail"><a href="#" title="Mail"><i class="moon-mail"></i></a>
                          </li>
                      </ul>
                  </div>
                    
                    

                    <?php 
                      if( (isset( $value['facebook']) && ($value['facebook'] !=''))
                      || (isset( $value['twitter']) && ($value['twitter'] !=''))
                      || (isset( $value['googleplus']) && ($value['googleplus'] !=''))
                      || (isset( $value['pinterest']) && ($value['pinterest'] !=''))
                      || (isset( $value['linkedin']) && ($value['linkedin'] !='')) ): ?>
                      <div class="social-icons">
                          <?php if($value['facebook'] !=''): ?>
                            <a target="_blank" href="<?php echo $value['facebook']; ?>" ><i class="icon-facebook"></i></a>
                          <?php endif; ?>
                          <?php if($value['twitter'] !=''): ?>
                            <a target="_blank" href="<?php echo $value['twitter']; ?>" ><i class="icon-twitter"></i></a>
                          <?php endif; ?>
                          <?php if($value['googleplus'] !=''): ?>
                            <a target="_blank" href="<?php echo $value['googleplus']; ?>" ><i class="icon-google-plus"></i></a>
                          <?php endif; ?>
                          <?php if($value['pinterest'] !=''): ?>
                            <a target="_blank" href="<?php echo $value['pinterest']; ?>" ><i class="icon-pinterest"></i></a>
                          <?php endif; ?>
                          <?php if($value['linkedin'] !=''): ?>
                            <a target="_blank" href="<?php echo $value['linkedin']; ?>" ><i class="icon-linkedin"></i></a>
                          <?php endif; ?>
                      </div><!--/.social-icons-->
                  <?php endif; ?>
                </div><!--/.member-->
            </div><!--/.span-->
    	<?php endforeach; ?>
    </div><!--/.row-fluid-->
</div>