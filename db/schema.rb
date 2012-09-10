# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120704160318) do

  create_table "arribos_bauxita", :force => true do |t|
    t.boolean  "activo",                    :default => true
    t.string   "bax_id"
    t.datetime "fecha_hora_arribo_bauxita"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "descargado",                :default => false
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "rol_id"
    t.integer "user_id"
  end

  create_table "tipo_novedades", :force => true do |t|
    t.boolean  "activo"
    t.string   "desc_tipo_novedad"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_equipos", :force => true do |t|
    t.boolean  "activo",             :default => true, :null => false
    t.string   "nombre_tipo_equipo",                   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

end
