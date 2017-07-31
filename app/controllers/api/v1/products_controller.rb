class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_product, only: [:show]

  # GET /products
  def index
    fetch_and_organize_products
    serializable_resource = ActiveModelSerializers::SerializableResource.new(@products, 
                                                                             adapter: :json).as_json
    render json: serializable_resource.merge(success: true, count: @all_products.count)
  end

  def show
    serializable_resource = ActiveModelSerializers::SerializableResource.new(@product, 
                                                                             adapter: :json).as_json
    render json: serializable_resource.merge(success: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:category_id,
                                      :name,
                                      :sold_out,
                                      :under_sale,
                                      :price_in_cents,
                                      :sale_price_in_cents,
                                      :sale_text,
                                      :limit,
                                      :offset)
    end

    def pagination_params
      params.require(:page).permit(:size, :number)
    end

    def filtering_params
      params.require(:filter).permit(:category, :minimum_price, :maximum_price)
    end

    def sorting_params
      params.require(:sorting).permit(:order)
    end

    def fetch_and_organize_products
      @all_products = helpers.filter(category: filtering_params[:category],
                                price_range: {maximum: filtering_params[:maximum_price], 
                                              minimum: filtering_params[:minimum_price]})
      products_on_page = helpers.paginate(resource: @all_products, 
                                          limit: pagination_params[:size],
                                          current_page: pagination_params[:number])
      @products = helpers.sort_by_price(products_on_page, sorting_params[:order])
    end
end
