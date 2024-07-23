<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
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
        .account-details {
            margin-bottom: 25px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
        .account-details p {
            font-size: 16px;
            margin: 5px 0;
            color: #495057;
        }
        .button-group {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
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
        #amountDialog, #balanceDialog, #confirmCloseDialog, #resetPasswordDialog {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            z-index: 1000;
            width: 320px;
        }
        #amountDialog form, #balanceDialog form, #confirmCloseDialog form, #resetPasswordDialog form {
            display: flex;
            flex-direction: column;
        }
        #amountDialog label, #amountDialog input, #balanceDialog p, #confirmCloseDialog p, #resetPasswordDialog input {
            margin-bottom: 12px;
        }
        #amountDialog input[type="submit"], #amountDialog button[type="button"], #balanceDialog button, #confirmCloseDialog button, #resetPasswordDialog button {
            padding: 12px;
            border: none;
            border-radius: 6px;
            background-color: #007bff;
            color: #ffffff;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        #amountDialog input[type="submit"]:hover, #amountDialog button[type="button"]:hover, #balanceDialog button:hover, #confirmCloseDialog button:hover, #resetPasswordDialog button:hover {
            background-color: #0056b3;
        }
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: 500;
        }
    </style>
    <script>
        function showDialog(action) {
            if (action === 'ViewBalance') {
                fetchBalance(); // Fetch balance when clicking View Balance
            } else if (action === 'CloseAccount') {
                document.getElementById('confirmCloseDialog').style.display = 'block';
            } else if (action === 'ResetPassword') {
                document.getElementById('resetPasswordDialog').style.display = 'block';
            } else {
                document.getElementById('actionType').value = action;
                document.getElementById('amountDialog').style.display = 'block';
            }
            document.getElementById('overlay').style.display = 'block';
        }

        function closeDialog() {
            document.getElementById('amountDialog').style.display = 'none';
            document.getElementById('balanceDialog').style.display = 'none';
            document.getElementById('confirmCloseDialog').style.display = 'none';
            document.getElementById('resetPasswordDialog').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        function fetchBalance() {
            fetch('GetBalanceServlet') // Replace with the actual servlet URL
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById('balanceAmount').innerText = 'Balance: ' + data.balance;
                    // Update balance in the container
                    document.getElementById('customerBalance').innerText = 'Balance: ' + data.balance;
                    document.getElementById('balanceDialog').style.display = 'block';
                })
                .catch(error => {
                    console.error('Error fetching balance:', error);
                });
        }

        function confirmClosure() {
            fetch('CloseccountServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'action': 'closeAccount'
                })
            })
            .then(response => response.text())
            .then(message => {
                alert(message); // Display a message from the server
                if (message.includes("successfully")) {
                    window.location.href = 'Index.html'; // Redirect to the homepage or login page
                }
            })
            .catch(error => {
                console.error('Error closing account:', error);
            });
        }

        function resetPassword() {
            const oldPassword = document.getElementById('oldPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                alert('New passwords do not match.');
                return;
            }

            fetch('ResetPasswordServlet', { // Ensure this matches the servlet URL
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'oldPassword': oldPassword,
                    'newPassword': newPassword
                })
            })
            .then(response => response.text())
            .then(message => {
                alert(message); // Display a message from the server
                closeDialog(); // Close the dialog
            })
            .catch(error => {
                console.error('Error resetting password:', error);
            });
        }

        function validateAmount() {
            const amountInput = document.querySelector('input[name="amount"]');
            const amount = parseFloat(amountInput.value);

            if (isNaN(amount) || amount <= 0) {
                alert("Please enter a valid positive number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div id="overlay"></div>
    <div class="container">
        <h1>Welcome, <%= session.getAttribute("customerName") %></h1>
        <h2>Account Details</h2>
        <div class="account-details">
            <p>Account Holder: <%= session.getAttribute("customerName") %></p>
            <p>Account Number: <%= session.getAttribute("customerAccNo") %></p>
            <p id="customerBalance">Balance: <%= session.getAttribute("customerBalance") %></p>
        </div>
        <div class="button-group">
            <button onclick="showDialog('Deposit')">Deposit</button>
            <button onclick="showDialog('Withdraw')">Withdraw</button>
            <button onclick="showDialog('ViewBalance')">View Balance</button>
            <button onclick="showDialog('ResetPassword')">Reset Password</button>
            <button onclick="window.location.href='ViewTransactions.jsp'">View Transactions</button>
            <button onclick="showDialog('CloseAccount')">Close Account</button>
            <a href="Index.html">Logout</a>
        </div>
    </div>

    <div id="amountDialog">
        <form action="TransactionServlet" method="post" onsubmit="return validateAmount()">
            <input type="hidden" name="action" id="actionType" value="">
            <label for="amount">Enter Amount:</label>
            <input type="number" name="amount" step="0.01" required>
            <input type="submit" value="Submit">
            <button type="button" onclick="closeDialog()">Cancel</button>
        </form>
    </div>

    <div id="balanceDialog">
        <p id="balanceAmount">Balance: </p>
        <button type="button" onclick="closeDialog()">Close</button>
    </div>

    <div id="confirmCloseDialog">
        <p>Are you sure you want to close your account? This action cannot be undone.</p>
        <button type="button" onclick="confirmClosure()">Confirm</button>
        <button type="button" onclick="closeDialog()">Cancel</button>
    </div>

    <div id="resetPasswordDialog">
        <form>
            <label for="oldPassword">Old Password:</label>
            <input type="password" id="oldPassword" name="oldPassword" required>
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="button" onclick="resetPassword()">Submit</button>
            <button type="button" onclick="closeDialog()">Cancel</button>
        </form>
    </div>
</body>
</html>
