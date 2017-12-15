(function() {

	'use strict';

	Vue.component('graficos-component', {
  		template: '#graficos_component',
  		created: function() {
  			var _this = this;
  			apiService.post('GetCampaingsGrafico', {id: this.id}, function(resp) {
  				_this['campana'] = resp[0];
  				var recaudado = _this['campana']['monto_recuperado'];
  				var service =  (_this['campana']['serviceType'] == 'SERVICIO 1' )
  								? _this['campana']['valueService1']
  								: _this['campana']['valueService2'];

  				var costo = parseFloat(_this['campana']['num_clientes']) * parseFloat(service);
  				var fee = (recaudado * _this['campana']['fee']);
  				var interests = (recaudado * _this['campana']['interests']);
  				var comisions = (recaudado * _this['campana']['comisions']);

  				var costo_campana = recaudado - (fee + interests + comisions);
  				console.log( fee, interests, comisions );
					var total = costo_campana+parseFloat(recaudado);
					var pendiente2 = parseFloat(100*costo_campana/total).toFixed(2);
					var recaudado2 = parseFloat(100*parseFloat(recaudado)/total).toFixed(2);
					console.log('======================');
					console.log(typeof costo_campana);
					console.log(typeof recaudado);
					console.log(total);
					console.log(pendiente2);
					console.log(recaudado2);
					console.log('======================');
  				var ctx = document.getElementById("myChart");
  				var myChart = new Chart(ctx, {
  					type: 'pie',
  					data: {
  						// labels: ["Costo campaña", "Total recaudado"],
  						datasets: [{
  							data: [costo_campana, recaudado],
  							backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)'],
  							borderColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)'],
  							borderWidth: 1
  						}],
  						options: {
  							 scales: {
  							 	xAxes: [{
  							 		display: false
  							 	}]
  							},
  							legend: {
  								display: false
  							},
  							tooltips: {
  								titleFontSize: 200
  							}
  						}
  					}
  				});

  				_this['pendiente2'] = pendiente2+' %';
					_this['recaudado2'] = recaudado2+' %';
					_this['costo'] = costo;
  				_this['recaudado'] = recaudado;
  				_this['costo_campana'] = costo_campana;

  				console.log(costo, _this['campana']['num_clientes'], service);
  				console.log(resp);
  			});
  		},
  		data: function() {
  			return {
  				costo: 0,
  				recaudado: 0,
  				costo_campana: 0,
  				campana: {}
  			}
  		},
			methods: {
				formatPrice(value) {
	        let val = (value/1).toFixed(2).replace('.', ',')
	        return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
	    	}
			},
  		props: ['id']
	});

	var app = new Vue({
		el: '#app-remision1',
		data: {
			showG: false,
			idCampaign: 0,
			campanas: []
		},
		methods: {
			formatPrice(value) {
        let val = (value/1).toFixed(2).replace('.', ',')
        return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
    },
			showGF: function(id) {
				this.showG = true;
				this.idCampaign =  id;
			},
			getData: function(e) {
				var _this = this;
				window.apiService.post('GetCampanasForRemision', {idCampaign: e.target.value}, function(response) {
					if(response[0].length  > 0) _this['campanas'] = response[0];
					else{
						_this['campanas'] = [];
						toastr.info('No hay campañas para mostrar.');
					}
					console.log(response[0]);
				});
			},
			remisionar: function(item) {
				var _this = this;
				var r = confirm('Seguro de realizar la orden de servicio esta cuenta?');
				var data = {
					monto: item.saldoCampana,
        			recaudo: item.recaudado,
        			comision: item.comisions,
        			idCliente: item.IdCampaign,
        			intereses: item.interests,
        			honorarios: item.fee,
        			idPayments: item.idPayments,
        			idWalletByCampaign: item.idWalletByCampaign
				};
				if(r) {
					window.apiService.post('GuardarRemisiones', data, function(response) {
						console.log(response);
						if(response[0] > 0) {
							console.log(response[0]);
							window.open('http://cojunal.com/plataforma/beta/admin/DescargarPdfRemision/' + response[0], '_newtab');
							updateList();
						}else {
							updateList();
						}
						function updateList() {
							_this.getData({target: {value: item.IdCampaign}});
						}
					});
				}
				// console.log(item, _this.getData({target: {value: 72}}));
			}
		}
	});

})();
