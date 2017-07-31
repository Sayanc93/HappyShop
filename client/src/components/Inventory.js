import React, { Component } from 'react';
import ReactPaginate from 'react-paginate';
import axios from 'axios';

import SideBar from './SideBar';
import ProductCard from './ProductCard';

import '../styles/Inventory.css';

class Inventory extends Component {
    constructor(props) {
        super();
        this.perPage = 6;
        this.state = {
                productsCollection : [],
                categoriesCollection: [],
                productsCount: 0,
                categoryFilter: "all",
                minimumPrice: 0,
                maximumPrice: 100000,
                isLoading: true,
                pageNumber: 0,
                sortingOrder: "ascending"
        }
        this.handlePageClick = this.handlePageClick.bind(this);
        this.filterProducts = this.filterProducts.bind(this);
        this.sortByPrice = this.sortByPrice.bind(this);
    }

    componentDidMount() {
        this.fetchProducts();
        this.fetchCategories();
    }

    fetchProducts() {
       let requestOptions = {   headers: {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                },
                                params: {
                                    'page[size]': this.perPage,
                                    'page[number]': this.state.pageNumber,
                                    'filter[category]': this.state.categoryFilter,
                                    'filter[minimum_price]': this.state.minimumPrice,
                                    'filter[maximum_price]': this.state.maximumPrice,
                                    'sorting[order]': this.state.sortingOrder
                                }
                            };
        axios.get('/api/v1/products', requestOptions).then(function(response) {
            if (response.data.success) {
                this.setState({ productsCollection: response.data.products,
                                productsCount: response.data.count, 
                                pageNumber: response.data.pageNumber,
                                isLoading: false });
            } else {
                console.log("Couldn't load products from inventory");
            }
        }.bind(this));
    }

    fetchCategories() {
       const requestOptions = { headers: {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                }
                            };
        axios.get('/api/v1/categories', requestOptions).then(function(response) {
            if (response.data.success) {
                this.setState({ categoriesCollection: response.data.categories });
            } else {
                console.log("Couldn't load products from inventory");
            }
        }.bind(this));
    }

    filterProducts(category, minimumPrice, maximumPrice) {
        this.setState({ categoryFilter: category, 
                        minimumPrice: minimumPrice, 
                        maximumPrice: maximumPrice
                    }, () => {
            this.fetchProducts();
        })
    }

    sortByPrice(sortingOrder) {
        this.setState({ sortingOrder: sortingOrder }, () => {
            this.fetchProducts();
        })
    }

    handlePageClick(event) {
        let currentPage = event.selected;

        this.setState({pageNumber: currentPage}, () => {
        this.fetchProducts();
        });
    };

    render() {
        let products = this.state.productsCollection;
        let pageCount = Math.ceil(this.state.productsCount / this.perPage);
        let categories = this.state.categoriesCollection;
        return (
            <div>
                <div className="text-center">
                    <SideBar categories={categories} 
                             filterProducts={this.filterProducts}
                             sortByPrice={this.sortByPrice} />
                </div>
                    <div className="row align-cards">
                        <div className="col-md-10 col-md-offset-2">
                            {
                                products.map(function(product, index) {
                                    return (
                                        <ProductCard id={product.id}
                                                     name={product.name}
                                                     key={index} 
                                                     description={product.description}
                                                     currency={product.currency}
                                                     price={product.price_in_cents}
                                                     salePrice={product.sale_price_in_cents}
                                                     saleText={product.sale_text}
                                                     soldOut={product.sold_out}
                                                     underSale={product.under_sale}
                                                     category={product.category} />
                                    )
                                })
                            }
                        </div>
                        <div className="col-md-10 col-md-offset-2">
                            <div className="text-center">
                                <ReactPaginate previousLabel={"previous"}
                                               nextLabel={"next"}
                                               breakLabel={<a href="">...</a>}
                                               breakClassName={"break-me"}
                                               pageCount={pageCount}
                                               marginPagesDisplayed={2}
                                               pageRangeDisplayed={2}
                                               onPageChange={this.handlePageClick}
                                               containerClassName={"pagination"}
                                               subContainerClassName={"pages pagination"}
                                               activeClassName={"active"} />
                            </div>
                        </div>
                    </div>
            </div>
        )
    }
}

export default Inventory;