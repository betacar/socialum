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

ActiveRecord::Schema.define(:version => 20111016003210) do

  create_table "alarmas", :force => true do |t|
    t.string   "nombre_alarma",                   :null => false
    t.integer  "creator_id",                      :null => false
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",        :default => true, :null => false
  end

  create_table "arribos_bauxita", :force => true do |t|
    t.boolean  "activo",                                                  :default => true
    t.string   "bax_id"
    t.string   "empresa_transporte_id"
    t.string   "capitan_arribo_bauxita"
    t.decimal  "tonelaje_arribo_bauxita",   :precision => 8, :scale => 2
    t.datetime "fecha_hora_arribo_bauxita"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "descargado",                                              :default => false
  end

  create_table "buques", :force => true do |t|
    t.boolean  "activo",                      :default => true,  :null => false
    t.integer  "tipo_materia_id",                                :null => false
    t.string   "nombre_buque",                                   :null => false
    t.string   "origen_buque"
    t.string   "proveedor_buque"
    t.string   "condicion_buque"
    t.string   "capitan_buque"
    t.decimal  "tonelaje_buque"
    t.datetime "fecha_zarpe_buque"
    t.datetime "eta_mtz_buque"
    t.datetime "fecha_arribo_buque"
    t.datetime "fecha_atraque_buque"
    t.datetime "fecha_inicio_descarga_buque"
    t.datetime "fecha_fin_descarga_buque"
    t.datetime "fecha_desatraque_buque"
    t.decimal  "tiempo_permitido_buque"
    t.decimal  "tiempo_utilizado_buque"
    t.decimal  "rata_permitida_buque"
    t.decimal  "rata_utilizada_buque"
    t.decimal  "pago_demora_buque"
    t.decimal  "pago_despacho_buque"
    t.text     "observaciones_buque"
    t.boolean  "descargado_buque",            :default => false, :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descargas_bauxita", :force => true do |t|
    t.boolean  "activo",                      :default => true, :null => false
    t.integer  "arribo_id"
    t.string   "arribo_type"
    t.integer  "equipo_id"
    t.string   "gabarra_id"
    t.decimal  "tonelaje_descarga_bauxita"
    t.datetime "atraque_descarga_bauxita"
    t.datetime "inicio_descarga_bauxita"
    t.datetime "fin_descarga_bauxita"
    t.datetime "desatraque_descarga_bauxita"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nombre_empresa",                        :null => false
    t.string   "pais_empresa",                          :null => false
    t.string   "responsable_empresa"
    t.integer  "creator_id",                            :null => false
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",              :default => true, :null => false
  end

  create_table "equipos", :force => true do |t|
    t.integer  "tipo_equipo_id",                   :null => false
    t.integer  "subproceso_id"
    t.integer  "empresa_id"
    t.string   "nombre_equipo",                    :null => false
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",         :default => true, :null => false
    t.integer  "updater_id"
  end

  create_table "estatus_gabarras", :force => true do |t|
    t.string   "desc_estatus_gabarra",                   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",               :default => true, :null => false
  end

  create_table "locaciones", :force => true do |t|
    t.string   "nombre_locacion",                   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",          :default => true, :null => false
  end

  create_table "metas", :force => true do |t|
    t.integer  "proceso_id"
    t.string   "proceso_type"
    t.boolean  "activo",        :default => true,  :null => false
    t.boolean  "limite",        :default => false, :null => false
    t.decimal  "valor_meta"
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.string   "unidad_medida"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novedades", :force => true do |t|
    t.boolean  "activo",          :default => true, :null => false
    t.integer  "proceso_id"
    t.string   "proceso_type"
    t.integer  "tipo_novedad_id"
    t.datetime "inicio_novedad"
    t.datetime "fin_novedad"
    t.text     "desc_novedad"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procesos", :force => true do |t|
    t.string   "nombre_proceso",                   :null => false
    t.integer  "creator_id",                       :null => false
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",         :default => true, :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "rol_id"
    t.integer "user_id"
  end

  create_table "stock_gabarras", :force => true do |t|
    t.integer  "locacion_id",                             :null => false
    t.integer  "estatus_gabarra_id",                      :null => false
    t.string   "empresa_transporte_id"
    t.string   "gabarra_id",                              :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "fecha_hora_stock"
    t.boolean  "activo",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subprocesos", :force => true do |t|
    t.integer  "proceso_id",                          :null => false
    t.string   "nombre_subproceso",                   :null => false
    t.integer  "creator_id",                          :null => false
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",            :default => true, :null => false
  end

  create_table "tipo_novedades", :force => true do |t|
    t.boolean  "activo"
    t.string   "desc_tipo_novedad"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_transportes", :force => true do |t|
    t.string   "desc_tipo_transporte",                   :null => false
    t.integer  "creator_id",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",               :default => true, :null => false
    t.integer  "updater_id"
  end

  create_table "tipos_equipos", :force => true do |t|
    t.boolean  "activo",             :default => true, :null => false
    t.string   "nombre_tipo_equipo",                   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_materiales", :force => true do |t|
    t.string   "desc_tipo_materia",                   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",            :default => true, :null => false
  end

  create_table "tmp_descargas", :id => false, :force => true do |t|
    t.text     "turno"
    t.datetime "fecha"
    t.text     "num_gabarra"
    t.text     "bax"
    t.datetime "dia_hr_atraque"
    t.datetime "dia_hr_inicio"
    t.datetime "dia_hr_fin"
    t.float    "su16_1_2_acbl"
    t.float    "su16_1_2_term"
    t.float    "orinoco_acbl"
    t.float    "orinoco_term"
    t.float    "gms_num_1_acbl"
    t.float    "gms_num_1_term"
    t.float    "gms_num_2_acbl"
    t.float    "gms_num_2_term"
    t.float    "otros_acbl"
    t.float    "otros_term"
    t.string   "numgabarra",     :limit => 100
    t.string   "numg",           :limit => 100
    t.string   "gabarra",        :limit => 100
    t.string   "zarpe",          :limit => 100
    t.string   "remolcador",     :limit => 100
  end

  create_table "tmp_stock", :id => false, :force => true do |t|
    t.datetime "fecha"
    t.float    "stock_gab_matanzas_acbl_carg"
    t.float    "stock_gab_matanzas_acbl_vacias"
    t.float    "stock_gab_matanzas_acbl_proc"
    t.float    "stock_gab_matanzas_acbl_rep"
    t.float    "stock_gab_matanzas_ermaca_carg"
    t.float    "stock_gab_matanzas_ermaca_vacias"
    t.float    "stock_gab_matanzas_ermaca_proc"
    t.float    "stock_gab_matanzas_ermaca_rep"
    t.float    "stock_gab_jobal_acbl_carg"
    t.float    "stock_gab_jobal_acbl_vacias"
    t.float    "stock_gab_jobal_acbl_proc"
    t.float    "stock_gab_jobal_acbl_rep"
    t.float    "stock_gab_jobal_termaca_carg"
    t.float    "stock_gab_jobal_termaca_vacias"
    t.float    "stock_gab_jobal_termaca_proc"
    t.float    "stock_gab_jobal_termaca_rep"
    t.float    "stock_gab_otros_acbl_carg"
    t.float    "stock_gab_otros_acbl_vacias"
    t.float    "stock_gab_otros_acbl_proc"
    t.float    "stock_gab_otros_acbl_rep"
    t.float    "stock_gab_otros_termaca_carg"
    t.float    "stock_gab_otros_termaca_vacias"
    t.float    "stock_gab_otros_termaca_proc"
    t.float    "stock_gab_otros_termaca_rep"
    t.float    "item"
    t.float    "rio_arriba"
    t.float    "rio_abajo"
  end

  create_table "transportes", :force => true do |t|
    t.integer  "tipo_transporte_id",                         :null => false
    t.integer  "empresa_id",                                 :null => false
    t.integer  "cod_sap_buque_transporte"
    t.string   "nombre_transporte",                          :null => false
    t.decimal  "capacidad_transporte",                       :null => false
    t.integer  "creator_id",                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo",                   :default => true, :null => false
    t.integer  "updater_id"
  end

  create_table "usuarios", :id => false, :force => true do |t|
    t.integer  "id",                                 :null => false
    t.integer  "estado_id",           :default => 1, :null => false
    t.string   "login",                              :null => false
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
    t.string   "encrypted_password"
    t.string   "password_salt"
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

end
