<link href="<?php echo Yii::app()->baseUrl; ?>/assets/site/css/profile_admin/usuarios.css" rel="stylesheet" type="text/css" />
<?php 
/*$paymentAmount = 0;                            
                            if (count($payments) > 0){ 
                              foreach ($payments as $payment) {
                                $paymentAmount += $payment->value;                              
                              }
                            }
                            $recoveryPorc = ($paymentAmount * 100) / $model->capitalValue;                            
                          ?>
                          <div class="porcent" style="width:<?= $recoveryPorc ?>%"></div><span><?= $recoveryPorc ?>%</span>*/
						  
?>
<div class="cont_home" id="usuarios">
	<section class="conten_inicial">
		<section class="wrapper_l dashContent p_t_25">
			<section class="padding panelBG">				

			
  <table class="bordered highlight responsive-table">
    <thead>
      <tr>
        <th class="txt_center">Campaña</th>
        <th class="txt_center">Cliente</th>
        <th class="txt_center">Fecha Creación</th>
        <th class="txt_center">Saldo</th>
        <th class="txt_center">Porcentaje de recuperacion</th>
		<th class="txt_center">Coordinador Asignado</th>
		<th class="txt_center">Tipo de servicio</th>
		<th class="txt_center">Coordinador</th>
		<th class="txt_center">Asignar</th>

    
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
        
      </tr>
    </thead>
    <tbody>
	  <?php foreach( $listado as $list): ?>
        <tr>
          <td><?php echo $list['campana'] ?></td>
          <td><?php echo $list['companyName'] ?></td>
          <td><?php echo $list['fCreacion'] ?></td>
          <td><?php echo number_format($list['total_campa'],2) ?></td>
		  <td>
      <?php 
                           $paymentAmount = 0;                            
                            if (count($payments) > 0){ 
                              foreach ($payments as $payment) {
                                $paymentAmount += $payment->value;                              
                              }
                            }
                            $recoveryPorc = ($paymentAmount * 100) / $list['total_campa'];    
                            
                            echo $recoveryPorc."%";
                          ?>
      
      </td>                   
		  <td><?php echo $list['coordinador'] ?></td>
		  <td><?php echo $list['type'] ?></td>
		  <td class="formweb">
		  	<select name="coordinador" style="display:block">
			  <option value="-1">Seleccione</option>
		  		<?php foreach($coordinadores as $list_coor)://echo $list['interes'] ?>
		  			<option value="<?php echo $list_coor->idAdviser?>"><?php echo $list_coor->name?></option>
				<?php endforeach;?>
			</select>
		  </td>

		  <td>Asignar</td>
        </tr>
      <?php endforeach ?>
    </tbody>
  </table>

			</section>
		</section>
	</section>

</div>





