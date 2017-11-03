(function() {

	'use strict';

	window.showCampaignList = function(input) {
		var idCampaign = $(input).val();
		if(idCampaign) getData(idCampaign)

		function getData(idCampaign) {
			window.apiService.post('getCampaignByClient', {idCampaign: idCampaign}, function(response) {
				console.log(response);
			});
		}

	}
})();