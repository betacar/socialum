class Bax < ActiveRecord::Base
  set_table_name 'vw_bax'
  set_primary_key 'id'
  has_many :BaxGabarras
  has_many :Ensayos, :foreign_key => :bax_id
  belongs_to :Remolcador, :foreign_key => :remolcador_id
  belongs_to :EmpresaTransporte, :foreign_key => :empresa_transporte_id
  has_one :ArriboBauxita
  attr_accessor :gabarras, :remolcador, :empresa_transportista, :capitan, :reportado, :eta_arribo # Atributos virtuales
  
  # Obtiene los trenes de gabarras que zarparon de Pijigüaos, 
  # junto a las gabarras y los ensayos de laboratorio asociados
  def self.trenes
    baxes = self.all
    i = 0
    
    baxes.each do |tren|
      baxes[i].gabarras = tren.BaxGabarras
      baxes[i].remolcador = tren.Remolcador.nombre_rem.titleize
      baxes[i].fecha_hora_zarpe = tren.fecha_hora_zarpe.to_datetime.to_s
      baxes[i].capitan = tren.nombre_capitan.titleize
      baxes[i].empresa_transportista = tren.EmpresaTransporte.nombre_emp
      baxes[i].eta_arribo = (tren.fecha_hora_zarpe.to_datetime + tren.Remolcador.tiempo_mina_planta.to_i.hours).to_s
      
      unless tren.ArriboBauxita.nil? 
        baxes[i].reportado = true 
      else
        baxes[i].reportado = false
      end
      
      i = i.next
    end
    
    baxes
  end
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
