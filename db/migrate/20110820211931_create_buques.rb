class CreateBuques < ActiveRecord::Migration
  def self.up
    create_table :buques do |t|
      t.boolean :activo, :default => true, :null => false
      t.references :tipo_material
      t.string :origen_buque
      t.string :proveedor_material
      t.decimal :cantidad_material_buque
      t.datetime :fecha_zarpe_buque
      t.text :observaciones_buque

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :buques
  end
end
