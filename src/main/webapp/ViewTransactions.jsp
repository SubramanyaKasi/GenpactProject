<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Transactions</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 70%;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1, h2 {
            color: #333;
            font-weight: 400;
            margin-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #dee2e6;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
        }
        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 12px; /* Adds space between buttons */
            margin-top: 20px;
        }
        .button-group button, .button-group a {
            background-color: #007bff;
            color: #ffffff;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        .button-group button:hover, .button-group a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Transaction History</h1>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String accNo = session.getAttribute("customerAccNo").toString();
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "Kasi@9563");
                        String sql = "SELECT * FROM transactions WHERE CustomerAccNo = ? ORDER BY TransactionDate DESC LIMIT 10";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, accNo);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("TransactionId") %></td>
                    <td><%= rs.getTimestamp("TransactionDate") %></td>
                    <td><%= rs.getString("TransactionType") %></td>
                    <td><%= rs.getDouble("Amount") %></td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
        <div class="button-group">
            <form action="DownloadPDFServlet" method="post">
                <input type="hidden" name="customerAccNo" value="<%= session.getAttribute("customerAccNo") %>">
                <button type="submit">Download PDF</button>
            </form>
            <a href="CustomerDashboard.jsp" class="button-group button">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
