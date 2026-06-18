<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    String active = (String) request.getAttribute("active");
    if (active == null) active = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ATI Badulla - Advanced Technological Institute</title>
    <!-- Bootstrap 5 (for the carousel & layout) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<nav class="navbar-ati">
  <div class="container-ati" style="display:flex;align-items:center;justify-content:space-between;padding:12px 18px;flex-wrap:wrap;">
      <a class="brand" href="<%= ctx %>/index.jsp">
          <img src="<%= ctx %>/images/logo.png" alt="ATI Badulla" style="height:42px;width:auto;border-radius:6px;">
          <span>ATI&nbsp;Badulla</span>
      </a>
      <div class="nav-links" style="display:flex;gap:6px;align-items:center;flex-wrap:wrap;">
          <a href="<%= ctx %>/index.jsp"   class="<%= active.equals("home")?"active":"" %>">Home</a>
          <a href="<%= ctx %>/about.jsp"   class="<%= active.equals("about")?"active":"" %>">About Us</a>
          <a href="<%= ctx %>/courses.jsp" class="<%= active.equals("courses")?"active":"" %>">Courses</a>
          <a href="<%= ctx %>/gallery.jsp" class="<%= active.equals("gallery")?"active":"" %>">Gallery</a>
          <a href="<%= ctx %>/results.jsp" class="<%= active.equals("results")?"active":"" %>">Results</a>
          <a href="<%= ctx %>/contact.jsp" class="<%= active.equals("contact")?"active":"" %>">Contact Us</a>
          <a href="<%= ctx %>/admin/login.jsp" class="btn-admin">Admin Login</a>
      </div>
  </div>
</nav>
