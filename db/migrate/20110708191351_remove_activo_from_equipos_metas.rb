class RemoveActivoFromEquiposMetas < ActiveRecord::Migration
  def self.up
    remove_column :equipos_metas, :activo
  end

  def self.down
    add_column :equipos_metas, :activo, :boolean, { :default => true, :null => false }
  end
end
