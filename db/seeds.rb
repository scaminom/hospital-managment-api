# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Doctor.destroy_all
User.destroy_all
Department.destroy_all
MedicalRecord.destroy_all
Patient.destroy_all

patients = [
  {
    insurance_number: '123-AAA',
    first_name:       'John',
    last_name:        'Doe',
    date_of_birth:    '1990-01-01',
    gender:           'M',
    address:          '123 Main St',
    phone_number:     '0998874856',
    email:            'jhondoe@gmail.com',
    blood_type:       'A+',
    allergies:        'None',
    birth_place:      'New York'
  },
  {
    insurance_number: '456-BBB',
    first_name:       'Jane',
    last_name:        'Doe',
    date_of_birth:    '1992-01-01',
    gender:           'F',
    address:          '123 Main St',
    phone_number:     '0998874856',
    email:            'janedoe@gmail.com',
    blood_type:       'B+',
    allergies:        'None',
    birth_place:      'New York'
  }
]

patients.each do |patient|
  Patient.create!(patient)
end

medical_records = [
  {
    patient_id: Patient.find_by(first_name: 'John').id,
    notes:      'Patient has a history of heart disease'
  },
  {
    patient_id: Patient.find_by(first_name: 'Jane').id,
    notes:      'Patient has a history of heart disease'
  }
]

medical_records.each do |record|
  MedicalRecord.create!(record)
end

departments = [
  {
    name:  'Cardiology',
    floor: 1
  },
  {
    name:  'Dermatology',
    floor: 2
  }
]

departments.each do |department|
  Department.create!(department)
end

doctor_users = [
  {
    username:   'juanp',
    email:      'juanp@gmail.com',
    password:   'secure123as',
    role:       'doctor',
    first_name: 'Juan',
    last_name:  'Perez'
  }
]

doctor_users.each do |user|
  User.create!(user)
end

doctors = [
  {
    speciality:     'Cardiologist',
    license_number: 'AB123432',
    user_id:        User.find_by(username: 'juanp').id,
    department_id:  Department.find_by(name: 'Cardiology').id
  }
]

doctors.each do |doctor|
  Doctor.create!(doctor)
end

puts 'Data created'
