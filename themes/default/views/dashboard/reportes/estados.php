<section class="padding">
	<table class="bordered highlight responsive-table" id="resporte_Estados_tabla">
		<thead>
			<tr>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Campaña</span>
					<input type="text" id="column0_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Nombre</span>
					<input type="text" id="column1_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">CC</span>
					<input type="text" id="column2_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Ciudad</span>
					<input type="text" id="column3_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Departamento</span>
					<input type="text" id="column4_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Teléfono</span>
					<input type="text" id="column5_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Dirección</span>
					<input type="text" id="column6_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Edad de la deuda</span>
					<input type="text" id="column7_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Etapa de la deuda</span>
					<input type="text" id="column8_search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Fecha de la deuda</span>
					<input type="text" id="column9_search" class="input-search"> 
				</th>
			</tr>
		</thead>
		<tbody>
			<?php $url = Yii::app()->baseUrl . '/wallet/search/';?>
			<?php foreach ($stadosAndSaldos as $value): ?>
				<tr>
					<td><?php echo $value->name; ?></td>
					<td><?php echo $value->legalName; ?></td>
					<td><?php echo $value->idNumber; ?></td>
					<td><?php echo $value->ciudad; ?></td>
					<td><?php echo $value->idStatus; ?></td>
					<td><?php echo $value->phone; ?></td>
					<td><?php echo $value->address; ?></td>
					<td><?php echo $value->idStatus; ?></td>
					<td><?php echo $value->idStatus; ?></td>
					<td><?php echo $value->dAssigment; ?></td>
				</tr>
			<?php endforeach ?>
		</tbody>
	</table>
</section>

<script>
	setTimeout(function() {
		$(document).ready(function() {

			var table = $('#resporte_Estados_tabla').DataTable({
				paging: false, 
				info: false,  
				dom: 'Bfrtip',
				buttons: [
            		'copy', 'csv', 'excel', 'pdf', 'print'
        		]
    		});

			[0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map(function(i) {
				$('#column'+i+'_search').on( 'keyup', function () {
					table.columns(i).search(this.value).draw();
				});
			})

		} );
	}, 1000)
</script>