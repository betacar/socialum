class CreateTransportes < ActiveRecord::Migration
  def self.up
    create_table :transportes do |t|
      t.references :estado, :null => false, :default => 1
      t.references :tipo_transporte, :null => false
      t.references :empresa, :null => false
      t.integer :cod_sap_buque_transporte
      t.string :nombre_transporte, :null => false
      t.decimal :capacidad_transporte, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :transportes
  end
end
