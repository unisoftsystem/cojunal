<link href="<?php
	echo Yii::app()->baseUrl.'/assets/site/css/profile_admin/usuarios.css'; ?>"
	rel="stylesheet" type="text/css" />



	<link href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>




<div class="cont_home" id="usuarios">
	<section class="conten_inicial">
		<section class="wrapper_l dashContent p_t_25">
			<section class="padding">
				<section class="panelBG wow fadeInUp m_b_20 animated">
					<section class="padd_v">
						<div class="row">
							<table class="bordered highlight responsive-table">
								<thead>
									<tr>
										<th class="txt_center">Campaña</th>
										<th class="txt_center">Identificación</th>
										<th class="txt_center">Nombre</th>
										<th class="txt_center">Ciudad</th>
										<th class="txt_center">Fecha asignación</th>
										<th class="txt_center">Última gestión</th>
										<th class="txt_center">Estado</th>
										<th class="txt_center">Saldo asigando</th>
										<th class="txt_center">Saldo capital	</th>
										<th class="txt_center">Intereses	</th>
										<th class="txt_center">Honorarios	</th>
										<th class="txt_center">Tipo	</th>
									</tr>
								</thead>
								<tbody>
									<tbody id="data-data">
										<?php foreach($rangedeudores as $list_info_re){?>
										<tr>
												<td><p style="font-size:1em;"><?php echo $list_info_re['campaignName'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['idNumber'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['legalName'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['ciudad'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['createAt'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['last'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo $list_info_re['status'] ?></p></td>
												<td><p style="font-size:1em;"><?php echo number_format($list_info_re['fee'], 2) ?></p></td>
												<td><p style="font-size:1em;"><?php echo number_format($list_info_re['capitalValue'], 2) ?></p></td>
												<td><p style="font-size:1em;"><?php echo number_format($list_info_re['interests'], 2) ?></p></td>
												<td><p style="font-size:1em;"><?php echo number_format($list_info_re['comisions'], 2) ?></p></td>
												<td><p style="font-size:1em;">
													<?php
														$echo;
														if($list_info_re['notificationType'] == 1){$echo = '<div class="estado red   tooltipped" data-position="top" data-delay="50" data-tooltip="DEUDORES ILOCALIZADOS" data-id="43228" data-tooltip-id="00ab5e6b-7c08-a133-69c8-1ce34c977623"></div>';}
														if($list_info_re['notificationType'] == 2){$echo = '<div class="estado blue   tooltipped" data-position="top" data-delay="50" data-tooltip="DEUDORES LOCALIZADOS" data-id="43228" data-tooltip-id="00ab5e6b-7c08-a133-69c8-1ce34c977623"></div>';}
														if($list_info_re['notificationType'] == 3){$echo = '<div class="estado yellow tooltipped" data-position="top" data-delay="50" data-tooltip="DEUDORES LOCALIZADOS" data-id="43228" data-tooltip-id="00ab5e6b-7c08-a133-69c8-1ce34c977623"></div>';}
														if($list_info_re['notificationType'] == 4){$echo = '<div class="estado green  tooltipped" data-position="top" data-delay="50" data-tooltip="DEUDORES LOCALIZADOS" data-id="43228" data-tooltip-id="00ab5e6b-7c08-a133-69c8-1ce34c977623"></div>';}
														 echo $echo;
													?>

												</p></td>
										</tr>
										<?php }?>
									</tbody>
								</tbody>
							</table>

							<br><br>
							<div class="padding">
								<?php include realpath('./') . '/themes/default/views/admin/utilities.php'; ?>
								<?php $currentPage = (isset($_GET['page']) ? $_GET['page'] : 1) ?>
								<?php echo pagination($totalregistros, 10, $currentPage, 'http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/'.$idGet.'?page=%s') ?>
							</div>
						</div>
						<div class="clear"></div>
					</section>
				</section>
			</section>
		</section>
	</section>

</div>

<script>
$(document).ready(function(){
	$('#data-table').DataTable()
	 //setTimeout(,1000);
});

document.addEventListener("DOMContentLoaded", function(event) {
	$(document).ready(function(){
		$('#data-table').DataTable()
		 //setTimeout(,1000);
	});
});
</script>

<script>
	<?php include realpath('./').'/themes/default/views/admin/main.js' ?>
</script>
