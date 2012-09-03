# coding: utf-8
class DescargaBauxita < ActiveRecord::Base
  self.table_name = :descargas_bauxita
  
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
  belongs_to :gabarra, :foreign_key => :gabarra_id
  belongs_to :bax, :foreign_key => :bax_id
  belongs_to :bax_gabarra, :foreign_key => :gabarra_id
  has_many :novedades, :as => :proceso, :dependent => :destroy
  
  before_validation :format_params

  validates_presence_of :atraque_descarga_bauxita, :message => 'La fecha y hora de atraque no pueden ser vacias'
  validates_presence_of :equipo_id, :message => 'Por favor, indique la grúa de descarga'

  validates_uniqueness_of :gabarra_id, :scope => [:arribo_id, :arribo_type]
  
  stampable

  default_scope order(:atraque_descarga_bauxita, :gabarra_id)

  attr_accessible :arribo_id, 
                  :arribo_type, 
                  :equipo_id, 
                  :gabarra_id, 
                  :tonelaje_descarga_bauxita, 
                  :atraque_descarga_bauxita, 
                  :inicio_descarga_bauxita, 
                  :fin_descarga_bauxita, 
                  :desatraque_descarga_bauxita

  def self.progreso
    calculate(:sum, :tonelaje_descarga_bauxita, :conditions => ['desatraque_descarga_bauxita IS NOT NULL'])
  end

  def self.gabarra(gabarra_id)
    where('gabarra_id = ?', gabarra_id).limit 1
  end

  private
    def format_params
      # Parametros de arribo
      self.arribo_type = 'ArriboBauxita'

      # Parametros de fecha y hora de operaciones de descarga
      %w(atraque_descarga_bauxita inicio_descarga_bauxita fin_descarga_bauxita desatraque_descarga_bauxita).each do |m|
        self.send("#{m}=", Time.zone.parse("#{self.send(m)[:fecha]} #{self.send(m)[:hora]}")) unless "#{self.send(m)[:fecha]} #{self.send(m)[:hora]}".nil?
      end
    end
end
