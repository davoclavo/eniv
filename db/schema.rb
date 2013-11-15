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

ActiveRecord::Schema.define(version: 20131115061601) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "posts", force: true do |t|
    t.string   "vine_id",             null: false
    t.string   "hashed_id"
    t.integer  "user_id"
    t.text     "video_url"
    t.text     "reversed_video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.text     "thumbnail_url"
    t.string   "share_url"
    t.string   "foursquare_venue_id"
    t.datetime "vine_created_at"
    t.text     "video_low_url"
    t.boolean  "verified"
    t.boolean  "post_to_facebook"
    t.boolean  "post_to_twitter"
    t.integer  "repost_count"
    t.integer  "like_count"
    t.integer  "post_flags"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "vine_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "avatar_url"
    t.string   "description"
    t.string   "location"
    t.string   "locale"
    t.boolean  "private"
    t.boolean  "verified"
    t.boolean  "explicit_content"
    t.boolean  "reposts_enabled"
    t.integer  "following_count"
    t.integer  "follower_count"
    t.integer  "post_count"
    t.integer  "authored_post_count"
    t.integer  "like_count"
  end

end
