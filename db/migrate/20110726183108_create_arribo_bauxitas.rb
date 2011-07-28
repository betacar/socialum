class CreateArriboBauxitas < ActiveRecord::Migration
  def self.up
    create_table :arribos_bauxita do |t|
      t.boolean :activo, :default => true
      t.string :bax_id
      t.references :transporte
      t.datetime :eta_arribo_bauxita
      t.string :capitan_arribo_bauxita
      t.decimal :tonelaje_arribo_bauxita
      t.datetime :fecha_hora_arribo_bauxita
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :arribos_bauxita
  end
end
