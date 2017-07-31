class SeedData
  class << self
    def generate
      create_categories
      create_products
    end

    def create_categories
      ['makeup', 'tools', 'brushes'].map do |category_name|
        Category.create!(name: category_name)
      end
    end

    def create_products
      create_make_up_products
      create_tool_products_with_sale_items
      create_brushes_products
    end

    def create_make_up_products
      category = Category.find_by(name: 'makeup')
      10.times do |count|
        Product.create!(name: "KAT VON D",
                        description: "Lock-It Foundation",
                        sold_out: Faker::Boolean.boolean(0.2),
                        price_in_cents: Faker::Number.between(1000, 10000),
                        category: category)
      end
    end

    def create_tool_products_with_sale_items
      category = Category.find_by(name: 'tools')
      10.times do |count|
        attributes = { name: "KAT VON D",
                       description: "Lock-It Foundation",
                       under_sale: Faker::Boolean.boolean(0.2),
                       price_in_cents: Faker::Number.between(1000, 10000),
                       category: category }
        attributes.merge!(sale_price_in_cents: Faker::Number.between(1000, 5000),
                          sale_text: Faker::Lorem.sentence(10, true)) if attributes[:under_sale]

        Product.create!(attributes)
      end
    end

    def create_brushes_products
      category = Category.find_by(name: 'brushes')
      10.times do
        Product.create!(name: "KAT VON D",
                        description: "Lock-It Foundation",
                        price_in_cents: Faker::Number.between(1000, 10000),
                        category: category)
      end
    end
  end
end

SeedData.generate

