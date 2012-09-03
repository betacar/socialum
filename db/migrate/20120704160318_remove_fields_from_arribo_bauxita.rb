class RemoveFieldsFromArriboBauxita < ActiveRecord::Migration
  def up
    %w(empresa_transporte_id capitan_arribo_bauxita tonelaje_arribo_bauxita).each do |f|
      remove_column :arribos_bauxita, f.to_sym
    end
  end

  def down
    %w(empresa_transporte_id capitan_arribo_bauxita).each do |f|
      add_column :arribos_bauxita, f.to_sym, :string
    end
    add_column :arribos_bauxita, :tonelaje_arribo_bauxita, :decimal
  end
end
