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

ActiveRecord::Schema[7.0].define(version: 2022_06_01_215603) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "executions", force: :cascade do |t|
    t.text "comment"
    t.bigint "realization_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_executions_on_exercise_id"
    t.index ["realization_id"], name: "index_executions_on_realization_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "therapist_id"
    t.index ["therapist_id"], name: "index_exercises_on_therapist_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "comment"
    t.integer "grade", default: 0
    t.boolean "show", default: false
    t.bigint "execution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["execution_id"], name: "index_feedbacks_on_execution_id"
  end

  create_table "frequencies", force: :cascade do |t|
    t.integer "repetition"
    t.integer "time"
    t.integer "series"
    t.bigint "exercise_id"
    t.bigint "training_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_frequencies_on_exercise_id"
    t.index ["training_id"], name: "index_frequencies_on_training_id"
  end

  create_table "orientations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_orientations_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.datetime "dt_nasc"
    t.datetime "dt_atend"
    t.text "resume"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "therapist_id"
    t.index ["therapist_id"], name: "index_patients_on_therapist_id"
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "realizations", force: :cascade do |t|
    t.text "comment"
    t.bigint "training_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_realizations_on_training_id"
  end

  create_table "therapists", force: :cascade do |t|
    t.string "name"
    t.datetime "dt_nasc"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_therapists_on_user_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.string "title"
    t.datetime "dt_start"
    t.datetime "dt_end"
    t.text "orientation"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["patient_id"], name: "index_trainings_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
