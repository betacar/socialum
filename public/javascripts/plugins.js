window.log = function(){
  log.history = log.history || [];  
  log.history.push(arguments);
  arguments.callee = arguments.callee.caller;  
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};
(function(b){function c(){}for(var d = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console = window.console||{});

// Almacena la ficha del usuario actual
var ficha = $('#ficha').attr('ficha');

// Ejecuta AJAX calls de diferentes tipos.
function Ajax(asyncBol, datos, tipoData, modificado, tipo, pagina, selectorError) {
  var respuesta = null;
  $.ajax({
    type: tipo, // GET o POST
    async: asyncBol, // Boolean
    url: pagina, // URL
    data: datos, // Data a enviar, en formato: ?uno=1&dos=2&tres=3& ... &N=n
    dataType: tipoData, // Formato de data a recibir: "xml", "json", "html", "script", "jsonp", "text"
    error: function (responseError) { // Funcion a ejecutar si se produce un error.
      $('.error').remove();
      error = eval('('+responseError.responseText+')');      
      errorOut = '<strong>Se han presentado los siguientes errores:</strong>';
      errorOut += '<ul>';
      
      for(i = 0; i < error.length; i++) {
        errorOut += '<li>' + error[i][1] + '</li>';
      }
      
      errorOut += '</ul>';      
      $(selectorError).parent().prepend('<div class="error"><span> </span>' + errorOut + '</div>');
      
      $('.error').delay(5000).fadeOut('slow', function () { $(this).remove() });
    }, 
    ifModified: modificado, // Será success si la respuesta ha modificado desde la última solicitud. Boolean.
    success: function(response) {
      respuesta = response;
    }
  });
    
  return respuesta;
}

// Oculta los botones
jQuery.fn.hideButtons = function() {
  this.parent().children('input[type="submit"], input[type="reset"]').fadeOut();  
  return false;
}

// Modifica el estado_id de la tupla
jQuery.fn.modEstado = function(controller) {
  var id = $(this).closest('td').attr('id'),
      estado_id = $(this).closest('td').attr('estado'),
      desc_estado = 'Inactivo',
      imagen = '<img src="/images/accepted_16.png" alt="" title="Activar" /\>',
      new_estado_id = '2';
  
  // Ejecuto el POST con el estado_id actual para que efectue el cambio
  Ajax(true, null, "json", false, "POST", controller + '/estado/' + id);
  
  // Verifico qué estado_id tiene, y hago cambios en los elementos involucrados
  if(estado_id != 1){
    desc_estado = 'Activo';
    imagen = '<img src="/images/close_16.png" alt="" title="Desactivar" /\>';
    new_estado_id = '1';
  }
  
  // Imprimo los nuevos elementos en la pantalla
  $(this).parent().parent().children('td:first-child').text(desc_estado);
  $(this).closest('td').attr('estado', new_estado_id);
  $(this).children('img').remove();
  $(this).append(imagen);
}

// Serializa un string a JSON
jQuery.fn.serializeJSON = function() {
  var obj = {},
      a = this.serializeArray();
      
  $.each(a, function() {
    if(obj[this.name] !== undefined) {
      if(!obj[this.name].push) {
        obj[this.name] = [obj[this.name]];
      }
      
      obj[this.name].push(this.value || '');
    } else {
      obj[this.name] = this.value || '';
    }
  });
  return obj;
};
