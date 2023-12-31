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

ActiveRecord::Schema[7.0].define(version: 2023_06_21_143242) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
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
    t.integer "rank"
    t.text "image_urls", default: [], array: true
    t.string "embed_url"
    t.string "status"
    t.text "producers", default: [], array: true
    t.text "themes", default: [], array: true
    t.string "slug"
    t.index ["slug"], name: "index_animes_on_slug", unique: true
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
    t.integer "episodenumber"
    t.integer "duration"
    t.index ["anime_id"], name: "index_episodes_on_anime_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
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

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo", default: "https://robohash.org/consequunturmagnamdolores.png?size=300x300&set=set1"
    t.string "bio"
    t.integer "points", default: 0
    t.string "username"
    t.string "banner", default: "https://images.alphacoders.com/131/1318300.png"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
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

  add_foreign_key "comments", "episodes"
  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "animes"
  add_foreign_key "reviews", "animes"
  add_foreign_key "reviews", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "watchlists", "animes"
  add_foreign_key "watchlists", "users"
end
