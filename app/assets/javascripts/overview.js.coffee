# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require raphael-min
#= require morris.min

$(document).ready ->
  # Descargas del mes
  Morris.Line
    element: 'descargas-mes'
    data: $('#descargas-mes').data 'json'
    xkey: 'fin_descarga_bauxita'
    ykeys: ['tonelaje_descarga_bauxita']
    labels: ['BX']
    postUnits: [' tons.']
    lineColors: ['#ac0000']
    xLabelFormat: (d) ->
      d.getDate()
    xLabels: 'day'

  Morris.Line
    element: 'descargas-temporada'
    data: $('#descargas-temporada').data 'json'
    xkey: 'fin_descarga_bauxita'
    ykeys: ['tonelaje_descarga_bauxita']
    labels: ['BX']
    postUnits: [' tons.']
    xLabelFormat: (d) ->
      "#{d.getDate()}/#{(d.getMonth() + 1)}"
    xLabels: 'day'