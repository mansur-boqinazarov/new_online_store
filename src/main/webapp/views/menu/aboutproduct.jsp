<%@ page import="uz.pdp.online_store.service.product.CategoryService" %>
<%@ page import="uz.pdp.online_store.entity.product.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.online_store.util.ImageUtil" %>
<%@ page import="uz.pdp.online_store.entity.product.Product" %>
<%@ page import="uz.pdp.online_store.service.product.ProductService" %>
<%@ page import="uz.pdp.online_store.entity.user.Users" %>
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
        /* Custom CSS */
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
        .form-inline .form-control {
            width: 300px;
        }
        .slideshow-container {
            position: relative;
            max-width: 95%;
            overflow: hidden;
        }
        .product-details p {
            margin: 5px 0;
            font-size: 16px; /* Changed font size */
            color: #ff0000; /* Changed color to bright red */
        }
        .mySlides {
            display: none;
            width: 100%;
        }
        .mySlides img {
            width: 100%;
            height: auto;
        }
        .prev, .next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
            cursor: pointer;
            color: #ffffff;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px 15px;
            border-radius: 5px;
        }
        .product-title {
            font-size: 18px; /* Changed font size */
            font-weight: bold;
            color: #333333;
            margin: 10px 0;
            text-align: center;
        }
        .prev:hover, .next:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }
        .main-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .category-list {
            flex: 1;
            max-width: 200px;
            margin-right: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 15px;
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
            transition: transform 0.3s ease-in-out;
            height: 520px; /* Increased height */
        }
        .product-item:hover {
            transform: scale(1.1);
        }
        .product-item img {
            width: 100%;
            height: auto;
            object-fit: contain;
            border-radius: 8px;
        }
        .add-to-cart {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
            width: 100%;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
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
    <a class="navbar-brand" href="/app">
        Online Store
    </a>
    <a href="/app">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"><i class="bi bi-list"></i></span>
    </button>
    </a>
    <div class="collapse navbar-collapse" id="navbarNav">
        <form class="form-inline my-2 my-lg-0 ml-auto">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="bi bi-search"></i></button>
        </form>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="loginSignUp"><i class="bi bi-person"></i> Login / Sign Up</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="bi bi-cart"></i> Cart</a>
            </li>
        </ul>
    </div>
</nav>
<div class="slideshow-container">
    <div class="mySlides active">
        <img src="rekPicture/1_resized.png" alt="Image 1">
    </div>
    <div class="mySlides">
        <img src="rekPicture/1_resized.png" alt="Image 2">
    </div>
    <div class="mySlides">
        <img src="rekPicture/1_resized.png" alt="Image 3">
    </div>
    <div class="mySlides">
        <img src="rekPicture/1_resized.png" alt="Image 4">
    </div>
    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>

<div class="main-container">
    <div class="category-list">
        <h5>Categories</h5>
        <ul class="list-group">
            <%
                CategoryService categoryService = new CategoryService();
                List<Category> categories = categoryService.getAllCategories();
                for (Category category : categories) {
            %>
            <li class="list-group-item"><%= category.getCategoryName() %></li>
            <%
                }
            %>
        </ul>
    </div>
    <div class="product-container">
        <%
            ProductService productService = new ProductService();
            List<Product> productList = productService.randomProduct();
            for (Product product : productList) {
                String base64Image = ImageUtil.getBase64Image(product.getPicture().getPicture());
        %>
        <div class="product-item">
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
            <div class="product-title"><%= product.getProductName() %></div>
            <div class="product-details">
                <p><strong>Price:</strong> <%= product.getProductPrice() %> so'm</p>
            </div>
            <div class="add-to-cart">
                <div class="quantity-controls">
                    <button onclick="updateQuantity(this, -1)">-</button>
                    <input type="number" value="1" min="1">
                    <button onclick="updateQuantity(this, 1)">+</button>
                </div>
                <%
                    Users user = (Users) session.getAttribute("user");
                %>
                <% if (user != null) { %>
                <form method="POST" action="cart">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit">
                        <i class="bi bi-basket"></i> Add to Cart
                    </button>
                </form>
                <% } else { %>
                <a href="cart">
                    <button>
                        <i class="bi bi-basket"></i> Add to Cart
                    </button>
                </a>
                <% } %>
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
