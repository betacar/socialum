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
        img: { // Para imágenes de gabarra
          en_espera: '/images/clock_red.png',
          atraque: '/images/anchor.png',
          descarga: '/images/arrow_rotate_clockwise.png',
          vacia: '/images/tick.png',
          desatraque: '/images/flag_finish.png'
        }
      },
      buque_id = 0,
      formato = 'd/M/yyyy H:mm'; // Formato default para fechas, para usar con la librería de fechas.
  
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
    
    $(esteban).attr('disabled', 'disabled');
    $(esteban).addClass('hold');
    $(esteban).val(status.label.hold);
        
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

    $(esteban).removeClass('hold');

    return false;
  });

  $('h3.down').click(function() {
    var url = '/arribos/gabarras/' + $(this).next().data('bax');
    $(this).next('ul.gabarras').load(url, function() {
      $('.gabarras li').tipsy({gravity:'nw',fade:true,html:true,opacity:.9});
    });
  });

  //
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
      $('<div class="widget_descarga" id="' + widget_id + '"><div class="centro"><img src="/images/loading_32.gif" alt="Cargando" title="Cargando" width="32" height="32" /><p>Cargando, por favor espere...</p></div></div>').load(url_arribo, function() {
        $('h2', '#' + widget_id).parent('div').draggable();

        $('input[name="submit_campo"]', this).live('click', function() {

          var arribo = $('time.fecha_arribo', '#bax_' + bax[0] + '_' + bax[1]).attr('datetime'),
              atraque = $('input[name="fecha_atraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_atraque"]', '#' + widget_id).val(),
              inicio_descarga = $('input[name="fecha_inicio_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_inicio_descarga"]', '#' + widget_id).val(),
              fin_descarga = $('input[name="fecha_fin_descarga"]', '#' + widget_id).val() + ' ' + $('input[name="hora_fin_descarga"]', '#' + widget_id).val(),
              desatraque = $('input[name="fecha_desatraque"]', '#' + widget_id).val() + ' ' + $('input[name="hora_desatraque"]', '#' + widget_id).val(),
              date = '',
              patron = /(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})\s-\d{4}/g, // Expresion regular para matchear la fecha en formato timedate
              este = $(this); // Selector 
          
          // Transformo la fecha de arribo en un objeto fecha
          date = patron.exec(arribo); // Separo el string en forma de array, según el patron
          date.shift(); // Elimino el primer elemento del array (string de arribo)
          date = new Date(date[0], date[1] - 1, date[2], date[3], date[4], date[5]); // Armo el objeto fecha con los datos de año, mes, día, hora, minutos y segundos

          // Deshabilito el boton, para evitar más clicks
          $(este).attr('disabled', 'disabled');
          $(este).addClass('hold');
          $(este).val(status.label.hold);

          descarga = {
            equipo_id: $('select[name="equipo_id"]', '#' + widget_id).val(),
            atraque: atraque,
            inicio_descarga: inicio_descarga,
            fin_descarga: fin_descarga,
            desatraque: desatraque
          }

          // Dependiendo del status del boton, comparo fechas de atraque vs. arribo, inicio de descarga vs. atraque, fin de descarga vs. inicio de descarga, desatraque vs. fin de descarga.
          // compareDates: Compara fechas. | formatDate: da formato a un objeto fecha.
          // Si es mayor, retorna 1. Si es menor, retorna 0. Si es -1, hay un error en el formato de fechas.
          // En todos los casos se valida que el formato de fecha sea valido.
          // Según sea el caso, hay valores que se establecen en blanco para montar el stock de gabarras.
          switch($(this).data('status')) {
            case status.boton.atraque:
              if (atraque == null || !isDate(atraque, formato)) {
                alert('La fecha y/u hora de atraque no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.atraque);
                return false;
              } else if (compareDates(atraque, formato, arribo, 'yyyy-MM-dd HH:mm:ss -0430') != 1) {
                alert('La fecha y/u hora de atraque no puede ser menor a la fecha de arribo del BAX (' + formatDate(date, 'dd/MM/yyyy HH:mm') + ').');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.atraque);
                return false;
              } else descarga.inicio_descarga = descarga.fin_descarga = descarga.desatraque = null;
              break;
            case status.boton.inicio_descarga:              
              if (inicio_descarga == null || !isDate(inicio_descarga, formato)) {
                alert('La fecha y/u hora de inicio de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.inicio_descarga);
                return false;
              } else if (compareDates(inicio_descarga, formato, atraque, formato) != 1) {
                alert('La fecha y/u hora de inicio de descarga no puede ser menor a la fecha de atraque (' + atraque + ').');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.inicio_descarga);
                return false;
              } else descarga.fin_descarga = descarga.desatraque = null;
              break;
            case status.boton.fin_descarga:              
              if (fin_descarga == null || !isDate(fin_descarga, formato)) {
                alert('La fecha y/u hora de fin de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.fin_descarga);
                return false;
              } else if (compareDates(fin_descarga, formato, inicio_descarga, formato) != 1) {
                alert('La fecha y/u hora de fin de descarga no puede ser menor a la fecha de inicio de descarga (' + inicio_descarga + ').');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.fin_descarga);
                return false;
              } else descarga.desatraque = null;
              break;
            case status.boton.desatraque:
              if (desatraque == null || !isDate(desatraque, formato)) {
                alert('La fecha y/u hora de fin de descarga no puede ser vacío o no cumple el formato requerido (dd/mm/aaaa). La hora debe estar formato militar (24H).');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.desatraque);
                return false;
              } else if (compareDates(desatraque, formato, fin_descarga, formato) != 1) {
                alert('La fecha y/u hora de fin de descarga no puede ser menor a la fecha de inicio de descarga (' + fin_descarga + ').');
                $(este, '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).removeClass('hold');
                $(este).val(status.label.desatraque);
                return false;
              }
              break;
            default:
              console.log('Estatus antes del $.post: ' + $(this).data('status'));
              break;
          }

          $.post(url_descarga, descarga, function(data) {

            $(este, '#' + widget_id).removeAttr('disabled');
            $(este, '#' + widget_id).removeClass('hold');

            switch($(este, '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $('input[name="fecha_inicio_descarga"], input[name="hora_inicio_descarga"]', '#' + widget_id).removeAttr('disabled');
                $('.historial_eventos', '#' + widget_id).data('descarga-id', data.descarga_bauxita.id);
                $('h3, h3+div', '#' + widget_id).fadeIn();
                $(este, '#' + widget_id).data('status', status.boton.inicio_descarga);
                $(este, '#' + widget_id).val(status.label.inicio_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.atraque);
                break;
              case status.boton.inicio_descarga:
                $('input[name="fecha_fin_descarga"], input[name="hora_fin_descarga"]', '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).data('status', status.boton.fin_descarga);
                $(este, '#' + widget_id).val(status.label.fin_descarga);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.descarga);
                break;
              case status.boton.fin_descarga:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $(este, '#' + widget_id).data('status', status.boton.desatraque);
                $(este, '#' + widget_id).val(status.label.desatraque);
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.vacia);
                break;
              case status.boton.desatraque:
                $('input[name="fecha_desatraque"], input[name="hora_desatraque"]', '#' + widget_id).removeAttr('disabled');
                $('#gabarra_' + widget_id).children('img').attr('src', status.img.desatraque);
                $('#gabarra_' + widget_id).addClass('deshabilitada');
                $('#gabarra_' + widget_id).die('click');
                $(este, '#' + widget_id).data('status', status.boton.submit);
                $(este, '#' + widget_id).val(status.label.submit);
                break;
              case status.boton.submit:
                $(este, '#' + widget_id).val(status.label.stop);
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

            $(este, '#' + widget_id).removeAttr('disabled');
            $(este, '#' + widget_id).removeClass('hold');

            switch($(este, '#' + widget_id).data('status')) {

              case status.boton.atraque:
                $(este, '#' + widget_id).val(status.label.atraque);
                break;
              case status.boton.inicio_descarga:
                $(este, '#' + widget_id).val(status.label.inicio_descarga);
                break;
              case status.boton.fin_descarga:
                $(este, '#' + widget_id).val(status.label.fin_descarga);
                break;
              case status.boton.desatraque:
                $(este, '#' + widget_id).val(status.label.desatraque);
                break;
              case status.boton.submit:
                $(este, '#' + widget_id).val(status.label.submit);
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
          var url_evento = 'descargar/evento/' + $('.historial_eventos', '#' + widget_id).data('descarga-id');
          console.log($(this));

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