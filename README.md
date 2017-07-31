# Introduction

Welcome to HappyShop repository!

HappyShop API expects params to be sent as JSON.
All requests should have the 'Content-Type' header set to 'application/json'.
The API repsonds with JSON data.

Note: The front-end React code resides in client folder. 

Run `rake start` to spin the entire project. Frontend runs on port 3000, while backend runs on port 3001.

# Fetch (Products)

This API end point can be used to fetch all products, default parameters of page, filter and sorting order is needed.

```shell
curl -X GET -H "Content-Type: application/json"
-d '
{"page": {"size": "6", 
          "number": "0"}, 
 "filter": {"category": "all", 
            "minimum_price": "0", 
            "maximum_price": "10000"}, 
"sorting": {"order": "ascending"}
}' "http://stark-island-44012.herokuapp.com/api/v1/products"
```

> The above command returns following JSON data:

```json
{"products":[{"id":"4", 
                "name":"KAT VON D", 
                "sold_out": false, 
                "under_sale":false, 
                "price_in_cents":1367, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 1, "name": "makeup"}}, 
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":1645, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}}]
  }
```


### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products`

### Query Parameters

* **page** : Pagination parameters
* **filter** : Filtering parameters
* **sorting** : Sorting parameters

# Fetch Product

This API end point can be used to fetch a single product details, ID must be passed in the request.

```shell
curl -X GET -H "Content-Type: application/json"
 "http://stark-island-44012.herokuapp.com/api/v1/products/1"
```

> The above command returns following JSON data:

```json
{"product":[{"id":"4", 
             "name":"KAT VON D", 
             "sold_out": false, 
             "under_sale":false, 
             "price_in_cents":1367, 
             "sale_price_in_cents": 0, 
             "sale_text": "", 
             "category": {"id": 1, "name": "makeup"}}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products/:id`

# Filter Products (By Category)

This API end point can be used to filter products by category name. Replacing category name from "all" triggers filter for products according to categories.

```shell
curl -X GET -H "Content-Type: application/json"
-d '
{"page": {"size": "6", 
          "number": "0"}, 
 "filter": {"category": "makeup", 
            "minimum_price": "0", 
            "maximum_price": "10000"}, 
"sorting": {"order": "ascending"}
}' "http://stark-island-44012.herokuapp.com/api/v1/products"
```

> Make sure to replace `makeup` with an appropriate category name.

> The above command returns following JSON data:

```json
{"products":[{"id":"4", 
                "name":"KAT VON D", 
                "sold_out": false, 
                "under_sale":false, 
                "price_in_cents":1367, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 1, "name": "makeup"}}, 
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":1645, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "makeup"}}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products`


# Filter Products (By Price Range)

This API end point can be used to filter products by price range. Replacing default price range with any minimum and maximum price creates a filtering range on the basis of those price values.

```shell
curl -X GET -H "Content-Type: application/json"
-d '
{"page": {"size": "6", 
          "number": "0"}, 
 "filter": {"category": "makeup", 
            "minimum_price": "2000", 
            "maximum_price": "3000"}, 
"sorting": {"order": "ascending"}
}' "http://stark-island-44012.herokuapp.com/api/v1/products"
```

> The above command returns following JSON data:

```json
{"products":[{"id":"4", 
                "name":"KAT VON D", 
                "sold_out": false, 
                "under_sale":false, 
                "price_in_cents":2345, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 1, "name": "makeup"}}, 
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":2678, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products`

# Sort Products (By Price)

This API end point can be used to sort products by price range. Replacing default sorting order value with either "ascending" or "descending" value, triggers reordering of products according to the requirement.

```shell
curl -X GET -H "Content-Type: application/json"
-d '
{"page": {"size": "6", 
          "number": "0"}, 
 "filter": {"category": "makeup", 
            "minimum_price": "2000", 
            "maximum_price": "3000"}, 
"sorting": {"order": "descending"}
}' "http://stark-island-44012.herokuapp.com/api/v1/products"
```

> The above command returns following JSON data:

```json
{"products":[{"id":"4", 
                "name":"KAT VON D", 
                "sold_out": false, 
                "under_sale":false, 
                "price_in_cents":9333, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 1, "name": "makeup"}}, 
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":4566, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}},
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":2266, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products`

# Paginate Products

This API end point can be used to get paginated list of products. Page size and number are mandatory fields alongwith the default parameters of other filtering options.

```shell
curl -X GET -H "Content-Type: application/json"
-d '
{"page": {"size": "3", 
          "number": "2"}, 
 "filter": {"category": "makeup", 
            "minimum_price": "2000", 
            "maximum_price": "3000"}, 
"sorting": {"order": "descending"}
}' "http://stark-island-44012.herokuapp.com/api/v1/products"
```

> The above command returns following JSON data:

```json
{"products":[{"id":"4", 
                "name":"KAT VON D", 
                "sold_out": false, 
                "under_sale":false, 
                "price_in_cents":9333, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 1, "name": "makeup"}}, 
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":4566, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}},
               {"id":17, 
                "name":"KAT VON D", 
                "sold_out":false, 
                "under_sale":false, 
                "price_in_cents":2266, 
                "sale_price_in_cents": 0, 
                "sale_text": "", 
                "category": {"id": 2, "name": "tools"}}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/products`

# Fetch All Categories

This API end point can be used to get all the categories of products.

```shell
curl -X GET -H "Content-Type: application/json"
-d  "http://stark-island-44012.herokuapp.com/api/v1/categories"
```

> The above command returns following JSON data:

```json
{"categories":[{"id": 1, "name": "makeup"}, 
               {"id": 2, "name": "tools"},
               {"id": 2, "name": "brushes"}]
  }
```

### HTTP Request

`GET http://stark-island-44012.herokuapp.com/api/v1/categories`