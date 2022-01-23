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

ActiveRecord::Schema.define(version: 2022_01_18_123239) do

  create_table "weather_data", force: :cascade do |t|
    t.date "date"
    t.decimal "lat", precision: 15, scale: 4
    t.decimal "lon", precision: 15, scale: 4
    t.string "city"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weather_temps", force: :cascade do |t|
    t.decimal "temp", precision: 4, scale: 1
    t.integer "weather_datum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["weather_datum_id"], name: "index_weather_temps_on_weather_datum_id"
  end

  add_foreign_key "weather_temps", "weather_data"
end
