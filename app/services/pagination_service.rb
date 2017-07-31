module PaginationService
    def paginate options={}
        expected_keys = [:resource, :limit, :current_page]
        fail unless expected_keys & options.keys == expected_keys
        offset = (options[:current_page].to_i * options[:limit].to_i).ceil
        options[:resource].limit(options[:limit]).offset(offset)
    end
end