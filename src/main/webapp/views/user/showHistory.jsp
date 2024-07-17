<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.online_store.entity.order.OrderItem" %>
<%@ page import="uz.pdp.online_store.util.ImageUtil" %>
<html>
<head>
    <title>Product History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #007bff;
            animation: fadeIn 1s ease-in-out;
        }

        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
        }

        .navbar a:hover {
            color: #d1e7ff;
        }

        .cart-container {
            width: 80%;
            margin: 50px auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: slideIn 1s ease-in-out;
        }

        .history-container {
            width: 80%;
            margin: 50px auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: slideIn 1s ease-in-out;
        }

        .cart-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            animation: fadeInUp 0.5s ease-in-out;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            border-radius: 8px;
            transition: transform 0.3s;
        }

        .cart-item img:hover {
            transform: scale(1.1);
        }

        .cart-item-details {
            flex: 1;
        }

        .cart-item-details a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            transition: color 0.3s;
        }

        .cart-item-details a:hover {
            color: #0056b3;
        }

        .cart-item-details p {
            margin: 5px 0;
        }

        .cart-summary {
            text-align: right;
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }

        .purchase-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .purchase-btn:hover {
            background-color: #218838;
            transform: scale(1.05);
        }

        .back-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .back-btn:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .history-item-btn {
            cursor: pointer;
            color: #007bff;
            font-size: 16px;
            border: none;
            background: none;
            text-decoration: underline;
            transition: color 0.3s;
        }

        .history-item-btn:hover {
            color: #0056b3;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
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
    </style>
</head>
<body>
<div class="navbar">
    <a href="/app">Menu</a>
</div>

<div class="cart-container">
    <h1>CART PRODUCTS</h1>
    <%
        @SuppressWarnings("unchecked")
        List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("allorderitembyorderid");
        for (OrderItem orderItem : orderItems) {
            String base64Image = ImageUtil.getBase64Image(orderItem.getProduct().getPicture().getPicture());
    %>
    <div class="cart-item">
        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
        <div class="cart-item-details">
            <a href="${pageContext.request.contextPath}/menu/productDetails?id=<%= orderItem.getProduct().getId() %>">
                <div class="product-title"><%= orderItem.getProduct().getProductName() %>
                </div>
            </a>
            <p>Product Name: <%= orderItem.getProduct().getProductName() %></p>
            <p>Price: <%= orderItem.getProduct().getProductPrice() %> сум</p>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>
