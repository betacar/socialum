class CreateDescargas < ActiveRecord::Migration
  def change
    create_table :descargas do |t|

      t.timestamps
    end
  end
end
