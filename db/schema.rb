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

ActiveRecord::Schema.define(version: 20141210110727) do

  create_table "cities", force: true do |t|
    t.string "title", null: false
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "screen_name"
    t.string   "photo_small"
    t.string   "photo"
    t.string   "photo_big"
    t.datetime "start"
    t.datetime "finish"
    t.text     "status"
    t.text     "description"
    t.string   "event_hash"
    t.integer  "place_id"
    t.integer  "city_id"
  end

  add_index "events", ["city_id"], name: "index_events_on_city_id"
  add_index "events", ["place_id"], name: "index_events_on_place_id"

  create_table "places", force: true do |t|
    t.string  "title"
    t.string  "la"
    t.string  "lo"
    t.string  "icon"
    t.integer "checkins"
    t.string  "address"
    t.integer "city_id_id"
  end

  add_index "places", ["city_id_id"], name: "index_places_on_city_id_id"

  create_table "users", force: true do |t|
    t.string   "first_name",                      null: false
    t.string   "last_name"
    t.string   "session_token",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "url"
    t.string   "avatar"
    t.string   "email"
    t.integer  "expiration"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id"

end
