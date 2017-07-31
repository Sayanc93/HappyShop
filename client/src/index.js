import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, browserHistory, Match, Miss } from 'react-router';

import Store from  './components/Store';
import Inventory from  './components/Inventory';
import NotFound from './components/NotFound';
import Product from './components/Product';

import './styles/Index.css';

const App = () => {
  return (
    <BrowserRouter history={browserHistory}>
      <div>
        <Match exactly pattern="/" component={Store} />
        <Match pattern="/inventory" component={Inventory} />
        <Match pattern="/product/:productId" component={Product} />
        <Miss component={NotFound} />
      </div>
    </BrowserRouter>
  )
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
