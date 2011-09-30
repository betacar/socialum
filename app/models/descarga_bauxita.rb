class DescargaBauxita < ActiveRecord::Base
  set_table_name 'descargas_bauxita'
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
  has_one :BaxGabarra
  has_many :Novedads, :as => :proceso
  validates_presence_of :atraque_descarga_bauxita, :message => 'La fecha y hora de atraque no pueden ser vacías'
  stampable

  # Reporta el atraque y descarga de una gabarra o buque
  def self.descargar(params)
    gabarra_id = params[:gabarra_id]
    atraque = params[:atraque]
    inicio_descarga = params[:inicio_descarga]
    fin_descarga = params[:fin_descarga]
    desatraque = params[:desatraque]
    action = params[:action]

    if action == 'gabarra'
      proceso = ArriboBauxita.find_by_bax_id(params[:num_zarpe] + '/' + params[:anio_zarpe])
    elsif action == 'buque'
      proceso = Buque.find(params[:buque_id])
    else
      raise Exceptions::PresenciaValoresExcepcion.new('La acción ' + action + ' no está definida en el modelo ' + self.name)
    end

    atracada = self.find_by_arribo_id_and_gabarra_id(proceso.id, gabarra_id)

    if action == 'buque'
      atracada = atracada.fecha_arribo_buque
    end

    if atracada.nil?
      descarga = self.new

      descarga.arribo = proceso
      descarga.equipo_id = params[:equipo_id]
      descarga.gabarra_id = gabarra_id

      if action == 'gabarra'
        descarga.tonelaje_descarga_bauxita = BaxGabarra.find_by_bax_id_and_gabarra_id(proceso.bax_id, gabarra_id).tone_transportada
      elsif action == 'buque'
        descarga.tonelaje_descarga_bauxita = params[:tonelaje_descarga]
      end

      descarga.atraque_descarga_bauxita = DateTime.strptime(atraque, '%d/%m/%Y %H:%M').to_datetime.to_s(:db)
      descarga.inicio_descarga_bauxita = DateTime.strptime(inicio_descarga, '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless inicio_descarga.nil? || inicio_descarga.empty? || inicio_descarga == 'null' || inicio_descarga == ' '
      descarga.fin_descarga_bauxita = DateTime.strptime(fin_descarga, '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless fin_descarga.nil? || fin_descarga.empty? || fin_descarga == 'null' || fin_descarga == ' '
      descarga.desatraque_descarga_bauxita = DateTime.strptime(desatraque, '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless desatraque.nil? || desatraque.empty? || desatraque == 'null' || desatraque == ' '
      descarga.save
    else
      descarga = self.find(atracada.id)

      # Los campos se actualizaran si no son nulos y si no tienen datos ya almacenados en la tabla
      descarga.update_attribute(:inicio_descarga_bauxita, DateTime.strptime(inicio_descarga, '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless inicio_descarga.nil? || inicio_descarga.empty? || inicio_descarga == 'null' || inicio_descarga == ' '
      descarga.update_attribute(:fin_descarga_bauxita, DateTime.strptime(fin_descarga, '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless fin_descarga.nil? || fin_descarga.empty? || fin_descarga == 'null' || fin_descarga == ' '
      descarga.update_attribute(:desatraque_descarga_bauxita, DateTime.strptime(desatraque, '%d/%m/%Y %H:%M').to_datetime.to_s(:db)) unless desatraque.nil? || desatraque.empty? || desatraque == 'null' || desatraque == ' '

      descarga.save
    end

    unless fin_descarga.nil? ||  fin_descarga.empty? || fin_descarga == 'null' || fin_descarga == ' ' # Verifico si el BAX o el buque ha sido totalmente descargado
      if action == 'gabarra'
        ArriboBauxita.bax_descargado(descarga.arribo_id)
      elsif action == 'buque'
        Buque.descargado(descarga.id)
      end
    end

    descarga
  end

  def self.novedad(params)
    if !params[:id].empty?
      begin
        descarga = self.find(params[:id])
        novedad = Novedad.create(descarga,params[:desc_novedad], params[:inicio_novedad], params[:fin_novedad])
        #evento = self.data_novedad(novedad.creator_id, novedad.inicio_novedad, novedad.fin_novedad, novedad.desc_novedad)
        evento = novedad.datos
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::PresenciaValoresExcepcion.new('No existe la descarga')
      end
    else
      raise Exceptions::PresenciaValoresExcepcion.new('No es posible encontrar la descarga sin el parámetro ID')
    end
  end

  private
    def self.bax_descargado(arribo_id)
      # bax_gabarras = BaxGabarra.find
    end
end
