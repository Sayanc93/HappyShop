module ProductsHelper
    def filter options={}
        category = options[:category]
        products = get_products_by_category category
        return products if options[:price_range] == {:maximum=>"10000", :minimum=>"0"}
        return get_products_by_price_range products, options[:price_range]
    end

    def get_products_by_category category
        return Product.all if category == "all"
        Category.find_by(name: category).products
    end

    def get_products_by_price_range products, price_range
        products.where(price_in_cents: price_range[:minimum]..price_range[:maximum])
    end

    def sort_by_price products, order
        return products.order(price_in_cents: :asc) if order == "ascending"
        return products.order(price_in_cents: :desc) if order == "descending"
        fail
    end
end
