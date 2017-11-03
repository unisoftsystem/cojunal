(function () {

	'use strict';

	/**
	 * [apiService description]
	 * @type {Object}
	 */
	window.apiService = {
		post: function(endPoint, data, callback) {
			$.ajax({
				type: "POST",
				url: endPoint,
				data: data,
				success: callback,
				dataType: 'json'
			});
		}
	}

	/**
	 * [enableOrDisableadviser description]
	 * @param  {[type]} input     [description]
	 * @param  {[type]} idAdviser [description]
	 * @return {[type]}           [description]
	 */
	window.enableOrDisableadviser = function(input, idAdviser) {
		var r = confirm("Continuar operación?");
    	if(r) {
			var msgError = 'Lo sentimos no fue posible procesar tu solicitud';
			if(!input || !idAdviser) {
				window.alert(msgError);
			}else {
				var active = $(input).val();
				var data = {idAdviser: idAdviser, active: active};
				window.apiService.post('enableDisableAdvisers', data, function(response) {
					window.location.reload();
				});
			}
    	}
	}

})();