class RemoveGabarraIdFromDescargaOtro < ActiveRecord::Migration
  def self.up
    remove_column :descargas_otros, :gabarra_id
  end

  def self.down
  end
end
