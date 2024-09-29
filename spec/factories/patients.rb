FactoryBot.define do
  factory :patient do
    insurance_number { "#{Faker::Number.number(digits: 3)}-#{Faker::Alphanumeric.alpha(number: 3).upcase}" }
    first_name { Faker::Name.first_name.gsub(/[^a-zA-Z]/, '')[0...50] }
    last_name { Faker::Name.last_name.gsub(/[^a-zA-Z]/, '')[0...50] }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 90) }
    gender { Patient::VALID_GENDERS.sample }
    address { Faker::Address.full_address }
    phone_number { Faker::Number.number(digits: 10).to_s }
    sequence(:email) { |n| "#{Faker::Internet.user_name(specifier: 10)}#{n}@#{Faker::Internet.domain_name}" }
    blood_type { Patient::VALID_BLOOD_TYPES.sample }
    allergies { Faker::Lorem.paragraph(sentence_count: 2)[0...255] }
  end
end

