<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ati.dao.*" %>
<%
    request.setAttribute("adminPage", "dash");
    long visits  = new StatsDAO().getCount();
    int notices  = new NoticeDAO().findAll().size();
    int gallery  = new GalleryDAO().findAll().size();
    int courses  = new CourseDAO().findAll().size();
    int results  = new ResultDAO().findAll().size();
%>
<jsp:include page="admin-header.jsp"/>

<div class="section-divider"></div>
<h2>Dashboard</h2>
<p class="sub">Overview of your portal content.</p>

<div class="stats" style="margin-bottom:30px;">
    <div class="stat-box"><div class="num"><%= visits %></div><div class="lbl">Total Visitors</div></div>
    <div class="stat-box"><div class="num"><%= notices %></div><div class="lbl">Notices</div></div>
    <div class="stat-box"><div class="num"><%= gallery %></div><div class="lbl">Gallery Images</div></div>
    <div class="stat-box"><div class="num"><%= courses %></div><div class="lbl">Courses</div></div>
    <div class="stat-box"><div class="num"><%= results %></div><div class="lbl">Results</div></div>
</div>

<div class="grid grid-4">
    <a class="card-ati" href="manage-notices.jsp"><h3>&#128221; Notices</h3><p>Add urgent notices for the newsline.</p></a>
    <a class="card-ati" href="manage-gallery.jsp"><h3>&#128247; Gallery</h3><p>Upload event photos &amp; set the Top 10.</p></a>
    <a class="card-ati" href="manage-courses.jsp"><h3>&#127891; Courses</h3><p>Update programmes offered.</p></a>
    <a class="card-ati" href="manage-results.jsp"><h3>&#128202; Results</h3><p>Publish exam results &amp; documents.</p></a>
</div>

<jsp:include page="admin-footer.jsp"/>
