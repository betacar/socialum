class CreateRols < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_rol, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
