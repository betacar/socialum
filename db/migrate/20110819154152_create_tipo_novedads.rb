class CreateTipoNovedads < ActiveRecord::Migration
  def self.up
    create_table :tipo_novedades do |t|
      t.boolean :activo
      t.string :desc_tipo_novedad
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_novedades
  end
end
