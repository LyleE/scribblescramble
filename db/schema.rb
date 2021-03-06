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

ActiveRecord::Schema.define(version: 20130824210515) do

  create_table "scribble_types", force: true do |t|
    t.string  "name"
    t.string  "full_name"
    t.integer "count",     default: 0
  end

  create_table "scribbles", force: true do |t|
    t.string  "s3_key"
    t.integer "scribble_type_id"
    t.integer "user_id"
    t.integer "last_rated",       default: 0
  end

  add_index "scribbles", ["scribble_type_id"], name: "type_index"

  create_table "users", force: true do |t|
    t.string   "username",                           null: false
    t.string   "happy_notifications", default: ""
    t.string   "sad_notifications",   default: ""
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "rating",              default: 1600
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
