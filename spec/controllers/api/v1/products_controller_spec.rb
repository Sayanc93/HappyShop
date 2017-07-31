require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  context "Products Controller" do

    let!(:products) { create_list(:product, 20)}

    context "tests basic mandatory success and failures dues to parameter absence and presence" do
        it 'tests success response on index action with default values' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                page: { size: 6, number: 0 },
                                sorting: { order: "ascending" } }
            expect(response).to have_http_status(:success)
            expect(JSON(response.body)["success"]).to be_truthy
        end

        it 'tests failure response on index action without filter' do
            get :index, params: { page: { size: 6, number: 0 },
                                sorting: { order: "ascending" } }
            expect(response).to have_http_status(:error)
            expect(JSON(response.body)["success"]).to be_falsy
        end

        it 'tests failure response on index action without page' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                sorting: { order: "ascending" } }
            expect(response).to have_http_status(:error)
            expect(JSON(response.body)["success"]).to be_falsy
        end

        it 'tests failure response on index action without page' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                page: { size: 6, number: 0 } }
            expect(response).to have_http_status(:error)
            expect(JSON(response.body)["success"]).to be_falsy
        end
    end

    context 'test pagination mechanism on index action' do
        it 'tests correct product count is returned if category is all' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }
            
            result = JSON(response.body)
            expect(result.key?("success")).to be_truthy
            expect(result.key?("products")).to be_truthy
            product_count = result["count"]
            expect(Product.count).to eq(product_count)
        end

         it 'tests products of page size is returned and not the entire list' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }
            
            result = JSON(response.body)
            products_in_response = result["products"]
            expect(6).to eq(products_in_response.size)
        end
    end

    context 'test filtering mechanism on index action' do
        it 'tests products are filtered according to category name provided' do
            get :index, params: { filter: { category: Category.first.name, minimum_price: 0, maximum_price: 10000 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }
            
            result = JSON(response.body)
            expect(result.key?("products")).to be_truthy
            product_count = result["count"]
            expect(Category.first.products.count).to eq(product_count)
        end

         it 'tests price range results in return correct products within specified range' do
            new_product_constant_price = create(:product, price_in_cents: 10001)
            get :index, params: { filter: { category: "all", minimum_price: 10000, maximum_price: 10002 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }

            result = JSON(response.body)
            products_in_response = result["products"]
            expect(products_in_response.size).to eq(1)
            expect(products_in_response.first["price_in_cents"]).to eq(10001)
        end
    end

    context 'test sorting mechanism on index action' do
        it 'tests products are returned in ascending order' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }
            
            result = JSON(response.body)
            expect(result.key?("success")).to be_truthy
            expect(result.key?("products")).to be_truthy
            product_prices_in_response = result["products"].map {|x| x["price_in_cents"] }
            expect(product_prices_in_response).to eq(product_prices_in_response.sort)
        end

         it 'tests products are returned in descending order' do
            get :index, params: { filter: { category: "all", minimum_price: 0, maximum_price: 10000 },
                                  page: { size: 6, number: 0 },
                                  sorting: { order: "ascending" } }
            
            result = JSON(response.body)
            expect(result.key?("products")).to be_truthy
            product_prices_in_response = result["products"].map {|x| x["price_in_cents"] }
            expect(product_prices_in_response).to eq(product_prices_in_response.reverse.sort)
        end
    end

    context 'tests result of show action' do
        it 'tests the details returned on the show action' do
            get :show, params: { id: Product.first.id }
                
            result = JSON(response.body)
            expect(result.key?("product")).to be_truthy
            product = result["product"]
            expect(product["id"]).to eq(Product.first.id)
        end
    end
  end

end
