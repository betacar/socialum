module BaxsHelper
  def formato_bax bax_id
    bax_id.gsub(/-/, '/')
  end

  def avance bax
    progreso = bax.arribo_bauxita.descarga_bauxitas.progreso * 100 / bax.carga_transportar
    number_to_percentage(progreso, :precision => 2)
  end

  def eta bax
    (bax.fecha_hora_zarpe.to_datetime + bax.remolcador.tiempo_mina_planta.to_i.hours).to_s.to_datetime
  end
end
