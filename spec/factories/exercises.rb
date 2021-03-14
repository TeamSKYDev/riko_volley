FactoryBot.define do
  factory :exercise do
    place_name { Faker::Lorem.characters(number:10) }
    started_at { Faker::Time.between(from: DateTime.current, to: DateTime.current + 1) }
    ended_at { Faker::Time.between(from: Time.current, to: Time.current + 1) }
    post
  end
end