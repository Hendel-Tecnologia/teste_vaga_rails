class Product < ApplicationRecord
  with_options presence: true do
    validates :name, uniqueness: true
    validates :description
    validates :price
    validates :quantity
  end
end
