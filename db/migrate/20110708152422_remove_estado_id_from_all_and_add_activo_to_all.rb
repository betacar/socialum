class RemoveEstadoIdFromAllAndAddActivoToAll < ActiveRecord::Migration
  # Elmina la tabla de estado y los atributos 'estado_id' de las tablas descritas
  # Agrega el campo activo (boolean), para describir el estado de la tupla
  # Migracion irreversible
  def self.up
    # Elimina la columna estado_id
    remove_column :alarmas, :estado_id
    remove_column :empresas, :estado_id
    remove_column :equipos, :estado_id
    remove_column :equipos_metas, :estado_id
    remove_column :estatus_gabarras, :estado_id
    remove_column :fallas, :estado_id
    remove_column :funciones, :estado_id
    remove_column :funciones_roles, :estado_id
    remove_column :locaciones, :estado_id
    remove_column :metas, :estado_id
    remove_column :patios, :estado_id
    remove_column :procesos, :estado_id
    remove_column :puntos_tolvas, :estado_id
    remove_column :rol_usuarios, :estado_id
    remove_column :roles, :estado_id
    remove_column :silos, :estado_id
    remove_column :stock_gabarras, :estado_id
    remove_column :subprocesos, :estado_id
    remove_column :tipo_transportes, :estado_id
    remove_column :tipos_equipos, :estado_id
    remove_column :tipos_fallas, :estado_id
    remove_column :tipos_materiales, :estado_id
    remove_column :tolvas, :estado_id
    remove_column :transportes, :estado_id
    remove_column :usuarios, :estado_id
    
    # Elimina la tabla estado
    drop_table :estados
    
    # Agrega la columna activo
    add_column :alarmas, :activo, :boolean, { :default => true, :null => false }
    add_column :empresas, :activo, :boolean, { :default => true, :null => false }
    add_column :equipos, :activo, :boolean, { :default => true, :null => false }
    add_column :equipos_metas, :activo, :boolean, { :default => true, :null => false }
    add_column :estatus_gabarras, :activo, :boolean, { :default => true, :null => false }
    add_column :fallas, :activo, :boolean, { :default => true, :null => false }
    add_column :funciones, :activo, :boolean, { :default => true, :null => false }
    add_column :locaciones, :activo, :boolean, { :default => true, :null => false }
    add_column :metas, :activo, :boolean, { :default => true, :null => false }
    add_column :patios, :activo, :boolean, { :default => true, :null => false }
    add_column :procesos, :activo, :boolean, { :default => true, :null => false }
    add_column :puntos_tolvas, :activo, :boolean, { :default => true, :null => false }
    add_column :roles, :activo, :boolean, { :default => true, :null => false }
    add_column :silos, :activo, :boolean, { :default => true, :null => false }
    add_column :stock_gabarras, :activo, :boolean, { :default => true, :null => false }
    add_column :subprocesos, :activo, :boolean, { :default => true, :null => false }
    add_column :tipo_transportes, :activo, :boolean, { :default => true, :null => false }
    add_column :tipos_equipos, :activo, :boolean, { :default => true, :null => false }
    add_column :tipos_fallas, :activo, :boolean, { :default => true, :null => false }
    add_column :tipos_materiales, :activo, :boolean, { :default => true, :null => false }
    add_column :tolvas, :activo, :boolean, { :default => true, :null => false }
    add_column :transportes, :activo, :boolean, { :default => true, :null => false }
    add_column :usuarios, :activo, :boolean, { :default => true, :null => false }
  end

  def self.down
  end
end
