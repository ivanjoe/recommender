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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121217133407) do

  create_table "movies", :force => true do |t|
    t.string   "movie_title"
    t.date     "release_date"
    t.string   "imdb_url"
    t.boolean  "action"
    t.boolean  "adventure"
    t.boolean  "animation"
    t.boolean  "children"
    t.boolean  "comedy"
    t.boolean  "crime"
    t.boolean  "documentary"
    t.boolean  "drama"
    t.boolean  "fantasy"
    t.boolean  "film_noir"
    t.boolean  "horror"
    t.boolean  "musical"
    t.boolean  "mystery"
    t.boolean  "romance"
    t.boolean  "sci_fi"
    t.boolean  "thriller"
    t.boolean  "war"
    t.boolean  "western"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "movie_id"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "rating"
    t.datetime "rated_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
