$(document).ready(function() {
  var status = {
        boton: {
          atraque: 'atraque',
          inicio_descarga: 'inicio_descarga',
          fin_descarga: 'fin_descarga',
          desatraque: 'desatraque',
          submit: 'subir'
        },
        label: {
          hold: 'Por favor espere',
          atraque: 'Enviar atraque',
          inicio_descarga: 'Enviar inicio de descarga',
          fin_descarga: 'Enviar fin de descarga',
          desatraque: 'Enviar desatraque',
          submit: 'Enviar',
          stop: 'Gabarra procesada',
          reportar: 'Reportar arribo',
          reportado: 'Arribo reportado'
        },
        img: {
          en_espera: '/images/clock_red.png',
          atraque: '/images/anchor.png',
          descarga: '/images/arrow_rotate_clockwise.png',
          vacia: '/images/tick.png',
          desatraque: '/images/flag_finish.png'
        }
      },
      buque_id = 0,
      formato = 'd/M/yyyy H:mm';
  
  $('#dialogo').height($(window).height());
  $('#dialogo').width($(window).width());
  
  $('.reportar_arribo').click(function() {
    var bax = $(this).data('bax'),
        esteban = $(this),
        id = '#bax_' + bax.split('/')[0] + '_' + bax.split('/')[1];
    
    $(esteban).attr('disabled', 'disabled');
    $(esteban).addClass('hold');
    $(esteban).val(status.label.hold);
        
    $.post('arribos/reportar/' + bax, null, function(){
      $(esteban, id).removeClass('reportar_arribo');
      $(esteban, id).attr('value', status.label.reportado);

      $('ul.gabarras li', id).each(function() {
        $(this).removeAttr('class');
        $(this).children('img').attr('src', status.img.en_espera);
      });
    }).error(function(error) {
      $(esteban, id).removeAttr('disabled');
      $(esteban, id).val(status.label.reportar);
    });

    $(esteban).removeClass('hold');

    return false;
  });
  
  $('.gabarras li').tipsy({gravity:'nw',fade:true,html:true,opacity:.9});

  $('.gabarras li:not(.deshabilitada)').live('click', function() {
    var bax_id = $(this).parent('.gabarras').data("bax"),
        gabarra_id = $(this).data("gabarra"),
        bax = bax_id.split("/"),
        gabarra = gabarra_id.split("-"),
        widget_id = bax[0] + '_' + bax[1] + '_' + gabarra[0] + '_' + gabarra[1],
        url_arribo = 'arribos/gabarra/' + bax_id + '/' + gabarra_id,
        url_descarga = 'descargar/gabarra/' + bax_id + '/' + gabarra_id,
        descarga = {},
        evento = {};

    $('#dialogo').append(
      $('<div class="widget_descarga grid_10" id="' + widget_id + '"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /></div>').load(url_arribo, function() {
        $('h2', '#' + widget_id).parent('div').draggable();

        $('input[name="submit_campo"]', this).live('click', function() {

          var arribo = $('input[name="fecha_atraque"]', '#' + widget_id).parent().data('arribo'),
              atraque = $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(),
              inicio_descarga = $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(),
              fin_descarga = $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(),
              desatraque = $('input[name="fecha_desatraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_desatraque"]', '#' + widget_id).val(),
              date = '';
          
          // Transformo la fecha de arribo en un objeto fecha
          date = arribo.split('-');
          date[2] = date[2].split(' ');
          date[2][1] = date[2][1].split(':');
          date = new Date(date[0], date[1], date[2][0], date[2][1][0], date[2][1][1], date[2][1][2]);

          $(this).attr('disabled', 'disabled');
          $(this).addClass('hold');
          $(this).val(status.label.hold);

          descarga = {
            equipo_id: $('select[name="equipo_id"]', '#' + widget_id).val(),
            atraque_descarga_bauxita: atraque,
            inicio_descarga_bauxita: inicio_descarga,
            fin_descarga_bauxita: fin_descarga,
            desatraque_descarga_bauxita: desatraque
          }

          switch($(this).data('status')) {
            case status.boton.atraque:
              if (atraque == null || !isDate(atraque, formato)) {
                alert('La fecha y/u hora de atraque no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.atraque);
                return false;
              } else if (compareDates(atraque, formato, arribo, 'yyyy-MM-dd HH:mm:ss') != 1) {
                alert('La fecha y/u hora de atraque no puede ser menor a la fecha de arribo del buque (' + formatDate(date, 'dd/MM/yyyy HH:mm') + ').');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.atraque);
                return false;
              } else descarga.inicio_descarga_bauxita = descarga.fin_descarga_bauxita = descarga.desatraque_descarga_bauxita = null;
              break;
            case status.boton.inicio_descarga:              
              if (inicio_descarga == null || !isDate(inicio_descarga, formato)) {
                alert('La fecha y/u hora de inicio de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.inicio_descarga);
                return false;
              } else if (compareDates(inicio_descarga, formato, atraque, formato) != 1) {
                alert('La fecha y/u hora de inicio de descarga no puede ser menor a la fecha de atraque (' + atraque + ').');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.inicio_descarga);
                return false;
              } else descarga.fin_descarga_bauxita = descarga.desatraque_descarga_bauxita = null;
              break;
            case status.boton.fin_descarga:              
              if (fin_descarga == null || !isDate(fin_descarga, formato)) {
                alert('La fecha y/u hora de fin de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.fin_descarga);
                return false;
              } else if (compareDates(fin_descarga, formato, inicio_descarga, formato) != 1) {
                alert('La fecha y/u hora de fin de descarga no puede ser menor a la fecha de inicio de descarga (' + inicio_descarga + ').');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.fin_descarga);
                return false;
              } else descarga.desatraque_descarga_bauxita = null;
              break;
            case status.boton.desatraque:
              if (desatraque == null || !isDate(desatraque, formato)) {
                alert('La fecha y/u hora de fin de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.desatraque);
                return false;
              } else if (compareDates(desatraque, formato, fin_descarga, formato) != 1) {
                alert('La fecha y/u hora de fin de descarga no puede ser menor a la fecha de inicio de descarga (' + fin_descarga + ').');
                $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');
                $(this).val(status.label.desatraque);
                return false;
              }
              break;
            default:
              console.log('Estatus antes del $.post: ' + $(this).data('status'));
              break;
          }

          $.post(url_descarga, descarga, function(data) {

            $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
            $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');

            switch($('input[name="submit_campo"]', '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $('input[name="fecha_inicio_descarga"], input[name="hora_inicio_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('form.evento', '#' + widget_id).data('descarga-id', data.descarga_bauxita.id);
                $('h3, h3+div', '#' + widget_id).fadeIn();
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.boton.inicio_descarga);
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.inicio_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.atraque);
                break;
              case status.boton.inicio_descarga:
                $('input[name="fecha_fin_descarga"], input[name="hora_fin_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.boton.fin_descarga);
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.fin_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.descarga);
                break;
              case status.boton.fin_descarga:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.boton.desatraque);
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.desatraque);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.vacia);
                break;
              case status.boton.desatraque:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.desatraque);
                $('#gabarra_' + widget_id).addClass('deshabilitada');
                $('#gabarra_' + widget_id).die('click');
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.boton.submit);
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.submit);
                break;
              case status.boton.submit:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.stop);
                $('input[name="fecha_atraque"], input[name="hora_atraque"], select[name="equipo_id"], input[name="fecha_inicio_descarga"], input[name="hora_inicio_descarga"], input[name="fecha_fin_descarga"], input[name="hora_fin_descarga"], input[name="fecha_desatraque"], input[name="hora_desatraque"], input[name="submit_campo"]', '#' + widget_id).attr('disabled', 'disabled');
                break;
              default:
                console.log('¡Epa! No debería caer acá. Este es el estatus: ' + $(this).data('status'));
                break;
            }

            $('.exito', '#' + widget_id).children('p').text('Se han cargado los datos correctamente.');

            if ($('.exito', '#' + widget_id).hasClass('oculto')) {
              $('.exito', '#' + widget_id).fadeIn();
              $('.exito', '#' + widget_id).delay(7000).fadeOut();
            }
          }).error(function(error) {

            $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
            $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');

            switch($('input[name="submit_campo"]', '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.atraque);
                break;
              case status.boton.inicio_descarga:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.inicio_descarga);
                break;
              case status.boton.fin_descarga:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.fin_descarga);
                break;
              case status.boton.desatraque:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.desatraque);
                break;
              case status.boton.submit:
                $('input[name="submit_campo"]', '#' + widget_id).val(status.label.submit);
                break;
              default:
                console.log('¡Epa! No debería caer acá. Este es el estatus: ' + $(this).data('status'));
                break;
            }

            $('.error', '#' + widget_id).children('p').text(error.responseText);

            if ($('.error', '#' + widget_id).hasClass('oculto')) {
              $('.error', '#' + widget_id).fadeIn();
              $('.error', '#' + widget_id).delay(10000).fadeOut();
            }
          });

          return false;
        }); // Enviar fechas y horas

        $('form.evento input[name="submit_acaecimiento"]', this).live('click', function() {
          var url_evento = 'descargar/evento/' + $('form.evento', '#' + widget_id).data('descarga-id');

          $('input[name="submit_acaecimiento"}', 'form.evento').attr('disabled', 'disabled');
          $('input[name="submit_acaecimiento"}', 'form.evento').addClass('hold');
          $('input[name="submit_acaecimiento"}', 'form.evento').val(status.label.hold);

          evento = {
            inicio_novedad: $('input[name="fecha_inicio_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_acaecimiento"]', '#' + widget_id).val(),
            fin_novedad: $('input[name="fecha_fin_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_acaecimiento"]', '#' + widget_id).val(),
            desc_novedad: $('textarea[name="observacion_acaecimiento"]', '#' + widget_id).val()
          };

          $.post(url_evento, evento, function(data) {

            $('input[name="fecha_inicio_acaecimiento"], input[name="hora_inicio_acaecimiento"], input[name="fecha_fin_acaecimiento"], input[name="hora_fin_acaecimiento"], textarea[name="observacion_acaecimiento"]', '#' + widget_id).val('');
            $('.historial_eventos', '#' + widget_id).append('<p class="margen_b_10">' + data.descipcion + '</p><small><span class="rojo">' + data.inicio + ' - ' + data.fin + '</span>  |  ' + data.login + '</small><hr />');
          });

          $('input[name="submit_acaecimiento"]', '#' + widget_id).removeAttr('disabled');
          $('input[name="submit_acaecimiento"]', '#' + widget_id).removeClass('hold');
          $('input[name="submit_acaecimiento"]', '#' + widget_id).val(status.label.submit);

          return false;
        }); // Enviar novedades
        
      return false;
    }));

    return false;
  });

  /* ------------------------------ BUQUES ------------------------------ */
  // Edición o desactivación de buques
  $('.edit, .destroy').click(function() {
    var boton = $(this);
    buque_id = boton.data('buque-id');

    if ($(this).hasClass('edit')) {
      window.location = '/buques/' + buque_id + '/edit';
    } else {
      if (confirm('¿Realmente desea cambiar el estado del buque?')) {
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

  // Adición de buque
  $('.add_buque').click(function(){
    window.location = '/buques/new';
  });

  // Reporte de arribo de buque
  $('.reportar_arribo_buque').click(function(){
    var boton = $(this),
        selector_id = $(this).parent().parent().attr('id');
    buque_id = boton.data('buque-id');

    boton.attr('disabled', 'disabled');
    boton.addClass('hold');
    boton.val(status.label.hold);

    $.get('/buques/reportar/' + buque_id, null, function(data){
      boton.fadeOut();
      $('.descargar_buque', '#' + selector_id).delay(300).fadeIn();
    }, 'json');

    return false;
  });

  $('.descargar_buque').click(function(){
    

    return false;
  });
});