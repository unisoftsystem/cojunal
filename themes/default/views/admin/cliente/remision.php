<style>
	.label { padding-top: 10px !important; }
</style>

<section class="panelBG m_b_20 lista_all_deudor">
	
	<!-- SELECCIOPN CLIENTE PARA REMISION -->
	<div class="padding">
			
			<br><br>

			<div class="large-4 medium-4 small-12 columns padding">
				<div class="label">Seleccione el cliente que desee remisionar</div>
			</div>

			<div class="large-6 medium-6 small-12 columns padding">
				<fieldset class="formweb">
					<select onchange="window.showCampaignList(this)">
						<option value="">Selecccione...</option>
						<?php foreach ($clientesNames as $name): ?>
							<option value="<?php echo$name['idCampaign'] ?>"><?php echo$name['name'] ?></option>
						<?php endforeach ?>
					</select>
				</fieldset>
			</div>

	</div>
	
	<br><br><br>

	<!-- TEXTO EXPLICATIVO -->
	<div class="padding">
			
			<div class="large-12 medium-12 small-12 columns padding">
				Acontinuación se muestran las campañas que se pueden remisionar para el cliente seleccionado, 
				por favor seleccione una a una las que desea adicionar a la remisión.
			</div>

	</div>
	
	<br><br><br>

	<!-- TABLA PARA LA SELECCION -->
	<table class="bordered highlight responsive-table">
		<thead>
			<tr>
				<th class="txt_center">Nombre de la campaña</th>
				<th class="txt_center">Saldo total de la campaña</th>
				<th class="txt_center">Valor recaudado</th>
				<th class="txt_center">Valor ganado por intereses</th>
				<th class="txt_center">Valor ganado por honorarios</th>
				<th class="txt_center">Valor ganado por comisión</th>
				<th class="txt_center">Remisionar</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>

</section>

<script>
	<?php include realpath('./').'/themes/default/views/admin/clientes/remision.js' ?>
</script>