class CreateFallas < ActiveRecord::Migration
  def self.up
    create_table :fallas do |t|
      t.references :estado, :null => false, :default => 1
      t.references :equipo, :null => false
      t.references :alarma, :null => false
      t.references :tipo_falla, :null => false
      t.datetime :fecha_inicio_falla, :null => false
      t.datetime :fecha_fin_falla, :null => false
      t.text :observaciones_falla
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :fallas
  end
end
