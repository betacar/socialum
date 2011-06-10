class CreatePatios < ActiveRecord::Migration
  def self.up
    create_table :patios do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_patio, :null => false
      t.decimal :cota_maxima
      t.decimal :capacidad_patio
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :patios
  end
end
