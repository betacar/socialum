class CreateStockGabarras < ActiveRecord::Migration
  def self.up
    create_table :stock_gabarras do |t|
      t.references :locacion, :null => false
      t.references :estatus_gabarra, :null => false
      t.string :empresa_transporte_id
      t.string :gabarra_id, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated
      t.datetime :fecha_hora_stock
      t.boolean :activo, :null => false, :default => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stock_gabarras
  end
end
