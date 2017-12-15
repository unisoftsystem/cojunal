<?php

class CoordinadorController extends GxController {

	function actionIndex ()
	{
		require realpath('./') . '/themes/default/views/main.php';
	}
	
}