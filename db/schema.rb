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

ActiveRecord::Schema.define(version: 2021_11_21_130624) do

  create_table "checker_boards", charset: "latin1", force: :cascade do |t|
    t.integer "space_type"
    t.string "space_name"
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chess_infos", charset: "latin1", force: :cascade do |t|
    t.string "chess_id"
    t.string "chess_name"
    t.integer "chess_priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leader_boards", charset: "latin1", force: :cascade do |t|
    t.bigint "player_id"
    t.integer "win_count"
    t.integer "lose_count"
    t.integer "total_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_leader_boards_on_player_id"
  end

  create_table "players", charset: "latin1", force: :cascade do |t|
    t.string "user_id"
    t.string "player_name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", charset: "latin1", force: :cascade do |t|
    t.string "room_id"
    t.string "red_player_name"
    t.string "blue_player_name"
    t.boolean "room_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
