module PaginationService
    def paginate resource, options={}
        raise ArgumentError.new("'limit' parameters is required") unless options[:limit]
        offset = (options[:current_page].to_i * options[:limit].to_i).ceil
        resource.limit(options[:limit]).offset(offset)
    end
end
