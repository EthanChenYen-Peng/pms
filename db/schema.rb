# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_05_090630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.string "name"
  end

  create_table "labels_projects", id: false, force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "project_id", null: false
    t.index ["label_id", "project_id"], name: "index_labels_projects_on_label_id_and_project_id", unique: true
    t.index ["project_id", "label_id"], name: "index_labels_projects_on_project_id_and_label_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "start_date"
    t.datetime "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.integer "priority", default: 0
    t.bigint "user_id"
    t.index ["title", "user_id"], name: "index_projects_on_title_and_user_id", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.integer "projects_count"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "projects", "users"
end
