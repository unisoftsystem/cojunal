<section class="panelBG m_b_20 lista_all_deudor">
  <table class="bordered highlight responsive-table">
    <thead>
      <tr>
        <th class="txt_center">Nombre de usuario</th>
        <th class="txt_center">Coordinador asiganado</th>
        <th class="txt_center">Total de campañas asignadas</th>
        <th class="txt_center">Saldo total asignado</th>
        <th class="txt_center">Saldo total recuperado</th>
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
      </tr>
    </thead>
    <tbody>
      <?php foreach ($asesores as $asesor): ?>
        <tr>
          <td><?php echo $asesor['name'] ?></td>
          <td class="formweb">
            <select  onchange="setCoordinador(this, <?php echo $asesor['idAdviser'] ?>)" placeholder="Seleccione...">
              <option value="">Seleccione</option>
              <?php foreach ($coordinadores_select as $coordinador): ?>
                <?php $selected = ($coordinador['idAdviser'] == $asesor['parentAdviser']) ? 'selected="selected"' : ''  ?>
                <option <?php echo $selected ?> value="<?php echo $coordinador['idAdviser'] ?>">
                  <?php echo $coordinador['name']  ?>
                </option>
              <?php endforeach ?>
            </select> 
          </td>
          <td class="txt_center"><?php echo $asesor['total_campanas'] ?></td>
          <td><?php echo '$ '.number_format($asesor['total_asignado'], 2) ?></td>
          <td><?php echo '$ '.number_format($asesor['total_recuperado'], 2) ?></td>
          <td>
            <form class="formweb" action="">
              <select onchange="enableOrDisableadviser(this, <?php echo $asesor['idAdviser'] ?>)" placeholder="Seleccione...">
                <option value="">Seleccione</option>
                <?php foreach ([0 => 'Inactivo', 1 => 'Activo'] as $key => $opt): ?>
                  <?php $selected = ($key == $asesor['active']) ? 'selected="selected"' : ''  ?>
                  <option <?php echo $selected ?> value="<?php echo $key ?>">
                    <?php echo $opt  ?>
                  </option>
                <?php endforeach ?>
              </select> 
            </form>
          </td>
        </tr>
      <?php endforeach ?>
    </tbody>
  </table>
</section>

<script>
  <?php include realpath('./').'/themes/default/views/admin/usuarios/listado_asesores.js' ?>
</script>