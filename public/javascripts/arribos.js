$(document).ready(function() {
  $('.gabarras li').tipsy({gravity:'nw',fade:true,html:true,opacity:.9});
  
  $('.gabarras li').click(function() {
  
    var bax_id = $(this).parent('.gabarras').data("bax"),
        url = '/descargar/gabarra/' + bax_id + '/' + $(this).data("gabarra");
    
    $('.dialogo').load(url);
    $('.widget_descarga').delay(3000).draggable();
    $('.dialogo').fadeIn();
    
    return false;
  });
  
;
      
  $('.reportar_arribo').click(function() {
    $(this).removeClass('reportar_arribo');
    $(this).attr('disabled', 'disabled');
    $(this).attr('value', 'Arribo reportado');
        
    Ajax(true, null, "json", false, "POST", 'arribos/reportar/' + $(this).data('bax'));

    return false;
  });
});
