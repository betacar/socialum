class CreateEstatusGabarras < ActiveRecord::Migration
  def self.up
    create_table :estatus_gabarras do |t|
      t.references :estado, :null => false, :default => 1
      t.string :desc_estatus_gabarra, :null => false
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :estatus_gabarras
  end
end
