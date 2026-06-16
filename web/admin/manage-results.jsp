<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.ResultDAO, com.ati.model.Result" %>
<%
    request.setAttribute("adminPage", "results");
    String ctx = request.getContextPath();
    List<Result> results = new ResultDAO().findAll();
%>
<jsp:include page="admin-header.jsp"/>

<div class="section-divider"></div>
<h2>Exam Results</h2>
<p class="sub">Publish student results. You may also attach a result document (PDF / image).</p>

<form class="form-ati" method="post" action="<%= ctx %>/ResultServlet"
      enctype="multipart/form-data" style="margin-bottom:28px;">
    <label>Student Index</label>
    <input type="text" name="studentIndex" required placeholder="e.g. BAD/IT/2024/001">

    <label>Student Name</label>
    <input type="text" name="studentName">

    <label>Course</label>
    <input type="text" name="courseName" placeholder="e.g. HNDIT">

    <label>Marks</label>
    <input type="text" name="marks" placeholder="e.g. 78">

    <label>Grade</label>
    <input type="text" name="grade" placeholder="e.g. A">

    <label>Result Document (optional)</label>
    <input type="file" name="resultFile" accept=".pdf,image/*">

    <button class="btn" type="submit">Add Result</button>
</form>

<table class="ati">
    <thead><tr><th>Index</th><th>Name</th><th>Course</th><th>Marks</th><th>Grade</th><th>Doc</th><th style="width:90px;">Action</th></tr></thead>
    <tbody>
    <% for (Result r : results) { %>
        <tr>
            <td><%= r.getStudentIndex() %></td>
            <td><%= r.getStudentName()==null?"":r.getStudentName() %></td>
            <td><%= r.getCourseName()==null?"":r.getCourseName() %></td>
            <td><%= r.getMarks()==null?"":r.getMarks() %></td>
            <td><%= r.getGrade()==null?"":r.getGrade() %></td>
            <td><% if (r.getResultFile()!=null && !r.getResultFile().isEmpty()) { %>
                    <a href="<%= ctx %>/<%= r.getResultFile() %>" target="_blank">View</a>
                <% } else { %>&mdash;<% } %></td>
            <td>
                <a class="btn btn-sm btn-danger" href="<%= ctx %>/ResultServlet?action=delete&id=<%= r.getId() %>"
                   onclick="return confirm('Delete this result?');">Delete</a>
            </td>
        </tr>
    <% } %>
    <% if (results.isEmpty()) { %><tr><td colspan="7" style="text-align:center;color:var(--muted);">No results yet.</td></tr><% } %>
    </tbody>
</table>

<jsp:include page="admin-footer.jsp"/>
