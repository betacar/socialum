# coding: utf-8
class DescargaBauxita < ActiveRecord::Base
  self.table_name = :descargas_bauxita
  
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
  belongs_to :gabarra, :foreign_key => :gabarra_id
  belongs_to :bax, :foreign_key => :bax_id
  belongs_to :bax_gabarra, :foreign_key => :gabarra_id

  stampable

  attr_accessible :arribo_id, 
                  :arribo_type, 
                  :equipo_id, 
                  :gabarra_id, 
                  :tonelaje_descarga_bauxita, 
                  :atraque_descarga_bauxita, 
                  :inicio_descarga_bauxita, 
                  :fin_descarga_bauxita, 
                  :desatraque_descarga_bauxita

  before_validation :format_params

  validates_presence_of :gabarra_id, :message => 'Debe indicar una gabarra.'
  validates_presence_of :arribo_id, :message => 'Debe indicar un arribo de embarque.'
  validates_presence_of :atraque_descarga_bauxita, :message => 'La fecha y hora de atraque no pueden ser vacias'
  validates_presence_of :equipo_id, :message => 'Indique la grúa de descarga'
  validates_presence_of :tonelaje_descarga_bauxita, :message => 'Indique el tonelaje de la gabarra'
  validates_uniqueness_of :gabarra_id, :scope => [:arribo_id, :arribo_type]
  validates :gabarra_id, :format => 
                       { :with => /[A-Z]{2,4}-\d{2,4}/, 
                         :message => 'El ID de gabarra debe cumplir el formato establecido.' }
  validates :tonelaje_descarga_bauxita, :format => 
                       { :with => /\d{3,}(\.\d+)?/, 
                         :message => 'El tonelaje de la gabarra debe ser numerico' }

  # validates_associated :arribo
  # validates_associated :equipo
  # validates_associated :gabarra

  default_scope order(:atraque_descarga_bauxita, :gabarra_id)

  def self.progreso
    calculate(:sum, :tonelaje_descarga_bauxita, :conditions => ['desatraque_descarga_bauxita IS NOT NULL'])
  end

  def self.gabarra(gabarra_id)
    where('gabarra_id = ?', gabarra_id).limit 1
  end

  private
    def format_params
      if self.gabarra_id.present?
        # Parametros de arribo
        self.arribo_type = 'ArriboBauxita'

        # Parametros de fecha y hora de operaciones de descarga
        %w(atraque_descarga_bauxita inicio_descarga_bauxita fin_descarga_bauxita desatraque_descarga_bauxita).each do |m|
          self.send("#{m}=", Time.zone.parse("#{self.send(m)[:fecha]} #{self.send(m)[:hora]}")) unless "#{self.send(m)[:fecha]} #{self.send(m)[:hora]}".nil?
        end
      end
    end
end
