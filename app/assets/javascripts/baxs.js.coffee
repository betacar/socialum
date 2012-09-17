# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
#= require ejs_production
#= require twitter/bootstrap/tooltip
#= require twitter/bootstrap/alert
#= require bootstrap-datepicker
#= require bootstrap-datepicker.es
#= require bootstrap-timepicker
#= require dates
#= require views/bax_gabarras/index.jst
#= require views/descargas/show.jst

wrapper = $('#wrapper')
main = $('#main')
panel = $('#panel')
alerta = $('#alerta')
estatus = 
  navegando:'navegando'
  esperando:'esperando'
  atracada:'atracada'
  descargando:'descargando'
  descargada:'descargada'
  desatracada:'desatracada'
ciclo = ['arribo', 'atraque', 'inicio', 'fin', 'desatraque']

$(document).ready ->
  # Control de filtro de BAX
  $('#lista-filtro a').filtrar()

  # Tooltips para botones de arribo
  $('#main [rel="tooltip"]').tooltip placement: 'bottom'

  # Control de boton de arribos
  $('#main [data-type="report-arribo"]').reportarArribo()

  # Control de boton para eliminar arribos
  $('#main').on 'click', '[data-type="delete-arribo"]:not(.hide)', ->
    boton = $(this)
    console.log boton.attr 'data-url' 

    if confirm('¿Realmente desea suprimir el arribo del BAX ' + boton.data('bax-id').replace(/-/, '/') + '?')
      destroy = $.ajax 
        url: boton.attr 'data-url'
        type: 'DELETE'
        dataType: 'json'

      destroy.done (resp) ->
        emitir_alerta('Se ha surpimido el arribo del BAX ' + boton.data('bax-id').replace(/-/, '/') + '.')
        eliminar_arribo boton

      boton.off 'click'

  # Control de boton para ver ventana de gabarras
  $('#main').on 'click', '[data-type="view-gabarras"]', ->
    boton = $(this)

    # Consulta AJAX via GET a la URL predefinida
    # que posee el boton
    $.getJSON boton.data('url'), (data) ->
      ver_gabarras data

      $('#gabarras-list').on 'click', 'li:not(.deshabilitada)', ->
        gabarra = $(this)

        unless $("#descarga-" + gabarra.data('bax-gabarra-id')).length >= 1
          # Consulta AJAX via GET a la URL predefinida
          # que posee el boton
          $.getJSON gabarra.data('url'), (data) ->
            descarga data
            bax_gabarra = data.bax_id + '-' + data.gabarra_id
            submit = $('#submit-descarga-' + bax_gabarra)

            submit.attr 'disabled', 'disabled' if $('#descarga-equipo-id-' + bax_gabarra + ', #fecha-atraque-' + bax_gabarra + ', #hora-atraque-' + bax_gabarra).val() is ''
            
            $('#descarga-equipo-id-' + bax_gabarra + ', #fecha-atraque-' + bax_gabarra + ', #hora-atraque-' + bax_gabarra).change ->
              if $('#descarga-equipo-id-' + bax_gabarra).val() is '' or $('#fecha-atraque-' + bax_gabarra).val() is '' or $('#hora-atraque-' + bax_gabarra).val() is ''
                submit.attr 'disabled', 'disabled'
              else
                submit.removeAttr 'disabled'

            $('#submit-descarga-' + bax_gabarra).on 'click', (e) ->
              e.preventDefault()
              submit = $(this)
              descarga = $('#form-' + bax_gabarra)

              request = $.ajax
                url: submit.attr 'data-url'
                context: descarga
                type: descarga.attr 'method'
                data: descarga.serialize()
                dataType: 'json'
              
              request.done (resp) ->
                carga_exitosa(resp, descarga, submit, data.bax_id)

            $('#delete-descarga-' + bax_gabarra).on 'click', (e) ->
              e.preventDefault()
              destroy = $(this)

              if confirm('¿Realmente desea suprimir la descarga de la gabarra ' + destroy.data('gabarra-id') + ', del BAX ' + destroy.data('bax-id').replace(/-/, '/') + '?', 'info')
                request = $.ajax
                  url: destroy.data('url')
                  context: descarga
                  type: 'DELETE'
                  dataType: 'json'
                
                request.done (resp) ->
                  emitir_alerta('Se ha surpimido la descarga de la gabarra ' + destroy.data('gabarra-id') + '.', 'info')
                  
                  $('#gabarra-' + bax_gabarra).children('span').removeClass().addClass 'esperando'

                  progresar(destroy.data('bax-id'), destroy.data('peso')) if $('#fecha-desatraque-' + bax_gabarra).val() != '' or $('#hora-desatraque-' + bax_gabarra).val() != ''

                  $('#descarga-' + bax_gabarra).hide 'slow', ->
                    $(this).remove()

