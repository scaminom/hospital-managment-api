FactoryBot.define do
  factory :doctor do
    first_name { "MyString" }
    last_name { "MyString" }
    speciality { "MyString" }
    license_number { "MyString" }
    department { nil }
  end
end
