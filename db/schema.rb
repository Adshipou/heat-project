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

ActiveRecord::Schema[7.0].define(version: 2024_04_15_232313) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "event_link"
    t.string "event_name"
    t.datetime "event_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "event_end"
    t.integer "event_points"
    t.text "event_description"
  end

  create_table "events_members", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_members_on_event_id"
    t.index ["member_id"], name: "index_events_members_on_member_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time"
    t.text "description"
  end

  create_table "meetings_members", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_meetings_members_on_meeting_id"
    t.index ["member_id"], name: "index_meetings_members_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "member_name"
    t.integer "member_points"
    t.boolean "executive_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events_members", "events"
  add_foreign_key "events_members", "members"
  add_foreign_key "meetings_members", "meetings"
  add_foreign_key "meetings_members", "members"
end
