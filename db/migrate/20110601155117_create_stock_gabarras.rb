class CreateStockGabarras < ActiveRecord::Migration
  def self.up
    create_table :stock_gabarras do |t|
      t.references :estado, :null => false, :default => 1
      t.references :locacion, :null => false
      t.references :estatus_gabarra, :null => false
      t.string :cod_gabarra, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stock_gabarras
  end
end
