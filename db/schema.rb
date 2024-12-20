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

ActiveRecord::Schema[7.0].define(version: 2024_12_20_155931) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "samples", force: :cascade do |t|
    t.string "code", null: false
    t.text "results", null: false
    t.bigint "user_id", null: false
    t.bigint "laboratorista_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tenant_id", null: false
    t.index ["code"], name: "index_samples_on_code", unique: true
    t.index ["laboratorista_id"], name: "index_samples_on_laboratorista_id"
    t.index ["tenant_id"], name: "index_samples_on_tenant_id"
    t.index ["user_id"], name: "index_samples_on_user_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "role", default: 2, null: false
    t.bigint "tenant_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "samples", "tenants"
  add_foreign_key "samples", "users", column: "laboratorista_id", on_delete: :cascade
  add_foreign_key "samples", "users", on_delete: :cascade
  add_foreign_key "users", "tenants"
end
