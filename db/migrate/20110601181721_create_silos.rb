class CreateSilos < ActiveRecord::Migration
  def self.up
    create_table :silos do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_silo, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :silos
  end
end
