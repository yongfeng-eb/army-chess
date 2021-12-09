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

ActiveRecord::Schema.define(version: 2021_12_08_011106) do

  create_table "all_chesses", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "chess_id"
    t.string "chess_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blank_spaces", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "x_position"
    t.integer "y_position"
    t.string "position_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chess_id"
  end

  create_table "chess_infos", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "chess_id"
    t.string "chess_name"
    t.integer "chess_priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lattices", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "space_id"
    t.integer "x_position"
    t.integer "y_position"
    t.string "near_lattice"
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

  create_table "line_of_spaces", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "one_x_position"
    t.integer "one_y_position"
    t.integer "two_x_position"
    t.integer "two_y_position"
    t.boolean "is_connected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "player_is_playings", charset: "latin1", force: :cascade do |t|
    t.boolean "player_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", charset: "latin1", force: :cascade do |t|
    t.string "user_id"
    t.string "player_name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_playing"
    t.boolean "is_login"
  end

  create_table "preset_chess_infos", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "preset_owners_id"
    t.string "chess_id"
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_placed"
    t.index ["preset_owners_id"], name: "index_preset_chess_infos_on_preset_owners_id"
  end

  create_table "preset_owners", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "players_id"
    t.integer "preset_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["players_id"], name: "index_preset_owners_on_players_id"
  end

  create_table "realtime_infos", charset: "latin1", force: :cascade do |t|
    t.integer "game_id"
    t.string "chess_id"
    t.integer "src_x_position"
    t.integer "src_y_position"
    t.integer "dst_x_position"
    t.integer "dst_y_position"
    t.string "position_type"
    t.integer "which_hand"
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
    t.boolean "next_turn"
    t.string "red_player_id"
    t.string "blue_player_id"
    t.boolean "is_game_over"
  end

  add_foreign_key "preset_chess_infos", "preset_owners", column: "preset_owners_id"
  add_foreign_key "preset_owners", "players", column: "players_id"
end
