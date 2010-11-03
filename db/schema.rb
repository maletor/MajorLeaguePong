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

ActiveRecord::Schema.define(:version => 20101103152919) do

  create_table "games", :force => true do |t|
    t.datetime "time"
    t.integer  "home_id"
    t.integer  "away_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rounds"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hit_count"
    t.integer  "shot_count"
    t.integer  "point_count"
    t.integer  "user_id"
    t.integer  "points",                                       :default => 0,   :null => false
    t.text     "profile",                                      :default => "",  :null => false
    t.decimal  "opp",            :precision => 8, :scale => 3
    t.decimal  "hit_percentage", :precision => 8, :scale => 3, :default => 0.0, :null => false
    t.integer  "last_cups",                                    :default => 0,   :null => false
    t.integer  "assholes"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "game_id"
    t.integer  "number",     :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shots", :force => true do |t|
    t.integer  "player_id"
    t.integer  "cup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "round_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "profile",                                  :default => "", :null => false
    t.integer  "points",                                   :default => 0,  :null => false
    t.decimal  "opp",        :precision => 8, :scale => 3
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
