import React, { Component } from 'react';

class Store extends Component {
  constructor(props) {
    super();
    this.goToStore = this.goToStore.bind(this);
  }

  goToStore(event) {
    event.preventDefault();
    this.context.router.transitionTo('/inventory');
  }

  render() {
    return ( 
      <form className="jumbotron container" onSubmit={this.goToStore}>
        <div className="row container">
          <h2 className="text-center">Welcome to Happy Shop</h2>
          <button type="submit" className="col-md-4 col-md-offset-4 btn btn-primary">Visit Store -></button>
        </div>
      </form>
    );
  }
}

Store.contextTypes = {
  router: React.PropTypes.object
}

export default Store;