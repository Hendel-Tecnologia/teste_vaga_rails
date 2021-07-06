FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentences.join }
    price { Faker::Commerce.price }
    quantity { Faker::Number.between(from: 0, to: 50) }
  end
end
