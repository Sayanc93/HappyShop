FactoryGirl.define do
  factory :product do
    name { Faker::StarWars.character }
    sold_out Faker::Boolean.boolean(0.2)
    under_sale Faker::Boolean.boolean(0.2)
    price_in_cents Faker::Number.between(1000, 10000)
    sale_price_in_cents Faker::Number.between(1000, 10000)
    sale_text Faker::StarWars.character
    category
  end
end