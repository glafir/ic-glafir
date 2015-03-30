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

ActiveRecord::Schema.define(:version => 20150315100921) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "aircompanies", :force => true do |t|
    t.string   "iata_code",          :limit => 2, :null => false
    t.string   "icao_code",          :limit => 3, :null => false
    t.string   "awb_prefix",         :limit => 3
    t.string   "airline_name_eng",                :null => false
    t.string   "airline_name_rus"
    t.integer  "airport_id",                      :null => false
    t.string   "country",                         :null => false
    t.string   "ap_hubs"
    t.date     "al_start"
    t.date     "al_finish"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "timetableaps_count"
  end

  add_index "aircompanies", ["airport_id"], :name => "Base_airport"

  create_table "aircraft_companies", :force => true do |t|
    t.string   "aircraft_company", :null => false
    t.integer  "country_id",       :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "aircraft_types", :force => true do |t|
    t.string   "atype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "aircraft_wake_categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "aircrafts", :force => true do |t|
    t.string   "aircraft_model"
    t.string   "aircraft_icao_code"
    t.string   "aircraft_iata_code"
    t.integer  "aircraft_seats"
    t.integer  "aircraft_wake_category_id"
    t.string   "aircraft_webinfo"
    t.integer  "aircraft_type_id"
    t.integer  "aircraft_maxspeed"
    t.integer  "aircraft_company_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "airports", :force => true do |t|
    t.string   "iata_code",    :limit => 3, :null => false
    t.string   "icao_code",    :limit => 4, :null => false
    t.string   "name_rus"
    t.string   "name_eng"
    t.string   "city_rus"
    t.string   "city_eng"
    t.string   "gmt_offset"
    t.string   "iso_code"     :limit => 2, :null => false
    t.string   "latitude"
    t.string   "longitude"
    t.string   "runway_length"
    t.string   "runway_elevation"
    t.integer  "timetableaps_count"
    t.string   "runnway_coll"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.string   "TerminalsColl"
    t.string   "Terminals"
    t.string   "Dist_to_town"
    t.integer  "town_id"
    t.integer  "aircompanies_count"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "airports", ["iata_code"], :name => "iata_code", :unique => true

  create_table "aphubs", :force => true do |t|
    t.integer  "airport_id",    :null => false
    t.integer  "aircompany_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "apkeys", :force => true do |t|
    t.integer  "airport_id",         :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "timetableaps_count"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "countries", :force => true do |t|
    t.string   "country_name"
    t.string   "country_iata_code"
    t.string   "country_icao_code"
    t.integer  "country_number"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "flight_types", :force => true do |t|
    t.string   "flight_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name_rus"
    t.string   "name_eng"
    t.integer  "country_id"
    t.float    "area"
    t.integer  "population"
    t.integer  "capitalcity_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "runway_aps", :force => true do |t|
    t.integer  "airport_id"
    t.string   "runway_name",      :limit => 5
    t.integer  "runway_elevation"
    t.string   "runway_data"
    t.datetime "created_at",                    :null => false
    t.integer  "runway_length"
    t.datetime "updated_at",                    :null => false
  end

  create_table "rw_routes", :force => true do |t|
    t.integer  "start_route"
    t.integer  "end_route"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rw_stations", :force => true do |t|
    t.string   "rw_zone",           :limit => 4, :default => "0000", :null => false
    t.string   "name_eng",                                           :null => false
    t.string   "name_rus",                                           :null => false
    t.integer  "rw_typestation_id",              :default => 5,      :null => false
    t.integer  "rw_route_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "rw_typestations", :force => true do |t|
    t.string   "typestation_name", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "timetableap_subs", :force => true do |t|
    t.integer  "Flight_Number",  :default => 0, :null => false
    t.integer  "timetableap_id",                :null => false
    t.integer  "aircompany_id",                 :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "timetableaps", :force => true do |t|
    t.integer  "Flight_Number",  :null => false
    t.integer  "aircompany_id",  :null => false
    t.integer  "way_start",      :null => false
    t.integer  "way_end",        :null => false
    t.string   "TermStart"
    t.string   "GateStart"
    t.string   "TermEnd"
    t.string   "GateEnd"
    t.string   "TypeOfPlane"
    t.time     "TimeStart",      :null => false
    t.time     "TimeEnd",        :null => false
    t.date     "DateOfStartNav", :null => false
    t.date     "DateOfEndNav",   :null => false
    t.integer  "s1",             :null => false
    t.integer  "s2",             :null => false
    t.integer  "s3",             :null => false
    t.integer  "s4",             :null => false
    t.integer  "s5",             :null => false
    t.integer  "s6",             :null => false
    t.integer  "s0",             :null => false
    t.integer  "e1",             :null => false
    t.integer  "e2",             :null => false
    t.integer  "e3",             :null => false
    t.integer  "e4",             :null => false
    t.integer  "e5",             :null => false
    t.integer  "e6",             :null => false
    t.integer  "e0",             :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "timetablesap_flights", :force => true do |t|
    t.integer  "Flight_Number",                :default => 0, :null => false
    t.integer  "aircompany_id",                               :null => false
    t.integer  "way_start",                                   :null => false
    t.integer  "runway_start",                                :null => false
    t.integer  "way_end",                                     :null => false
    t.integer  "runway_end",                                  :null => false
    t.string   "TermStart",      :limit => 50
    t.string   "TermEnd",        :limit => 50
    t.string   "GateStart",      :limit => 50
    t.string   "GateEnd",        :limit => 50
    t.string   "TypeOfPlane",    :limit => 50
    t.datetime "start",                                       :null => false
    t.datetime "end",                                         :null => false
    t.datetime "created_at",                                  :null => false
    t.integer  "flight_type_id",                              :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "towns", :force => true do |t|
    t.string   "country",     :limit => 3, :default => "", :null => false
    t.string   "city",                     :default => "", :null => false
    t.string   "accent_city",              :default => "", :null => false
    t.string   "city_rus",                 :default => ""
    t.string   "region",      :limit => 3, :default => "", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "towns", ["accent_city"], :name => "accent_city"
  add_index "towns", ["city"], :name => "city"
  add_index "towns", ["city_rus"], :name => "city_rus"
  add_index "towns", ["country"], :name => "country"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "time_zone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