cambiar_boton_arribo = (el,data) ->
  # Elemento time que indica el ETA de arribo
  eta = $('#eta-arribo-bax-' + data.bax_id)
  bax = $('#bax-' + data.bax_id)

  habilitar_gabarras(data.bax_id)

  # Fecha de arribo en formato ISO8601
  fecha_arribo = Date.create(data.fecha_hora_arribo_bauxita).format Date.ISO8601_DATETIME

  # Fecha de arribo formateada
  fecha_arribo_f = Date.create(data.fecha_hora_arribo_bauxita).format '{dd}/{mon}./{year} ~ {HH}:{mm}'

  el.removeClass('btn-primary').addClass('btn-success disabled').text 'Arribo reportado'
  el.attr('rel', 'tooltip').attr('data-arribo-bauxita-id', data.id).attr 'data-original-title', fecha_arribo_f
  el.removeAttr 'data-type'
  el.prepend('<i class="fa-icon-ban-circle"> </i>')
  el.tooltip placement: 'bottom'

  eta.attr('datetime', fecha_arribo).text fecha_arribo_f
  eta.attr 'data-eta', eta.attr 'datetime'
  eta.prev('h6').text 'Arribo Matanzas (M201)'
  eta.attr 'id', 'arribo-bax-' + data.bax_id

  bax.attr 'data-bax-reportado', true

  unless $('#delete-arribo-' + data.bax_id).length is 0
    destroy = $('#delete-arribo-' + data.bax_id)
    destroy.attr 'data-url', '/baxs/' + data.bax_id + '/arribos_bauxitas/' + data.id

    destroy.show 'slow', ->
      destroy.removeClass('hide').removeAttr 'style'

  $('#bax-progress-bar-' + data.bax_id).show 'slow', ->
    $(this).removeClass('hide').removeAttr 'style'

eliminar_arribo = (el) ->
  bax_id = el.data('bax-id')
  progress_bar = $('#bax-descarga-' + bax_id)
  arribo_time = $('#arribo-bax-' + bax_id)
  arribo_boton = $('#bax-arribo-' + bax_id)
  eta = arribo_time.data 'eta'

  eta_f = Date.create(eta).format '{dd}/{mon}./{year} ~ {HH}:{mm}'
  
  # Fechas
  arribo_time.attr 'datetime', eta
  arribo_time.text eta_f
  arribo_time.prev('h6').text 'ETA Matanzas (M201)'
  arribo_time.attr 'id', 'eta-arribo-bax-' + bax_id

  # Botones
  arribo_boton.removeClass('btn-success disabled').addClass('btn-primary').text 'Reportar arribo'
  arribo_boton.attr 'data-type', 'report-arribo'
  arribo_boton.removeAttr('rel').removeAttr('data-arribo-bauxita-id').removeAttr 'data-original-title'
  arribo_boton.prepend('<i class="fa-icon-bullhorn"> </i>')
  arribo_boton.reportarArribo()

  $('#bax-progress-bar-' + bax_id).hide 'slow', ->
    $(this).addClass('hide').removeAttr 'style'
  progress_bar.css 'width', 0
  progress_bar.text '0,0 tons.'
  progress_bar.attr 'data-progreso', 0

  el.hide 'slow', ->
    el.addClass('hide').removeAttr('style').removeAttr 'data-url'

habilitar_gabarras = (bax_id) ->
  unless $('#gabarras-' + bax_id).length is 0
    $('#gabarras-' + bax_id + ' li').removeClass('deshabilitada').children('span').removeClass('navegando').addClass 'esperando'
    $('#gabarras-' + bax_id + ' li').tooltip placement: 'bottom'

ver_gabarras = (data) ->
  # Carga de plantilla e inyección en DOM
  panel.html JST['views/bax_gabarras/index'](data)

  if panel.hasClass 'hide'
    panel.show 'slow', ->
      panel.removeClass('hide').removeAttr 'style'

  $('#gabarras').resetScroll()

  # Tooltip de gabarra
  $('.gabarras li:not(.deshabilitada)').tooltip placement: 'bottom'

  wrapper_panel(false)

  $('#panel .fa-icon-remove').on 'click', ->
    panel.hide 'slow', ->
      panel.addClass('hide').removeAttr 'style'
    
    wrapper_panel(true)

wrapper_panel = (expand) ->
  if expand
    wrapper.addClass('wide').removeClass 'phi-main'
  else
    wrapper.removeClass('wide').addClass 'phi-main'

  main.resetScroll()

