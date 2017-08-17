module ProductsFilteringService
    def filter options={}
        raise ArgumentError.new("Category is required.") unless options[:category].present?
        category = options[:category]
        all_category_products = get_products_by_category category
        return all_category_products if options[:price_range] == { :maximum =>"10000", :minimum => "0" }
        return get_products_by_price_range(all_category_products, options[:price_range])
    end

    def get_products_by_category category
        return Product.all if category == "all"
        category = Category.find_by(name: category)
        raise ActiveRecord::RecordNotFound unless category
        category.products
    end

    def get_products_by_price_range products, price_range
        raise ArgumentError.new("Minimum price is required.") unless price_range[:minimum]
        raise ArgumentError.new("Maximum price is required.") unless price_range[:maximum]
        products.where(price_in_cents: price_range[:minimum]..price_range[:maximum])
    end

    def sort_by_price products, order = "ascending"
        return products.order(price_in_cents: :asc) if order == "ascending"
        return products.order(price_in_cents: :desc) if order == "descending"
        if order != "ascending" || order != "descending"
            raise ArgumentError.new("Order needs to be either 'ascending' or 'descending'.")
        end
    end
end
