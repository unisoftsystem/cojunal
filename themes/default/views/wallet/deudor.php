<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--<![endif]-->
<!-- html5.js for IE less than 9 -->
<!--[if lt IE 9]>  <script src="assets/js/lib/html5.js"></script>  <![endif]-->
<html>
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta http-equiv="content-language" content="es" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <title>COJUNAL</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="copyright" content="imaginamos.com" />
  <meta name="date" content="2016" />
  <meta name="author" content="diseño web: imaginamos.com" />
  <meta name="robots" content="All" />
  <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico" />
  <link rel="author" type="text/plain" href="humans.txt" />
  <!--Style's-->
  <link href="<?php echo Yii::app()->baseUrl; ?>/assets/css/cojunal.css" rel="stylesheet" type="text/css" />
  <link href="<?php echo Yii::app()->baseUrl; ?>/assets/css/alts.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript">
    var idioma = "es"
  </script>

  <style type="text/css">
    .iniciales{
          color: #fff;
          position: absolute;
          margin-top: 20%;
          font-size: 27px;
          font-weight: bolder;
          margin-left: 15%;
    }
    .user_log{
        background-color: #f5a623 !important;
    }
  </style>

  <style type="text/css">
    .iniciales2{
          color: #f5a623;
          position: absolute;
          margin-top: 20%;
          font-size: 17px;
          font-weight: bolder;
          margin-left: 15%;
    }

  </style>
  <?php // require 'javascriptPrototipesUtilities.php' ?>
  <link rel="stylesheet" href="http://cojunal.com/plataforma/beta/assets/site/css/profile_admin/usuarios.css">
</head>

<body>

  <section class="content_all">
    <section class="preload">
      <div class="progress"> <div class="indeterminate"></div></div>
      <div class="loading waves-button waves-effect waves-light">
        <div class="logo_load"><img src="<?php echo Yii::app()->baseUrl; ?>/assets/img/logo.png"></div>
      </div>
    </section>

    <header>
      <div class="row">
        <a href="#" data-activates="nav-mobile" class="nav_movile top-nav hide-on-large-only">    
          <div class="burger"> <ul> <li></li> <li></li> <li></li> </ul></div>
        </a>
        <a href="carter.php" class="logo animated fadeInLeft">
          <img src="<?php echo Yii::app()->baseUrl; ?>/assets/img/logo.png" alt="">
        </a>       
      </div>  
    </header>
    <nav id="nav-mobile" class="side-nav fixed">
      <div class="bg_profile">              
        <a href="<?php echo Yii::app()->baseUrl; ?>/campaign/profile">
          <div class="user_log responsive-img">
            <span class="iniciales"> <?= strtoupper($iniciales); ?> </span>
          </div>
          <h1><?= $deudor->legalName ?></h1>
          <p><?= $deudor->idNumber ?></p>
        </a>
      </div>
      <ul>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/dashboard" class="waves-effect waves-light" id="wallets"><i class="fa fa-users" aria-hidden="true"></i> <?=Yii::t("menu","cartera")?></a></li>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/logout" class="waves-effect waves-light"><i class="fa fa-lock" aria-hidden="true"></i> <?=Yii::t("menu","cerrarSesion")?></a></li>
      </ul>
      <?php 
            if($session['idioma']==2){
            ?>
                <a href="<?php echo Yii::app()->baseUrl; ?>/changeIdioma"><img src="<?php echo Yii::app()->baseUrl; ?>/assets/site/img/spain.png"></a>
            <?php 
            }else { 
            ?>
                <a href="<?php echo Yii::app()->baseUrl; ?>/changeIdioma"><img src="<?php echo Yii::app()->baseUrl; ?>/assets/site/img/usa.png"></a>
          <?php } ?>
    </nav>

    <!--Calendar-->
    <div id="root-picker-outlet"></div>
    <!--Calendar-->
        <!--Contenidos Sitio-->
        <main>
        	<div class="cont_home" id="usuarios">
        		<section class="conten_inicial">
        			<section class="wrapper_l dashContent p_t_25">
        				<section class="padding">
							<!-- header -->
							<section class="row m_b_20">
								<div class="dates_pend wow fadeInDown animated" style="visibility: visible; animation-name: fadeInDown;">
									<div class="large-8 medium-8 small-12 columns boxs">
										<div class="panel">
											<h1>Deudores</h1>
											<h2>Valor unidad: $15,241,252.00</h2>
											<h2>Número de deudores: 1</h2>
										</div>
									</div>
									<div class="large-4 medium-4 small-12 columns boxs">
										<div class="panel">
											<p><b>Porcentaje de recuperacion total:</b> 0 %</p>
											<a href="/plataforma/beta/list-campaign">Ver toda la lista<i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
										</div>
									</div>
								</div>
							</section>
							
        					<!-- deuda conten -->
							<section class="panelBG wow fadeInUp m_b_20 animated">
								<section class="padd_v">
									
									Cliente al que le debe, 
									monto de la deuda, 
									Intereses de la deuda, 
									comisión de la deuda, 
									monto total de la deuda.
									
									<br />

									- Le mostrará dos métodos de pago. 1) botón de pago de la deuda total. 2) Botón de acuerdo de pago, donde tendrá un formulario de contacto para que el asesor encargado se comunique con èl y realice el acuerdo.

								</section>
							</section>
						</section>
					</section>
				</section>
			</div>

          <footer>
            <div class="large-6 medium-6 small-12 columns">
              <p>© 2016 <span>COJUNAL</span> Todos los derechos reservados.</p>

            </div>
            <div class="large-6 medium-6 small-12 columns">
            <div class="footer-autor">
              <a href="http://www.imaginamos.com" target="_blank">Diseño web: <span id="ahorranito2"></span> Imagin<span>a</span>mos.com</a>
            </div>
            </div>
            <div class="clear"></div>  
          </footer>
        </main>
  </section>
<?php 
  // require("modal_wallet.php");
?>

		<!--Jquery-->
		<!-- <script src="assets/js/lib/jquery.min.js"></script>    -->
		<!--Plungis-->
		<!-- <script src="assets/js/lib/materialize.js"></script>
		<script src="assets/js/lib/plugins.js"></script>
		<script src="assets/js/app.js"></script> -->
		<script src="<?php echo Yii::app()->baseUrl;?>/assets/js/app.min.js"></script>
	    <!-- <script src='https://www.google.com/recaptcha/api.js'></script>
	    <script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js'></script>
	    <script src='https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js'></script>
	    <script src='https://cdn.datatables.net/1.10.16/js/dataTables.foundation.min.js'></script>
	    <script src='https://cdn.datatables.net/buttons/1.5.0/js/dataTables.buttons.min.js'></script>
	    <script src='//cdn.datatables.net/buttons/1.5.0/js/buttons.flash.min.js'></script>
	    <script src='//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'></script>
	    <script src='//cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'></script>
	    <script src='//cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'></script>
	    <script src='//cdn.datatables.net/buttons/1.5.0/js/buttons.html5.min.js'></script>
	    <script src='//cdn.datatables.net/buttons/1.5.0/js/buttons.print.min.js'></script>
	    
	    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.0/css/buttons.dataTables.min.css" />
	    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.foundation.min.css" /> -->

   	</main>    
    <!--Fin Contenidos Sitio-->

</section><!--Content_all-->
