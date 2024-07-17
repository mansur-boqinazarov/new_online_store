<%@ page import="uz.pdp.online_store.service.shop.ShopService" %>
<%@ page import="uz.pdp.online_store.entity.shop.Shop" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Stores</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #282c34;
            color: #ffffff;
            padding: 20px;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .shop-container {
            width: 100%;
            max-width: 800px;
            background-color: #3a3f47;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .shop-item {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #555b66;
            border-radius: 5px;
            background-color: #2f343b;
            transition: transform 0.2s ease;
        }

        .shop-item:hover {
            transform: scale(1.05);
        }

        .shop-name {
            font-size: 24px;
            color: #61dafb;
            margin-bottom: 10px;
        }

        .shop-details {
            margin: 10px 0;
        }

        .shop-details strong {
            color: #61dafb;
        }

        .menu-button {
            background-color: #61dafb;
            color: #282c34;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            margin-bottom: 20px;
            transition: background-color 0.2s ease;
        }

        .menu-button:hover {
            background-color: #52c0e0;
        }
    </style>
</head>
<body>
<a href="/app/seller" class="menu-button">Menu</a>
<div class="shop-container">
    <h1>My Stores</h1>
    <%
        ShopService shopService = new ShopService();
        String userId = (String) request.getSession().getAttribute("user_id");
        List<Shop> myShops = shopService.allMyShops(userId);
        for (Shop shop : myShops) {
    %>
    <div class="shop-item">
        <div class="shop-name"><%= shop.getShopName() %></div>
        <div class="shop-details"><strong>Do'kon nomi:</strong> <%= shop.getShopName() %></div>
        <div class="shop-details"><strong>Umumiy balans:</strong> <%= shop.getShopTotalBalance() %></div>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
