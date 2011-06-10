class CreateFuncionesRoles < ActiveRecord::Migration
  def self.up
    create_table :funciones_roles, :id => false do |t|
      t.integer :estado_id, :null => false, :default => 1
      t.integer :rol_id, :null => false
      t.integer :funcion_id, :null => false
    end      
  end

  def self.down
    drop_table :funciones_roles
  end
end
