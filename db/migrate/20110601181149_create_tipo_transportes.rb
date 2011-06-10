class CreateTipoTransportes < ActiveRecord::Migration
  def self.up
    create_table :tipo_transportes do |t|
      t.references :estado, :null => false, :default => 1
      t.string :desc_tipo_transporte, :null => false
      t.integer :usuario_id_created, :null => false
      t.updated :usuario_id_update, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_transportes
  end
end
