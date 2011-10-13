$(document).ready(function() {
  var status = { // Estados de gabarras
        boton: { // Para data-status en el submit
          atraque: 'atraque',
          inicio_descarga: 'inicio_descarga',
          fin_descarga: 'fin_descarga',
          desatraque: 'desatraque',
          submit: 'subir'
        },
        label: { // Como etiqueta para el submit
          send: 'Enviar',
          hold: 'Por favor espere',
          stop: 'Gabarra procesada',
          reportar: 'Reportar arribo',
          reportado: 'Arribo reportado'
        },
        img: { // Para imÃ¡genes de gabarra
          en_espera: '/images/clock_red.png',
          atraque: '/images/anchor.png',
          descarga: '/images/arrow_rotate_clockwise.png',
          vacia: '/images/tick.png',
          desatraque: '/images/flag_finish.png'
        }
      },
      buque_id = 0,
      formato_datetime = 'd/M/yyyy H:mm', // Formato default para fechas, para usar con la librería de fechas.
      formato_date = 'd/m/yyyy';
  
  // Control de tabulador de bauxita y buques
  $('.remolcadores, .importaciones').click(function(){
    if ($(this).hasClass('remolcadores')) {
      if ($('article.bauxita').hasClass('oculto')) {
        $('article.bauxita').removeClass('oculto');
        $('article.buques').addClass('oculto');
      }
    } else if ($(this).hasClass('importaciones')) {
      if ($('article.buques').hasClass('oculto')) {
        $('article.bauxita').addClass('oculto');
        $('article.buques').removeClass('oculto');
      }
    }
    return false;
  });

  // Control para reportar el arribo de un tren 
  $('.reportar_arribo_bax').click(function() {
    var bax = $(this).data('bax'),
        esteban = $(this), // Este boton (es para no perder el selector en el $.post =P)
        id = '#bax_' + bax.split('/')[0] + '_' + bax.split('/')[1], // Armo el selector del BAX
        fecha_arribo = new Date();
    
    esteban.attr('disabled', 'disabled');
    esteban.addClass('hold');
    esteban.val(status.label.hold);
        
    $.post('arribos/reportar/' + bax, null, function(){
      $(esteban, id).removeClass('reportar_arribo');
      $(esteban, id).attr('value', status.label.reportado);

      $('small.eta_bax_title', id).text('arribo matanzas (m-201):');
      $('small.eta_bax_title', id).removeClass('eta_bax_title');
      $('time.eta_bax_date', id).attr('datetime', formatDate(fecha_arribo, 'yyyy-MM-dd HH:mm:ss -0430'));
      $('time.eta_bax_date', id).text(formatDate(fecha_arribo, 'dd/NNN./yyyy ~ HH:mm'));
      $('time.eta_bax_date', id).addClass('azul fecha_arribo').removeClass('eta_bax_date');

      $('ul.gabarras li', id).each(function() {
        $(this).removeAttr('class');
        $(this).children('img').attr('src', status.img.en_espera);
      });
    }).error(function(error) {
      $(esteban, id).removeAttr('disabled');
      $(esteban, id).val(status.label.reportar);
    });

    esteban.removeClass('hold');

    return false;
  });

  $('h3.down').click(function() {
    var url = $(this).data('bax-url');
    $(this).next('ul.gabarras').load(url, function() {
      $('.gabarras li').tipsy({gravity:'nw',fade:true,html:true,opacity:0.9});
    });
  });

  $('.gabarras li.deshabilitada a').live('click', function() {
    return false;
  });
  
  //
  $('.gabarras li:not(.deshabilitada)').live('click', function() {
    var bax_id = $(this).parent('.gabarras').data("bax-id"),
        gabarra_id = $(this).data("gabarra-id"),
        bax = bax_id.split("/"),
        gabarra = gabarra_id.split("-"),
        widget_id = bax[0] + '_' + bax[1] + '_' + gabarra[0] + '_' + gabarra[1],
        url_arribo = $(this).find('a').attr('href'),
        descarga = {},
        evento = {},
        arribo = $('time.fecha_arribo', '#bax_' + bax[0] + '_' + bax[1]).attr('datetime');

    $('#dialogo').append(
      $('<div class="widget_descarga" id="' + widget_id + '"><div class="centro"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /><p>Cargando, por favor espere...</p></div></div>').load(url_arribo, function() {
        
        var date = '',
            patron = /(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})\s-\d{4}/g; // Expresion regular para matchear la fecha en formato datetime
        
        $('h2', this).parent('div').draggable();

        // Transformo la fecha de arribo en un objeto fecha
        date = patron.exec(arribo); // Separo el string en forma de array, segÃºn el patron
        date.shift(); // Elimino el primer elemento del array (string de arribo)
        date = new Date(date[0], date[1] - 1, date[2], date[3], date[4], date[5]); // Armo el objeto fecha con los datos de aÃ±o, mes, dia, hora, minutos y segundos

        // Control para 'observar' los cambios en los campos de fecha y hora de atraque, inicio de descarga, fin de descarga y desatraque
        $('input[name^="fecha_"], input[name^="hora_"]', this).change(function() {
          var campo = $(this);

          if(campo.is('[name^="fecha_"]')) { // Si el valor del atributo name del campo comienza por fecha, entonces es fecha.
            if (campo.val() === '' || !isDate(campo.val(), formato_date)) {
              campo.addClass('hasError'); // Imprimimos el error en la ventana de descarga
              error_dialogo_descarga('La fecha no puede ser vacía o no cumple el formato requerido (dd/mm/aaaa).', widget_id);
            } else if (campo.is('[name="fecha_atraque"]')) { // Si es atraque
              validar_campo_fecha(campo,  formatDate(date, 'dd/MM/yyyy'), 'La fecha de atraque no puede ser menor a la fecha de arribo del BAX (' + formatDate(date, 'dd/MM/yyyy') + ').', widget_id);
            } else if (campo.is('[name="fecha_inicio_descarga"]')) { // Si inicio de descarga
              validar_campo_fecha(campo,  $('input[name="fecha_atraque"]', '#' + widget_id).val(), 'La fecha de inicio de descarga no puede ser menor a la fecha de atraque (' + $('input[name="fecha_atraque"]', '#' + widget_id).val() + ').', widget_id);
            } else if (campo.is('[name="fecha_fin_descarga"]')) { // Si es fin de descarga
              validar_campo_fecha(campo,  $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val(), 'La fecha de fin de descarga no puede ser menor a la fecha de inicio de descarga (' + $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ').', widget_id);
            } else if (campo.is('[name="fecha_desatraque"]')) { // Si es desatraque
              validar_campo_fecha(campo, $('input[name="fecha_fin_descarga"]', '#' + widget_id).val(), 'La fecha de desatraque de gabarra no puede ser menor a la fecha de fin de descarga (' + $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ').', widget_id);
            }
          } else if (campo.is('[name^="hora_"]')) { // Sino, es hora
            // Las validaciones de hora se hacen uniendo la fecha y la hora. 
            // No es posible validar una hora sin fecha.
            if (!isDate(campo.val(), 'H:mm')) {
              campo.addClass('hasError');
              error_dialogo_descarga('La hora no puede ser vacía o no cumple el formato militar requerido (HH:MM).', widget_id);
            } else if (campo.is('[name="hora_atraque"]')) { // Si es hora de atraque
              validar_campo_hora(campo, formatDate(date, 'dd/MM/yyyy HH:mm'), 'La hora de atraque no puede ser menor o igual a la hora de arribo del BAX (' + formatDate(date, 'HH:mm') + ').', widget_id, false); 
            } else if (campo.is('[name="hora_inicio_descarga"]')) { // Si es inicio de descarga
              validar_campo_hora(campo, $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(), 'La hora de inicio de descarga no puede ser menor o igual a la hora de atraque (' + $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val() + ').', widget_id, status.boton.inicio_descarga); 
            } else if (campo.is('[name="hora_fin_descarga"]')) { // Si es fin de descarga
              validar_campo_hora(campo, $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(), 'La hora de fin de descarga no puede ser menor o igual a la hora de inicio de descarga (' + $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val() + ').', widget_id, status.boton.fin_descarga); 
            } else if (campo.is('[name="hora_desatraque"]')) { // Si es desatraque
              validar_campo_hora(campo, $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(), 'La hora de fin de descarga no puede ser menor o igual a la hora de inicio de descarga (' + $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val() + ').', widget_id, status.boton.desatraque); 
            }
          }
        });

        $('input[name="submit_campo"]', this).live('click', function() {
          var este = $(this), // Selector del boton
              url = este.parent().parent().attr('action'); // URL de descarga de gabarra

          descarga = {
            equipo_id: $('select[name="equipo_id"]', '#' + widget_id).val(),
            atraque: $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(),
            inicio_descarga: $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(),
            fin_descarga: $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(),
            desatraque: $('input[name="fecha_desatraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_desatraque"]', '#' + widget_id).val()
          };
          
          // Deshabilito el boton, para evitar mÃ¡s clicks
          este.attr('disabled', 'disabled');
          este.addClass('hold');
          este.val(status.label.hold);

          $.post(url, descarga, function(data) {

            $('h3, h3+div', '#' + widget_id).fadeIn();

            if (!$('.historial_eventos', '#' + widget_id).data('descarga-id')) $('.historial_eventos', '#' + widget_id).data('descarga-id', data.descarga_bauxita.id);

            switch($(este, '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $('h3, h3+div', '#' + widget_id).fadeIn();
                $(este, '#' + widget_id).data('status', status.boton.inicio_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.atraque);
                break;
              case status.boton.inicio_descarga:
                $(este, '#' + widget_id).data('status', status.boton.fin_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.descarga);
                break;
              case status.boton.fin_descarga:
                $(este, '#' + widget_id).data('status', status.boton.desatraque);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.vacia);
                break;
              case status.boton.desatraque:
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.desatraque);
                $('#gabarra_' + widget_id).addClass('deshabilitada');
                $('#gabarra_' + widget_id).die('click');
                break;
              default:
                console.log('¡Epa! No debería caer acá¡. Este es el estatus: ' + $(this).data('status'));
                break;
            }

            if (data.descarga_bauxita.desatraque_descarga_bauxita) {
              $('input[name^="fecha_"], input[name^="hora_"], input[name="submit_campo"]', '#' + widget_id).attr('disabled', 'disabled');
              $(este, '#' + widget_id).val(status.label.stop);
              $(este, '#' + widget_id).removeClass('hold');
            } else {
              $(este, '#' + widget_id).val(status.label.send);
              $(este, '#' + widget_id).removeAttr('disabled');
              $(este, '#' + widget_id).removeClass('hold');
            }

            $('.exito', '#' + widget_id).children('p').text('Se han cargado los datos correctamente.');

            if ($('.exito', '#' + widget_id).hasClass('oculto')) {
              $('.exito', '#' + widget_id).fadeIn();
              $('.exito', '#' + widget_id).delay(7000).fadeOut();
            }

          }).error(function(error) {
            $(este, '#' + widget_id).val(status.label.send);
            $(este, '#' + widget_id).removeAttr('disabled');
            $(este, '#' + widget_id).removeClass('hold');
              
            // Imprimimos el error en la ventana de descarga
            error_dialogo_descarga(error.responseText, widget_id);            
          });

          return false;
        }); // Enviar fechas y horas

        $('form.evento input[name="submit_acaecimiento"]', this).live('click', function() {
          var url = 'descargar/evento/' + $('.historial_eventos', '#' + widget_id).data('descarga-id');

          $('input[name="submit_acaecimiento"]', 'form.evento').attr('disabled', 'disabled');
          $('input[name="submit_acaecimiento"]', 'form.evento').addClass('hold');
          $('input[name="submit_acaecimiento"]', 'form.evento').val(status.label.hold);

          evento = {
            inicio_novedad: $('input[name="fecha_inicio_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_acaecimiento"]', '#' + widget_id).val(),
            fin_novedad: $('input[name="fecha_fin_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_acaecimiento"]', '#' + widget_id).val(),
            desc_novedad: $('textarea[name="observacion_acaecimiento"]', '#' + widget_id).val()
          };

          $.post(url, evento, function(data) {
            $('[name$="_acaecimiento"]', '#' + widget_id).val(''); // Reseteo los valores de los campos.
            $('.historial_eventos', '#' + widget_id).append('<p class="margen_b_10">' + data.descripcion + '</p><small><span class="rojo">' + data.inicio + ' - ' + data.fin + '</span>Â Â |Â Â ' + data.login + '</small><hr />');
          });

          $('input[name="submit_acaecimiento"]', '#' + widget_id).removeAttr('disabled');
          $('input[name="submit_acaecimiento"]', '#' + widget_id).removeClass('hold');
          $('input[name="submit_acaecimiento"]', '#' + widget_id).val(status.label.send);

          return false;
        }); // Enviar novedades
        
      return false;
    }));

    return false;
  });

  /* ------------------------------ BUQUES ------------------------------ */
  // EdiciÃ³n o desactivaciÃ³n de buques
  $('.edit, .destroy').click(function() {
    var boton = $(this);
    buque_id = boton.data('buque-id');

    if ($(this).hasClass('edit')) {
      window.location = '/buques/' + buque_id + '/edit';
    } else {
      if (confirm('Â¿Realmente desea cambiar el estado del buque?')) {
          boton.attr('disabled', 'disabled');
          boton.addClass('hold');
          boton.val(status.label.hold);
          boton.removeClass('cancel blue');

        $.get('/buques/destroy/' + buque_id, null, function(data){
          console.log(data);
          boton.removeAttr('disabled');
          boton.removeClass('hold');
          if (!data.buque.activo){
            boton.val('Activar buque');
            boton.addClass('blue');
          } else {
            boton.val('Desactivar buque');
            boton.addClass('cancel');
          }
        }, 'json');
      }
    }

    return false;
  });

  // AdiciÃ³n de buque
  $('.add_buque').click(function(){
    window.location = '/buques/new';
  });

  // Reporte de arribo de buque
  $('.reportar_arribo_buque').click(function() {
    var boton = $(this),
        selector_id = $(this).parent().parent().attr('id'),
        buque_id = boton.data('buque-id'),
        id = '#buque_' + boton.data('buque-id'),
        fecha_arribo = new Date();

    boton.attr('disabled', 'disabled');
    boton.addClass('hold');
    boton.val(status.label.hold);

    $.get('/buques/reportar/' + buque_id, null, function(data){
      boton.fadeOut().remove();
      $('.descargar_buque', '#' + selector_id).delay(300).fadeIn();

      $('small.eta_buque_title', id).text('arribo matanzas (m-201):');
      $('small.eta_buque_title', id).removeClass('eta_bax_title');
      $('time.eta_buque_date', id).attr('datetime', formatDate(fecha_arribo, 'yyyy-MM-dd HH:mm:ss -0430'));
      $('time.eta_buque_date', id).text(formatDate(fecha_arribo, 'dd/NNN./yyyy ~ HH:mm'));
      $('time.eta_buque_date', id).addClass('azul').removeClass('eta_bax_date');

    }, 'json');

    return false;
  });

  $('.descargar_buque').click(function(){
    var buque_id = $(this).data('buque-id'),
        widget_id = 'buque_' + $(this).data('buque-id');
    $('#dialogo').append($('<div class="widget_descarga" id="' + widget_id + '"><div class="centro"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /><p>Cargando, por favor espere...</p></div></div>').load('/arribos/buque/' + buque_id, function(){
      $('h2', '#' + widget_id).parent('div').draggable();
    }));

    return false;
  });
});

