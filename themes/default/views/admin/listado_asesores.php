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
      <?php 
     
      //foreach ($asesores as $asesor): ?>
        <tr>
          <td><?php // echo $asesor->name ?></td>
          <td>hola</td>
          <td>hola</td>
          <td>hola</td>
          <td>hola</td>
          <td>hola</td>
          <td><?php // echo $asesor->active ?></td>
        </tr>
      <?php // endforeach ?>
    </tbody>
  </table>
</section>