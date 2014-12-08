FactoryGirl.define do
  factory :user do
    first_name{Faker::Name.first_name}
    last_name{Faker::Name.last_name}
    id{Faker::Number.between(1,2000)}
    association :city
    session_token{Faker::Lorem.characters(10)}
  end
end