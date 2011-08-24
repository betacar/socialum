class Bax < ActiveRecord::Base
  set_table_name 'vw_bax'
  set_primary_key 'id'
  has_many :BaxGabarras
  has_many :Ensayos, :foreign_key => :bax_id
  belongs_to :Remolcador, :foreign_key => :remolcador_id
  belongs_to :EmpresaTransporte, :foreign_key => :empresa_transporte_id
  has_one :ArriboBauxita
  attr_accessor :gabarras, :remolcador, :empresa_transportista, :capitan, :reportado, :eta_arribo, :status_img # Atributos virtuales
  
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
      baxes[i].eta_arribo = (tren.fecha_hora_zarpe.to_datetime + tren.Remolcador.tiempo_mina_planta.to_i.hours).to_s

      case tren.EmpresaTransporte.nombre_emp
        when "ACBL DE VENEZUELA"
          baxes[i].empresa_transportista = 'ACBL de Venezuela'
        when "TERMINALES MARACAIBO CA"
          baxes[i].empresa_transportista = 'TM Servicios Marítimos'
        else 
          baxes[i].empresa_transportista = tren.EmpresaTransporte.nombre_emp.titleize
      end
      
      unless tren.ArriboBauxita.nil? 
        baxes[i].reportado = true

        x = 0
          
        baxes[i].gabarras.each do |gabarra|
          descarga = DescargaBauxita.find_by_arribo_id_and_gabarra_id(tren.ArriboBauxita.id, gabarra.gabarra_id)

          # Si, el código adyacente es un desastre. Pero funciona.
          if !descarga.nil? 
            if !descarga.desatraque_descarga_bauxita.nil? # La gabarra ya ha sido desatracada 
              baxes[i].gabarras[x].status_img = 'flag_finish.png'
            else
              if !descarga.fin_descarga_bauxita.nil? # La gabarra ya ha sido descargada 
                baxes[i].gabarras[x].status_img = 'tick.png'
              else
                if !descarga.inicio_descarga_bauxita.nil? # La gabarra ya ha iniciado el proceso de descarga 
                  baxes[i].gabarras[x].status_img = 'arrow_rotate_clockwise.png'
                else
                  if !descarga.atraque_descarga_bauxita.nil? # La gabarra ya ha sido atracada 
                    baxes[i].gabarras[x].status_img = 'anchor.png'
                  else # La gabarra está a la espera para atracar
                    baxes[i].gabarras[x].status_img = 'clock_red.png'
                  end
                end
              end
            end
          else
            baxes[i].gabarras[x].status_img = 'clock_red.png' # La gabarra está a la espera para atracar
          end

          x = x.next
        end

      else
        baxes[i].reportado = false
        x = 0

        baxes[i].gabarras.each do |gabarra| # El BAX aún no ha sido reportado como que arribó a Matanzas
          baxes[i].gabarras[x].status_img = 'steering_wheel.png'
          x = x.next
        end
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
