<section class="panelBG m_b_20 lista_all_deudor">
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
      <tr class="filters formweb">
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
        <td>
          <input type="text"  name="Campaigns" id="Campaigns" maxlength="100" 
            value="" onchange='javascript:uploadList("name","Campaigns")'>
        </td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($clientesList as $client): ?>
        <tr>
          <td> <?php echo $client['name'] ?> </td>
          <td> <?php echo $client['contactEmail'] ?> </td>
          <td> <?php echo date('d-m-Y', strtotime($client['fCreacion'])) ?> </td>
          <td class="txt_center"> <?php echo $client['numCampanas'] ?> </td>
          <td class="txt_right"> <?php echo '$'.number_format($client['sumHonorarios'], 2) ?> </td>
          <td class="txt_right"> <?php echo '$'.number_format($client['sumintereses'], 2) ?> </td>
          <td class="txt_right"></td>
          <td class="txt_right"> <?php echo '$'.number_format($client['saldoAsignado'], 2) ?> </td>
          <td class="txt_right"> <?php echo '$'.number_format($client['totalRecuperado'], 2) ?> </td>
        </tr>
      <?php endforeach ?>
    </tbody>
  </table>

  <br><br>
  
  <div class="padding">
    <?php include realpath('./') . '/themes/default/views/admin/utilities.php'; ?>
    <?php $currentPage = (isset($_GET['page']) ? $_GET['page'] : 1) ?>
    <?php echo pagination($totalRecords, 10, $currentPage, 'http://cojunal.com/plataforma/beta/admin/clientes?page=%s') ?>
  </div>

</section>
  

<script>
  <?php // include realpath('./').'/themes/default/views/admin/usuarios/listado_coordinadores.js' ?>
</script>