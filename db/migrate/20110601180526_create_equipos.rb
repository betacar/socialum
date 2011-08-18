class CreateEquipos < ActiveRecord::Migration
  def self.up
    create_table :equipos do |t|
      t.boolean :activo, :default => true, :null => false
      t.references :tipo_equipo, :null => false
      t.references :subproceso
      t.references :empresa
      t.string :nombre_equipo, :null => false
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :equipos
  end
end
