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

ActiveRecord::Schema[8.0].define(version: 2025_10_08_130608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"

  create_table "made_n_laid_statutory_instruments", force: :cascade do |t|
    t.string "uri", limit: 255, null: false
    t.string "title", limit: 500, null: false
    t.date "made_on", null: false
    t.date "laid_on", null: false
    t.string "procedure", limit: 255, null: false
    t.string "procedure_browser_url", limit: 255, null: false
    t.boolean "posted_to_bluesky", default: false
    t.boolean "posted_to_mastodon", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treaties", force: :cascade do |t|
    t.string "uri", limit: 255, null: false
    t.string "title", null: false
    t.string "lead_organisation_name", limit: 255, null: false
    t.string "series_citation", limit: 255, null: false
    t.date "laid_on", null: false
    t.string "procedure_browser_url", limit: 255, null: false
    t.boolean "posted_to_bluesky", default: false
    t.boolean "posted_to_mastodon", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
