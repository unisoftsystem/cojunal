(function (self) {

  self.setIdCampaingModalClienteGraficos = function(id) {
    console.log(id);

    apiService.post('GetCampaingsGrafico', {id: id}, function(resp) {
    	console.log(resp[0]);

    	var d = resp[0];
	    
	    var ctx = document.getElementById("g-campanas");
	    var myChart = new Chart(ctx, {
	    	type: 'bar',
	    	data: {
	    		labels: ["Total campañas", "Total recuperado", "Total asignado", "Número de deudores"],
	    		datasets: [{
	    			label: '# of Votes',
	    			data: [d.cant_campanas, d.cant_recuperada, d.cant_deudores]
	    		}]
	    	}
	    });
    });

  }



})(window);