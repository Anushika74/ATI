<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.GalleryDAO, com.ati.model.GalleryImage" %>
<%
    request.setAttribute("adminPage", "gallery");
    String ctx = request.getContextPath();
    List<GalleryImage> images = new GalleryDAO().findAll();
%>
<jsp:include page="admin-header.jsp"/>

<div class="section-divider"></div>
<h2>Event Gallery</h2>
<p class="sub">Upload images. Tick "Show in carousel" to include it in the homepage Top-10 slider.</p>

<form class="form-ati" method="post" action="<%= ctx %>/GalleryServlet"
      enctype="multipart/form-data" style="margin-bottom:28px;">
    <label>Image Title</label>
    <input type="text" name="title" placeholder="e.g. Annual Sports Meet 2026">

    <label>Image File</label>
    <input type="file" name="image" accept="image/*" required>

    <label style="display:flex;align-items:center;gap:8px;margin-top:14px;">
        <input type="checkbox" name="carousel" style="width:auto;"> Show in homepage carousel (Top 10)
    </label>

    <button class="btn" type="submit">Upload Image</button>
</form>

<div class="grid grid-4 gallery-grid">
    <% for (GalleryImage g : images) { %>
        <div class="card-ati" style="padding:12px;">
            <img src="<%= ctx %>/<%= g.getImagePath() %>" alt="<%= g.getTitle() %>" style="height:150px;">
            <div style="margin:8px 0;color:var(--muted);font-size:.85rem;"><%= g.getTitle()==null?"(untitled)":g.getTitle() %></div>
            <div style="display:flex;gap:6px;flex-wrap:wrap;">
                <% if (g.isCarousel()) { %>
                    <a class="btn btn-sm btn-ghost" href="<%= ctx %>/GalleryServlet?action=carousel&value=0&id=<%= g.getId() %>">&#11088; In Top 10</a>
                <% } else { %>
                    <a class="btn btn-sm" href="<%= ctx %>/GalleryServlet?action=carousel&value=1&id=<%= g.getId() %>">Add to Top 10</a>
                <% } %>
                <a class="btn btn-sm btn-danger" href="<%= ctx %>/GalleryServlet?action=delete&id=<%= g.getId() %>"
                   onclick="return confirm('Delete this image?');">Delete</a>
            </div>
        </div>
    <% } %>
    <% if (images.isEmpty()) { %><p class="sub">No images uploaded yet.</p><% } %>
</div>

<jsp:include page="admin-footer.jsp"/>
