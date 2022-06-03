FactoryBot.define do
  factory :activity do
    association :team
    description { "MyText" }
    duration_of_work { "9.99" }
    place_of_training { "MyString" }
  end
end
