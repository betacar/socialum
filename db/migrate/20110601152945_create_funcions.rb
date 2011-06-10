class CreateFuncions < ActiveRecord::Migration
  def self.up
    create_table :funciones do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_funcion, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :funciones
  end
end
