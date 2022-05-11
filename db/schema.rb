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

ActiveRecord::Schema.define(version: 2022_05_11_022524) do

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "task_instances", force: :cascade do |t|
    t.text "notes"
    t.date "due_date", null: false
    t.boolean "complete", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "task_id", null: false
    t.integer "user_id"
    t.index ["task_id"], name: "index_task_instances_on_task_id"
    t.index ["user_id"], name: "index_task_instances_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "due_date", null: false
    t.string "recurrence_type", default: ""
    t.integer "separation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id", null: false
    t.integer "user_id"
    t.integer "visibility_delay"
    t.index ["group_id"], name: "index_tasks_on_group_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_group_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["group_id"], name: "index_user_group_assignments_on_group_id"
    t.index ["user_id"], name: "index_user_group_assignments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "task_instances", "tasks"
  add_foreign_key "task_instances", "tasks", on_delete: :cascade
  add_foreign_key "task_instances", "users"
  add_foreign_key "tasks", "groups"
  add_foreign_key "tasks", "groups", on_delete: :cascade
  add_foreign_key "tasks", "users"
  add_foreign_key "user_group_assignments", "groups"
  add_foreign_key "user_group_assignments", "groups", on_delete: :cascade
  add_foreign_key "user_group_assignments", "users"
  add_foreign_key "user_group_assignments", "users", on_delete: :cascade
end
