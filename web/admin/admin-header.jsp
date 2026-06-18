<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ati.model.User" %>
<%
    String ctx = request.getContextPath();
    // Session guard (the AuthFilter also protects this, this is a second layer)
    User loggedUser = (session != null) ? (User) session.getAttribute("user") : null;
    if (loggedUser == null) {
        response.sendRedirect(ctx + "/admin/login.jsp");
        return;
    }
    String navPage = (String) request.getAttribute("adminPage");
    if (navPage == null) navPage = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin - ATI Badulla</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<div class="admin-shell">
    <aside class="sidebar">
        <h3><img src="<%= ctx %>/images/logo.png" alt="ATI" style="height:26px;width:auto;border-radius:4px;vertical-align:middle;margin-right:6px;">ATI Admin</h3>
        <a href="<%= ctx %>/admin/dashboard.jsp"        class="<%= navPage.equals("dash")?"active":"" %>">Dashboard</a>
        <a href="<%= ctx %>/admin/manage-notices.jsp"   class="<%= navPage.equals("notices")?"active":"" %>">Manage Notices</a>
        <a href="<%= ctx %>/admin/manage-gallery.jsp"   class="<%= navPage.equals("gallery")?"active":"" %>">Event Gallery</a>
        <a href="<%= ctx %>/admin/manage-courses.jsp"   class="<%= navPage.equals("courses")?"active":"" %>">Manage Courses</a>
        <a href="<%= ctx %>/admin/manage-results.jsp"   class="<%= navPage.equals("results")?"active":"" %>">Exam Results</a>
        <hr style="border-color:var(--border);margin:14px 0;">
        <a href="<%= ctx %>/index.jsp" target="_blank">View Website &#8599;</a>
        <a href="<%= ctx %>/LogoutServlet" style="color:#ff8a80;">Logout</a>
    </aside>
    <main class="admin-main">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
            <div></div>
            <div style="color:var(--muted);">Signed in as <strong style="color:#fff;"><%= loggedUser.getUsername() %></strong></div>
        </div>
