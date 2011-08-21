class ChangeUsuarioIdFromAll < ActiveRecord::Migration
    def self.up
  	rename_column :alarmas, :usuario_id_created, :creator_id
  	rename_column :arribos_bauxita, :usuario_id_created, :creator_id
  	rename_column :arribos_buques, :usuario_id_created, :creator_id
  	rename_column :descargas_bauxita, :usuario_id_created, :creator_id
    rename_column :descargas_otros, :usuario_id_created, :creator_id
    rename_column :empresas, :usuario_id_created, :creator_id
    rename_column :equipos, :usuario_id_created, :creator_id
    rename_column :estatus_gabarras, :usuario_id_created, :creator_id
    rename_column :locaciones, :usuario_id_created, :creator_id
    rename_column :novedades, :usuario_id_created, :creator_id
    rename_column :procesos, :usuario_id_created, :creator_id
    rename_column :stock_gabarras, :usuario_id_created, :creator_id
    rename_column :subprocesos, :usuario_id_created, :creator_id
    rename_column :tipo_novedades, :usuario_id_created, :creator_id
    rename_column :tipo_transportes, :usuario_id_created, :creator_id
    rename_column :tipos_equipos, :usuario_id_created, :creator_id
    rename_column :tipos_materiales, :usuario_id_created, :creator_id
    rename_column :transportes, :usuario_id_created, :creator_id

    rename_column :alarmas, :usuario_id_updated, :updater_id
    rename_column :arribos_bauxita, :usuario_id_updated, :updater_id
    rename_column :arribos_buques, :usuario_id_updated, :updater_id
    rename_column :descargas_bauxita, :usuario_id_updated, :updater_id
    rename_column :descargas_otros, :usuario_id_updated, :updater_id
    rename_column :empresas, :usuario_id_updated, :updater_id
    add_column :equipos, :updater_id, :integer
    rename_column :estatus_gabarras, :usuario_id_updated, :updater_id
    rename_column :locaciones, :usuario_id_updated, :updater_id
    rename_column :novedades, :usuario_id_updated, :updater_id
    rename_column :procesos, :usuario_id_updated, :updater_id
    rename_column :stock_gabarras, :usuario_id_updated, :updater_id
    rename_column :subprocesos, :usuario_id_updated, :updater_id
    rename_column :tipo_novedades, :usuario_id_updated, :updater_id
    add_column :tipo_transportes, :updater_id, :integer
    rename_column :tipos_equipos, :usuario_id_updated, :updater_id
    rename_column :tipos_materiales, :usuario_id_updated, :updater_id
    add_column :transportes, :updater_id, :integer
  end

  def self.down
    rename_column :alarmas, :creator_id, :usuario_id_created
    rename_column :arribos_bauxita, :creator_id, :usuario_id_created
    rename_column :arribos_buques, :creator_id, :usuario_id_created
    rename_column :descargas_bauxita, :creator_id, :usuario_id_created
    rename_column :descargas_otros, :creator_id, :usuario_id_created
    rename_column :empresas, :creator_id, :usuario_id_created
    rename_column :equipos, :creator_id, :usuario_id_created
    rename_column :estatus_gabarras, :creator_id, :usuario_id_created
    rename_column :locaciones, :creator_id, :usuario_id_created
    rename_column :novedades, :creator_id, :usuario_id_created
    rename_column :procesos, :creator_id, :usuario_id_created
    rename_column :stock_gabarras, :creator_id, :usuario_id_created
    rename_column :subprocesos, :creator_id, :usuario_id_created
    rename_column :tipo_novedades, :creator_id, :usuario_id_created
    rename_column :tipo_transportes, :creator_id, :usuario_id_created
    rename_column :tipos_equipos, :creator_id, :usuario_id_created
    rename_column :tipos_materiales, :creator_id, :usuario_id_created
    rename_column :transportes, :creator_id, :usuario_id_created

    rename_column :alarmas, :updater_id, :usuario_id_updated
    rename_column :arribos_bauxita, :updater_id, :usuario_id_updated
    rename_column :arribos_buques, :updater_id, :usuario_id_updated
    rename_column :descargas_bauxita, :updater_id, :usuario_id_updated
    rename_column :descargas_otros, :updater_id, :usuario_id_updated
    rename_column :empresas, :updater_id, :usuario_id_updated
    rename_column :estatus_gabarras, :updater_id, :usuario_id_updated
    rename_column :locaciones, :updater_id, :usuario_id_updated
    rename_column :novedades, :updater_id, :usuario_id_updated
    rename_column :procesos, :updater_id, :usuario_id_updated
    rename_column :stock_gabarras, :updater_id, :usuario_id_updated
    rename_column :subprocesos, :updater_id, :usuario_id_updated
    rename_column :tipo_novedades, :updater_id, :usuario_id_updated
    rename_column :tipos_equipos, :updater_id, :usuario_id_updated
    rename_column :tipos_materiales, :updater_id, :usuario_id_updated
  end
end
