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

ActiveRecord::Schema.define(version: 2019_10_02_124440) do

  create_table "affiliations", force: :cascade do |t|
    t.string "name"
  end

  create_table "affiliations_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "affiliation_id", null: false
    t.index ["person_id", "affiliation_id"], name: "index_affiliations_people_on_person_id_and_affiliation_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "locations_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "location_id", null: false
    t.index ["person_id", "location_id"], name: "index_locations_people_on_person_id_and_location_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "species"
    t.string "weapon"
    t.string "vehicle"
  end

end
