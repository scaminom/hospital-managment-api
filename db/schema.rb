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

ActiveRecord::Schema[7.1].define(version: 2024_09_29_135357) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anamneses", force: :cascade do |t|
    t.string "gender", null: false
    t.integer "age", null: false
    t.string "birth_place", null: false
    t.string "current_residence", null: false
    t.string "education_level", null: false
    t.string "occupation", null: false
    t.string "marital_status", null: false
    t.string "blood_type", null: false
    t.string "religion", null: false
    t.string "handedness", null: false
    t.string "family_reference", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "visit_id", null: false
    t.index ["visit_id"], name: "index_anamneses_on_visit_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "floor", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "speciality", null: false
    t.string "license_number", null: false
    t.bigint "user_id", null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_doctors_on_department_id"
    t.index ["license_number"], name: "index_doctors_on_license_number", unique: true
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "laboratory_results", force: :cascade do |t|
    t.string "test_type", null: false
    t.string "test_name", null: false
    t.text "test_result", null: false
    t.datetime "performed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "visit_id"
    t.index ["visit_id"], name: "index_laboratory_results_on_visit_id"
  end

  create_table "medical_records", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_medical_records_on_doctor_id"
    t.index ["patient_id"], name: "index_medical_records_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "insurance_number", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "date_of_birth", null: false
    t.string "gender", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.string "blood_type", null: false
    t.text "allergies", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["insurance_number"], name: "index_patients_on_insurance_number", unique: true
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "medication", null: false
    t.string "dosage", null: false
    t.string "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "visit_id"
    t.index ["visit_id"], name: "index_prescriptions_on_visit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.integer "role", default: 0, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "visit_type", null: false
    t.integer "priority_level", null: false
    t.datetime "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medical_record_id", null: false
    t.index ["medical_record_id"], name: "index_visits_on_medical_record_id"
  end

  add_foreign_key "anamneses", "visits"
  add_foreign_key "doctors", "departments"
  add_foreign_key "doctors", "users"
  add_foreign_key "laboratory_results", "visits"
  add_foreign_key "medical_records", "doctors"
  add_foreign_key "medical_records", "patients"
  add_foreign_key "prescriptions", "visits"
  add_foreign_key "visits", "medical_records"
end
