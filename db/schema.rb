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

ActiveRecord::Schema.define(version: 20141010014613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "event_date"
    t.integer  "performer_id"
    t.decimal  "cost",         precision: 8, scale: 2
    t.boolean  "accepted"
    t.time     "event_time"
    t.integer  "user_id"
    t.boolean  "active",                               default: true
    t.string   "transfer_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "booking_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "performers", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "soundcloud_url"
    t.text     "description"
    t.decimal  "price",               precision: 8, scale: 2
    t.string   "recipient_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "location"
    t.boolean  "active",                                      default: true
  end

  create_table "recipients", force: true do |t|
    t.string "stripe_id", null: false
  end

  create_table "reviews", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "performer_id"
    t.text     "content"
    t.boolean  "hidden",       default: false, null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
