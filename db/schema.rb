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

ActiveRecord::Schema[7.0].define(version: 2023_06_13_154846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "points"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "animes", force: :cascade do |t|
    t.string "title"
    t.string "synopsis"
    t.date "date_start"
    t.date "date_finish"
    t.string "genre"
    t.integer "rating"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "episodecount"
    t.integer "api_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_comments_on_episode_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.date "date_aired"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "anime_id", null: false
    t.index ["anime_id"], name: "index_episodes_on_anime_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.integer "likes"
    t.bigint "user_id", null: false
    t.bigint "anime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_reviews_on_anime_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "image"
    t.string "title"
    t.date "date_start"
    t.date "date_finish"
    t.bigint "anime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_seasons_on_anime_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "photo"
    t.string "bio"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watchlists", force: :cascade do |t|
    t.boolean "status"
    t.string "notes"
    t.bigint "user_id", null: false
    t.bigint "anime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_watchlists_on_anime_id"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "achievements", "users"
  add_foreign_key "comments", "episodes"
  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "animes"
  add_foreign_key "reviews", "animes"
  add_foreign_key "reviews", "users"
  add_foreign_key "seasons", "animes"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "watchlists", "animes"
  add_foreign_key "watchlists", "users"
end
