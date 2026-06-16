<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.CourseDAO, com.ati.model.Course" %>
<%
    request.setAttribute("active", "courses");
    java.util.List<Course> courses = new CourseDAO().findAll();
%>
<jsp:include page="includes/header.jsp"/>

<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Courses</h2>
    <p class="sub">Diplomas and certificate programmes currently offered.</p>

    <div class="grid grid-3">
        <% for (Course c : courses) { %>
        <div class="card-ati">
            <div class="meta"><%= c.getDuration()==null?"":c.getDuration() %>
                <% if (c.getFee()!=null && !c.getFee().isEmpty()) { %> &middot; <%= c.getFee() %><% } %>
            </div>
            <h3><%= c.getName() %></h3>
            <p><%= c.getDescription()==null?"":c.getDescription() %></p>
        </div>
        <% } %>
        <% if (courses.isEmpty()) { %><p class="sub">No courses available yet.</p><% } %>
    </div>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
