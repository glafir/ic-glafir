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

ActiveRecord::Schema.define(version: 20190118093659) do

  create_table "aircompanies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "airline_name_eng",                                                      null: false
    t.string   "alias",                            default: "",                         null: false
    t.string   "iata_code",              limit: 2,                                      null: false
    t.string   "icao_code",              limit: 3,                                      null: false
    t.string   "airline_name_eng_short"
    t.string   "country_str"
    t.string   "status",                 limit: 3
    t.string   "awb_prefix",             limit: 3
    t.string   "airline_name_rus"
    t.integer  "airport_id"
    t.integer  "country_id"
    t.integer  "al_start"
    t.integer  "al_finish"
    t.datetime "created_at",                       default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at",                       default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer  "timetableaps_count",               default: 0,                          null: false
    t.integer  "manager_id"
    t.string   "avatar"
    t.index ["airline_name_eng"], name: "airline_name_eng", using: :btree
    t.index ["airport_id"], name: "Base_airport", using: :btree
    t.index ["country_id"], name: "country_id", using: :btree
    t.index ["iata_code"], name: "iata_code", using: :btree
    t.index ["icao_code"], name: "icao_code", using: :btree
    t.index ["id"], name: "id", unique: true, using: :btree
    t.index ["manager_id"], name: "manager_id", using: :btree
  end

  create_table "aircraft_companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "aircraft_company", null: false
    t.integer  "country_id",       null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "aircraft_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "atype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aircraft_wake_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aircrafts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "aircraft_model"
    t.string   "aircraft_icao_code"
    t.string   "aircraft_iata_code"
    t.integer  "aircraft_seats"
    t.integer  "aircraft_wake_category_id"
    t.string   "aircraft_webinfo"
    t.integer  "aircraft_type_id"
    t.integer  "aircraft_maxspeed"
    t.integer  "aircraft_company_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "airline_codeshares", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "aircompany_id"
    t.integer  "codeshare_id"
    t.date     "code_share_start"
    t.date     "code_share_finish"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "airpor_size_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airport_air_traffics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "klass",      null: false
    t.integer  "max_pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airport_distances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "airport_start_id"
    t.integer  "airport_finish_id"
    t.float    "distance",          limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "airport_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airport_terminal_gates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "airport_terminal_id"
    t.string   "gate"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "airport_terminals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "airport_id"
    t.string   "terminal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "iata_code",              limit: 3,  null: false
    t.string   "icao_code",              limit: 4,  null: false
    t.string   "name_rus"
    t.string   "name_eng"
    t.string   "city_rus"
    t.string   "city_eng"
    t.string   "gmt_offset"
    t.string   "iso_code",               limit: 2
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
    t.integer  "airport_air_traffic_id"
    t.integer  "weather_state"
    t.integer  "airport_state_id"
    t.string   "time_zone",              limit: 50
    t.integer  "country_id"
    t.integer  "aircompanies_count"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["airport_air_traffic_id"], name: "airport_air_traffic_id", using: :btree
    t.index ["airport_state_id"], name: "airport_state_id", using: :btree
    t.index ["city_eng"], name: "city_eng", type: :fulltext
    t.index ["city_rus"], name: "city_rus", type: :fulltext
    t.index ["country_id"], name: "country_id", using: :btree
    t.index ["iata_code"], name: "iata_code", unique: true, using: :btree
    t.index ["icao_code"], name: "icao_code", using: :btree
    t.index ["latitude"], name: "latitude", using: :btree
    t.index ["longitude"], name: "longitude", using: :btree
    t.index ["name_eng"], name: "name_eng", type: :fulltext
    t.index ["name_rus"], name: "name_rus", type: :fulltext
    t.index ["town_id"], name: "town_id", using: :btree
    t.index ["weather_state"], name: "weather_state", using: :btree
  end

  create_table "aphubs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "airport_id",                null: false
    t.integer  "aircompany_id",             null: false
    t.integer  "hub_type",      default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["aircompany_id"], name: "aircompany_id", using: :btree
    t.index ["airport_id", "aircompany_id", "hub_type"], name: "airport_id_aircompany_id_hub_type", unique: true, using: :btree
    t.index ["airport_id"], name: "airport_id", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "country_name"
    t.string   "country_iata_code"
    t.string   "country_icao_code"
    t.integer  "country_number"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "flash_message_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flash_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                             null: false
    t.string   "message",                             null: false
    t.string   "request_url",                         null: false
    t.string   "request_ip",             limit: 15,   null: false
    t.string   "request_method",         limit: 6,    null: false
    t.string   "request_referrer",       limit: 1000, null: false
    t.string   "useragent",              limit: 1000, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "flash_message_state_id"
  end

  create_table "flight_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "flight_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "lang"
    t.string   "lang_iso"
    t.string   "lang_iata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "old_passwords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "encrypted_password",    null: false
    t.string   "password_salt"
    t.string   "password_history_type", null: false
    t.integer  "password_history_id",   null: false
    t.datetime "created_at"
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_rus"
    t.string   "name_eng"
    t.integer  "country_id"
    t.float    "area",           limit: 24
    t.integer  "population"
    t.integer  "capitalcity_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "runway_aps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "airport_id"
    t.string   "runway_name",      limit: 5
    t.integer  "runway_elevation"
    t.string   "runway_data"
    t.datetime "created_at",                 null: false
    t.integer  "runway_length"
    t.datetime "updated_at",                 null: false
  end

  create_table "rw_routes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "start_route"
    t.integer  "end_route"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "sign_in_failures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "ip_address"
    t.string   "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "typename",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_zones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "station_id"
    t.string   "zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "station_zone_id", limit: 4, default: "0000", null: false
    t.string   "name_eng",                                   null: false
    t.string   "name_rus",                                   null: false
    t.integer  "station_type_id",           default: 5,      null: false
    t.integer  "rw_route_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terminals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "marking"
    t.integer  "floor"
    t.integer  "reception"
    t.integer  "parking"
    t.integer  "teletrap"
    t.integer  "gate"
    t.integer  "airport_id"
    t.float    "area",       limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "timetableaps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "flight_number",     null: false
    t.integer  "aircompany_id",     null: false
    t.integer  "parent_id"
    t.integer  "airport_start_id",  null: false
    t.integer  "airport_finish_id", null: false
    t.integer  "TermStart"
    t.integer  "GateStart"
    t.integer  "TermEnd"
    t.integer  "GateEnd"
    t.integer  "aircraft_id"
    t.time     "timeStart",         null: false
    t.time     "timeEnd",           null: false
    t.date     "dateOfStartNav",    null: false
    t.date     "dateOfEndNav",      null: false
    t.integer  "s1",                null: false
    t.integer  "s2",                null: false
    t.integer  "s3",                null: false
    t.integer  "s4",                null: false
    t.integer  "s5",                null: false
    t.integer  "s6",                null: false
    t.integer  "s0",                null: false
    t.integer  "e1",                null: false
    t.integer  "e2",                null: false
    t.integer  "e3",                null: false
    t.integer  "e4",                null: false
    t.integer  "e5",                null: false
    t.integer  "e6",                null: false
    t.integer  "e0",                null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["aircraft_id"], name: "aircraft_id", using: :btree
    t.index ["airport_finish_id"], name: "airport_finish_id", using: :btree
    t.index ["airport_start_id"], name: "airport_start_id", using: :btree
    t.index ["flight_number", "aircompany_id"], name: "Flight_Number_aircompany_id", unique: true, using: :btree
    t.index ["id", "parent_id"], name: "id", unique: true, using: :btree
    t.index ["parent_id"], name: "parent_id", using: :btree
    t.index ["timeEnd"], name: "timeEnd", using: :btree
    t.index ["timeStart"], name: "timeStart", using: :btree
  end

  create_table "timetablesap_flights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "Flight_Number",             default: 0, null: false
    t.integer  "aircompany_id",                         null: false
    t.integer  "way_start",                             null: false
    t.integer  "runway_start",                          null: false
    t.integer  "way_end",                               null: false
    t.integer  "runway_end",                            null: false
    t.string   "TermStart",      limit: 50
    t.string   "TermEnd",        limit: 50
    t.string   "GateStart",      limit: 50
    t.string   "GateEnd",        limit: 50
    t.string   "TypeOfPlane",    limit: 50
    t.datetime "start",                                 null: false
    t.datetime "end",                                   null: false
    t.datetime "created_at",                            null: false
    t.integer  "flight_type_id",                        null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "towns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "country_iso", limit: 3,  default: "", null: false
    t.integer  "country_id"
    t.string   "city",                   default: "", null: false
    t.string   "accent_city",            default: "", null: false
    t.string   "city_rus",               default: ""
    t.string   "region",      limit: 3,  default: "", null: false
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["accent_city"], name: "accent_city", using: :btree
    t.index ["accent_city"], name: "accent_city_full_text", type: :fulltext
    t.index ["city"], name: "city", using: :btree
    t.index ["city"], name: "city_full_text", type: :fulltext
    t.index ["city_rus"], name: "city_rus", using: :btree
    t.index ["city_rus"], name: "city_rus_full_text", type: :fulltext
    t.index ["country_id"], name: "country_id", using: :btree
    t.index ["country_iso"], name: "country", using: :btree
    t.index ["id"], name: "id", unique: true, using: :btree
    t.index ["latitude"], name: "latitude", using: :btree
    t.index ["longitude", "latitude"], name: "longitude", using: :btree
  end

  create_table "translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value",          limit: 65535
    t.text     "interpolations", limit: 65535
    t.boolean  "is_proc",                      default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "user_themes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "theme",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["theme"], name: "theme", unique: true, using: :btree
  end

  create_table "user_tracings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                   null: false
    t.string   "ip_address",  limit: 15
    t.text     "useragent",   limit: 65535
    t.datetime "sign_in_at",                null: false
    t.datetime "sign_out_at",               null: false
    t.index ["ip_address"], name: "ip_address", using: :btree
    t.index ["user_id"], name: "index_user_tracings_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "username",                             null: false
    t.string   "time_zone",                            null: false
    t.integer  "town_id",                              null: false
    t.integer  "country_id",             default: 508, null: false
    t.integer  "user_theme_id",          default: 1,   null: false
    t.integer  "role",                   default: 1,   null: false
    t.integer  "aircompany_id",          default: 1
    t.datetime "last_seen"
    t.string   "password_salt"
    t.string   "avatar"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "language_id",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "weather_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "weather_id"
    t.string   "main"
    t.string   "description"
    t.string   "icon"
    t.integer  "weather_icon_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["description"], name: "description", using: :btree
    t.index ["icon"], name: "icon", using: :btree
    t.index ["main"], name: "main", using: :btree
    t.index ["weather_icon_id"], name: "weather_icon_id", using: :btree
    t.index ["weather_id"], name: "weather_id", using: :btree
  end

  create_table "weathers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "place_id"
    t.float    "temp",                limit: 24
    t.float    "temp_min",            limit: 24
    t.float    "temp_max",            limit: 24
    t.float    "pressure",            limit: 24
    t.float    "pressure_sea_level",  limit: 24
    t.float    "pressure_grnd_level", limit: 24
    t.float    "wind_speed",          limit: 24
    t.float    "wind_deg",            limit: 24
    t.float    "humidity",            limit: 24
    t.integer  "clouds"
    t.integer  "dt"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["clouds"], name: "clouds", using: :btree
    t.index ["dt"], name: "dt", using: :btree
    t.index ["humidity"], name: "humidity", using: :btree
    t.index ["place_id", "temp"], name: "place_id", using: :btree
    t.index ["pressure"], name: "pressure", using: :btree
    t.index ["temp"], name: "temp", using: :btree
    t.index ["wind_deg"], name: "wind_deg", using: :btree
    t.index ["wind_speed"], name: "wind_speed", using: :btree
  end

end
