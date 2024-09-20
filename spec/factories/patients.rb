FactoryBot.define do
  factory :patient do
    insurance_number { 'MyString' }
    first_name { 'MyString' }
    last_name { 'MyString' }
    date_of_birth { '2024-09-20 00:08:33' }
    gender { 'MyString' }
    address { 'MyString' }
    phone_number { 'MyString' }
    email { 'MyString' }
    blood_type { 'MyString' }
    allergies { 'MyText' }
  end
end
