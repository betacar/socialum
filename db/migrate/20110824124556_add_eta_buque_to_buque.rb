class AddEtaBuqueToBuque < ActiveRecord::Migration
  def self.up
  	add_column :buques, :eta_buque, :datetime
  	add_column :buques, :descargado, :boolean, :default => false, :null => false
  end

  def self.down
  	remove_column :buques, :eta_buque
  end
end
