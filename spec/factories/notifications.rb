FactoryBot.define do
  factory :notification do
    status { true }
    days_before { 1 }
  end
end