descarga = (data) ->
  bax_gabarra = data.bax_id + '-' + data.gabarra_id
  # Carga de plantilla e inyección en DOM
  $('#descargas-' + data.bax_id).append JST['views/descargas/show'](data) unless $("#descarga-" + bax_gabarra).length >= 1

  $('#gabarras').resetScroll()

  fechas_y_horas_descarga(data)

  $('#cerrar-descarga-' + bax_gabarra).on 'click', ->
    $('#descarga-' + bax_gabarra).remove()
    $('#gabarras').resetScroll()

  # Asignación de datetimes y timepickers a formularios
  $('input[type="datetime"]').datepicker
    format: 'dd/mm/yyyy'
    weekstart: 1
    autoclose: true
    language: 'es'

  $('input[type="datetime"]').datepicker 'setStartDate', Date.create().format '{year}-{MM}-{dd}'

  $('input[type="datetime"], input[type="time"]').change ->
    date_manager($(this))

EJS.Helpers.prototype.estatus = (arribo, gabarra) ->
  if Object.has(gabarra, 'descarga')
    gabarra.descarga = gabarra.descarga[0]

    if gabarra.descarga.desatraque_descarga_bauxita
      estatus.desatracada
    else if gabarra.descarga.fin_descarga_bauxita
      estatus.descargada
    else if gabarra.descarga.inicio_descarga_bauxita
      estatus.descargando
    else if gabarra.descarga.atraque_descarga_bauxita
      estatus.atracada
    else
      estatus.esperando
  else if arribo
    estatus.esperando
  else
    estatus.navegando

EJS.Helpers.prototype.muestreo = (m) ->
  switch m
    when 'M'
      'Manual'
    when 'A'
      'Automático'
    else
      'N/D'

EJS.Helpers.prototype.procedencia = (p) ->
  switch p
    when 'J'
      'Jobal'
    when 'B'
      'Bypass'
    when 'A'
      'Jobal / Bypass'      
    else
      'N/D'

EJS.Helpers.prototype.equipo_descarga = (equipo, descarga) ->
  if equipo.id is descarga.equipo_id
    'selected="selected" '
  else
    ''

fechas_y_horas_descarga = (data) ->
  fecha = []
  hora = []
  estados = ['atraque', 'inicio', 'fin', 'desatraque']
  i = 0
  
  while i < estados.length
    if data.has_descarga and data.descarga[0][estados[i] + '_descarga_bauxita']
      fecha[i] =  Date.create(data.descarga[0][estados[i] + '_descarga_bauxita']).format '{dd}/{MM}/{year}'
      hora[i] = Date.create(data.descarga[0][estados[i] + '_descarga_bauxita']).format '{HH}:{mm}'

    fase = estados[i] + '-' + data.bax_id + '-' + data.gabarra_id

    $('#fecha-' + fase).val fecha[i]
    $('#hora-' + fase).val hora[i]
    $('#hora-' + fase).timepicker
      showMeridian: false
      minuteStep: 1
      defaultTime: 'value'

    $('#hora-' + fase).val null unless fecha[i]

    i++

  false

carga_exitosa = (data, form, boton, bax_id) ->
  bax_gabarra = bax_id + '-' + data.gabarra_id

  if form.attr('method') is 'POST'
    url = boton.data('url') + '/' + data.id
    form.attr 'method', 'PUT'
    boton.attr 'data-url', url
    $('#delete-descarga-' + bax_gabarra).attr 'data-url', url 
    $('#delete-descarga-' + bax_gabarra).fadeIn()

  $('#gabarra-' + bax_gabarra).children('span').removeClass().addClass(EJS.Helpers.prototype.estatus(true, { descarga: [ data ] }))

  emitir_alerta 'Datos de descarga guardados.', 'success', bax_gabarra
  
  progresar(bax_id, data.tonelaje_descarga_bauxita) if data.desatraque_descarga_bauxita

progresar = (bax_id, toneladas) ->
  barra = $('#bax-descarga-' + bax_id)
  tonelaje_total = barra.data('tonelaje-total').toNumber()
  toneladas = toneladas.toNumber()
  progreso = barra.attr('data-progreso').toNumber()

  if progreso == toneladas and toneladas < 0
    avance = 0.0
    porcentaje = 0
  else
    avance = progreso + toneladas
    porcentaje = ( avance * 100 / tonelaje_total ).format(2) + '%'

  if avance <= 0
    barra.css 'width', '0%'
  else
    barra.css 'width', porcentaje
    barra.attr 'data-original-title', porcentaje

  barra.attr 'data-progreso', avance
  barra.text avance.format(2, '.', ',') + ' tons.'

  if avance == tonelaje_total
    arribo_bauxita_id = $('#bax-arribo-' + bax_id).data 'arribo-bauxita-id'

    datos = 
      arribo_bauxita: 
        descargado: true

    ajax = $.ajax
      url: '/baxs/' + bax_id + '/arribos_bauxitas/' + arribo_bauxita_id
      type: 'PUT'
      data: datos
      dataType: 'json'

    ajax.done ->
      emitir_alerta('El BAX ' + bax_id.replace(/-/, '/') + ' ha sido descargado.', 'info')

      $('#bax-' + bax_id).delay(7000).hide 'slow', ->
        $(this).remove()

