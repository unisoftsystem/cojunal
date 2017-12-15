(function() {

    'use strict';
    var app = new Vue({
        el: '#app-remisiones',

        data: {
            clientes: []
        },
        methods: {
            Clientesvalue: function() {
                var _this = this;
                window.apiService.post('GetCampanasForRemisiones', { idCliente: this.clientes }, function(response) {
                    //if (response[0].length > 0) _this['campanas'] = response[0];
                    console.log(response);
                    _this['clientes'] = response[0];

                    /* else {
                         _this['campanas'] = [];
                         toastr.info('No hay campañas para mostrar.');
                     }*/

                });
            },
            descargar: function(item) {
                var _this = this;
            }
        }
    });

})();

function searchNumberRemission(){
  var app = new Vue({
      el: '#app-remisiones',

      data: {
          clientes: []
      },
      methods: {
          Clientesvalue: function() {
              var _this = this;
              window.apiService.post('GetCampanasForRemisionesNumber', { numberRemission: querySelector('#numberRemission').value }, function(response) {
                  //if (response[0].length > 0) _this['campanas'] = response[0];
                  console.log(response);
                  _this['clientes'] = response[0];

                  /* else {
                       _this['campanas'] = [];
                       toastr.info('No hay campañas para mostrar.');
                   }*/

              });
          },
          descargar: function(item) {
              var _this = this;
          }
      }
  })
}
