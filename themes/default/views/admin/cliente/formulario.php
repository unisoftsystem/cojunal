<style>
	.label { padding-top: 10px !important; }
</style>

<section class="panelBG m_b_20 lista_all_deudor">
	
	<section class="padding">
	
		<div class="panelBG wow m_b_20">
			
			<fieldset class="large-12 medium-12 small-12 columns padding">
				
				<div class="tab_base m_t_20">

					<?php $action = Yii::app()->baseUrl.'/cms/campaigns/create'; ?>
					<!-- FORMULARIO COORDINADOR  -->			
					<form id="advisers-form" class="formweb" action="<?php echo $action ?>" method="POST">
						<!-- Campaigns[name] -->
						<!-- Campaigns[name] -->
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">NOMBRE</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>

						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">NIT</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">CORREO</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">VALOR POR CARGA DE USUARIO SERVICIO 1</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">VALOR POR CARGA DE USUARIO SERVICIO 1</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">HONORARIOS POR CAMPAÑA</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">INTERESES POR CAMPAÑA</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>

						<fieldset class="large-12 medium-12 small-12 columns padding">
							<div class="large-3 medium-6 small-12 columns">
								<label class="label">% DE COMISIÓN POR CAMPAÑA</label>
							</div>				
							<div class="large-6 medium-6 small-12 columns">
								<input type="text">
							</div>				
						</fieldset>
						
						<div class="txt_right block large-12 medium-12 small-12 columns padding">
							<div class="large-9 medium-9 small-12 columns">	
								<button id="btnSaveInfo" class="btnb waves-effect waves-light">GUARDAR</button>
							</div>
						</div>

					</form>

				</div>	

			</fieldset>

		</div>	

	</section>

</section>