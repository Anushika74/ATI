<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.CourseDAO, com.ati.model.Course" %>
<%
    request.setAttribute("adminPage", "courses");
    String ctx = request.getContextPath();
    CourseDAO dao = new CourseDAO();

    Course editing = null;
    String editId = request.getParameter("edit");
    if (editId != null) editing = dao.findById(Integer.parseInt(editId));

    List<Course> courses = dao.findAll();
%>
<jsp:include page="admin-header.jsp"/>

<div class="section-divider"></div>
<h2>Manage Courses</h2>
<p class="sub">Add or update diplomas and certificate programmes.</p>

<form class="form-ati" method="post" action="<%= ctx %>/CourseServlet" style="margin-bottom:28px;">
    <input type="hidden" name="action" value="<%= editing!=null?"update":"add" %>">
    <% if (editing != null) { %><input type="hidden" name="id" value="<%= editing.getId() %>"><% } %>

    <label>Course Name</label>
    <input type="text" name="name" required value="<%= editing!=null?editing.getName():"" %>">

    <label>Description</label>
    <textarea name="description" rows="3"><%= editing!=null && editing.getDescription()!=null?editing.getDescription():"" %></textarea>

    <label>Duration</label>
    <input type="text" name="duration" placeholder="e.g. 2.5 Years" value="<%= editing!=null && editing.getDuration()!=null?editing.getDuration():"" %>">

    <label>Fee</label>
    <input type="text" name="fee" placeholder="e.g. Government Funded" value="<%= editing!=null && editing.getFee()!=null?editing.getFee():"" %>">

    <button class="btn" type="submit"><%= editing!=null?"Update Course":"Add Course" %></button>
    <% if (editing != null) { %><a class="btn btn-ghost" href="<%= ctx %>/admin/manage-courses.jsp">Cancel</a><% } %>
</form>

<table class="ati">
    <thead><tr><th>Name</th><th>Duration</th><th>Fee</th><th style="width:160px;">Actions</th></tr></thead>
    <tbody>
    <% for (Course c : courses) { %>
        <tr>
            <td><%= c.getName() %></td>
            <td><%= c.getDuration()==null?"":c.getDuration() %></td>
            <td><%= c.getFee()==null?"":c.getFee() %></td>
            <td>
                <a class="btn btn-sm" href="<%= ctx %>/admin/manage-courses.jsp?edit=<%= c.getId() %>">Edit</a>
                <a class="btn btn-sm btn-danger" href="<%= ctx %>/CourseServlet?action=delete&id=<%= c.getId() %>"
                   onclick="return confirm('Delete this course?');">Delete</a>
            </td>
        </tr>
    <% } %>
    <% if (courses.isEmpty()) { %><tr><td colspan="4" style="text-align:center;color:var(--muted);">No courses yet.</td></tr><% } %>
    </tbody>
</table>

<jsp:include page="admin-footer.jsp"/>
