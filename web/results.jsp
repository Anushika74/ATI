<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.ResultDAO, com.ati.model.Result" %>
<%
    request.setAttribute("active", "results");
    String ctx = request.getContextPath();
    ResultDAO dao = new ResultDAO();
    String q = request.getParameter("index");
    java.util.List<Result> results = (q != null && !q.trim().isEmpty())
            ? dao.searchByIndex(q.trim())
            : dao.findAll();
%>
<jsp:include page="includes/header.jsp"/>

<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Examination Results</h2>
    <p class="sub">Search by your student index number, or browse the published results.</p>

    <form class="form-ati" method="get" action="<%= ctx %>/results.jsp" style="margin-bottom:24px;">
        <label>Student Index Number</label>
        <input type="text" name="index" value="<%= q==null?"":q %>" placeholder="e.g. BAD/IT/2024/001">
        <button class="btn" type="submit">Search</button>
    </form>

    <table class="ati">
        <thead>
            <tr><th>Index</th><th>Name</th><th>Course</th><th>Marks</th><th>Grade</th><th>Document</th></tr>
        </thead>
        <tbody>
        <% for (Result r : results) { %>
            <tr>
                <td><%= r.getStudentIndex() %></td>
                <td><%= r.getStudentName()==null?"":r.getStudentName() %></td>
                <td><%= r.getCourseName()==null?"":r.getCourseName() %></td>
                <td><%= r.getMarks()==null?"":r.getMarks() %></td>
                <td><%= r.getGrade()==null?"":r.getGrade() %></td>
                <td>
                    <% if (r.getResultFile()!=null && !r.getResultFile().isEmpty()) { %>
                        <a href="<%= ctx %>/<%= r.getResultFile() %>" target="_blank">View</a>
                    <% } else { %>&mdash;<% } %>
                </td>
            </tr>
        <% } %>
        <% if (results.isEmpty()) { %>
            <tr><td colspan="6" style="text-align:center;color:var(--muted);">No results found.</td></tr>
        <% } %>
        </tbody>
    </table>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
