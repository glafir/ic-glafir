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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160124184713) do

  create_table "aircompanies", force: :cascade do |t|
    t.string   "iata_code",          limit: 2,               null: false
    t.string   "icao_code",          limit: 3,               null: false
    t.string   "awb_prefix",         limit: 3
    t.string   "airline_name_eng",   limit: 255,             null: false
    t.string   "airline_name_rus",   limit: 255
    t.integer  "airport_id",         limit: 4,               null: false
    t.integer  "country_id",         limit: 4
    t.integer  "al_start",           limit: 4
    t.integer  "al_finish",          limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "timetableaps_count", limit: 4,   default: 0, null: false
    t.integer  "manager_id",         limit: 4
    t.string   "avatar",             limit: 255
  end

  add_index "aircompanies", ["airport_id"], name: "Base_airport", using: :btree
  add_index "aircompanies", ["country_id"], name: "country_id", using: :btree
  add_index "aircompanies", ["iata_code"], name: "iata_code", using: :btree
  add_index "aircompanies", ["icao_code"], name: "icao_code", using: :btree
  add_index "aircompanies", ["id"], name: "id", unique: true, using: :btree
  add_index "aircompanies", ["manager_id"], name: "manager_id", using: :btree

  create_table "aircraft_companies", force: :cascade do |t|
    t.string   "aircraft_company", limit: 255, null: false
    t.integer  "country_id",       limit: 4,   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "aircraft_types", force: :cascade do |t|
    t.string   "atype",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "aircraft_wake_categories", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "aircrafts", force: :cascade do |t|
    t.string   "aircraft_model",            limit: 255
    t.string   "aircraft_icao_code",        limit: 255
    t.string   "aircraft_iata_code",        limit: 255
    t.integer  "aircraft_seats",            limit: 4
    t.integer  "aircraft_wake_category_id", limit: 4
    t.string   "aircraft_webinfo",          limit: 255
    t.integer  "aircraft_type_id",          limit: 4
    t.integer  "aircraft_maxspeed",         limit: 4
    t.integer  "aircraft_company_id",       limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "airpor_size_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "airport_air_traffics", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "klass",      limit: 4,   null: false
    t.integer  "max_pass",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "airport_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string   "iata_code",              limit: 3,   null: false
    t.string   "icao_code",              limit: 4,   null: false
    t.string   "name_rus",               limit: 255
    t.string   "name_eng",               limit: 255
    t.string   "city_rus",               limit: 255
    t.string   "city_eng",               limit: 255
    t.string   "gmt_offset",             limit: 255
    t.string   "iso_code",               limit: 2
    t.string   "latitude",               limit: 255
    t.string   "longitude",              limit: 255
    t.string   "runway_length",          limit: 255
    t.string   "runway_elevation",       limit: 255
    t.integer  "timetableaps_count",     limit: 4
    t.string   "runnway_coll",           limit: 255
    t.string   "phone",                  limit: 255
    t.string   "fax",                    limit: 255
    t.string   "email",                  limit: 255
    t.string   "website",                limit: 255
    t.string   "TerminalsColl",          limit: 255
    t.string   "Terminals",              limit: 255
    t.string   "Dist_to_town",           limit: 255
    t.integer  "town_id",                limit: 4
    t.integer  "airport_air_traffic_id", limit: 4
    t.integer  "weather_state",          limit: 4
    t.integer  "airport_state_id",       limit: 4
    t.string   "time_zone",              limit: 50
    t.integer  "country_id",             limit: 4
    t.integer  "aircompanies_count",     limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "airports", ["iata_code"], name: "iata_code", unique: true, using: :btree

  create_table "aphubs", force: :cascade do |t|
    t.integer  "airport_id",    limit: 4, null: false
    t.integer  "aircompany_id", limit: 4, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "aphubs", ["aircompany_id"], name: "aircompany_id", using: :btree
  add_index "aphubs", ["airport_id"], name: "airport_id", using: :btree

  create_table "apkeys", force: :cascade do |t|
    t.integer  "airport_id",         limit: 4, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "timetableaps_count", limit: 4
  end

  create_table "countries", force: :cascade do |t|
    t.string   "country_name",      limit: 255
    t.string   "country_iata_code", limit: 255
    t.string   "country_icao_code", limit: 255
    t.integer  "country_number",    limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "flash_message_states", force: :cascade do |t|
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "flash_messages", force: :cascade do |t|
    t.integer  "user_id",                limit: 4,    null: false
    t.string   "message",                limit: 255,  null: false
    t.string   "request_url",            limit: 255,  null: false
    t.string   "request_ip",             limit: 15,   null: false
    t.string   "request_method",         limit: 6,    null: false
    t.string   "request_referrer",       limit: 1000, null: false
    t.string   "useragent",              limit: 1000, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "flash_message_state_id", limit: 4
  end

  create_table "flight_types", force: :cascade do |t|
    t.string   "flight_type", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string   "encrypted_password",    limit: 255, null: false
    t.string   "password_salt",         limit: 255
    t.string   "password_history_type", limit: 255, null: false
    t.integer  "password_history_id",   limit: 4,   null: false
    t.datetime "created_at"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name_rus",       limit: 255
    t.string   "name_eng",       limit: 255
    t.integer  "country_id",     limit: 4
    t.float    "area",           limit: 24
    t.integer  "population",     limit: 4
    t.integer  "capitalcity_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  create_table "runway_aps", force: :cascade do |t|
    t.integer  "airport_id",       limit: 4
    t.string   "runway_name",      limit: 5
    t.integer  "runway_elevation", limit: 4
    t.string   "runway_data",      limit: 255
    t.datetime "created_at",                   null: false
    t.integer  "runway_length",    limit: 4
    t.datetime "updated_at",                   null: false
  end

  create_table "rw_routes", force: :cascade do |t|
    t.integer  "start_route", limit: 4
    t.integer  "end_route",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sign_in_failures", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "ip_address", limit: 255
    t.string   "user_agent", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "station_types", force: :cascade do |t|
    t.string   "typename",   limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "station_zones", force: :cascade do |t|
    t.string   "station_id", limit: 255
    t.string   "zone",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "station_zone_id", limit: 4,   default: "0000", null: false
    t.string   "name_eng",        limit: 255,                  null: false
    t.string   "name_rus",        limit: 255,                  null: false
    t.integer  "station_type_id", limit: 4,   default: 5,      null: false
    t.integer  "rw_route_id",     limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "timetableap_subs", force: :cascade do |t|
    t.integer  "Flight_Number",  limit: 4, default: 0, null: false
    t.integer  "timetableap_id", limit: 4,             null: false
    t.integer  "aircompany_id",  limit: 4,             null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "timetableaps", force: :cascade do |t|
    t.integer  "flight_number",  limit: 4,   null: false
    t.integer  "aircompany_id",  limit: 4,   null: false
    t.integer  "parent_id",      limit: 4
    t.integer  "way_start",      limit: 4,   null: false
    t.integer  "way_end",        limit: 4,   null: false
    t.string   "TermStart",      limit: 255
    t.string   "GateStart",      limit: 255
    t.string   "TermEnd",        limit: 255
    t.string   "GateEnd",        limit: 255
    t.integer  "aircraft_id",    limit: 4
    t.time     "TimeStart",                  null: false
    t.time     "TimeEnd",                    null: false
    t.date     "DateOfStartNav",             null: false
    t.date     "DateOfEndNav",               null: false
    t.integer  "s1",             limit: 4,   null: false
    t.integer  "s2",             limit: 4,   null: false
    t.integer  "s3",             limit: 4,   null: false
    t.integer  "s4",             limit: 4,   null: false
    t.integer  "s5",             limit: 4,   null: false
    t.integer  "s6",             limit: 4,   null: false
    t.integer  "s0",             limit: 4,   null: false
    t.integer  "e1",             limit: 4,   null: false
    t.integer  "e2",             limit: 4,   null: false
    t.integer  "e3",             limit: 4,   null: false
    t.integer  "e4",             limit: 4,   null: false
    t.integer  "e5",             limit: 4,   null: false
    t.integer  "e6",             limit: 4,   null: false
    t.integer  "e0",             limit: 4,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "timetableaps", ["aircraft_id"], name: "aircraft_id", using: :btree
  add_index "timetableaps", ["flight_number", "aircompany_id"], name: "Flight_Number_aircompany_id", unique: true, using: :btree
  add_index "timetableaps", ["flight_number", "parent_id"], name: "flight_number_parent_id", unique: true, using: :btree
  add_index "timetableaps", ["id"], name: "id", unique: true, using: :btree
  add_index "timetableaps", ["parent_id"], name: "parent_id", using: :btree
  add_index "timetableaps", ["way_end"], name: "way_end", using: :btree
  add_index "timetableaps", ["way_start"], name: "way_start", using: :btree

  create_table "timetablesap_flights", force: :cascade do |t|
    t.integer  "Flight_Number",  limit: 4,  default: 0, null: false
    t.integer  "aircompany_id",  limit: 4,              null: false
    t.integer  "way_start",      limit: 4,              null: false
    t.integer  "runway_start",   limit: 4,              null: false
    t.integer  "way_end",        limit: 4,              null: false
    t.integer  "runway_end",     limit: 4,              null: false
    t.string   "TermStart",      limit: 50
    t.string   "TermEnd",        limit: 50
    t.string   "GateStart",      limit: 50
    t.string   "GateEnd",        limit: 50
    t.string   "TypeOfPlane",    limit: 50
    t.datetime "start",                                 null: false
    t.datetime "end",                                   null: false
    t.datetime "created_at",                            null: false
    t.integer  "flight_type_id", limit: 4,              null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "towns", force: :cascade do |t|
    t.string   "country_iso", limit: 3,   default: "", null: false
    t.integer  "country_id",  limit: 4
    t.string   "city",        limit: 255, default: "", null: false
    t.string   "accent_city", limit: 255, default: "", null: false
    t.string   "city_rus",    limit: 255, default: ""
    t.string   "region",      limit: 3,   default: "", null: false
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "towns", ["accent_city"], name: "accent_city", using: :btree
  add_index "towns", ["city"], name: "city", using: :btree
  add_index "towns", ["city_rus"], name: "city_rus", using: :btree
  add_index "towns", ["country_id"], name: "country_id", using: :btree
  add_index "towns", ["country_iso"], name: "country", using: :btree
  add_index "towns", ["id"], name: "id", unique: true, using: :btree

  create_table "user_themes", force: :cascade do |t|
    t.string   "theme",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_themes", ["theme"], name: "theme", unique: true, using: :btree

  create_table "user_tracings", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,     null: false
    t.string   "ip_address",  limit: 15
    t.text     "useragent",   limit: 65535
    t.datetime "sign_in_at",                null: false
    t.datetime "sign_out_at",               null: false
  end

  add_index "user_tracings", ["ip_address"], name: "ip_address", using: :btree
  add_index "user_tracings", ["user_id"], name: "index_user_tracings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",  null: false
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "username",               limit: 255,               null: false
    t.string   "time_zone",              limit: 255,               null: false
    t.integer  "town_id",                limit: 4,                 null: false
    t.integer  "country_id",             limit: 4,   default: 508, null: false
    t.integer  "user_theme_id",          limit: 4,   default: 1,   null: false
    t.integer  "role",                   limit: 4,   default: 1,   null: false
    t.integer  "aircompany_id",          limit: 4,   default: 1
    t.datetime "last_seen"
    t.string   "password_salt",          limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
