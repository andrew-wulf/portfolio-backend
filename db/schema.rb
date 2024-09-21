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

ActiveRecord::Schema[7.1].define(version: 2024_09_20_234157) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "keys", force: :cascade do |t|
    t.string "api"
    t.string "key1"
    t.string "key2"
    t.string "key3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lobbies", force: :cascade do |t|
    t.string "code"
    t.boolean "active", default: true
    t.boolean "full", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "lobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "quoted_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retweets", force: :cascade do |t|
    t.integer "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "timestamp"
    t.integer "retweet_id"
    t.integer "user_id"
    t.boolean "is_retweet", default: true
  end

  create_table "subtweets", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "sub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.integer "user_id"
    t.string "text"
    t.string "image"
    t.string "video"
    t.boolean "edited", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_subtweet", default: false
    t.boolean "is_quote", default: false
    t.integer "views", default: 0
    t.datetime "timestamp"
    t.integer "like_count", default: 0
    t.integer "retweet_count", default: 0
    t.integer "reply_count", default: 0
    t.boolean "is_retweet", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "display_name"
    t.string "avi"
    t.string "banner"
    t.string "bio"
    t.boolean "verified", default: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "follower_count", default: 0
    t.integer "following_count", default: 0
  end

  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
end
