$(document).ready(function() {
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
  $("div.exito span, div.advertencia span, div.info span, div.error span").click(function() {
      $(this).parent().animate({
          opacity: 'toggle'
      }, 'fast');
  });
});
