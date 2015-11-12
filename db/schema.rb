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

ActiveRecord::Schema.define(version: 20151105021104) do

  create_table "projects", force: :cascade do |t|
    t.string   "author"
    t.string   "title"
    t.string   "level"
    t.string   "category"
    t.text     "description"
    t.string   "status"
    t.integer  "percentage"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "difficult"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

end
