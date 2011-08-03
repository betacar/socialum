class AddDescargadoToArribosBauxita < ActiveRecord::Migration
  def self.up
    add_column :arribos_bauxita, :descargado, :boolean, :default => false
  end

  def self.down
    remove_column :arribos_bauxita, :descargado
  end
end
