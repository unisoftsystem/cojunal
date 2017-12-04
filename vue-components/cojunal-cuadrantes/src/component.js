(function() {

	document.addEventListener("DOMContentLoaded", function(event) {
		Vue.component('cojunal-cuarantes-component', {
			template: TEMPLATE[''],
			data: function() {
				return {
					cuadrantes: null
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
							_this.cuadrantes = JSON.parse(xhttp.responseText);
						}
					}
				};
				xhttp.open("GET", "http://cojunal.com/plataforma/beta/admin/get_deudores_mora", true);
				xhttp.send();
			}
		});
	});
	
})();