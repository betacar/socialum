$(document).ready(function() {
  var zoom = 1500,
      status = {
        atraque: 'atraque',
        inicio_descarga: 'inicio_descarga',
        fin_descarga: 'fin_descarga',
        desatraque: 'desatraque',
        submit: 'subir',
        img: {
          en_espera: '/images/clock_red.png',
          atraque: '/images/anchor.png',
          descarga: '/images/arrow_rotate_clockwise.png',
          vacia: '/images/tick.png',
          desatraque: '/images/flag_finish.png'
        }
      };
  
  $('.dialogo').height($(document).height);
  
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

  $('.gabarras li:not(.deshabilitada)').click(function() {
    var bax_id = $(this).parent('.gabarras').data("bax"),
        gabarra_id = $(this).data("gabarra"),
        bax = bax_id.split("/"),
        gabarra = gabarra_id.split("-"),
        widget_id = bax[0] + '_' + bax[1] + '_' + gabarra[0] + '_' + gabarra[1],
        url_arribo = 'arribos/gabarra/' + bax_id + '/' + gabarra_id,
        url_descarga = 'descargar/gabarra/' + bax_id + '/' + gabarra_id
        descarga_bauxita = {};

    $('.dialogo').append(
      $('<div class="widget_descarga grid_10" id="' + widget_id + '"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /></div>').load(url_arribo, function() {
        $('#' + widget_id).draggable();

        $('input[name="submit_campo"]', this).live('click', function() {

          descarga_bauxita = {
            equipo_id: $('select[name="equipo_id"]', '#' + widget_id).val(),
            atraque_descarga_bauxita: $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(),
            inicio_descarga_bauxita: $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(),
            fin_descarga_bauxita: $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(),
            desatraque_descarga_bauxita: $('input[name="fecha_desatraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_desatraque"]', '#' + widget_id).val()
          }

          switch($(this).data('status')) {
            case status.atraque:
              descarga_bauxita.inicio_descarga_bauxita = descarga_bauxita.fin_descarga_bauxita = descarga_bauxita.desatraque_descarga_bauxita = null;
              break;
            case status.inicio_descarga:
              descarga_bauxita.fin_descarga_bauxita = descarga_bauxita.desatraque_descarga_bauxita = null;
              break;
            case status.fin_descarga:
              descarga_bauxita.desatraque_descarga_bauxita = null;
              break;
            default:
              console.log('Estatus antes del $.post: ' + $(this).data('status'));
              break;
          }

          console.log(descarga_bauxita);

          $.post(url_descarga, descarga_bauxita, function(data) {

            switch($('input[name="submit_campo"]', '#' + widget_id).data('status')) {
              case status.atraque:
                $('input[name="fecha_inicio_descarga"], input[name="hora_inicio_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('h3, h3+div', '#' + widget_id).fadeIn();
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.inicio_descarga);
                $('input[name="submit_campo"]', '#' + widget_id).val('Enviar inicio de descarga');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.atraque);
                break;
              case status.inicio_descarga:
                $('input[name="fecha_fin_descarga"], input[name="hora_fin_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.fin_descarga);
                $('input[name="submit_campo"]', '#' + widget_id).val('Enviar fin de descarga');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.descarga);
                break;
              case status.fin_descarga:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.desatraque);
                $('input[name="submit_campo"]', '#' + widget_id).val('Enviar desatraque');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.vacia);
                break;
              case status.desatraque:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.desatraque);
                $('input[name="submit_campo"]', '#' + widget_id).data('status', status.submit);
                $('input[name="submit_campo"]', '#' + widget_id).val('Enviar');
                break;
              case status.submit:
                $('input[name="submit_campo"]', '#' + widget_id).val('Gabarra ya procesada');
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
            /*$('.error', '#' + widget_id).children('p').text(error);

            if ($('.error', '#' + widget_id).hasClass('oculto')) {
              $('.error', '#' + widget_id).fadeIn();
            }*/
            console.log(error);
          });

          return false;
        });
        
      return false;
    }));

    return false;
  });
});