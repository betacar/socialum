class RemoveImportadaFromDescargasBauxita < ActiveRecord::Migration
  def self.up
    remove_column :descargas_bauxita, :importada
  end

  def self.down
    add_column :descargas_bauxita, :importada, :string
  end
end
