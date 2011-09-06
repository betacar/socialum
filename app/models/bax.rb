class Bax < ActiveRecord::Base
  set_table_name 'vw_bax'
  set_primary_key 'id'
  has_many :BaxGabarras
  has_many :Ensayos, :foreign_key => :bax_id
  belongs_to :Remolcador, :foreign_key => :remolcador_id
  belongs_to :EmpresaTransporte, :foreign_key => :empresa_transporte_id
  has_one :ArriboBauxita
  attr_accessor :remolcador, :empresa_transportista, :capitan, :reportado, :eta_arribo, :fecha_arribo # Atributos virtuales
  
  # Obtiene los trenes de gabarras que zarparon de Pijigüaos, 
  # junto a las gabarras y los ensayos de laboratorio asociados
  def self.trenes
    baxes = self.all
    i = 0
    
    baxes.each do |bax|
      baxes[i].remolcador = bax.Remolcador.nombre_rem.titleize
      baxes[i].fecha_hora_zarpe = bax.fecha_hora_zarpe.to_datetime.to_s
      baxes[i].capitan = bax.nombre_capitan.titleize
      baxes[i].eta_arribo = (bax.fecha_hora_zarpe.to_datetime + bax.Remolcador.tiempo_mina_planta.to_i.hours).to_s

      case bax.EmpresaTransporte.nombre_emp
        when "ACBL DE VENEZUELA"
          baxes[i].empresa_transportista = 'ACBL de Venezuela'
        when "TERMINALES MARACAIBO CA"
          baxes[i].empresa_transportista = 'TM Servicios Marítimos'
        else 
          baxes[i].empresa_transportista = bax.EmpresaTransporte.nombre_emp.titleize
      end
      
      unless bax.ArriboBauxita.nil? 
        baxes[i].reportado = true
        baxes[i].fecha_arribo = bax.ArriboBauxita.fecha_hora_arribo_bauxita
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
