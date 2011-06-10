class CreateTolvas < ActiveRecord::Migration
  def self.up
    create_table :tolvas do |t|
      t.references :estado, :null => false, :defualt => 1
      t.string :desc_tolva, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tolvas
  end
end
