<section class="panelBG m_b_20 lista_all_deudor">
  <table class="bordered highlight responsive-table">
    <thead>
      <tr>
        <th class="txt_center">Nombre de usuario</th>
        <th class="txt_center">Número de asesores a cargo</th>
        <th class="txt_center">Total de campañas asignadas</th>
        <th class="txt_center">Total asignado</th>
        <th class="txt_center">Total recuperado</th>
        <th class="txt_center">% de recuperación</th>
        <th class="txt_center">Habilitar</th>
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
      </tr>
    </thead>
    <tbody>
      <?php foreach ($coordinadores as $coordinador): ?>
        <tr>
          <td><?php echo $coordinador['name'] ?></td>
          <td class="txt_center"><?php echo $coordinador['total_asesores'] ?></td>
          <td class="txt_center"><?php echo $coordinador['total_campanas'] ?></td>
          <td><?php echo '$ '.number_format($coordinador['total_asignado'], 2) ?></td>
          <td><?php echo '$ '.number_format($coordinador['total_recuperado'], 2) ?></td>
          <?php //$recuperacion = ($coordinador['total_asignado'] / $coordinador['total_recuperado']) ?>
          <td><?php echo $coordinador['name'] ?></td>
          <td class="formweb">
            <select onchange="enableOrDisableadviser(this, <?php echo $coordinador['idAdviser'] ?>)">
              <option value="">Seleccione</option>
              <?php foreach ([0 => 'Inactivo', 1 => 'Activo'] as $key => $opt): ?>
                <?php $selected = ($key == $coordinador['active']) ? 'selected="selected"' : ''  ?>
                <option <?php echo $selected ?> value="<?php echo $key ?>">
                  <?php echo $opt  ?>
                </option>
              <?php endforeach ?>
            </select>  
          </td>
        </tr>
      <?php endforeach ?>
    </tbody>
  </table>
</section>

<script>
  <?php include realpath('./').'/themes/default/views/admin/usuarios/listado_coordinadores.js' ?>
</script>