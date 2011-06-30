class AddFechaHoraStockToStockGabarra < ActiveRecord::Migration
  def self.up
    add_column :stock_gabarras, :fecha_hora_stock, :datetime
  end

  def self.down
    remove_column :stock_gabarras, :fecha_hora_stock
  end
end
