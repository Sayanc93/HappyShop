FactoryGirl.define do
  factory :category do
   sequence(:name) {|n| "#{Faker::StarWars.character + n.to_s}" }
  end
end