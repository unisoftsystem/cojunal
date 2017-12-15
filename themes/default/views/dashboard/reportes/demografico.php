<style>
	#myChart {
		/*width: 400px !important;
		height: 400px !important;
		margin: auto; */
	}
</style>	

<section class="padding">
	
	<canvas id="myChart" width="100" height="100"></canvas>

</section>

<script>

var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'pie',
    data: {
    	datasets: [{
    	    data: [
    	    	parseInt('<?php echo $quadrants['q1']['value'] ?>'.replace('$', '').replace(',', '')),	
    	    	parseInt('<?php echo $quadrants['q2']['value'] ?>'.replace('$', '').replace(',', '')),	
    	    	parseInt('<?php echo $quadrants['q3']['value'] ?>'.replace('$', '').replace(',', '')),	
    	    	parseInt('<?php echo $quadrants['q4']['value'] ?>'.replace('$', '').replace(',', '')),	
    	    ],
		    backgroundColor: [
		        '#f5a623',
		        '#193153',
		        '#134695',
		        '#09ca69'
		    ]
	    }],
	    labels: [
	        '<?php echo $quadrants['q1']['days'] . " días" ; ?>',
	        '<?php echo $quadrants['q2']['days'] . " días" ; ?>',
	        '<?php echo $quadrants['q3']['days'] . " días" ; ?>',
	        '<?php echo $quadrants['q4']['days'] . " días" ; ?>'
	    ],
    }
});

</script>