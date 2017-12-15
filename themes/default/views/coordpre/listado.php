<link href="<?php 
	echo Yii::app()->baseUrl.'/assets/site/css/profile_admin/usuarios.css'; ?>" 
	rel="stylesheet" type="text/css" />

<div class="cont_home " id="usuarios">
	<section class="conten_inicial ">
		<section class="wrapper_l dashContent p_t_25">
			<section class="padding panelBG">
				
			<table class="bordered highlight responsive-table">
    <thead>
      <tr>
        <th class="txt_center">Nombre del cliente</th>
        <th class="txt_center">Campaña</th>
        <th class="txt_center">Valor total</th>
        <th class="txt_center">Saldo</th>
        <th class="txt_center">% recaudo</th>
        <th class="txt_center"># deudores</th>
      </tr>
    </thead>
    <tbody id="info-busqueda" >
      
        <tr >
          <td class="txt_center">  <?php //echo $client['name'] ?> </td>
          <td class="txt_center"> <?php //echo $client['contactEmail'] ?> </td>
          <td class="txt_center"> <?php //echo date('d-m-Y', strtotime($client['fCreacion'])) ?> </td>
          <td class="txt_center"> <?php //echo $client['numCampanas'] ?> </td>
		  <td class="txt_center"> <?php //echo $client['numCampanas'] ?> </td>
		  <td class="txt_center"> <?php //echo $client['numCampanas'] ?> </td>
         
        </tr>
     
    </tbody>
  </table>
				
			</section>
		</section>
	</section>

</div>

<script>
	<?php //include realpath('./').'/themes/default/views/admin/main.js' ?>
</script>