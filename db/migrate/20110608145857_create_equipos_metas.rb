class CreateEquiposMetas < ActiveRecord::Migration
  def self.up
    create_table :equipos_metas, :id => false do |t|
      t.integer :estado_id, :null => false, :default => 1
      t.integer :equipo_id, :null => false
      t.integer :meta_id, :null => false
    end
  end

  def self.down
    drop_table :equipos_metas
  end
end
