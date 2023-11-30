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

ActiveRecord::Schema[7.1].define(version: 2023_11_28_210511) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "inns", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.string "description"
    t.string "payment_methods"
    t.boolean "accepts_pets"
    t.string "usage_policies"
    t.time "check_in"
    t.time "check_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.float "average_rating"
    t.index ["admin_id"], name: "index_inns_on_admin_id"
  end

  create_table "price_customizations", force: :cascade do |t|
    t.integer "room_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "daily_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season"
    t.string "season_name"
    t.index ["room_id"], name: "index_price_customizations_on_room_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "grade"
    t.string "comment"
    t.integer "room_reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["room_reservation_id"], name: "index_ratings_on_room_reservation_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "review_responses", force: :cascade do |t|
    t.string "comment"
    t.integer "rating_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rating_id"], name: "index_review_responses_on_rating_id"
  end

  create_table "room_reservations", force: :cascade do |t|
    t.date "check_in"
    t.date "check_out"
    t.string "quantity"
    t.integer "number_of_guests"
    t.integer "room_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_daily_rates"
    t.string "code"
    t.integer "status", default: 5
    t.datetime "guest_arrival"
    t.string "chosen_payment_method"
    t.datetime "guest_departure"
    t.integer "paid"
    t.index ["room_id"], name: "index_room_reservations_on_room_id"
    t.index ["user_id"], name: "index_room_reservations_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "inn_id", null: false
    t.string "title"
    t.string "description"
    t.integer "dimension"
    t.integer "max_occupancy"
    t.integer "daily_rate"
    t.boolean "private_bathroom", default: false
    t.boolean "balcony", default: false
    t.boolean "air_conditioning", default: false
    t.boolean "tv", default: false
    t.boolean "wardrobe", default: false
    t.boolean "safe_available", default: false
    t.boolean "accessible_for_disabled", default: false
    t.integer "for_reservations", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "inns", "admins"
  add_foreign_key "price_customizations", "rooms"
  add_foreign_key "ratings", "room_reservations"
  add_foreign_key "ratings", "users"
  add_foreign_key "review_responses", "ratings"
  add_foreign_key "room_reservations", "rooms"
  add_foreign_key "room_reservations", "users"
  add_foreign_key "rooms", "inns"
end
