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

ActiveRecord::Schema.define(version: 20151106045814) do

  create_table "airplanes", force: :cascade do |t|
    t.string   "hex"
    t.integer  "sqawk"
    t.string   "flight"
    t.float    "lat"
    t.float    "lon"
    t.integer  "validposition"
    t.integer  "altitude"
    t.integer  "vert_rate"
    t.integer  "track"
    t.integer  "validtrack"
    t.integer  "speed"
    t.integer  "messages"
    t.integer  "seen"
    t.boolean  "mlat"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "range"
    t.boolean  "is_inview"
  end

  create_table "settings", force: :cascade do |t|
    t.float    "cloudceiling"
    t.datetime "sunset"
    t.datetime "sunrise"
    t.float    "dayrange"
    t.float    "nightrange"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "originlat"
    t.float    "originlon"
    t.float    "rightlat"
    t.float    "rightlon"
    t.float    "leftlat"
    t.float    "leftlon"
    t.boolean  "use"
    t.boolean  "update_in_bg"
    t.boolean  "use_flightaware_api"
    t.time     "fa_starttime"
    t.time     "fa_stoptime"
    t.string   "dump1090url"
    t.integer  "refreshrate"
    t.float    "farrightlat"
    t.float    "farrightlon"
    t.float    "farleftlat"
    t.float    "farleftlon"
  end

end
