<%@ page import="uz.pdp.online_store.entity.product.Product" %>
<%@ page import="uz.pdp.online_store.service.product.ProductService" %>
<%@ page import="uz.pdp.online_store.util.ImageUtil" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <style>
        body {
            font-family: "Source Sans Pro", sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40;
        }
        .navbar-brand {
            color: #ffffff;
            font-weight: bold;
        }
        .main-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .product-details-container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            animation: fadeIn 1s ease-in-out;
        }
        .product-details-container img {
            width: 250px;
            height: auto;
            object-fit: contain;
            border-radius: 8px;
            margin-right: 20px;
            animation: slideInFromLeft 1s ease-in-out;
        }
        .product-info {
            display: flex;
            flex-direction: column;
            animation: fadeIn 1s ease-in-out;
        }
        .product-title {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 20px;
            text-align: left;
        }
        .product-details {
            font-size: 16px;
            color: #666666;
            margin-bottom: 20px;
            text-align: left;
        }
        .price {
            font-size: 20px;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 20px;
        }
        .add-to-cart {
            display: flex;
            align-items: center;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            margin-right: 20px;
        }
        .quantity-controls button {
            border: none;
            background-color: #343a40;
            color: #ffffff;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .quantity-controls input {
            width: 40px;
            text-align: center;
            border: 1px solid #dddddd;
            margin: 0 5px;
        }
        .add-to-cart button {
            background-color: #28a745;
            border: none;
            color: #ffffff;
            padding: 5px 10px;
            cursor: pointer;
            display: flex;
            align-items: center;
        }
        .add-to-cart button i {
            margin-right: 5px;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        @keyframes slideInFromLeft {
            from {
                transform: translateX(-100%);
            }
            to {
                transform: translateX(0);
            }
        }
        .related-products {
            margin-top: 40px;
        }
        .related-product-container {
            background-color: #fff;
            padding: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin: 10px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .related-product-container:hover {
            transform: scale(1.05);
        }
        .related-product-container img {
            width: 100px;
            height: auto;
            object-fit: contain;
            border-radius: 8px;
        }
        .related-product-info {
            margin-left: 10px;
        }
        .related-product-title {
            font-size: 16px;
            font-weight: bold;
            color: #333333;
            text-align: left;
        }
        .related-product-price {
            font-size: 14px;
            font-weight: bold;
            color: #28a745;
            text-align: left;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="">
        Online Store
    </a>
    <a class="btn btn-primary mt-3" href="/app">Menu</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"><i class="bi bi-list"></i></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="bi bi-cart"></i> Cart</a>
            </li>
        </ul>
    </div>
</nav>

<%
    String productId = request.getParameter("id");
    ProductService productService = new ProductService();
    Product product = productService.getProduct(productId);
    String base64Image = ImageUtil.getBase64Image(product.getPicture().getPicture());
%>

<div class="main-container">
    <div class="product-details-container">
        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
        <div class="product-info">
            <div class="product-title"><%= product.getProductName() %></div>
            <div class="product-details">
                <p><strong>Description:</strong> <%= product.getProductDescription() %></p>
            </div>
            <div class="price"><%= product.getProductPrice() %> so'm</div>
            <div class="add-to-cart">
                <div class="quantity-controls">
                    <button onclick="updateQuantity(this, -1)">-</button>
                    <input type="number" value="1" min="1">
                    <button onclick="updateQuantity(this, 1)">+</button>
                </div>
                <button onclick="addToCart(<%= product.getId() %>)">
                    <i class="bi bi-basket"></i> Add to Cart
                </button>
            </div>
        </div>
    </div>
</div>

<div class="related-products container">
    <h3>Related Products</h3>
    <div class="row">
        <%
            List<Product> randomProducts = productService.randomProduct2();
            for (Product randomProduct : randomProducts) {
                String randomProductImage = ImageUtil.getBase64Image(randomProduct.getPicture().getPicture());
        %>
        <div class="col-md-3 related-product-container" onclick="window.location.href='productDetails?id=<%= randomProduct.getId() %>'">
            <div class="d-flex">
                <img src="data:image/jpeg;base64,<%= randomProductImage %>" alt="Related Product Image">
                <div class="related-product-info">
                    <div class="related-product-title"><%= randomProduct.getProductName() %></div>
                    <div class="related-product-price"><%= randomProduct.getProductPrice() %> so'm</div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function updateQuantity(button, change) {
        let input = button.parentElement.querySelector('input');
        let newValue = parseInt(input.value) + change;
        if (newValue < 1) newValue = 1;
        input.value = newValue;
    }

    function addToCart(productId) {
        let quantityInput = event.target.parentElement.querySelector('.quantity-controls input');
        let quantity = parseInt(quantityInput.value);

        $.post('addToCart', {
            productId: productId,
            quantity: quantity
        }, function(response) {
            alert('Product added to cart!');
        });
    }
</script>
</body>
</html>
