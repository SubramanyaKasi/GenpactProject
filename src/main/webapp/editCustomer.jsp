<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="bankapp.CustomerDAO1" %>
<%@ page import="bankapp.Customer1" %>

<%
String customerAccNo = request.getParameter("CustomerAccNo");
CustomerDAO1 customerDAO = new CustomerDAO1();
Customer1 customer = customerDAO.getCustomerByAccNo(customerAccNo);
%>

<html>
<head>
    <title>Edit Customer</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
        }
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #007bff;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="date"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Customer</h2>
        <form action="EditCustomerServlet" method="post">
            <input type="hidden" name="CustomerAccNo" value="<%= customer.getCustomerAccNo() %>">
            <label for="CustomerFullName">Full Name:</label>
            <input type="text" id="CustomerFullName" name="CustomerFullName" value="<%= customer.getCustomerFullName() %>" required>
            
            <label for="CustomerAddress">Address:</label>
            <input type="text" id="CustomerAddress" name="CustomerAddress" value="<%= customer.getCustomerAddress() %>" required>
            
            <label for="CustomerMobileNo">Mobile No:</label>
            <input type="text" id="CustomerMobileNo" name="CustomerMobileNo" value="<%= customer.getCustomerMobileNo() %>" required>
            
            <label for="CustomerEmailid">Email:</label>
            <input type="email" id="CustomerEmailid" name="CustomerEmailid" value="<%= customer.getCustomerEmailid() %>" required>
            
            <label for="CustomerTypeofAcc">Type of Account:</label>
            <input type="text" id="CustomerTypeofAcc" name="CustomerTypeofAcc" value="<%= customer.getCustomerTypeofAcc() %>" required>
            
            <label for="CustomerDOB">DOB:</label>
            <input type="date" id="CustomerDOB" name="CustomerDOB" value="<%= customer.getCustomerDOB() %>" required>
            
            <label for="Id_Proof">ID Proof:</label>
            <input type="text" id="Id_Proof" name="Id_Proof" value="<%= customer.getId_Proof() %>" required>
            
            <label for="Id_Number">ID Number:</label>
            <input type="text" id="Id_Number" name="Id_Number" value="<%= customer.getId_Number() %>" required>
            
            <input type="submit" value="Update Customer">
        </form>
    </div>
</body>
</html>
