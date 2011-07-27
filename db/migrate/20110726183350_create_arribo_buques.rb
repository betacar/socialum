class CreateArriboBuques < ActiveRecord::Migration
  def self.up
    create_table :arribos_buques do |t|
      t.boolean :activo
      t.references :tipo_materia
      t.datetime :eta_arribo_buque
      t.string :capitan_arribo_buque
      t.string :origen_arribo_buque
      t.decimal :tonelaje_arribo_buque
      t.string :proveedor_arribo_buque
      t.datetime :fecha_hora_arribo_buque
      t.integer :usuario_id_created
      t.integer :usuario_id_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :arribos_buques
  end
end
