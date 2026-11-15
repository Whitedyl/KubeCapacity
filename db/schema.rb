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

ActiveRecord::Schema[8.1].define(version: 2026_11_14_235000) do
  create_table "sizing_scenarios", force: :cascade do |t|
    t.string "name"
    t.integer "replica_count"
    t.integer "cpu_request_millicores"
    t.integer "memory_request_megabytes"
    t.integer "node_cpu_millicores"
    t.integer "node_memory_megabytes"
    t.integer "system_reserved_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
