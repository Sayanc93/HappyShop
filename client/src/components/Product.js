import React, { Component } from 'react';
import axios from 'axios';

import '../styles/Card.css';

class Product extends Component {
    constructor(props) {
        super();
        this.state = {
            name: undefined,
            description: undefined,
            priceInCents: 0
        }
    }

    componentDidMount() {
        this.fetchProducts();
    }

    fetchProducts() {
       let requestOptions = {   headers: {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                }
                            };
        axios.get(`/api/v1/products/${this.props.params.productId}`, requestOptions).then(function(response) {
            if (response.data.success) {
                console.log(response.data.product);
                this.setState({ name: response.data.product.name,
                                description: response.data.product.description,
                                priceInCents: response.data.product.price_in_cents });
            } else {
                console.log("Couldn't load product");
            }
        }.bind(this));
    }

    render() {
        console.log(this.state);
        return (
            <div className="jumbotron container align-lower">
                <div className="row">
                    <div className="col-xs-4">
                        <img src="http://www.sephora.com/productimages/sku/s1398858-main-hero.jpg" alt="product photo" />
                        <div className="col-xs-6 col-md-offset-3">
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                        </div>
                    </div>
                    <div className="col-xs-5">
                        <h3>{this.state.name}</h3> 
                        <div>
                            <small><span>NEW</span> | <span>LIMITED EDITION</span></small>
                        </div>   
                        <h3>$ {this.state.priceInCents / 100}</h3>  
                        <p>"Voluptatem nihil sint placeat ratione modi maxime. Tenetur enim et ipsam sed dolor. Necessitatibus omnis voluptate delectus voluptas a itaque illo. Voluptas aut inventore et velit eius.", "Et illum cum ipsum culpa. Esse aut voluptates delectus occaecati tempore saepe. Quis qui tempora sint soluta cumque. Odit voluptatem aperiam qui libero molestias quibusdam. Dolorem ut voluptas molestiae odio.", "Et dolor et molestiae beatae iusto maxime. Deleniti quas consequuntur facere dicta. Facilis dolor voluptatem vitae placeat sit nostrum velit."</p>                                              
                    </div> 
                </div>  
            </div>                           
        )
    }
}

export default Product;