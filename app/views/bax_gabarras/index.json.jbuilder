json.bax_id @bax_gabarras.first.bax_id
json.cantidad @bax_gabarras.size

json.arribo @bax_gabarras.first.arribo_bauxita.present?

if @bax_gabarras.first.arribo_bauxita.present? && @bax_gabarras.first.arribo_bauxita.descarga_bauxitas.present?
  json.descargas @bax_gabarras.first.arribo_bauxita.descarga_bauxitas.size
else
  json.descargas 0
end

json.gabarras @bax_gabarras do |json, bax_gabarra|
  json.(bax_gabarra, :gabarra_id)

  json.url bax_bax_gabarra_path(bax_gabarra.bax_id, bax_gabarra.gabarra_id)

  if bax_gabarra.arribo_bauxita.present? && bax_gabarra.arribo_bauxita.descarga_bauxitas.gabarra(bax_gabarra.gabarra_id).present?
    json.descarga bax_gabarra.arribo_bauxita.descarga_bauxitas.gabarra(bax_gabarra.gabarra_id) do |json, descarga| 
      json.extract! descarga, :atraque_descarga_bauxita,
                              :inicio_descarga_bauxita,
                              :fin_descarga_bauxita,
                              :desatraque_descarga_bauxita
    end
  end
end

json.admin (can? :create, DescargaBauxita)