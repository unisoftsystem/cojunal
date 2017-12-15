<section class="list_dash">
  <ul>
    <li class="large-6 medium-6 small-12 columns wow flipInX">
      <a href="<?php echo Yii::app()->baseUrl;?>/list-campaign/1">
        <div class="card_dash sin_margin waves-effect waves-light">
          <div class="icon_num">1</div>
          <div class="lineap"></div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "valor")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q1']['value']; ?></p>
          </div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "tiempoMora")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q1']['days']; ?> <span><?=Yii::t("dashboard", "dias")?></span></p>
          </div>
          <div class="clear"></div>
        </div>
      </a>
    </li>
    <li class="large-6 medium-6 small-12 columns wow flipInX">
      <a href="<?php echo Yii::app()->baseUrl;?>/list-campaign/2">
        <div class="card_dash sin_margin waves-effect waves-light">
          <div class="icon_num">2</div>
          <div class="lineap"></div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "valor")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q2']['value']; ?></p>
          </div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "tiempoMora")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q2']['days']; ?> <span><?=Yii::t("dashboard", "dias")?></span></p>
          </div>
          <div class="clear"></div>
        </div>
      </a>
    </li>
    <li class="large-6 medium-6 small-12 columns wow flipInX">
      <a href="<?php echo Yii::app()->baseUrl;?>/list-campaign/3">
        <div class="card_dash sin_margin waves-effect waves-light">
          <div class="icon_num">3</div>
          <div class="lineap"></div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "valor")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q3']['value']; ?></p>
          </div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "tiempoMora")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q3']['days']; ?> <span><?=Yii::t("dashboard", "dias")?></span></p>
          </div>
          <div class="clear"></div>
        </div>
      </a>
    </li>
    <li class="large-6 medium-6 small-12 columns wow flipInX">
      <a href="<?php echo Yii::app()->baseUrl;?>/list-campaign/4">
        <div class="card_dash sin_margin waves-effect waves-light">
          <div class="icon_num">4</div>
          <div class="lineap"></div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "valor")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q4']['value']; ?></p>
          </div>
          <div class="row">
            <p class="large-5 medium-5 small-12 columns"><b><?=Yii::t("dashboard", "tiempoMora")?>:</b></p>
            <p class="large-7 medium-7 small-12 columns"><?php echo $quadrants['q4']['days']; ?> <span><?=Yii::t("dashboard", "dias")?></span></p>
          </div>
          <div class="clear"></div>
        </div>
      </a>
    </li>
  </ul>
</section>