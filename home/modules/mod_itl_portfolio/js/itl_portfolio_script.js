(function($){
    "use strict";
    $(document).ready(function(){
    	$("#portfolio-wrap").owlCarousel({
    		//items
            items: 4,
    		responsive: true,
            //navigation & pagination
    		navigation: true,
            pagination: false,
            //Basic Speeds
            slideSpeed : 800,
            paginationSpeed : 800,
            rewindSpeed : 1000,
            //navitions text
            navigationText: ['<','>']
    	});
    });
  })(jQuery);