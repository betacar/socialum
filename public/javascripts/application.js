// Configuración básica de jQuery para Rails
$.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$.fn.enviarAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
}


$(document).ready(function() {
  // 960 GS bookmark
  var gOverride = {
    urlBase: 'http://gridder.andreehansson.se/releases/latest/',
    gColor: '#ff0000',
    gColumns: 24,
    gOpacity: 0.5,
    gWidth: 5,
    pColor: '#C0C0C0',
    pHeight: 10,
    pOffset: 0,
    pOpacity: 0.55,
    center: true,
    gEnabled: true,
    pEnabled: true,
    setupEnabled: true,
    fixFlash: false,
    size: 960
  };
  
  // Capturador de evento clic para
  // ocultar las notificaciones
  $('div.exito span, div.advertencia span, div.info span, div.error span').click(function() {
    $(this).parent().animate({
      opacity: 'toggle'
    }, 'fast');
  });
  
  // Agrega, luego de hacer click en el link NEW, 
  // una nueva fila a la tabla adyacente
  $('a[href*="#new"]').click(function() {
    $('.wrapper input[type="submit"].oculto').fadeIn();
    
    // Remueve, luego de hacer click en el link DELETE, 
    // la nueva fila de la tabla. Solo cuando se agrega 
    // la fila nueva, ya que no existe cuando se carga el DOM 
    $('a[href*="#delete"]').click(function() {
      $(this).closest('tr').fadeOut('normal', function(){
        $(this).remove();        
      });
    });
  });
  
  $('a[href*="#edit"]').click(function() {
    console.log('I\'m in! =D');
  });
});
