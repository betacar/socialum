window.log = function(){
  log.history = log.history || [];  
  log.history.push(arguments);
  arguments.callee = arguments.callee.caller;  
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};
(function(b){function c(){}for(var d = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console = window.console||{});

// Almacena la ficha del usuario actual
var ficha = $('#ficha').data('ficha'),
    item = $('#menu li:not(.activo)');

// Permite hacer que un elemento "li" del menu redirija a su href hijo, sin tener que hacer click sobre "a"
item.click(function() {
  var link = $(this).find('a').attr('href');
  if (link) window.location = link;
  
  return false;
}); 

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
      $(selectorError).parent().prepend('<div class="error"><span class="cerrar"> </span>' + errorOut + '</div>');
      
      $('.error').delay(10000).fadeOut('slow', function () { $(this).remove() });
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

// Remueve una fila de una tabla
jQuery.fn.removeFila = function() {
  this.closest('tr').fadeOut('normal', function() {
    $(this).remove();
  });
}

// Remueve el conjunto de filas de una tabla, si el campo de texto está vacío
jQuery.fn.removeNuevos = function(nuevo) {
  if ($(nuevo).children('input[type="text"]').val() == null) {
    $(nuevo).fadeOut('normal', function() {
      $(this).remove();
    });
  }
}

// Modifica el estado de la tupla
jQuery.fn.modEstado = function(controller) {
  var id = $(this).closest('td').attr('id'),
      estado = $(this).closest('td').attr('estado'),
      desc_estado = 'Inactivo',
      imagen = '<img src="/images/accepted_16.png" alt="" title="Activar" /\>',
      new_estado = 'false';
  
  // Ejecuto el POST con el estado_id actual para que efectue el cambio
  Ajax(true, null, "json", false, "POST", controller + '/estado/' + id);
  
  // Verifico qué estado_id tiene, y hago cambios en los elementos involucrados
  if(estado != 'true'){
    desc_estado = 'Activo';
    imagen = '<img src="/images/close_16.png" alt="" title="Desactivar" /\>';
    new_estado = 'true';
  }
  
  // Imprimo los nuevos elementos en la pantalla
  $(this).parent().parent().children('td:first-child').text(desc_estado);
  $(this).closest('td').attr('estado', new_estado);
  $(this).children('img').remove();
  $(this).append(imagen);
}

// Oculta y elimina del DOM el elemento padre del boton
jQuery.fn.cierra = function(elimina) {
  this.parent().fadeOut(function() {
    if (elimina) {
      $(this).remove();
    }
  });

  this.die('click');
};

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

