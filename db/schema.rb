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

ActiveRecord::Schema.define(version: 20160501190945) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer  "performance_fee"
    t.integer  "total"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "bookings", ["profile_id"], name: "index_bookings_on_profile_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feedbacks", ["booking_id"], name: "index_feedbacks_on_booking_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["profile_id"], name: "index_photos_on_profile_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "category"
    t.integer  "member"
    t.string   "profile_name"
    t.text     "bio"
    t.string   "location"
    t.boolean  "is_english"
    t.boolean  "is_indonesia"
    t.boolean  "is_travel"
    t.boolean  "is_wedding"
    t.boolean  "is_corporate"
    t.boolean  "is_private"
    t.boolean  "is_birthday"
    t.boolean  "is_school"
    t.boolean  "is_cafe"
    t.integer  "performance_fee"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "star",       default: 1
    t.integer  "profile_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reviews", ["profile_id"], name: "index_reviews_on_profile_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fullname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "phone_number"
    t.text     "description"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
