Faker::Config.locale = 'pt-BR'

Product.create!(
  (1..500).map do
    {
      name: Faker::Commerce.unique.product_name,
      description: Faker::Lorem.sentences.join,
      price: Faker::Commerce.price,
      quantity: Faker::Number.between(from: 0, to: 50)
    }
  end
)


