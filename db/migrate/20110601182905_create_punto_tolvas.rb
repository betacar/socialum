class CreatePuntoTolvas < ActiveRecord::Migration
  def self.up
    create_table :puntos_tolvas do |t|
      t.references :estado, :null => false, :default => 1
      t.string :desc_punto_tolva, :null => false
      t.decimal :minimo_punto_tolva, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :puntos_tolvas
  end
end
