class CreateDescargaOtros < ActiveRecord::Migration
  def self.up
    create_table :descargas_otros do |t|
      t.boleean :activo
      t.references :buque
      t.references :gabarra
      t.datetime :atraque_descarga_otro
      t.datetime :inicio_descarga_otro
      t.datetime :fin_descarga_otro
      t.datetime :desatraque_descarga_otro
      t.decimal :tonelaje_descarga_otro
      t.decimal :tiempo_permitido_descarga_otro
      t.decimal :tiempo_utilizado_descarga_otro
      t.decimal :rata_permitida_descarga_otro
      t.decimal :rata_utilizada_descarga_otro
      t.decimal :pago_demora_descarga_otro
      t.decimal :pago_despacho_descarga_otro

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :descargas_otros
  end
end