date_manager = (el) ->
  id = el.attr('id')
  name = /\w{1,}-([a-z]{1,})/.exec id
  bax_gabarra = el.data('bax-gabarra')
  bax_id = /^\d*-\d{4}/.exec(bax_gabarra)[0]
  container = $('#' + name[1] + '-' + bax_gabarra)
  indice = ciclo.indexOf(name[1]) - 1

  # Compruebo que sea un fecha, en el formato correcto
  if id.indexOf('fecha') == 0
    if el.val().isDate()
      date = (el.val() + ' 23:59').getDateFromFormat 'd/M/yyyy H:mm' 
    else
      emitir_alerta 'No es una fecha.', 'error', bax_gabarra, name[1]
  else
    datetime = $('#' + id.replace(/hora/, 'fecha')).val() + ' ' + el.val()

    if datetime.isDate 'd/M/yyyy H:mm'
      date = datetime.getDateFromFormat 'd/M/yyyy H:mm' 
    else
      emitir_alerta 'No es una fecha/hora válida.', 'error', bax_gabarra, name[1]

  # Determino la fecha anterior
  if name[1] == 'atraque'
    anterior = Date.create $('#arribo-bax-' + bax_id).attr 'datetime'
  else
    anterior = ($('#fecha-' + ciclo[indice] + '-' + bax_gabarra).val() + ' ' + $('#hora-' + ciclo[indice] + '-' + bax_gabarra).val()).getDateFromFormat 'd/M/yyyy H:mm'

  # Verifica si está dentro del rango
  if date.isBetween anterior, 'tomorrow'
    habilitar_envio container, bax_gabarra
  else
    emitir_alerta 'La fecha y hora de ' + name[1] + ' debe ser mayor a la fecha y hora de ' + ciclo[indice] + '.', 'error', bax_gabarra, name[1]

emitir_alerta = (msg, tipo, bax_gabarra, container) ->
  clase = 'alert-' + tipo

  if bax_gabarra
    context = $('#alerta-' + bax_gabarra)
    submit = $('#submit-descarga-' + bax_gabarra)
  else
    context = alerta

  context.addClass(clase) unless context.hasClass clase
  context.children('span').text msg
  context.fadeIn().delay(10000).fadeOut()

  $('#' + container + '-' + bax_gabarra).addClass(tipo) if container

  submit.attr 'disabled', 'disabled' if tipo == 'error' and bax_gabarra

habilitar_envio = (container, bax_gabarra) ->
  container.removeClass('error').addClass('success') if container.hasClass('error')
  $('#submit-descarga-' + bax_gabarra).removeAttr 'disabled'
  $('#alerta-' + bax_gabarra).fadeOut().removeClass 'alert-error'

$.fn.reportarArribo = ->
  this.on 'click', ->
    boton = $(this)
    # Consulta AJAX via GET a la URL predefinida
    # que posee el boton
    $.post boton.data('url'), (data) ->
        cambiar_boton_arribo boton, data
        boton.off 'click'
      , 'json'

$.fn.filtrar = ->
  self = $(this)

  self.on 'click', (e) ->
    e.preventDefault()
    self = $(this)

    switch self.data('reportado')
      when 'reportado'
        $('#main article[data-bax-reportado="false"]').hide 'slow'
        $('#main article[data-bax-reportado="true"]').show 'slow'
      when 'no-reportado'
        $('#main article[data-bax-reportado="true"]').hide 'slow'
        $('#main article[data-bax-reportado="false"]').show 'slow'
      when 'todos'
        $('#main article[style="display: none;"]').show 'slow'
      else
        false

    main.resetScroll()
    main.scrollTop(0)

# Gabarra = (bax_id, gabarra_id) ->
#   @$boton = $('#gabarra-' + bax_id + '-' + gabarra_id)
#   @$descarga = $('#descarga-' + bax_id + '-' + gabarra_id)
#   @init()

# Gabarra:: =
#   constructor: Gabarra