import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Match, Miss } from 'react-router';

import Store from  './components/Store';
import Inventory from  './components/Inventory';
import NotFound from './components/NotFound';
import Product from './components/Product';

import './styles/Index.css';

const App = () => {
  return (
    <BrowserRouter>
      <div>
        <Match exactly pattern="/" component={Store} />
        <Match exactly pattern="/inventory" component={Inventory} />
        <Match exactly pattern="/product/:productId" component={Product} />
        <Miss component={NotFound} />
      </div>
    </BrowserRouter>
  )
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
