class RemoveEmpresaIdFromEquipos < ActiveRecord::Migration
  def up
    remove_column :equipos, :empresa_id
  end

  def down
    add_column :equipos, :empresa_id, :integer
  end
end
