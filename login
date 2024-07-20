login.html

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
      }
      
      h2 {
        color: #333;
      }
      
      form {
        background-color: #fff;
        border: 1px solid #ddd;
        padding: 20px;
        margin: 10px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      
      label {
        display: block;
        margin-bottom: 8px;
      }
      
      input {
        width: 100%;
        padding: 8px;
        margin-bottom: 15px;
        box-sizing: border-box;
      }
      
      button {
        background-color: #4caf50;
        color: #fff;
        padding: 10px 15px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
      }
      
      button:hover {
        background-color: #45a049;
      }
      
      .alert {
        background-color: #f2dede;
        color: #a94442;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ebccd1;
        border-radius: 4px;
      }
  </style>
</head>
<body>

  <h2>Login</h2>
  <form id="loginForm" action="login.jsp" method="post"> <!-- Specify the action and method for form submission -->
    <label for="loginUsername">Username:</label>
    <input type="text" id="loginUsername" required name="loginUsername">
    
    <label for="loginPassword">Password:</label>
    <input type="password" id="loginPassword" required name="loginPassword">

    <button type="submit">Login</button>
  </form>

  <script>
    $(document).ready(function() {
        // This part is no longer needed, as the form will be submitted to the server-side code for validation
      });
  </script>
</body>
</html>

login.jsp

<%@ page import="java.sql.SQLException" %>
<%@ page import="com.javatpoint.dao.loginDAO" %>
<%@ page import="com.javatpoint.bean.User1" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    if (request.getMethod().equals("POST")) {
        String loginUsername = request.getParameter("loginUsername");
        String loginPassword = request.getParameter("loginPassword");
        
        if (loginUsername != null && loginPassword != null) {
            loginDAO loginDAO = new loginDAO();
            try {
                User1 loggedInUser = loginDAO.getUserByUsername(loginUsername);

                if (loggedInUser != null && loggedInUser.getPassword().equals(loginPassword)) {
                    session.setAttribute("loggedInUser", loggedInUser);
                    response.sendRedirect("depressed.html"); // Redirect to another page after successful login
                } else {
                    out.println("<script>alert('Login failed. Please check your username and password.');</script>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                // Handle the exception appropriately
                out.println("<script>alert('An error occurred while processing your request.');</script>");
                e.printStackTrace();
            }
        } else {
            out.println("<script>alert('Enter both username and password.');</script>");
        }
    }
%>
