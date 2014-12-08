FactoryGirl.define do
  factory :city do
    id{Faker::Number.between(2,100)}
    title{Faker::Address.city}
    factory :first_city do
      id 1
    end
  end
end