<section class="padding">
	<table class="bordered highlight responsive-table" id="resporte_Saldos_tabla">
		<thead>
			<tr>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Campaña</span>
					<input type="text" id="column0__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Nombre</span>
					<input type="text" id="column1__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">CC</span>
					<input type="text" id="column2__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Ciudad</span>
					<input type="text" id="column3__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Departamento</span>
					<input type="text" id="column4__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Teléfono</span>
					<input type="text" id="column5__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Dirección</span>
					<input type="text" id="column6__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Recaudo</span>
					<input type="text" id="column7__search" class="input-search"> 
				</th>
				<th class="txt_center formweb elipsis">
					<span class="b-title">Saldo a recaudar</span>
					<input type="text" id="column8__search" class="input-search"> 
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
					<td><?php echo $value->valueAssigment - $value->saldo; ?></td>
					<td><?php echo $value->saldo; ?></td>
				</tr>
			<?php endforeach ?>
		</tbody>
	</table>
</section>

<script>
	setTimeout(function() {
		$(document).ready(function() {
			
			var table  = $('#resporte_Saldos_tabla').DataTable({
				paging: false, 
				info: false,  
				dom: 'Bfrtip',
				buttons: [
            		'copy', 'csv', 'excel', 'pdf', 'print'
        		]
    		});

			[0, 1, 2, 3, 4, 5, 6, 7, 8].map(function(i) {
				$('#column'+i+'__search').on( 'keyup', function () {
					table.columns(i).search(this.value).draw();
				});
			})

		} );
	}, 1000)
</script>