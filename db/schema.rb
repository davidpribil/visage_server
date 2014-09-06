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

ActiveRecord::Schema.define(version: 20140825174930) do

  create_table "ar_targets", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "data_url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.string   "ar_type"
    t.string   "ar_subtype"
    t.string   "feature_description_alignment"
    t.integer  "max_objects_to_detect_per_frame"
    t.integer  "max_objects_to_track_in_parallel"
    t.float    "similarity_threshold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poi_data_locations", force: true do |t|
    t.string   "position"
    t.string   "rotation"
    t.string   "scale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poi_data_id"
    t.string   "source"
    t.integer  "tab_id"
  end

  add_index "poi_data_locations", ["poi_data_id", "created_at"], name: "index_poi_data_locations_on_poi_data_id_and_created_at"

  create_table "poi_datas", force: true do |t|
    t.string   "description"
    t.string   "scale"
    t.binary   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poi_id"
    t.integer  "data_type",   default: 0
    t.string   "filename"
  end

  add_index "poi_datas", ["poi_id", "created_at"], name: "index_poi_datas_on_poi_id_and_created_at"

  create_table "pois", force: true do |t|
    t.string   "name"
    t.float    "target_height"
    t.float    "target_width"
    t.float    "gps_latitude"
    t.float    "gps_longitude"
    t.float    "similarity_threshold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
    t.string   "metaio_id"
    t.boolean  "enabled",              default: false
    t.binary   "marker_image"
    t.string   "tab_data"
    t.float    "height"
    t.float    "width"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
