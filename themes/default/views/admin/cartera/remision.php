<style>
	a { cursor: pointer; }
	.label { padding-top: 10px !important; }
	.txt-center { text-align: center; }
	#myChart {
		margin: auto;
		width: 320px !important;
    height: 320px !important;
    margin-top: -20px;
	}
	#custom-grafico {
		position: absolute;
		top: 0;
		width: 100%;
		background: white;
		padding: 30px;
		height: 100%;
	}
	.b-grafico {
		margin: 20px 0px;
		text-align: center
	}
	.recaudado {
		padding: 5px 15px;
		background-color: rgba(255, 99, 132, 0.2);
	}
	.costo {
		padding: 5px 15px;
		background-color: rgba(54, 162, 235, 0.2);
	}
</style>

<div id="app-remision1">

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
						<select v-on:change="getData">
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
					Acontinuación se muestran las campañas que se pueden ver las ordenes de servicio para el cliente seleccionado,
					por favor seleccione una a una las que desea adicionar a la orden de servicios.
				</div>

		</div>

		<br><br><br>

		<div class="well padding">
			<ul  class="large-12 medium-12 small-12 columns padding">
				<li class="large-3 medium-3 small-12 columns animated fadeInLeft">
					<div class="card_dash sin_margin waves-effect waves-light">
						<div class="row txt_center">
							<p class="block"><b>Número de campañas: <b>{{ campanas.length }}</b> </b></p>
						</div>
					</div>
				</li>
			</ul>
		</div>

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
					<th class="txt_center">Orden de servicio</th>
					<th class="txt_center">Gráfico</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="c in campanas">
					<td>{{ c.campaignName }}</td>
					<td class="txt-center">{{ formatPrice(parseFloat((c.saldoCampana - c.totalRecaudado || 0)))}}</td>
					<td class="txt-center">{{ formatPrice(parseFloat((c.recaudado || 0))) }}</td>
					<td class="txt-center">{{ formatPrice(parseFloat(((c.recaudado * c.interests) || 0))) }}</td>
					<td class="txt-center">{{ formatPrice(parseFloat(((c.recaudado * c.fee)|| 0))) }}</td>
					<td class="txt-center">{{ formatPrice(parseFloat(((c.recaudado * c.comisions) || 0))) }}</td>
					<td class="txt-center">
						<a v-if="c.idPayments" v-on:click="remisionar(c)">Orden de servicio</a>
						<a v-if="!c.idPayments">Sin datos para realizar la orden</a>
					</td>
					<td>
						<a v-on:click="showGF(c.idWalletByCampaign)">Ver</a>
					</td>
				</tr>
			</tbody>
		</table>

		<graficos-component v-if="showG" v-bind:id="idCampaign"></graficos-component>

	</section>

</div>

<script type="text/template" id="graficos_component">

	<div id="custom-grafico">

		<span>
			<b>
				{{ campana.campaignName }} $
				<span v-if="campana.monto_total">{{ formatPrice(parseFloat(campana.monto_total)) }}</span>
				<span v-if="!campana.monto_total">0</span>
			</b>
		</span>
		<br>
		<span>
			Número de deudores:
			<b v-if="campana.num_clientes">{{  formatPrice(parseFloat(campana.num_clientes)) }}</b>
			<b v-if="!campana.num_clientes">0</b>
		</span>
		<br>
		<span>Fecha de subida: <b>{{ campana.createAt }}</b></span>
		<a v-on:click="$parent.showG = false" style="float: right;margin-top: -50px;">X Cerrar</a>
		<br>
		<div class="b-grafico">
			<span>
				Costo total campaña:
				<b v-if="costo_campana" class="recaudado">{{ formatPrice(parseFloat(costo_campana)) }}</b>
				<b class="recaudado">{{pendiente2}}</b>
				<b v-if="!costo_campana" class="recaudado">0</b>

			</span>
			<span>
				Valor total recaudado:
				<b v-if="recaudado" class="costo">{{ formatPrice(parseFloat(recaudado)) }}</b>
				<b class="costo">{{recaudado2}}</b>
				<b v-if="!recaudado" class="costo">0</b>

			</span>
		</div>
		<br>
		<canvas id="myChart" width="320px" height="320px"></canvas>
	</div>

</script>

<script>
	<?php include 'remision.js' ?>
</script>
