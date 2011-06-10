class CreateEstados < ActiveRecord::Migration
  def self.up
    create_table :estados do |t|
      t.string :desc_estado, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :estados
  end
end
