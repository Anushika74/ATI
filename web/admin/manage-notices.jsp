<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.NoticeDAO, com.ati.model.Notice" %>
<%
    request.setAttribute("adminPage", "notices");
    String ctx = request.getContextPath();
    NoticeDAO dao = new NoticeDAO();

    // If ?edit=ID is present, load that notice into the form
    Notice editing = null;
    String editId = request.getParameter("edit");
    if (editId != null) editing = dao.findById(Integer.parseInt(editId));

    List<Notice> notices = dao.findAll();
%>
<jsp:include page="admin-header.jsp"/>

<div class="section-divider"></div>
<h2>Manage Notices</h2>
<p class="sub">These appear in the scrolling newsline on the homepage.</p>

<form class="form-ati" method="post" action="<%= ctx %>/NoticeServlet" style="margin-bottom:28px;">
    <input type="hidden" name="action" value="<%= editing!=null?"update":"add" %>">
    <% if (editing != null) { %><input type="hidden" name="id" value="<%= editing.getId() %>"><% } %>

    <label>Title</label>
    <input type="text" name="title" required value="<%= editing!=null?editing.getTitle():"" %>">

    <label>Content</label>
    <textarea name="content" rows="3"><%= editing!=null && editing.getContent()!=null?editing.getContent():"" %></textarea>

    <label>Priority</label>
    <select name="priority">
        <% String[] pr = {"NORMAL","HIGH","URGENT"};
           String cur = editing!=null?editing.getPriority():"NORMAL";
           for (String p : pr) { %>
            <option value="<%= p %>" <%= p.equals(cur)?"selected":"" %>><%= p %></option>
        <% } %>
    </select>

    <label>Download / More Link (optional)</label>
    <input type="text" name="link" placeholder="https://... (e.g. a Google Drive file)"
           value="<%= editing!=null && editing.getLink()!=null ? editing.getLink() : "" %>">

    <button class="btn" type="submit"><%= editing!=null?"Update Notice":"Add Notice" %></button>
    <% if (editing != null) { %>
        <a class="btn btn-ghost" href="<%= ctx %>/admin/manage-notices.jsp">Cancel</a>
    <% } %>
</form>

<table class="ati">
    <thead><tr><th>Title</th><th>Priority</th><th>Date</th><th style="width:160px;">Actions</th></tr></thead>
    <tbody>
    <% for (Notice n : notices) { %>
        <tr>
            <td><%= n.getTitle() %></td>
            <td><span class="badge badge-<%= n.getPriority() %>"><%= n.getPriority() %></span></td>
            <td><%= n.getNoticeDate() %></td>
            <td>
                <a class="btn btn-sm" href="<%= ctx %>/admin/manage-notices.jsp?edit=<%= n.getId() %>">Edit</a>
                <a class="btn btn-sm btn-danger" href="<%= ctx %>/NoticeServlet?action=delete&id=<%= n.getId() %>"
                   onclick="return confirm('Delete this notice?');">Delete</a>
            </td>
        </tr>
    <% } %>
    <% if (notices.isEmpty()) { %><tr><td colspan="4" style="text-align:center;color:var(--muted);">No notices yet.</td></tr><% } %>
    </tbody>
</table>

<jsp:include page="admin-footer.jsp"/>
