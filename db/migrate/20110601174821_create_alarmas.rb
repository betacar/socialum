class CreateAlarmas < ActiveRecord::Migration
  def self.up
    create_table :alarmas do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_alarma, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :alarmas
  end
end
