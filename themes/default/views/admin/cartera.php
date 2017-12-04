<?php
	$bannerCss = Yii::app()->baseUrl.'/vue-components/cojunal-deudores-banner/dist/css/component.css';
	$cuadrantesCss = Yii::app()->baseUrl.'/vue-components/cojunal-cuadrantes/dist/css/component.css';
?>

<link href="<?php echo $bannerCss; ?>" rel="stylesheet" type="text/css" />
<link href="<?php echo $cuadrantesCss; ?>" rel="stylesheet" type="text/css" />

<div class="cont_home" id="usuarios">
	<section class="conten_inicial">
		<section class="wrapper_l dashContent p_t_25">
			<section class="padding">
				<div class="">
					<div id="app">
						<cojunal-deudores-banner></cojunal-deudores-banner>
						<div style="clear: both;"></div>
						<cojunal-cuarantes-component></cojunal-cuarantes-component>
						<div style="clear: both;"></div>
					</div>
				</div>
			</section>
		</section>
	</section>
</div>
<style>
	#deudores-banner .b-col-40{
		display: none !important;
	}
	#deudores-banner .b-col-60{
		width: 100% !important;
	}

</style>
<script>
	<?php include realpath('./').'/themes/default/views/admin/main.js' ?>
</script>
<script src="https://unpkg.com/vue@2.5.2/dist/vue.js"></script>
<script src="<?php echo Yii::app()->baseUrl.'/vue-components/cojunal-deudores-banner/dist/js/main.js'; ?>"></script>
<script src="<?php echo Yii::app()->baseUrl.'/vue-components/cojunal-cuadrantes/dist/js/main.js'; ?>"></script>
<script>
	document.addEventListener("DOMContentLoaded", function(event) {
		new Vue({
			el: '#app'
		});
	});
</script>
