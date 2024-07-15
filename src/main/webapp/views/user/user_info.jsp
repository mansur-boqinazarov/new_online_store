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
    .logout-btn {
      background-color: #dc3545;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s ease;
    }
    .logout-btn:hover {
      background-color: #c82333;
    }
    .confirm-dialog {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      z-index: 1000;
      opacity: 0;
      transition: opacity 0.3s ease, transform 0.3s ease;
    }
    .confirm-dialog.show {
      opacity: 1;
      transform: translate(-50%, -50%) scale(1);
    }
    .confirm-dialog button {
      margin: 10px;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }
    .confirm-dialog .yes-btn {
      background-color: #28a745;
      color: #ffffff;
    }
    .confirm-dialog .yes-btn:hover {
      background-color: #218838;
    }
    .confirm-dialog .no-btn {
      background-color: #6c757d;
      color: #ffffff;
    }
    .confirm-dialog .no-btn:hover {
      background-color: #5a6268;
    }
    .overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 999;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
    .overlay.show {
      display: block;
      opacity: 1;
    }
  </style>
  <script>
    function showConfirmDialog() {
      document.getElementById('overlay').classList.add('show');
      document.getElementById('confirmDialog').classList.add('show');
    }
    function hideConfirmDialog() {
      document.getElementById('overlay').classList.remove('show');
      document.getElementById('confirmDialog').classList.remove('show');
    }
    function logout() {
      window.location.href = 'logout.jsp';  // Create a separate JSP file to handle logout
    }
  </script>
</head>
<body>
<div class="container">
  <h2>User Information</h2>
  <div class="user-info">
    <%-- Retrieve user information from session --%>
    <% Users user = (Users) session.getAttribute("user");
      if (user != null) { %>
    <p><strong>Name:</strong> <%= user.getFullName() %></p>
    <p><strong>Email:</strong> <%= user.getEmail() %></p>
    <p><strong>Phone Number:</strong> <%= user.getPhoneNumber() %></p>
    <hr>
    <button class="logout-btn" onclick="showConfirmDialog()">Logout</button>
    <% } else { %>
    <p>User not logged in.</p>
    <% } %>
  </div>
  <a href="${pageContext.request.contextPath}">Back to Main Menu</a>
</div>

<div id="overlay" class="overlay"></div>
<div id="confirmDialog" class="confirm-dialog">
  <p>Are you sure you want to logout?</p>
  <a href="logout"><button type="button" class="yes-btn">Yes</button></a>
  <button class="no-btn" onclick="hideConfirmDialog()">No</button>
</div>

</body>
</html>
