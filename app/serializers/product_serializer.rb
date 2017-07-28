class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :sold_out, :under_sale, :price_in_cents, :sale_price_in_cents, :sale_text
  has_one :category
end
