# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110726190617) do

  create_table "alarmas", :force => true do |t|
    t.string   "nombre_alarma",                        :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "arribos_bauxita", :force => true do |t|
    t.boolean  "activo"
    t.integer  "transporte_id"
    t.datetime "eta_arribo_bauxita"
    t.integer  "num_zarpe_arribo_bauxita"
    t.integer  "ano_zarpe_arribo_bauxita"
    t.datetime "fecha_hora_arribo_bauxita"
    t.decimal  "tonelaje_arribo_bauxita"
    t.string   "capitan_arribo_bauxita"
    t.integer  "usuario_id_created"
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arribos_buques", :force => true do |t|
    t.boolean  "activo"
    t.integer  "tipo_materia_id"
    t.datetime "eta_arribo_buque"
    t.string   "capitan_arribo_buque"
    t.string   "origen_arribo_buque"
    t.decimal  "tonelaje_arribo_buque"
    t.string   "proveedor_arribo_buque"
    t.datetime "fecha_hora_arribo_buque"
    t.integer  "usuario_id_created"
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descargas_bauxita", :force => true do |t|
    t.boolean  "activo"
    t.integer  "arribo_id"
    t.string   "arribo_type"
    t.integer  "equipo_id"
    t.string   "cod_gabarra_descarga_bauxita"
    t.decimal  "tonelaje_descarga_bauxita"
    t.datetime "atraque_descarga_bauxita"
    t.datetime "inicio_descarga_bauxita"
    t.datetime "fin_descarga_bauxita"
    t.datetime "desatraque_descarga_bauxita"
    t.integer  "usuario_id_created"
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descargas_otros", :force => true do |t|
    t.integer  "arribo_buque_id"
    t.datetime "atraque_descarga_otro"
    t.datetime "inicio_descarga_otro"
    t.datetime "fin_descarga_otro"
    t.datetime "desatraque_descarga_otro"
    t.decimal  "tonelaje_descarga_otro"
    t.decimal  "tiempo_permitido_descarga_otro"
    t.decimal  "tiempo_utilizado_descarga_otro"
    t.decimal  "rata_permitida_descarga_otro"
    t.decimal  "rata_utilizada_descarga_otro"
    t.decimal  "pago_demora_descarga_otro"
    t.decimal  "pago_despacho_descarga_otro"
    t.integer  "usuario_id_created"
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nombre_empresa",                        :null => false
    t.string   "pais_empresa",                          :null => false
    t.string   "responsable_empresa"
    t.integer  "usuario_id_created",                    :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",              :default => true, :null => false
  end

  create_table "equipos", :force => true do |t|
    t.integer  "tipo_equipo_id",                       :null => false
    t.integer  "subproceso_id"
    t.integer  "empresa_id",                           :null => false
    t.string   "nombre_equipo",                        :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "equipos_metas", :id => false, :force => true do |t|
    t.integer "equipo_id", :null => false
    t.integer "meta_id",   :null => false
  end

  create_table "estatus_gabarras", :force => true do |t|
    t.string   "desc_estatus_gabarra",                   :null => false
    t.integer  "usuario_id_created",                     :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",               :default => true, :null => false
  end

  create_table "fallas", :force => true do |t|
    t.integer  "equipo_id",                             :null => false
    t.integer  "alarma_id",                             :null => false
    t.integer  "tipo_falla_id",                         :null => false
    t.datetime "fecha_inicio_falla",                    :null => false
    t.datetime "fecha_fin_falla",                       :null => false
    t.text     "observaciones_falla"
    t.integer  "usuario_id_created",                    :null => false
    t.integer  "usuario_id_updated",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",              :default => true, :null => false
  end

  create_table "funciones", :force => true do |t|
    t.string   "nombre_funcion",                       :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "funciones_roles", :id => false, :force => true do |t|
    t.integer "rol_id",     :null => false
    t.integer "funcion_id", :null => false
  end

  create_table "locaciones", :force => true do |t|
    t.string   "nombre_locacion",                      :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "metas", :force => true do |t|
    t.integer  "subproceso_id"
    t.decimal  "numero_meta",                          :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "patios", :force => true do |t|
    t.string   "nombre_patio",                         :null => false
    t.decimal  "cota_maxima"
    t.decimal  "capacidad_patio"
    t.integer  "usuario_id_created",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "procesos", :force => true do |t|
    t.string   "nombre_proceso",                       :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "puntos_tolvas", :force => true do |t|
    t.string   "desc_punto_tolva",                     :null => false
    t.decimal  "minimo_punto_tolva",                   :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "rol_usuarios", :force => true do |t|
    t.integer  "usuario_id",         :null => false
    t.integer  "rol_id",             :null => false
    t.integer  "usuario_id_created", :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "nombre_rol",                           :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "silos", :force => true do |t|
    t.string   "nombre_silo",                          :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "stock_gabarras", :force => true do |t|
    t.integer  "locacion_id",                          :null => false
    t.integer  "estatus_gabarra_id",                   :null => false
    t.string   "cod_gabarra",                          :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "fecha_hora_stock"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "subprocesos", :force => true do |t|
    t.integer  "proceso_id",                           :null => false
    t.string   "nombre_subproceso",                    :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "tipo_transportes", :force => true do |t|
    t.string   "desc_tipo_transporte",                   :null => false
    t.integer  "usuario_id_created",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",               :default => true, :null => false
  end

  create_table "tipos_equipos", :force => true do |t|
    t.string   "nombre_tipo_equipo",                   :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "tipos_fallas", :force => true do |t|
    t.string   "desc_tipo_falla",                      :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "tipos_materiales", :force => true do |t|
    t.string   "desc_tipo_materia",                    :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.integer  "usuario_id_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "tolvas", :force => true do |t|
    t.string   "desc_tolva",                           :null => false
    t.integer  "usuario_id_created",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",             :default => true, :null => false
  end

  create_table "transportes", :force => true do |t|
    t.integer  "tipo_transporte_id",                         :null => false
    t.integer  "empresa_id",                                 :null => false
    t.integer  "cod_sap_buque_transporte"
    t.string   "nombre_transporte",                          :null => false
    t.decimal  "capacidad_transporte",                       :null => false
    t.integer  "usuario_id_created",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",                   :default => true, :null => false
  end

  create_table "usuarios", :id => false, :force => true do |t|
    t.integer  "id",                                    :null => false
    t.string   "login",                                 :null => false
    t.string   "ldap_attributes"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",              :default => true, :null => false
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

end
