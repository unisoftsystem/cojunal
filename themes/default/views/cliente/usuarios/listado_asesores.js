(function () {

  'use strict';

  /**
   * [setCoordinador description]
   * @param {[type]} idAdviser     [description]
   * @param {[type]} parentAdviser [description]
   */
  window.setCoordinador = function(idAdviser, parentAdviser) {
    var r = confirm("Continuar operación?");
    if(r) {
      var msgError = 'Lo sentimos no fue posible procesar tu solicitud';
      var id = $(idAdviser).val();
      if(!id || !idAdviser) {
        window.alert(msgError);
      }else {
        var data = {parentAdviser: id, idAdviser:parentAdviser};
        window.apiService.post('setParentAdviser', data, function(response) {
          window.location.reload();
        });
      }
    }
  }

})();