/** 
 *------------------------------------------------------------------------------
 * @package       T3 Framework for Joomla!
 *------------------------------------------------------------------------------
 * @copyright     Copyright (C) 2004-2013 JoomlArt.com. All Rights Reserved.
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 * @authors       JoomlArt, JoomlaBamboo, (contribute to this project at github 
 *                & Google group to become co-author)
 * @Google group: https://groups.google.com/forum/#!forum/t3fw
 * @Link:         http://t3-framework.org 
 *------------------------------------------------------------------------------
 */

 (function($){
    "use strict";
    $(document).ready(function(){
        $(".fancybox").fancybox();
    	$("#portfolio-wrap").owlCarousel({
    		//items
            items: 4,
            itemsTablet: [768,3],
            //navigation & pagination
    		navigation: true,
            pagination: false,
            //Basic Speeds
            slideSpeed : 800,
            paginationSpeed : 800,
            rewindSpeed : 1000,
            //navitions text
            navigationText: ['dd','dd']
    	});
    	$(".itl-clients").owlCarousel({
            //items
            items: 5,
    		responsive: true,
            //navigation & pagination
    		navigation: true,
            pagination: false,
            //Basic Speeds
            slideSpeed : 800,
            paginationSpeed : 800,
            rewindSpeed : 1000,
            //navitions text
            navigationText: ['dd','dd']
    	});
        $('.chart').each(function(){
            var $chart = $(this);
            var $color = $(this).data('color');
            $chart.easyPieChart({
                animate: 2000,
                barColor: $color,
                barColor2: $color,
                lineCap: 'square',
                lineWidth: 20,
                scaleColor: false,
                size: 120,
            });
        });

        $('.tooltips').tooltipster({
            animation: 'fade',
            delay: 200,
            theme: 'tooltipster-light',
        });

        $('#tog-search').click (function(){
            $('.head-search').fadeToggle('vis');
            $('#tog-search').toggleClass('moon-close');
        })
    });
  })(jQuery);