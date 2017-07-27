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

ActiveRecord::Schema.define(version: 20140422150554) do

  create_table "error_logs", force: :cascade do |t|
    t.string   "netid",           limit: 255
    t.string   "path",            limit: 255
    t.text     "message",         limit: 65535
    t.text     "params",          limit: 65535
    t.text     "stack_trace",     limit: 65535
    t.datetime "created_at"
    t.string   "state",           limit: 255
    t.text     "user_agent",      limit: 65535
    t.string   "exception_class", limit: 255
  end

  create_table "primo_display_field_examples", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "record_id",  limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primo_display_field_examples", ["key"], name: "index_primo_display_field_examples_on_key", using: :btree
  add_index "primo_display_field_examples", ["record_id"], name: "index_primo_display_field_examples_on_record_id", using: :btree

  create_table "primo_display_fields", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primo_display_fields", ["key"], name: "index_primo_display_fields_on_key", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 255,             null: false
    t.integer  "sign_in_count",      limit: 4,   default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
