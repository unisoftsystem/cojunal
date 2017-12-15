<style>
	.label { padding-top: 10px !important; }
	.txt-center { text-align: center; }
</style>

<div id="app-remisiones">

	<section class="panelBG m_b_20 lista_all_deudor">

		<!-- SELECCIOPN CLIENTE PARA REMISION -->
		<div class="padding">

				<br><br>

				<div class="large-4 medium-4 small-12 columns padding">
					<div class="label">Seleccione el cliente que desee ver las ordenes de servicio</div>
				</div>

				<!-- onchange="window.showCampaignList(this)" -->
				<div class="large-6 medium-6 small-12 columns padding">
					<fieldset class="formweb">
						<select name="clientes" v-model="clientes" @change="Clientesvalue">
							<option value="">Selecccione...</option>
							<?php foreach ($clientesNames as $name): ?>
								<option value="<?php echo$name['idCampaign'] ?>"><?php echo$name['name'] ?></option>
							<?php endforeach ?>
						</select>
					</fieldset>
				</div>

				<div class="large-4 medium-4 small-12 columns padding">
					<div class="label">Si conoce el número de la orden de servicio digítelo:</div>
				</div>
				<form id="form-searchNumberRemission" action="javascript:searchNumberRemission();" method="post">
				<!-- onchange="window.showCampaignList(this)" -->
				<div class="large-6 medium-6 small-12 columns padding">
					<fieldset class="formweb">
						<input type="tel" id="numberRemission" name="numberRemission" value="" required>
					</fieldset>
				</div>

				<div class="large-2 small-12 columns padding">
					<button type="submit" style="padding: 8px;background: rgb(19, 70, 149);color: rgb(255, 255, 255);border-radius: 4px;margin-top: 2px;"> Buscar</button>
				</div>
				</form>

		</div>

		<br><br><br>

		<!-- TEXTO EXPLICATIVO -->
		<div class="padding">

				<div class="large-12 medium-12 small-12 columns padding">
					Acontinuación se muestran las ordenes de servicio para el cliente seleccionado.
				</div>

		</div>

		<br><br><br>

		<!-- TABLA PARA LA SELECCION -->
		<table class="bordered highlight responsive-table">
			<thead>
				<tr>
					<th class="txt_center">Nombre de la campaña</th>
					<th class="txt_center">Fecha</th>
					<th class="txt_center">Hora</th>
					<th class="txt_center">Descarga</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="cliente in clientes">
					<td>{{ cliente.name }}</td>
					<td class="txt-center">{{ cliente.fecha }}</td>
					<td class="txt-center">{{ cliente.hora }}</td>
					<td class="txt-center">
						<a :href="'http://cojunal.com/plataforma/beta/admin/DescargarPdfRemision/'+cliente.id" target="_blank">Descarga</a>
					</td>
				</tr>
			</tbody>
		</table>

	</section>


</div>

<script>
	<?php include realpath('./').'/themes/default/views/admin/clientes/remisiones.js' ?>
</script>
