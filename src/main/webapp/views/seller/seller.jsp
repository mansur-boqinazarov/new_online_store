<%@ page import="uz.pdp.online_store.service.product.CategoryService" %>
<%@ page import="uz.pdp.online_store.entity.product.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.online_store.util.ImageUtil" %>
<%@ page import="uz.pdp.online_store.entity.product.Product" %>
<%@ page import="uz.pdp.online_store.service.product.ProductService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Store</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="resources/css/mainMenu.css">
    <style>
        body {
            font-family: "Source Sans Pro", sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            color: #ffffff;
            font-weight: bold;
            transition: color 0.3s;
        }
        .navbar-brand:hover {
            color: #f8f9fa;
        }
        .form-inline .form-control {
            width: 300px;
            transition: width 0.3s;
        }
        .form-inline .form-control:focus {
            width: 350px;
        }
        .mySlides img {
            width: 100%;
            height: auto;
        }
        .main-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            padding: 0 20px;
        }
        .product-container {
            flex: 3;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .product-item {
            flex: 1 1 calc(25% - 40px);
            margin: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
            padding: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s;
            height: 480px;
            animation: fadeInUp 0.5s ease;
        }
        @keyframes fadeInUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        .product-item:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .product-item img {
            width: 100%;
            height: auto;
            object-fit: contain;
            border-radius: 8px;
            transition: transform 0.3s;
        }
        .product-item:hover img {
            transform: scale(1.1);
        }
        .product-title {
            font-size: 18px;
            font-weight: bold;
            color: #333333;
            margin: 10px 0;
            text-align: center;
            transition: color 0.3s;
        }
        .product-title:hover {
            color: #007bff;
        }
        .add-to-cart {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
            width: 100%;
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
            transition: background-color 0.3s;
        }
        .quantity-controls button:hover {
            background-color: #495057;
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
            transition: background-color 0.3s;
        }
        .add-to-cart button:hover {
            background-color: #218838;
        }
        .add-to-cart button i {
            margin-right: 5px;
        }
        @media (max-width: 768px) {
            .product-item {
                flex: 1 1 calc(50% - 40px);
            }
        }
        @media (max-width: 576px) {
            .product-item {
                flex: 1 1 100%;
            }
            .category-list {
                display: none;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="">
        Online Store
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"><i class="bi bi-list"></i></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <form class="form-inline my-2 my-lg-0 ml-auto">
            <h2>SELLER MENU</h2>
        </form>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a href=${pageContext.request.contextPath}/seller/createstore>
                    <button type="button" class="animated-button animate__animated animate__fadeInUp">DO'KON YARATISH</button>
                </a>
                <a href=${pageContext.request.contextPath}/seller/mystore>
                    <button type="button" class="animated-button animate__animated animate__fadeInUp">MENING DO'KONIM</button>
                </a>
                <a href=${pageContext.request.contextPath}/seller/addproduct>
                    <button type="button" class="animated-button animate__animated animate__fadeInUp">MAHSULOT QO'SHISH</button>
                </a>
            </li>
        </ul>
    </div>
</nav>

<div class="main-container">
    <div class="product-container">
        <%
            ProductService productService = new ProductService();
            List<Product> productList = productService.randomProduct();
            for (Product product : productList) {
                String base64Image = ImageUtil.getBase64Image(product.getPicture().getPicture());
        %>
        <div class="product-item">
            <a href="${pageContext.request.contextPath}/menu/productDetails?id=<%= product.getId() %>">
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
                <div class="product-title"><%= product.getProductName() %></div>
            </a>
            <div class="product-details">
                <p><strong>Price:</strong><%= product.getProductPrice() %> so'm</p>
            </div>
            <div class="add-to-cart">
                <form action="${pageContext.request.contextPath}/admin/deleteProduct" method="post">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <button type="submit">DELETE</button>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="resources/js/mainMenu.js"></script>
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
