import React, { Component } from 'react';

import '../styles/Sidebar.css';

class SideBar extends Component {
    constructor(props) {
        super(props);
        this.filterByCategory = this.filterByCategory.bind(this);
        this.filterByPriceRange = this.filterByPriceRange.bind(this);
        this.sortByPrice = this.sortByPrice.bind(this);
        this.state = {
            selectedCategory: "all",
            minimumPrice: 0,
            maximumPrice: 10000,
            selectedSortingOrder: "ascending"
        }
    }

    filterByCategory(event) {
        this.setState({ selectedCategory: event.target.value }, () => {
            this.props.filterProducts(this.state.selectedCategory, 
                                      this.state.minimumPrice,
                                      this.state.maximumPrice)
        });
    }

    filterByPriceRange(minimum, maximum) {
        this.setState({ minimumPrice: minimum, maximumPrice: maximum }, () => {
            this.props.filterProducts(this.state.selectedCategory,
                                      this.state.minimumPrice, 
                                      this.state.maximumPrice)
        });
    }

    sortByPrice(order) {
        this.setState({ selectedSortingOrder: order }, () => {
            this.props.sortByPrice(this.state.selectedSortingOrder)
        });
    }
    
    render() {
        let categories = this.props.categories;
        return (
            <div className="sidebar">
                <h1> Filters </h1>
                <hr/>
                <div className="container-fluid">
                    <ul className="list-group">
                        <li>
                            <h4>Category</h4>
                            <hr/>
                            <div className="list-group">
                                {
                                    categories.map(function(category) {
                                            let assignActiveClassToSelected = ""
                                            if (this.state.selectedCategory === category.name) {
                                                assignActiveClassToSelected = "active"
                                            }
                                            return(
                                                <input type="button" 
                                                        className={"list-group-item form-control " + assignActiveClassToSelected}
                                                        key={category.id}
                                                        value={category.name}
                                                        onClick={this.filterByCategory} />
                                            )              
                                        }, this)
                                }
                            </div>
                        </li>
                        <li>
                            <h4>Price Range</h4>
                            <hr/>
                            <div className="list-group">
                                    <input type="button"
                                           key="1"
                                           className={"list-group-item form-control"}
                                           onClick={this.filterByPriceRange.bind(this, 0, 2000)}
                                           value="$0 - $20"/>
                                    <input type="button" 
                                           key="2"
                                           className={"list-group-item form-control"}
                                           onClick={this.filterByPriceRange.bind(this, 2000, 4000)}
                                           value="$20 - $40"/>
                                    <input type="button" 
                                           key="3"
                                           className={"list-group-item form-control"}
                                           onClick={this.filterByPriceRange.bind(this, 4000, 6000)}
                                           value="$40 - $60"/>
                                    <input type="button" 
                                           key="4"
                                           className={"list-group-item form-control"}
                                           onClick={this.filterByPriceRange.bind(this, 6000, 8000)}
                                           value="$60 - $80"/>
                                    <input type="button" 
                                           key="5"
                                           className={"list-group-item form-control"}
                                           onClick={this.filterByPriceRange.bind(this, 8000, 10000)}
                                           value="$80 - $100"/>
                            </div>
                        </li>
                        <li>
                            <h2>Sort By Price</h2>
                            <hr/>
                            <div className="list-group">
                                    <input type="button" 
                                           className={"list-group-item form-control"}
                                           onClick={this.sortByPrice.bind(this, "ascending")}
                                           value="Lower to Higher"/>
                                    <input type="button" 
                                           className={"list-group-item form-control"}
                                           onClick={this.sortByPrice.bind(this, "descending")}
                                           value="Higher to Lower"/>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        )
    }
}

export default SideBar;