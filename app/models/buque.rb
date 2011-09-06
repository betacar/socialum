class Buque < ActiveRecord::Base
  belongs_to :tipo_materia
  has_one :ArriboBuque
  has_many :DescargaBauxitas, :as => :arribo
  stampable
  validates_presence_of :tipo_materia_id, :nombre_buque, :tonelaje_buque, :origen_buque, :message => 'El campo no puede estar vacío'
  attr_accessor :tipos_materiales, :gabarras, :descarga

  # retorna un hash con los atributos del modelo, incluyendo un array con los tipos de materiales.
  def self.nuevo
    buque = self.new
    buque.tipos_materiales = TipoMateria.all

    buque
  end

  # almacena la data de un buque nuevo. Formatea las fechas de zarpe y arribo.
  def self.guardar(params)
    params[:fecha_zarpe_buque] = DateTime.strptime(params[:fecha_zarpe_buque], '%d/%m/%Y').to_datetime.to_s(:db) unless params[:fecha_zarpe_buque].nil? || params[:fecha_zarpe_buque] == 'null'
    params[:eta_mtz_buque] = DateTime.strptime(params[:eta_mtz_buque], '%d/%m/%Y').to_datetime.to_s(:db) unless params[:eta_mtz_buque].nil? || params[:eta_mtz_buque] == 'null'

    buque = Buque.new(params[:buque])
    buque.save
  end

  # Busca y retorna la data de un buque particular, incluyendo un array con los tipos de materiales.
  def self.buscar_editar(id)
    buque = self.find(id)
    buque.tipos_materiales = TipoMateria.all

    buque.fecha_zarpe_buque = buque.fecha_zarpe_buque.to_s(:fecha) unless buque.fecha_zarpe_buque.nil?
    buque.eta_mtz_buque = buque.eta_mtz_buque.to_s(:fecha) unless buque.eta_mtz_buque.nil?

    buque
  end

  # Actualiza data del buque
  def self.actualizar(params)
    buque = self.find(params[:id])

    params[:fecha_zarpe_buque] = DateTime.strptime(params[:fecha_zarpe_buque], '%d/%m/%Y').to_datetime.to_s(:db) unless params[:fecha_zarpe_buque].nil? || params[:fecha_zarpe_buque] == 'null'
    params[:eta_mtz_buque] = DateTime.strptime(params[:eta_mtz_buque], '%d/%m/%Y').to_datetime.to_s(:db) unless params[:eta_mtz_buque].nil? || params[:eta_mtz_buque] == 'null'

    buque.update_attributes(params[:buque])
    buque.save
  end
  
  # Reporta el arribo de un buque
  def self.reportar(id)
    buque = self.find(id)
    buque.update_attribute(:fecha_arribo_buque, Time.now)
  end

  # def self.descargar(id)
  #   buque = self.find(id)
  #   if buque.tipo_materia_id == 1
  #     buque.gabarras = Gabarra.all
  #     buque.descarga = DescargaBauxita.find_by_arribo_id_and_arribo_type(buque.id, self.class.name)
  #   else
  #     buque.descarga = buque.DescargaOtro
  #   end 
  #end

  # Si tonelaje descargado iguala el tonelaje de material del buque, el buque se considera descargado
  def self.buque_descargado(id)
    buque = self.find(id)

    if buque.tipo_materia_id == 1 # Si el buque es de bauxita, busco en el model de descargas de bauxita
      tonelaje_descarga = DescargaBauxita.sum(:tonelaje_descarga_bauxita, :conditions => {:arribo_id => buque.id, :arribo_type => self.class.name})
    else
      tonelaje_descarga = DescargaOtro.sum(:tonelaje_descarga_otro, :conditions => {:buque_id => buque.id})
    end

    if buque.tonelaje_buque == tonelaje_descarga
      buque.toggle!(:descargado)
    end
  end
end