function error_dialogo_descarga(string, widget_id) {
  $('.error', '#' + widget_id).children('p').text(string);

  if ($('.error', '#' + widget_id).hasClass('oculto')) {
    $('.error', '#' + widget_id).fadeIn();
    $('.error', '#' + widget_id).delay(10000).fadeOut();
  }

  return false;
}

function validar_campo_fecha(field, previous, string_error, widget_id) {
  if (compareDates(previous, 'd/m/yyyy', field.val(), 'd/m/yyyy') == 1) {
    field.addClass('hasError');
    error_dialogo_descarga(string_error, widget_id);

    if ($('input.hasError', '#' + widget_id).size()) {
      $('input[name="submit_campo"]', '#' + widget_id).attr('disabled', 'disabled');
    }
  } else {
    if (field.hasClass('hasError')) field.removeClass('hasError');

    if (!$('.error', '#' + widget_id).hasClass('oculto')) $('.error', '#' + widget_id).fadeOut();

    if (!$('input.hasError', '#' + widget_id).size()) {
      $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
    }
  }
  return false;
}

function validar_campo_hora(field, previous, string_error, widget_id, status) {
  status = typeof status !== 'undefined' ? status : null;
  var date = $('input[name="' + field.attr('name').replace('hora_', 'fecha_') + '"]', '#' + widget_id).val();

  if (compareDates(date + ' ' + field.val(), 'd/m/yyyy H:mm', previous, 'd/m/yyyy H:mm') != 1) {
    field.addClass('hasError');
    error_dialogo_descarga(string_error, widget_id);

    if ($('input.hasError', '#' + widget_id).size()) {
      $('input[name="submit_campo"]', '#' + widget_id).attr('disabled', 'disabled');
    }
  } else {
    if (field.hasClass('hasError')) field.removeClass('hasError');
    if (!$('.error', '#' + widget_id).hasClass('oculto')) $('.error', '#' + widget_id).fadeOut();
    if (status) $('input[name="submit_campo"]', '#' + widget_id).data('status', status); // Seteo un nuevo status al boton.

    if (!$('input.hasError', '#' + widget_id).size()) {
      $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
    }
  }
  return false;
}