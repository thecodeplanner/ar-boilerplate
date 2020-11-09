# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_09_193053) do

  create_table "gardenplants", force: :cascade do |t|
    t.integer "garden_id"
    t.integer "plant_id"
    t.string "status"
  end

  create_table "gardens", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "garden_name"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
  end

end
