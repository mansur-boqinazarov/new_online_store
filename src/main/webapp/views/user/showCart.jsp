<%@ page import="uz.pdp.online_store.service.order.OrderService" %>
<%@ page import="uz.pdp.online_store.entity.order.Orders" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.online_store.entity.order.OrderItem" %>
<%@ page import="uz.pdp.online_store.util.ImageUtil" %>
<%@ page import="uz.pdp.online_store.entity.user.Users" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart Products</title>
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

        .cart-item-actions {
            display: flex;
            align-items: center;
        }

        .cart-item-actions input[type="number"] {
            width: 50px;
            text-align: center;
            margin: 0 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border-color 0.3s;
        }

        .cart-item-actions input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
        }

        .cart-item-actions .remove-btn {
            cursor: pointer;
            color: #d9534f;
            font-size: 18px;
            border: none;
            background: none;
            transition: color 0.3s;
        }

        .cart-item-actions .remove-btn:hover {
            color: #a94442;
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
<div class="cart-container">
    <h1>CART PRODUCTS</h1>
    <%
        Users user = (Users) session.getAttribute("user");
        Optional<Orders> orderByUser = new OrderService().findOrderByUser(user);
        Orders order = orderByUser.get();
        List<OrderItem> orderItems = order.getOrderItems();
        for (OrderItem orderItem : orderItems) {
            String base64Image = ImageUtil.getBase64Image(orderItem.getProduct().getPicture().getPicture());
    %>
    <h2>Oldin sotib olingan mahsulotlar</h2>
    <ul>
        <%
            List<String> historyOrderedItems = new OrderService().historyOrdered(user);
            for (String item : historyOrderedItems) {
        %>
        <li>
            <form method="post" action="/app/showHistoryProduct">
                <input type="hidden" name="historyItem" value="<%= item %>">
                <button type="submit" class="history-item-btn">
                    <%= item %>
                </button>
            </form>
        </li>
        <%
            }
        %>
    </ul>

    <div class="cart-item">
        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
        <div class="cart-item-details">
            <a href="${pageContext.request.contextPath}/menu/productDetails?id=<%= orderItem.getProduct().getId() %>">
                <div class="product-title"><%= orderItem.getProduct().getProductName() %>
                </div>
            </a>
            <p>Product Name: <%= orderItem.getProduct().getProductName() %>
            </p>
            <p>Price: <%= orderItem.getProduct().getProductPrice() %> сум</p>
        </div>
        <div class="cart-item-actions">
            <input type="number" value="<%= orderItem.getQuantity() %>" min="1">
            <form method="post" action="showCartRemoveProduct">
                <input type="hidden" name="itemId" value="<%= orderItem.getId() %>">
                <button type="submit" class="remove-btn">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </form>
        </div>
    </div>
    <hr>
    <%
        }
    %>
    <form method="post" action="/app/purchase">
        <%if (!orderItems.isEmpty()){%>
        <input type="hidden" name="orderId" value="<%= orderItems.get(0).getOrder().getId() %>">
        <button type="submit" class="purchase-btn">Sotib olish</button>
        <%} else {%>
        <h1>Sizning savatingiz bo'sh</h1>
        <%}%>
    </form>
    <button onclick="window.location.href='/app'" class="back-btn">Orqaga</button>

</div>
</body>
</html>
