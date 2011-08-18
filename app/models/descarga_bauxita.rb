class DescargaBauxita < ActiveRecord::Base
  set_table_name 'descargas_bauxita'
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
  has_one :BaxGabarra
  
  # Reporta el atraque de una gabarra para descargar
  def self.gabarra(params)
    arribo = ArriboBauxita.find_by_bax_id(params[:num_zarpe] + '/' + params[:anio_zarpe])
    gabarra_id = params[:gabarra_id]
    
    if arribo.nil?
      raise Exceptions::PresenciaValoresExcepcion.new('No existen arribos asociados al BAX ' + params[:num_zarpe] + '/' + params[:anio_zarpe])
    else
      atracada = self.find_by_arribo_id_and_gabarra_id(arribo.id, gabarra_id)
      
      if atracada.nil?
        descarga = self.new

        descarga.arribo = arribo
        descarga.equipo_id = params[:equipo_id]
        descarga.gabarra_id = gabarra_id
        descarga.tonelaje_descarga_bauxita = BaxGabarra.find_by_bax_id_and_gabarra_id(arribo.bax_id, gabarra_id).tone_transportada
        descarga.atraque_descarga_bauxita = DateTime.strptime(params[:atraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)

        descarga.save

        return descarga
      else
        descarga = self.find(atracada.id)        

        # Los campos se actualizaran si y solo si no son nulos.
        descarga.update_attribute(:atraque_descarga_bauxita, DateTime.strptime(params[:atraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:atraque_descarga_bauxita].nil? || params[:atraque_descarga_bauxita] == 'null'
        descarga.update_attribute(:inicio_descarga_bauxita, DateTime.strptime(params[:inicio_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:inicio_descarga_bauxita].nil? || params[:inicio_descarga_bauxita] == 'null'
        descarga.update_attribute(:fin_descarga_bauxita, DateTime.strptime(params[:fin_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:fin_descarga_bauxita].nil? || params[:fin_descarga_bauxita] == 'null'
        descarga.update_attribute(:desatraque_descarga_bauxita, DateTime.strptime(params[:desatraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:desatraque_descarga_bauxita].nil? || params[:desatraque_descarga_bauxita] == 'null'

        #descarga.save

        return descarga
      end
    end    
  end

end
