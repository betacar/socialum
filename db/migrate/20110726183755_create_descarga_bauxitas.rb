class CreateDescargaBauxitas < ActiveRecord::Migration
  def self.up
    create_table :descargas_bauxita do |t|
      t.boolean :activo
      t.string :importada
      t.references :arribo, :polymorphic => true
      t.references :equipo
      t.string :cod_gabarra_descarga_bauxita
      t.decimal :tonelaje_descarga_bauxita
      t.datetime :atraque_descarga_bauxita
      t.datetime :inicio_descarga_bauxita
      t.datetime :fin_descarga_bauxita
      t.datetime :desatraque_descarga_bauxita
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :descargas_bauxita
  end
end
