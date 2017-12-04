function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

(function() {

    'use strict';



    var app = new Vue({
        el: '#app-busca_clientes',

        data: {
            buscar_cliente: []
        },
        components: {
            infotabla: {
                props: ['buscar_cliente'],
                template: '#info-busqueda'
            }
        },
        methods: {
            busqueda: function() {

                // var _this = this;
                if (this['buscar_cliente'].length > 3) {
                    console.log(this['buscar_cliente'])
                    var html = ""
                    window.apiService.post('GetSearchClientes', { busqueda: this['buscar_cliente'] }, function(response) {
                        // console.log(JSON.stringify(response[0]))
                        //var data = JSON.stringify(response[0]);
                        //jQuery.each(arr, function(item, val) {
                        $.each(response[0], function(key, item) {
                            html += '<tr>';
                            html += '<td class="txt_center">' + item.name + ' </td>';
                            html += '<td class="txt_center">' + item.contactEmail + ' </td>';
                            html += '<td class="txt_center">' + item.fCreacion + ' </td>';
                            html += '<td class="txt_center">' + item.numCampanas + '</td>';
                            html += '<td class="txt_center">' + addCommas(parseInt(item.sumHonorarios)) + '</td>';
                            html += '<td class="txt_center">' + addCommas(parseInt(item.sumintereses)) + '</td>';
                            html += '<td class="txt_center">' + addCommas(parseInt(item.percentageCommission)) + '</td>';
                            html += '<td class="txt_center">' + addCommas(parseInt(item.saldoAsignado)) + '</td>';
                            html += '<td class="txt_center">' + addCommas(parseInt(item.totalRecuperado)) + '</td>';

                        })

                        $('#info-busqueda').html(html);
                        console.log(response);

                    })
                }


            }

        }
    });

})();