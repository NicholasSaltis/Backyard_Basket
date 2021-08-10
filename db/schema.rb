# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_09_125458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "house_number"
    t.string "street_name"
    t.string "suburb"
    t.integer "postcode"
    t.string "state"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "country"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "topic"
    t.text "body"
    t.string "received_messageable_type"
    t.bigint "received_messageable_id"
    t.string "sent_messageable_type"
    t.bigint "sent_messageable_id"
    t.boolean "opened", default: false
    t.boolean "recipient_delete", default: false
    t.boolean "sender_delete", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "ancestry"
    t.boolean "recipient_permanent_delete", default: false
    t.boolean "sender_permanent_delete", default: false
    t.datetime "opened_at"
    t.index ["ancestry"], name: "index_messages_on_ancestry"
    t.index ["received_messageable_id", "received_messageable_type"], name: "acts_as_messageable_received"
    t.index ["sent_messageable_id", "received_messageable_id"], name: "acts_as_messageable_ids"
    t.index ["sent_messageable_id", "sent_messageable_type"], name: "acts_as_messageable_sent"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "organic"
    t.date "harvested_date"
    t.date "expiry_date"
    t.integer "stock"
    t.float "price_per_unit"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_products_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "bio"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "comment_text"
    t.date "comment_date"
    t.integer "rating"
    t.bigint "reviewer_id_id", null: false
    t.bigint "seller_id_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reviewer_id_id"], name: "index_reviews_on_reviewer_id_id"
    t.index ["seller_id_id"], name: "index_reviews_on_seller_id_id"
  end

  create_table "users", force: :cascade do |t|
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

  add_foreign_key "addresses", "profiles"
  add_foreign_key "products", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "profiles", column: "reviewer_id_id"
  add_foreign_key "reviews", "profiles", column: "seller_id_id"
end
