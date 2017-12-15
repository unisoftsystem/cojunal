<?php 
  $session = Yii::app()->session;
  //Para probar idioma
  // Yii::app()->language = "en";
  if($session['idioma']==2){
      Yii::app()->language = "en";
  }else {
    Yii::app()->language = "es";
  }
?>
<<<<<<< HEAD

<style>
  #resporte_Saldos_tabla_filter, #resporte_Estados_tabla_filter {
    display: none;
  }
  #resporte_Saldos_tabla thead .sorting, 
  #resporte_Estados_tabla thead .sorting, 
  #resporte_Saldos_tabla thead .sorting_asc, 
  #resporte_Estados_tabla thead .sorting_asc, 
  #resporte_Saldos_tabla thead .sorting_desc,
  #resporte_Estados_tabla thead .sorting_desc {
    background : none;
  }
  #resporte_Saldos_tabla th, #resporte_Estados_tabla th {
    padding-right: 0;
  }
  .elipsis {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    padding-bottom: 0;
  }
  input.input-search {
    font-weight: normal;
    margin-top: 15px !important;
    margin-bottom: 15px !important;
    font-size: 13px !important; 
  }
  .b-title {
    display: block;
    padding-bottom: 15px;
    padding-top: 15px;
    border-bottom: 1px solid #e8e8e8;
  }
  .dt-button:hover {
    background: #008d96 !important;
  }
  .dt-button {
    text-align: center;
    font-size: 14px;
    font-family: 'montserrat_bold';
    letter-spacing: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    color: #fff !important;
    padding: 11px 26px;
    -webkit-transition: 0.4s;
    -o-transition: 0.4s;
    -ms-transition: 0.4s;
    -moz-transition: 0.4s;
    transition: 0.4s;
    overflow: hidden;
    position: relative;
    text-transform: uppercase;
    -webkit-border-radius: 2px;
    border-radius: 2px !important;
    display: inline-block;
    background: #09ca69 !important;
    border: none !important;
  }
</style>

<section class="cont_home" id="usuarios">       
=======
<section class="cont_home">       
>>>>>>> 81973bf585de445668108c4c821fc0399d707555
  <section class="conten_inicial">
    <section class="wrapper_l dashContent p_t_25">
      
      <section class="padding">

        <!--Datos iniciales-->
        <section class="row m_b_20">
          <div class="dates_pend wow fadeInDown">
            <div class="large-8 medium-8 small-12 columns boxs">
              <div class="panel">
                <h1><?=Yii::t("dashboard", "deudores")?></h1>
                <h2><?=Yii::t("dashboard", "valorUnidad")?>: <?php echo $valueUnity; ?></h2>
                <h2><?=Yii::t("dashboard", "numeroDeudores")?>: <?php echo $debtorsCount; ?></h2>
              </div>
            </div>
            <div class="large-4 medium-4 small-12 columns boxs">
              <div class="panel">
                <p><b><?=Yii::t("dashboard", "porcentajeRecuperacion")?>:</b> <?php echo round( $recover, 2, PHP_ROUND_HALF_UP)?> %</p>
                <a href="<?php echo Yii::app()->baseUrl;?>/list-campaign"><?= Yii::t("dashboard","verLista") ?><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
              </div>
            </div>
          </div>
        </section>
        <!--Fin Datos iniciales-->

        <!--Global Dashboard-->              
<<<<<<< HEAD
        <section class="wrapper_l dashContent p_t_25">
          <section class="padding">
            <div class="block">
              <ul class="tabs tab_usuarios" data-tabs id="example-tabs">
                <li class="tab"><a href="#campanas" class="active">Demográfico</a></li>
                <li class="tab"><a href="#juridicos">Edad de la deuda</a></li>
                <li class="tab"><a href="#reportes">Estado de la deuda</a></li>
                <li class="tab"><a href="#reportes1">Saldos</a></li>
              </ul>
            </div>

            <section class="panelBG wow fadeInUp m_b_20 animated">
              <section class="padd_v">
                <div class="row">
                  <article id="campanas" class="block">
                    <?php require_once realpath('./') . '/themes/default/views/dashboard/reportes/demografico.php'; ?>
                  </article>

                  <article id="juridicos" class="block">
                    <?php require_once realpath('./') . '/themes/default/views/dashboard/reportes/cuadrantes_empresa.php'; ?>
                  </article>

                  <article id="reportes" class="block">
                    <?php require_once realpath('./') . '/themes/default/views/dashboard/reportes/estados.php'; ?>
                  </article>

                  <article id="reportes1" class="block">
                    <?php require_once realpath('./') . '/themes/default/views/dashboard/reportes/saldos.php'; ?>
                  </article>
                </div>
                <div class="clear"></div>
              </section>
            </section>
          </section>
=======
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
>>>>>>> 81973bf585de445668108c4c821fc0399d707555
        </section>
        <!--Fin Global Dashboard-->              

      </section>

      <div class="clear"></div>
    </section>
  </section>
    <div class="clear"></div>
</section>
<script type="text/javascript">
  $( document ).ready(function() {
    $("#wallets").addClass("activo");
  });
</script>