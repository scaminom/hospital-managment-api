FactoryBot.define do
  factory :visit do
    medical_record { nil }
    visit_type { 1 }
    priority_level { 1 }
    start_date { "2024-09-20 00:19:28" }
    end_date { "2024-09-20 00:19:28" }
  end
end
