<%@ page import="uz.pdp.online_store.entity.user.Users" %>
<%@ page import="uz.pdp.online_store.service.user.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="uz.pdp.online_store.service.shop.ShopService" %>
<%@ page import="uz.pdp.online_store.entity.shop.Shop" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Todo List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #282c34;
            color: #ffffff;
            padding: 20px;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .todo-container {
            width: 100%;
            max-width: 600px;
            background-color: #3a3f47;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .button-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .animated-button {
            font-size: 24px;
            padding: 15px 30px;
            border: 2px solid #61dafb;
            background-color: transparent;
            color: #61dafb;
            cursor: pointer;
            outline: none;
            position: relative;
            overflow: hidden;
            transition: color 0.4s, box-shadow 0.4s;
            border-radius: 5px;
        }

        .animated-button::before,
        .animated-button::after {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            background-color: #61dafb;
            transition: transform 0.4s;
            z-index: -1;
        }

        .animated-button::before {
            transform: scaleX(0);
            border-top: 2px solid #61dafb;
            border-bottom: 2px solid #282c34;
        }

        .animated-button::after {
            transform: scaleY(0);
            border-left: 2px solid #282c34;
            border-right: 2px solid #282c34;
        }

        .animated-button:hover::before {
            transform: scaleX(1);
        }

        .animated-button:hover::after {
            transform: scaleY(1);
        }

        .animated-button:hover {
            color: #282c34;
            box-shadow: 0 0 10px #61dafb, 0 0 20px #61dafb, 0 0 30px #61dafb;
        }

        .todo-item {
            margin-bottom: 15px;
        }

        .todo-button {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #61dafb;
            color: #282c34;
            padding: 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            cursor: pointer;
            width: 100%;
        }

        .todo-button:hover {
            background-color: #51c5e7;
            transform: scale(1.05);
        }

        .todo-icon {
            font-size: 20px;
        }

        .todo-details {
            display: none;
            padding: 15px;
            background-color: #3a3f47;
            border: 1px solid #555b66;
            border-radius: 5px;
            margin-top: 5px;
        }

        .todo-details p {
            margin: 5px 0;
        }

        .download-link {
            color: #61dafb;
            text-decoration: none;
            font-weight: bold;
        }

        .delete-button {
            background-color: transparent;
            border: none;
            color: #ff6b6b;
            cursor: pointer;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .delete-button:hover {
            color: #ff4c4c;
        }
    </style>
</head>
<body>

<div class="todo-container">
    <div class="button-container">
        <button class="animated-button">USER LIST</button>

    </div>
    <%
        ShopService shopService = new ShopService();

        List<Shop> list = shopService.getAllShops();
        for (Shop users : list) {
    %>
    <div class="todo-item">
        <button class="todo-button">
            <span><%= users.getShopName() %></span>
            <i class="fas fa-angle-down todo-icon"></i>
        </button>
        <div class="todo-details">
            <p><strong>Total Balance:</strong> <i><%= users.getShopTotalBalance() %>
            </i></p>
            <p><strong>Create At:</strong> <i><%= users.getCreatedAt() %>
            </i></p>
            <p><strong>Owner Name:</strong> <i><%= users.getUsers().getEmail() %>
            </i></p>
            <p><strong>Email:</strong> <i><%= users.getUsers().getEmail() %>
            </i></p>

        </div>
    </div>
    <%
        }
    %>
</div>


<script>
    document.querySelectorAll('.todo-button').forEach(button => {
        button.addEventListener('click', () => {
            const details = button.nextElementSibling;
            details.style.display = (details.style.display === 'none' || details.style.display === '') ? 'block' : 'none';
        });
    });
</script>
</body>
</html>