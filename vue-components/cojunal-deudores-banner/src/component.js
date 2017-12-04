(function() {

	document.addEventListener("DOMContentLoaded", function(event) {
		Vue.component('cojunal-deudores-banner', {
			template: cojunalDeudoresBannerTemplate[''],
			data: function() {
				return {
					data: {
						cantidad_deudores: 0,
						porcentaje_recuperacion: 0
					}
				}				
			},
			methods: {
				verified: function(num) {
					return parseFloat(num);
				}
			},
			created: function() {
				var _this = this;
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						if(JSON.parse(xhttp.responseText)) {
							_this.data = JSON.parse(xhttp.responseText);
							console.log(_this.data);
						}
					}
				};
				xhttp.open("GET", "http://cojunal.com/plataforma/beta/admin/get_deudores_cartera", true);
				xhttp.send();
			}
		});
	});
	
})();