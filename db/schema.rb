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

ActiveRecord::Schema.define(version: 20141017155223) do

  create_table "page_views", force: true do |t|
    t.string   "url"
    t.string   "referrer"
    t.datetime "created_at"
    t.string   "hash"
  end

  add_index "page_views", ["created_at", "url"], name: "index_page_views_on_created_at_and_url", using: :btree
  add_index "page_views", ["created_at"], name: "index_page_views_on_created_at", using: :btree
  add_index "page_views", ["url"], name: "index_page_views_on_url", using: :btree

end
