class CreateEquipos < ActiveRecord::Migration
  def self.up
    create_table :equipos do |t|
      t.references :estado, :null => false, :default => 1
      t.references :tipo_equipo, :null => false
      t.references :subproceso
      t.references :empresa, :null => false
      t.string :nombre_equipo, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :equipos
  end
end
