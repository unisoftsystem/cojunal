<section class="panelBG m_b_20 lista_all_deudor" id="app-busca_clientes">
<div class="padding">
		<br><br>

				<div class="large-4 medium-4 small-12 columns padding">
					<div class="label">Digite el nombre del cliente</div>
				</div>

			<div class="row" >
				<div class="large-6 medium-6 small-12 columns padding">
					<fieldset class="formweb" >
					<input type="text" v-on:keyup="busqueda" v-model="buscar_cliente" class="form-control" placeholder=" Buscar clientes" >
					</fieldset>
				</div>
			</div>
		</div>
    <br><br>
  <table class="bordered highlight responsive-table">
    <thead>
      <tr>
        <th class="txt_center">Nombre del cliente</th>
        <th class="txt_center">Correo del cliente</th>
        <th class="txt_center">Fecha de creación</th>
        <th class="txt_center">Número de campañas</th>
        <th class="txt_center">Horarios</th>
        <th class="txt_center">Intereses</th>
        <th class="txt_center">% Comisión</th>
        <th class="txt_center">Saldo total asignado</th>
        <th class="txt_center">Saldo total recuperado</th>
      </tr>
    </thead>
    <tbody id="info-busqueda" >
      <?php foreach ($clientesList as $client): ?>
        <tr >
          <td class="txt_center">  <?php echo $client['name'] ?> </td>
          <td class="txt_center"> <?php echo $client['contactEmail'] ?> </td>
          <td class="txt_center"> <?php echo date('d-m-Y', strtotime($client['fCreacion'])) ?> </td>
          <td class="txt_center"> <?php echo $client['numCampanas'] ?> </td>
          <td class="txt_right"> <?php echo number_format($client['sumHonorarios'], 1) ?> </td>
          <td class="txt_right"> <?php echo number_format($client['sumintereses'], 1) ?> </td>
          <td class="txt_right"><?php echo number_format($client['percentageCommission'], 1) ?>%</td>
          <td class="txt_right"> <?php echo number_format($client['saldoAsignado'], 1) ?> </td>
          <td class="txt_right"> <?php echo number_format($client['totalRecuperado'], 1) ?> </td>
        </tr>
      <?php endforeach ?>
    </tbody>
  </table>
  
  <br><br>

  <div class="padding">
    <?php include realpath('./') . '/themes/default/views/admin/utilities.php'; ?>
    <?php $currentPage = (isset($_GET['page']) ? $_GET['page'] : 1) ?>
    <?php  echo pagination($totalRecords, 10, $currentPage, 'http://cojunal.com/plataforma/beta/admin/clientes?page=%s') ?>
    <p style="float: right; margin: -2% 0;"><a href="http://cojunal.com/plataforma/beta/admin/reportesdeudacampanas">Descargar Informe</a></p>
  </div>

</section>


<script>
	<?php include realpath('./').'/themes/default/views/admin/clientes/buscar_clientes.js' ?>
</script>

