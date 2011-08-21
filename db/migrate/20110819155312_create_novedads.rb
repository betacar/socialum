class CreateNovedads < ActiveRecord::Migration
  def self.up
    create_table :novedades do |t|
      t.boolean :activo, :default => true, :null => false
      t.references :proceso, :polymorphic => true
      t.references :tipo_novedad
      t.datetime :inicio_novedad
      t.datetime :fin_novedad
      t.text :desc_novedad
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :novedades
  end
end
