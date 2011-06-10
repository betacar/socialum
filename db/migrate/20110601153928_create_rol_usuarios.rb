class CreateRolUsuarios < ActiveRecord::Migration
  def self.up
    create_table :rol_usuarios do |t|
      t.references :estado, :null => false, :default => 1
      t.references :usuario, :null => false
      t.references :rol, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :rol_usuarios
  end
end
