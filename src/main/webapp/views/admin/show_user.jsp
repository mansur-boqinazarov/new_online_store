<%@ page import="uz.pdp.online_store.entity.user.Users" %>
<%@ page import="uz.pdp.online_store.service.user.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
        }

        img {
            max-width: 100%;
        }

        .user {
            margin: 20px;
            border-radius: 6px;
            width: calc(33.3% - 40px);
            overflow: hidden;
            box-shadow: 0 5px 10px rgba(0,0,0,.05), 0 0 0 1px #ddd inset;
            position: relative;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            font-size: 0;
            margin-right: 12px;
        }

        .user-header {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            padding: 20px;
            background: linear-gradient(to bottom, rgba(0,0,0,0.05) 0%,rgba(0,0,0,0.05) 1%,rgba(0,0,0,0) 100%);
        }

        .user-basic-info {
            flex: 1;
            overflow: hidden;
            white-space: nowrap;
        }

        .user-fullname {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: rgba(0,0,0,0.6);
            font-size: 14px;
        }

        .user-nick {
            text-transform: uppercase;
            font-weight: 600;
            font-size: 15px;
            margin-bottom: 2px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .user-info {
            padding: 16px 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            font-size: 15px;
        }

        .user-info + .user-info {
            border-top: 1px solid #efefef;
        }

        .user-title {
            font-size: 11px;
            font-weight: bold;
            color: rgba(0,0,0,0.4);
            letter-spacing: 1px;
        }

        .user-list {
            display: flex;
            flex-wrap: wrap;
            padding: 0 20px;
            max-width: 1200px;
            margin: auto;
        }

        .user-remove {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 0;
            background-color: #d80c0c;
            box-shadow: 0 0 0 40px rgba(255, 255, 255, 0.8), 0 0 0 5px rgba(216, 12, 12, 0.8);
            padding: 10px;
            border-radius: 5px;
            color: #fff;
            opacity: 0;
            outline: 0;
            cursor: pointer;
            transition: .3s;
        }

        .user:hover .user-remove {
            opacity: 1;
        }

        @media (max-width: 800px) {
            .user {
                width: calc(50% - 40px);
            }
        }

        @media (max-width: 600px) {
            .user {
                width: calc(100% - 40px);
            }
        }
    </style>
</head>
<body>

<div class="user-list">
    <%
        UserService userService = new UserService();
        List<Users> list = userService.getAllUsers();
        for (Users users : list) {
    %>
    <div class="user">
        <div class="user-header">

            <div class="user-basic-info">
                <div class="user-fullname"><h1><%= users.getFullName() %></h1></div>
            </div>
        </div>
        <div class="user-info">
            <span class="user-title">EMAIL</span>
            <span class="user-data"><%= users.getEmail() %></span>
        </div>
        <div class="user-info">
            <span class="user-title">STATUS</span>
            <span class="user-data"><%= users.getStatus() %></span>
        </div>
        <div class="user-info">
            <span class="user-title">PHONE</span>
            <span class="user-data"><%= users.getPhoneNumber() %></span>
        </div>
        <div class="user-info">
            <span class="user-title">CREATED AT</span>
            <span class="user-data"><%= users.getCreatedAt() %></span>
        </div>
        <form method="post" action = "${pageContext.request.contextPath}/admin/removeUser">
        <input type="hidden" name="removeUserId" value="<%=users.getId()%>">
        <button type="submit" class="user-remove">REMOVE</button>
        </form>
    </div>
    <%
        }
    %>
</div>

</body>
</html>
