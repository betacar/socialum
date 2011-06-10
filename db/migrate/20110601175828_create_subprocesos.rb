class CreateSubprocesos < ActiveRecord::Migration
  def self.up
    create_table :subprocesos do |t|
      t.references :estado, :null => false, :default => 1
      t.references :proceso, :null => false
      t.string :nombre_subproceso, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :subprocesos
  end
end
