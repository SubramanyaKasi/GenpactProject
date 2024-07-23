<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            background-color: #f4f4f4;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #333;
            padding-top: 20px;
        }
        .sidebar a {
            padding: 15px 8px 15px 16px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #575757;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container h2 {
            margin-top: 0;
        }
        .main-content .header {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            background-color: #4CAF50;
            padding: 10px;
            color: white;
        }
        .main-content .header img {
            border-radius: 50%;
            margin-right: 10px;
        }
        .admin-info {
            margin-top: 20px;
        }
        .admin-info p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Banking System Admin Dashboard</h1>
    </div>
    <div class="sidebar">
        <a href="adminManageusers.html">Manage Users</a>
        <a href="adminTransactions.jsp">Transactions</a>
        <a href="settings.jsp">Reset Password</a>
        <a href="Index.html">Logout</a>
    </div>
    <div class="content">
        <div class="main-content">
            <div class="header">
                <span>Admin</span>
            </div>
            <div class="admin-info container">
                <%
                    String fullName = (String) session.getAttribute("adminFullName");
                    String email = (String) session.getAttribute("adminEmailid");
                    String phone = (String) session.getAttribute("adminPhoneno");
                    String info = (String) session.getAttribute("adminInfo");
                %>
                <h2>Welcome, <%= fullName %></h2>
                <p><strong>Name:</strong> <%= fullName %></p>
                <p><strong>Email:</strong> <%= email %></p>
                <p><strong>Phone:</strong> <%= phone %></p>
                <p><strong>Info:</strong> <%= info %></p>
            </div>
        </div>
    </div>
</body>
</html>
