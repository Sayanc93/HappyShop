import React, { Component } from 'react';
import '../styles/Card.css';

class ProductCard extends Component {
    constructor(props) {
        super();
        this.goToProduct = this.goToProduct.bind(this);
        this.state = {
            isMouseHover: false
        }
    }

    goToProduct(event) {
         this.context.router.transitionTo(`/product/${this.props.id}`);
    }

    render() {
        return (
            <div className="col-xs-6 col-md-4">
                <div className="thumbnail" onClick={this.goToProduct}>
                    <span className="pull-right glyphicon glyphicon-heart-empty"></span>
                    <img src="http://www.sephora.com/productimages/sku/s1398858-main-hero.jpg" alt="300x200" style={{width: "400px", height: "300px"}} className="img-responsive" />
                    <div className="caption">
                        <div>
                            <small><span>NEW</span> | <span>LIMITED EDITION</span></small>
                        </div>
                        <div className="title">{this.props.name}</div>
                        <div className="price">$ {this.props.price / 100}</div>
                        <div>
                            <small><span>Category</span>: <span>{this.props.category.name}</span></small>
                        </div>
                        <div>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                            <span className="glyphicon glyphicon-star-empty"></span>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

ProductCard.contextTypes = {
  router: React.PropTypes.object
}

export default ProductCard;