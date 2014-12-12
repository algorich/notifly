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

ActiveRecord::Schema.define(version: 20141212122918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dummy_objects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "notifly_notifications", force: true do |t|
    t.string   "template"
    t.boolean  "read",          default: false
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.boolean  "seen",          default: false
    t.string   "mail"
    t.string   "kind",          default: "notification"
  end

  add_index "notifly_notifications", ["receiver_id", "receiver_type"], name: "index_notifly_notifications_on_receiver_id_and_receiver_type", using: :btree
  add_index "notifly_notifications", ["sender_id", "sender_type"], name: "index_notifly_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "notifly_notifications", ["target_id", "target_type"], name: "index_notifly_notifications_on_target_id_and_target_type", using: :btree

  create_table "posts", force: true do |t|
    t.string  "author"
    t.string  "title"
    t.text    "content"
    t.boolean "published",       default: false
    t.integer "dummy_object_id"
  end

  add_index "posts", ["dummy_object_id"], name: "index_posts_on_dummy_object_id", using: :btree

end
