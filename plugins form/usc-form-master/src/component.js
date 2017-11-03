(function() {

	document.addEventListener("DOMContentLoaded", function(event) {
		Vue.component('component-name', {
			template: TEMPLATE[''],
			props: [ 'dataSource', 'endPoint' ],
			methods: {
				sendForm: function(e) {
					event.preventDefault();
					alert('...');
				}
			}
		});
	});
	
})();