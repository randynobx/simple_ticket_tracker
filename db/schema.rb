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

ActiveRecord::Schema.define(version: 20150206145329) do

  create_table "accounts", force: :cascade do |t|
    t.string   "category"
    t.string   "name"
    t.string   "business"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.date     "date"
    t.integer  "account_id"
    t.integer  "ticket_id"
    t.text     "notes"
    t.boolean  "settled"
    t.decimal  "income", :scale => 2
    t.decimal  "expense", :scale => 2
    t.decimal  "total", :scale => 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "records", ["account_id"], name: "index_records_on_account_id"
  add_index "records", ["ticket_id"], name: "index_records_on_ticket_id"

  create_table "services", force: :cascade do |t|
    t.string   "category"
    t.decimal  "price", :scale => 2
    t.string   "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.date     "date"
    t.integer  "account_id"
    t.integer  "service_id"
    t.text     "materialslist"
    t.decimal  "materialscost", :scale => 2
    t.decimal  "labor", :scale => 2
    t.decimal  "total", :scale => 2
    t.boolean  "closed"
    t.text     "worklog"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tickets", ["account_id"], name: "index_tickets_on_account_id"
  add_index "tickets", ["service_id"], name: "index_tickets_on_service_id"

end
