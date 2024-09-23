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

ActiveRecord::Schema[7.1].define(version: 20_240_923_231_259) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'departments', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'floor', null: false
  end

  create_table 'doctors', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'speciality', null: false
    t.string 'license_number', null: false
    t.bigint 'department_id', null: false
    t.index ['department_id'], name: 'index_doctors_on_department_id'
  end

  create_table 'medical_records', force: :cascade do |t|
    t.bigint 'patient_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['patient_id'], name: 'index_medical_records_on_patient_id'
  end

  create_table 'patients', force: :cascade do |t|
    t.string 'insurance_number', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.datetime 'date_of_birth', null: false
    t.string 'gender', null: false
    t.string 'address', null: false
    t.string 'phone_number', null: false
    t.string 'email', null: false
    t.string 'blood_type', null: false
    t.text 'allergies', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_patients_on_email', unique: true
    t.index ['insurance_number'], name: 'index_patients_on_insurance_number', unique: true
  end

  create_table 'visits', force: :cascade do |t|
    t.bigint 'medical_record_id', null: false
    t.integer 'visit_type', default: 0, null: false
    t.integer 'priority_level', null: false
    t.datetime 'start_date', null: false
    t.datetime 'end_date', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['medical_record_id'], name: 'index_visits_on_medical_record_id'
  end

  add_foreign_key 'doctors', 'departments'
  add_foreign_key 'medical_records', 'patients'
  add_foreign_key 'visits', 'medical_records'
end
