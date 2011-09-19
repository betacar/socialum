class CreateBuques < ActiveRecord::Migration
  def self.up
    create_table :buques do |t|
      t.boolean :activo, :default => true, :null => false
      t.references :tipo_materia, :null => false
      t.string :nombre_buque, :null => false
      t.string :origen_buque
      t.string :proveedor_buque
      t.string :condicion_buque
      t.string :capitan_buque
      t.decimal :tonelaje_buque
      t.datetime :fecha_zarpe_buque
      t.datetime :eta_mtz_buque
      t.datetime :fecha_arribo_buque
      t.datetime :fecha_atraque_buque
      t.datetime :fecha_inicio_descarga_buque
      t.datetime :fecha_fin_descarga_buque
      t.datetime :fecha_desatraque_buque
      t.decimal :tiempo_permitido_buque
      t.decimal :tiempo_utilizado_buque
      t.decimal :rata_permitida_buque
      t.decimal :rata_utilizada_buque
      t.decimal :pago_demora_buque
      t.decimal :pago_despacho_buque
      t.text :observaciones_buque
      t.boolean :descargado_buque, :default => false, :null => false

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :buques
  end
end
