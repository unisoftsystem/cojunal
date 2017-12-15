<?php

ob_start();
ob_clean();

// Vendor autoload
require_once __DIR__ . '/vendor/autoload.php';

// change the following paths if necessary
$yii=dirname(__FILE__).'/yii-1.1.17/framework/yii.php';

// remove the following lines when in production mode
defined('YII_DEBUG') or define('YII_DEBUG',true);
// specify how many levels of call stack should be shown in each log message
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);

require_once($yii);

// var_dump( in_array('mod_rewrite', apache_get_modules()) );

$config = dirname(__FILE__).'/protected/config/front.php';
Yii::createWebApplication($config)->runEnd('front');
