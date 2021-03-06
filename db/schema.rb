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

ActiveRecord::Schema.define(version: 20141214211625) do

  create_table "admins", force: true do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "aliases", force: true do |t|
    t.string   "user_source",           limit: 255
    t.integer  "domain_source_id",      limit: 4
    t.integer  "user_destination_id",   limit: 4
    t.integer  "domain_destination_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "domains", force: true do |t|
    t.string   "name",       limit: 255
    t.integer  "admin_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "domains", ["admin_id"], name: "index_domains_on_admin_id", using: :btree

  create_table "forwardings", force: true do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "domain_id",   limit: 4
    t.string   "destination", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "forwardings", ["domain_id"], name: "index_forwardings_on_domain_id", using: :btree
  add_index "forwardings", ["user_id"], name: "index_forwardings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "domain_id",  limit: 4
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["domain_id"], name: "index_users_on_domain_id", using: :btree

  add_foreign_key "domains", "admins"
  add_foreign_key "forwardings", "domains"
  add_foreign_key "forwardings", "users"
  add_foreign_key "users", "domains"
end
