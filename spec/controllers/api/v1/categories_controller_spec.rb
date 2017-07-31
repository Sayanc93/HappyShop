require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do

  context "Categories Controller" do

        let!(:categories) { create_list(:category, 5)}

        context "tests basic mandatory success and failures dues to parameter absence and presence" do
            it 'tests success response on index action with default values' do
                get :index
                expect(response).to have_http_status(:success)
                categories = JSON(response.body)["categories"]
                expect(categories.size).to eq(5)
            end
        end
    end
end