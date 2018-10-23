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

ActiveRecord::Schema.define(version: 2018_07_06_051048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "rate"
    t.string "mortgage_type"
    t.string "term"
    t.integer "amortization"
    t.decimal "broker_fee"
    t.decimal "lender_fee"
    t.string "pre_payment_penalties"
    t.text "comments"
    t.string "status"
    t.integer "user_id"
    t.integer "borrower_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "borrower_requests", force: :cascade do |t|
    t.string "mortgage_type"
    t.text "property_address"
    t.integer "property_value"
    t.integer "credit_score"
    t.string "mortagage_level"
    t.text "description"
    t.integer "user_id"
    t.text "place"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "status", default: "draft"
    t.datetime "bidding_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
  end

  create_table "broker_invitations", force: :cascade do |t|
    t.integer "borrower_request_id"
    t.integer "user_id"
    t.datetime "invitation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coins"
    t.text "benefit_description"
    t.string "stripe_package_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "title"
    t.text "languages"
    t.text "mortgage_types"
    t.text "areas"
    t.string "company"
    t.text "company_address"
    t.text "telephone_numbers"
    t.string "facebook_link"
    t.string "twitter_link"
    t.string "youtube_link"
    t.string "linked_in_link"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "package_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "package_id"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.string "stripe_invoice_id"
    t.boolean "is_active"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bid_id"
    t.string "transaction_type"
    t.string "transaction_source"
    t.integer "coins"
    t.datetime "transacted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role_id", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verification_status", default: "not_verified"
    t.string "stripe_customer_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
