class Product < ApplicationRecord
  belongs_to :category
  validates_presence_of :price_in_cents, :name
end
