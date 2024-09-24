FactoryBot.define do
  factory :visit do
    medical_record { nil }
    visit_type { 1 }
    priority_level { 1 }
    start_date { "2024-09-24 14:42:53" }
    end_date { "2024-09-24 14:42:53" }
  end
end
