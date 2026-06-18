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

<!-- ===================== NEWS TICKER (shown ABOVE the carousel) ===================== -->
<div class="newsline">
    <div class="track">
        <% if (ticker.isEmpty()) { %>
            <span class="marquee-item">No notices yet. Check back soon.</span>
        <% } else { for (Notice n : ticker) {
             String pr = (n.getPriority()==null || n.getPriority().isEmpty()) ? "NORMAL" : n.getPriority(); %>
            <span class="marquee-item">
                <span class="badge badge-<%= pr %>"><%= pr %></span>
                <span class="bullhorn">&#128227;</span>
                <span class="mq-text"><%= n.getTitle() %><% if (n.getContent()!=null && !n.getContent().isEmpty()) { %> &mdash; <%= n.getContent() %><% } %></span>
                <% if (n.getLink()!=null && !n.getLink().trim().isEmpty()) { %>
                    <a href="<%= n.getLink() %>" target="_blank" rel="noopener">Download</a>
                <% } %>
            </span>
        <% } } %>
    </div>
</div>

<!-- ===================== CAROUSEL (self-contained, auto-sliding) ===================== -->
<div class="ati-carousel" id="atiCarousel">
  <div class="ati-slides">
    <% if (slides.isEmpty()) { %>
        <div class="ati-slide active ati-slide-placeholder">
            <div class="ati-cap">
                <h2>Welcome to ATI Badulla</h2>
                <p>Upload images from the Admin Panel and mark them "Top 10" to show them here.</p>
            </div>
        </div>
    <% } else {
         for (int i = 0; i < slides.size(); i++) {
             GalleryImage g = slides.get(i);
             String title = g.getTitle()==null ? "" : g.getTitle(); %>
        <div class="ati-slide <%= i==0?"active":"" %>">
            <img src="<%= ctx %>/<%= g.getImagePath() %>" alt="<%= title %>">
            <% if (!title.isEmpty()) { %>
              <div class="ati-cap"><h2><%= title %></h2></div>
            <% } %>
        </div>
    <%   } } %>
  </div>

  <% if (slides.size() > 1) { %>
  <button class="ati-prev" type="button" aria-label="Previous">&#10094;</button>
  <button class="ati-next" type="button" aria-label="Next">&#10095;</button>
  <div class="ati-dots">
    <% for (int i = 0; i < slides.size(); i++) { %>
        <button class="ati-dot <%= i==0?"active":"" %>" data-i="<%= i %>" type="button"></button>
    <% } %>
  </div>
  <% } %>
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

<!-- Self-contained carousel script: auto-advances and handles controls.
     Works even without Bootstrap / internet. -->
<script>
(function () {
    var root = document.getElementById('atiCarousel');
    if (!root) return;
    var slides = [].slice.call(root.querySelectorAll('.ati-slide'));
    var dots   = [].slice.call(root.querySelectorAll('.ati-dot'));
    if (slides.length < 2) return;            // nothing to rotate
    var i = 0, timer = null;
    function show(n) {
        i = (n + slides.length) % slides.length;
        slides.forEach(function (s, x) { s.classList.toggle('active', x === i); });
        dots.forEach(function (d, x) { d.classList.toggle('active', x === i); });
    }
    function next() { show(i + 1); }
    function prev() { show(i - 1); }
    function start() { timer = setInterval(next, 3500); }   // auto-switch every 3.5s
    function restart() { clearInterval(timer); start(); }
    var nb = root.querySelector('.ati-next'), pb = root.querySelector('.ati-prev');
    if (nb) nb.addEventListener('click', function () { next(); restart(); });
    if (pb) pb.addEventListener('click', function () { prev(); restart(); });
    dots.forEach(function (d) {
        d.addEventListener('click', function () {
            show(parseInt(d.getAttribute('data-i'), 10)); restart();
        });
    });
    root.addEventListener('mouseenter', function () { clearInterval(timer); });
    root.addEventListener('mouseleave', start);
    start();
})();
</script>

<jsp:include page="includes/footer.jsp"/>
