class CreateMetas < ActiveRecord::Migration
  def self.up
    create_table :metas do |t|
      t.references :estado, :null => false, :default => 1
      t.references :subproceso
      t.decimal :numero_meta, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :metas
  end
end
