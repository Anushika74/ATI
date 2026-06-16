<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.ati.dao.*, com.ati.model.*" %>
<%
    request.setAttribute("active", "home");
    String ctx = request.getContextPath();

    // --- Visitor counter: increments every time index.jsp is loaded ---
    long visits = new StatsDAO().incrementAndGet();

    // --- Carousel: top 10 most recent images flagged is_carousel = 1 ---
    List<GalleryImage> slides = new GalleryDAO().findCarousel();

    // --- Newsline: most recent notices ---
    List<Notice> ticker = new NoticeDAO().findRecent(8);

    // --- Featured courses ---
    List<Course> courses = new CourseDAO().findAll();
%>
<jsp:include page="includes/header.jsp"/>

<!-- ===================== CAROUSEL ===================== -->
<div id="atiCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="3500">
  <div class="carousel-indicators">
    <% if (slides.isEmpty()) { %>
        <button type="button" data-bs-target="#atiCarousel" data-bs-slide-to="0" class="active"></button>
    <% } else { for (int i = 0; i < slides.size(); i++) { %>
        <button type="button" data-bs-target="#atiCarousel" data-bs-slide-to="<%= i %>"
                class="<%= i==0?"active":"" %>"></button>
    <% } } %>
  </div>
  <div class="carousel-inner">
    <% if (slides.isEmpty()) { %>
        <div class="carousel-item active">
            <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&w=1600&q=80" alt="ATI Badulla">
            <div class="carousel-caption">
                <h2>Welcome to ATI Badulla</h2>
                <p>Upload images from the Admin Panel and mark them "Top 10" to show them here.</p>
            </div>
        </div>
    <% } else {
         for (int i = 0; i < slides.size(); i++) {
             GalleryImage g = slides.get(i); %>
        <div class="carousel-item <%= i==0?"active":"" %>">
            <img src="<%= ctx %>/<%= g.getImagePath() %>" alt="<%= g.getTitle() %>">
            <div class="carousel-caption">
                <h2><%= g.getTitle()==null?"":g.getTitle() %></h2>
            </div>
        </div>
    <%   } } %>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#atiCarousel" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#atiCarousel" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

<!-- ===================== NEWS TICKER ===================== -->
<div class="newsline">
    <div class="label">&#128226; NEWSLINE</div>
    <div class="track">
        <% if (ticker.isEmpty()) { %>
            <span>No notices yet. Check back soon.</span>
        <% } else { for (Notice n : ticker) { %>
            <span>
                <% if ("URGENT".equals(n.getPriority())) { %><span class="badge-urgent">[URGENT]</span> <% } %>
                <%= n.getTitle() %> &mdash; <%= n.getContent()==null?"":n.getContent() %>
            </span>
        <% } } %>
    </div>
</div>

<!-- ===================== WELCOME + STATS ===================== -->
<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Advanced Technological Institute, Badulla</h2>
    <p class="sub">Empowering the Uva Province with quality higher education in technology, accountancy and English.</p>

    <div class="stats">
        <div class="stat-box"><div class="num"><%= visits %></div><div class="lbl">Total Visitors</div></div>
        <div class="stat-box"><div class="num"><%= courses.size() %></div><div class="lbl">Courses Offered</div></div>
        <div class="stat-box"><div class="num"><%= slides.size() %></div><div class="lbl">Featured Photos</div></div>
        <div class="stat-box"><div class="num"><%= ticker.size() %></div><div class="lbl">Active Notices</div></div>
    </div>
  </div>
</div>

<!-- ===================== FEATURED COURSES ===================== -->
<div class="section" style="padding-top:0;">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Programmes We Offer</h2>
    <p class="sub">Nationally recognised diplomas and certificate courses.</p>
    <div class="grid grid-3">
        <% int shown=0; for (Course c : courses) { if (shown++>=6) break; %>
        <div class="card-ati">
            <div class="meta"><%= c.getDuration()==null?"":c.getDuration() %></div>
            <h3><%= c.getName() %></h3>
            <p><%= c.getDescription()==null?"":c.getDescription() %></p>
        </div>
        <% } %>
        <% if (courses.isEmpty()) { %><p class="sub">No courses added yet.</p><% } %>
    </div>
    <div style="margin-top:22px;"><a class="btn" href="<%= ctx %>/courses.jsp">View All Courses</a></div>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
