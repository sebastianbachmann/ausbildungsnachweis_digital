FactoryBot.define do
  factory :activity_report do
    association :team
    title { "MyString" }
  end
end
