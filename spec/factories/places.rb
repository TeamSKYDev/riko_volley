FactoryBot.define do
  factory :place do
    name { Faker::Lorem.characters(number:10) }
  end
end