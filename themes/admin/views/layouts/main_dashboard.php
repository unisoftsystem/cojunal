<?php
$this->Widget('ext.yii-toast.ToastrWidget');
$base = Yii::app()->request->baseUrl;
$session = Yii::app()->session;
?>
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
    var idioma = "<?php //echo $idioma ?>"
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
            <span class="iniciales"> <?php //= strtoupper($iniciales); ?> </span>
          </div>
          <h1><?php //=$campaign->contactName?></h1>
          <p><?php //=$campaign->contactEmail?></p>
        </a>
      </div>
      <ul>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/dashboard" class="waves-effect waves-light" id="wallets"><i class="fa fa-users" aria-hidden="true"></i> <?=Yii::t("menu","cartera")?></a></li>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/campaign" class="waves-effect waves-light" id="reports"><i class="fa fa-calendar-o" aria-hidden="true"></i> <?=Yii::t("menu","reportes")?></a></li>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/database" class="waves-effect waves-light" id="fileUpload"><i class="fa fa-file-text-o" aria-hidden="true"></i> <span class="inline"><?=Yii::t("menu","cargarData")?></span></a></li>
        <li><a href="<?php echo Yii::app()->baseUrl;?>/logout" class="waves-effect waves-light"><i class="fa fa-lock" aria-hidden="true"></i> <?=Yii::t("menu","cerrarSesion")?></a></li>
      </ul>
      <?php 
        if($session['idioma']==2){
        ?>
            <a href="<?php echo $base; ?>/changeIdioma"><img src="<?php echo $base; ?>/assets/site/img/spain.png"></a>
        <?php 
        }else { 
        ?>
            <a href="<?php echo $base; ?>/changeIdioma"><img src="<?php echo $base; ?>/assets/site/img/usa.png"></a>
      <?php } ?>
    </nav>

  </section>
	
  <!--Jquery-->
  <script src="<?php echo Yii::app()->baseUrl;?>/assets/js/lib/jquery.min.js"></script>
  <!--Plungis-->
  <!-- <script src="<?php echo Yii::app()->baseUrl;?>/assets/js/lib/materialize.js"></script>
  <script src="<?php echo Yii::app()->baseUrl;?>/assets/js/lib/plugins.js"></script>
  <script src="<?php echo Yii::app()->baseUrl;?>/assets/js/app.js"></script> -->
	<script src="<?php echo Yii::app()->baseUrl;?>/assets/js/app.min.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
</body>
</html>