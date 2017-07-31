class Api::V1::CategoriesController < Api::V1::BaseController
  
  def index
    all_categories = Category.all
    serializable_resource = ActiveModelSerializers::SerializableResource.new(all_categories, 
                                                                             root: 'categories', 
                                                                             adapter: :json).as_json 
    render json: serializable_resource.merge(success: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end
end
