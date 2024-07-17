<%@ page import="uz.pdp.online_store.entity.user.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>User Info</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
      margin: 0;
      padding: 0;
      animation: fadeIn 1s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .container {
      max-width: 80%;
      margin: 0 auto;
      padding: 20px;
      animation: slideIn 1s ease-in-out;
    }
    @keyframes slideIn {
      from { transform: translateY(20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }
    .user-info {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .user-info:hover {
      transform: scale(1.02);
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    }
    .button-group {
      margin-top: 20px;
    }
    .button-group button {
      background-color: #007bff;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      border-radius: 5px;
      margin-right: 10px;
      transition: background-color 0.3s ease;
    }
    .button-group button:hover {
      background-color: #0056b3;
    }
    .logout-btn {
      background-color: #dc3545;
    }
    .logout-btn:hover {
      background-color: #c82333;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>User Information</h2>
  <div class="user-info">
    <% Users user = (Users) session.getAttribute("user");
      if (user != null) { %>
    <p><strong>Name:</strong> <%= user.getFullName() %></p>
    <p><strong>Email:</strong> <%= user.getEmail() %></p>
    <p><strong>Phone Number:</strong> <%= user.getPhoneNumber() %></p>
    <% } else { %>
    <p>User not logged in.</p>
    <% } %>
  </div>
  <div class="button-group">
    <button onclick="location.href='/app'">Menu</button>
    <form action="/app/logout" method="post" style="display:inline;">
      <button type="submit" class="logout-btn">Log Out</button>
    </form>
  </div>
</div>
</body>
</html>
