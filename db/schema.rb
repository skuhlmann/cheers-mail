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

ActiveRecord::Schema.define(version: 20150507203742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: true do |t|
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "season"
    t.integer  "series_id"
  end

  add_index "episodes", ["series_id"], name: "index_episodes_on_series_id", using: :btree

  create_table "series", force: true do |t|
    t.string  "name"
    t.integer "seasons"
  end

  create_table "series_requests", force: true do |t|
    t.string   "name"
    t.integer  "subscription_id"
    t.boolean  "fulfilled",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_subscriptions", force: true do |t|
    t.integer  "subscription_id"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "series_subscriptions", ["series_id"], name: "index_series_subscriptions_on_series_id", using: :btree
  add_index "series_subscriptions", ["subscription_id"], name: "index_series_subscriptions_on_subscription_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "email_address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email_address"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
