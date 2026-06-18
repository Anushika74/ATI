<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login - ATI Badulla</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<div class="login-wrap">
    <div class="form-ati login-card">
        <div style="text-align:center;margin-bottom:18px;">
            <img src="<%= ctx %>/images/logo.jpg" alt="ATI Badulla" style="height:64px;width:auto;border-radius:8px;margin:0 auto 10px;display:block;">
            <h2 style="color:#fff;">Admin Panel</h2>
            <p style="color:var(--muted);">Sign in to manage the portal</p>
        </div>

        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <form method="post" action="<%= ctx %>/LoginServlet">
            <label>Username</label>
            <input type="text" name="username" required autofocus>
            <label>Password</label>
            <input type="password" name="password" required>
            <button class="btn" type="submit" style="width:100%;">Login</button>
        </form>

        <p style="color:var(--muted);margin-top:16px;text-align:center;font-size:.85rem;">
            Default: <strong>admin</strong> / <strong>admin123</strong>
        </p>
        <p style="text-align:center;margin-top:8px;"><a href="<%= ctx %>/index.jsp">&larr; Back to website</a></p>
    </div>
</div>
</body>
</html>
