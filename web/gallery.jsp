<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.GalleryDAO, com.ati.model.GalleryImage" %>
<%
    request.setAttribute("active", "gallery");
    String ctx = request.getContextPath();
    java.util.List<GalleryImage> images = new GalleryDAO().findAll();
%>
<jsp:include page="includes/header.jsp"/>

<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Event Gallery</h2>
    <p class="sub">Memorable moments and events at ATI Badulla.</p>

    <div class="grid grid-4 gallery-grid">
        <% for (GalleryImage g : images) { %>
        <div>
            <img src="<%= ctx %>/<%= g.getImagePath() %>" alt="<%= g.getTitle() %>">
            <div style="color:var(--muted);font-size:.85rem;margin-top:6px;"><%= g.getTitle()==null?"":g.getTitle() %></div>
        </div>
        <% } %>
        <% if (images.isEmpty()) { %><p class="sub">No images uploaded yet.</p><% } %>
    </div>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
