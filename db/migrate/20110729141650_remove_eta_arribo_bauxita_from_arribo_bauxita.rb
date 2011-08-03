class RemoveEtaArriboBauxitaFromArriboBauxita < ActiveRecord::Migration
  def self.up
    remove_column :arribos_bauxita, :eta_arribo_bauxita
  end

  def self.down
    add_column :arribos_bauxita, :eta_arribo_bauxita, :datetime
  end
end
