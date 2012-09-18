class RemoveSubprocesoIdFromEquipos < ActiveRecord::Migration
  def up
    remove_column :equipos, :subproceso_id
  end

  def down
    add_column :equipos, :subproceso_id, :integer
  end
end
