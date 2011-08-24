class DescargaBauxita < ActiveRecord::Base
  set_table_name 'descargas_bauxita'
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
  has_one :BaxGabarra
  has_many :Novedads, :as => :proceso
  validates_presence_of :atraque_descarga_bauxita, :message => 'La fecha y hora de atraque no pueden ser vacías'
  stampable
  
  # Reporta el atraque de una gabarra para descargar
  def self.gabarra(params)
    if !params[:num_zarpe].empty? || !params[:anio_zarpe].empty?
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
          descarga.inicio_descarga_bauxita = DateTime.strptime(params[:inicio_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless params[:inicio_descarga_bauxita].nil? || params[:inicio_descarga_bauxita] == 'null'
          descarga.fin_descarga_bauxita = DateTime.strptime(params[:fin_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless params[:fin_descarga_bauxita].nil? || params[:fin_descarga_bauxita] == 'null'
          descarga.desatraque_descarga_bauxita = DateTime.strptime(params[:desatraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless params[:desatraque_descarga_bauxita].nil? || params[:desatraque_descarga_bauxita] == 'null'
          descarga.save

          return descarga
        else
          descarga = self.find(atracada.id)        

          # Los campos se actualizaran si y solo si no son nulos.
          descarga.update_attribute(:atraque_descarga_bauxita, DateTime.strptime(params[:atraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:atraque_descarga_bauxita].nil? || params[:atraque_descarga_bauxita] == 'null'
          descarga.update_attribute(:inicio_descarga_bauxita, DateTime.strptime(params[:inicio_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:inicio_descarga_bauxita].nil? || params[:inicio_descarga_bauxita] == 'null'
          descarga.update_attribute(:fin_descarga_bauxita, DateTime.strptime(params[:fin_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:fin_descarga_bauxita].nil? || params[:fin_descarga_bauxita] == 'null'
          descarga.update_attribute(:desatraque_descarga_bauxita, DateTime.strptime(params[:desatraque_descarga_bauxita], '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless params[:desatraque_descarga_bauxita].nil? || params[:desatraque_descarga_bauxita] == 'null'
          descarga.save

          return descarga
        end
        
        # Verifico si el BAX ha sido totalmente descargado
        ArriboBauxita.bax_descargado(descarga.arribo_id) unless params[:fin_descarga_bauxita].nil? || params[:fin_descarga_bauxita] == 'null'

      end
    else
      raise Exceptions::PresenciaValoresExcepcion.new('No es posible encontrar el BAX sin los parámetros de número y año de zarpe')
    end
  end

  def self.novedad(params)
    if !params[:id].empty?
      descarga = self.find(params[:id])

      if descarga.nil?
        raise Exceptions::PresenciaValoresExcepcion.new('La descarga no existe')
      else
        novedad = Novedad.new
        novedad.proceso = descarga
        #novedad.tipo_novedad_id = params[:tipo_novedad_id]
        novedad.inicio_novedad = DateTime.strptime(params[:inicio_novedad], '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless params[:inicio_novedad].empty?
        novedad.fin_novedad = DateTime.strptime(params[:fin_novedad], '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless params[:fin_novedad].empty?
        novedad.desc_novedad = params[:desc_novedad]
        novedad.save

        evento = self.data_novedad(novedad.creator_id, novedad.inicio_novedad, novedad.fin_novedad, novedad.desc_novedad)
      end
    else
      raise Exceptions::PresenciaValoresExcepcion.new('No es posible encontrar la descarga sin el parámetro ID')
    end
  end

  private
    def self.data_novedad(creator, inicio, fin, desc)
      evento = Hash.new
      evento[:login] = Empleado.find(creator)
      evento[:login] = (evento[:login].nombres + ' ' + evento[:login].apellidos).titleize
      evento[:inicio] = inicio.to_s(:dia_mes)
      evento[:fin] = fin.to_s(:dia_mes)
      evento[:descipcion] = desc

      evento
    end

    def self.bax_descargado(arribo_id)
      # bax_gabarras = BaxGabarra.find
    end
end
