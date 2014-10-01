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

ActiveRecord::Schema.define(version: 20141001135613) do

  create_table "error_logs", force: true do |t|
    t.string   "netid"
    t.string   "path"
    t.text     "message"
    t.text     "params"
    t.text     "stack_trace"
    t.datetime "created_at"
    t.string   "state"
    t.text     "user_agent"
    t.string   "exception_class"
  end

  create_table "primo_display_field_examples", force: true do |t|
    t.string   "key"
    t.string   "record_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primo_display_field_examples", ["key"], name: "index_primo_display_field_examples_on_key", using: :btree
  add_index "primo_display_field_examples", ["record_id"], name: "index_primo_display_field_examples_on_record_id", using: :btree

  create_table "primo_display_fields", force: true do |t|
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primo_display_fields", ["key"], name: "index_primo_display_fields_on_key", using: :btree

  create_table "stats_link_clicks", force: true do |t|
    t.string   "fulltext_title"
    t.integer  "stats_source_id"
    t.datetime "created_at"
  end

  add_index "stats_link_clicks", ["stats_source_id"], name: "index_stats_link_clicks_on_stats_source_id", using: :btree

  create_table "stats_sources", force: true do |t|
    t.string "primo_id"
    t.string "source"
  end

  add_index "stats_sources", ["primo_id"], name: "index_stats_sources_on_primo_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                       null: false
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
