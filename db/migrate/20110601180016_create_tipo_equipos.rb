class CreateTipoEquipos < ActiveRecord::Migration
  def self.up
    create_table :tipos_equipos do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_tipo_equipo, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :tipos_equipos
  end
end
