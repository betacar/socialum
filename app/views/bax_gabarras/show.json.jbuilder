json.extract! @bax_gabarra, :bax_id,
                            :gabarra_id,
                            :tone_transportada,
                            :sio2r,
                            :sio2q,
                            :al2o3,
                            :fe2o3,
                            :humedad,
                            :muestreo,
                            :tipo_carga

json.arribo_id @bax_gabarra.arribo_bauxita.id

if @bax_gabarra.arribo_bauxita.present? && @bax_gabarra.arribo_bauxita.descarga_bauxitas.gabarra(@bax_gabarra.gabarra_id).present?
  json.has_descarga true

  json.descarga_url bax_arribo_bauxita_descarga_path(@bax_gabarra.bax_id, @bax_gabarra.arribo_bauxita.id, @bax_gabarra.arribo_bauxita.descarga_bauxitas.gabarra(@bax_gabarra.gabarra_id).first.id)

  json.descarga @bax_gabarra.arribo_bauxita.descarga_bauxitas.gabarra(@bax_gabarra.gabarra_id) do |json, descarga| 
    json.extract! descarga, :id,
                            :equipo_id,
                            :atraque_descarga_bauxita,
                            :inicio_descarga_bauxita,
                            :fin_descarga_bauxita,
                            :desatraque_descarga_bauxita

    json.extract! descarga.novedades do |json, novedad|
      json.extract! novedad, :id, :inicio_novedad, :fin_novedad, :desc_novedad, :creator_id
    end
  end
else
  json.has_descarga false
  json.descarga_url bax_arribo_bauxita_descargas_path(@bax_gabarra.bax_id, @bax_gabarra.arribo_bauxita.id)
end

json.equipos Equipo.find_all_by_tipo_equipo_id(1), :id, :nombre_equipo

json.admin (can? :manage, DescargaBauxita)