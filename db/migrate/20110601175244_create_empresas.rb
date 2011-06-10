class CreateEmpresas < ActiveRecord::Migration
  def self.up
    create_table :empresas do |t|
      t.references :estado, :null => false, :default => 1
      t.string :nombre_empresa, :null => false
      t.string :pais_empresa, :null => false
      t.string :responsable_empresa
      t.integer :usuario_id_created, :null => false
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :empresas
  end
end
