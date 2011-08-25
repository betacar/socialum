class Novedad < ActiveRecord::Base
  set_table_name 'novedades'
  belongs_to :proceso, :polymorphic => true
  belongs_to :tipo_novedad
  stampable
  attr_accessor :login, :inicio_evento, :fin_evento
  def self.create(proceso,desc_novedad,inicio_novedad,fin_novedad)
      novedad = self.new
      novedad.proceso = proceso
      novedad.inicio_novedad = DateTime.strptime(inicio_novedad, '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless inicio_novedad.empty?
      novedad.fin_novedad = DateTime.strptime(fin_novedad, '%d/%m/%Y %H:%M').to_datetime.to_s(:db) unless fin_novedad.empty?
      novedad.desc_novedad = desc_novedad
      if novedad.save
        novedad
      else
        raise Exceptions::PresenciaValoresExcepcion.new('Fallo al intentar salvar la Novedad')
      end
  end
  def datos
      evento = Hash.new
      evento[:login] = Empleado.find(self.creator_id)
      evento[:login] = (evento[:login].nombres + ' ' + evento[:login].apellidos).titleize
      evento[:inicio] = self.inicio_novedad.to_s(:dia_mes)
      evento[:fin] = self.fin_novedad.to_s(:dia_mes)
      evento[:descipcion] = self.desc_novedad
      evento
  end
end

