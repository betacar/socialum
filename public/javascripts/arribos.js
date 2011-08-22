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
          stop: 'Gabarra procesada'
        },
        img: {
          en_espera: '/images/clock_red.png',
          atraque: '/images/anchor.png',
          descarga: '/images/arrow_rotate_clockwise.png',
          vacia: '/images/tick.png',
          desatraque: '/images/flag_finish.png'
        }
      };
  
  $('#dialogo').height($(window).height());
  $('#dialogo').width($(window).width());
  
  $('.reportar_arribo').click(function() {
    var bax = $(this).data('bax'),
        esteban = $(this),
        id = '#bax_' + bax.split('/')[0] + '_' + bax.split('/')[1];
        
    $.post('arribos/reportar/' + bax, null, function(){
      $(esteban, id).removeClass('reportar_arribo');
      $(esteban, id).attr('disabled', 'disabled');
      $(esteban, id).attr('value', 'Arribo reportado');

      $('ul.gabarras li', id).each(function() {
        $(this).removeAttr('class');
        $(this).children('img').attr('src', status.img.en_espera);
      });
    });

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
        url_evento = 'descargar/evento/' + $('form.evento', '#' + widget_id).attr('data-id'),
        descarga = {},
        evento = {};

    $('#dialogo').append(
      $('<div class="widget_descarga grid_10" id="' + widget_id + '"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /></div>').load(url_arribo, function() {
        $('#' + widget_id).draggable();

        $('input[name="submit_campo"]', this).live('click', function() {

          $(this).attr('disabled', 'disabled');
          $(this).addClass('hold');
          $(this).val(status.label.hold);

          descarga = {
            equipo_id: $('select[name="equipo_id"]', '#' + widget_id).val(),
            atraque_descarga_bauxita: $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(),
            inicio_descarga_bauxita: $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(),
            fin_descarga_bauxita: $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(),
            desatraque_descarga_bauxita: $('input[name="fecha_desatraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_desatraque"]', '#' + widget_id).val()
          }

          switch($(this).data('status')) {
            case status.boton.atraque:
              descarga.inicio_descarga_bauxita = descarga.fin_descarga_bauxita = descarga.desatraque_descarga_bauxita = null;
              break;
            case status.boton.inicio_descarga:
              descarga.fin_descarga_bauxita = descarga.desatraque_descarga_bauxita = null;
              break;
            case status.boton.fin_descarga:
              descarga.desatraque_descarga_bauxita = null;
              break;
            default:
              console.log('Estatus antes del $.post: ' + $(this).data('status'));
              break;
          }

          console.log(descarga);

          $.post(url_descarga, descarga, function(data) {

            console.log(data);

            $('input[name="submit_campo"]', '#' + widget_id).removeAttr('disabled');
            $('input[name="submit_campo"]', '#' + widget_id).removeClass('hold');

            switch($('input[name="submit_campo"]', '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $('input[name="fecha_inicio_descarga"], input[name="hora_inicio_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('form.evento', '#' + widget_id).attr('data-id', data.descarga_bauxita.id);
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

          evento = {
            inicio_novedad: $('input[name="fecha_inicio_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_acaecimiento"]', '#' + widget_id).val(),
            fin_novedad: $('input[name="fecha_fin_acaecimiento"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_acaecimiento"]', '#' + widget_id).val(),
            desc_novedad: $('input[name="observacion_acaecimiento"]', '#' + widget_id).val()
          };

          $.post(url_evento, evento, function(data) {
            console.log(data);
            //$('.eventos', '#' + widget_id).append('<p class="margen_b_10">' + data.novedad.desc_novedad + '</p><span class="rojo">' + data.novedad.inicio_novedad + ' - ' + data.novedad.fin_novedad + '</span>  |  ' + data.novedad.usuario_id_created + '</small><hr />');
          });

          return false;
        }); // Enviar novedades
        
      return false;
    }));

    return false;
  });
});