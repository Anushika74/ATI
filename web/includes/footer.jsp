<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String fctx = request.getContextPath(); %>
<footer class="footer-ati">
  <div class="container-ati">
    <div class="footer-grid">

      <!-- Brand + description -->
      <div>
        <div class="footer-brand">
          <img src="<%= fctx %>/images/logo.png" alt="ATI Badulla">
          <span>ATI&nbsp;BADULLA</span>
        </div>
        <p>A leading higher educational institution under the Sri Lanka Institute of
           Advanced Technological Education (SLIATE), committed to excellence in
           technological education.</p>
      </div>

      <!-- Quick Links -->
      <div>
        <h4>Quick Links</h4>
        <ul class="footer-links">
          <li><a href="<%= fctx %>/index.jsp">Home</a></li>
          <li><a href="<%= fctx %>/about.jsp">About Us</a></li>
          <li><a href="<%= fctx %>/courses.jsp">Courses</a></li>
          <li><a href="<%= fctx %>/results.jsp">Results</a></li>
          <li><a href="<%= fctx %>/index.jsp">News</a></li>
          <li><a href="<%= fctx %>/contact.jsp">Contact</a></li>
        </ul>
      </div>

      <!-- Resources -->
      <div>
        <h4>Resources</h4>
        <ul class="footer-links">
          <li><a href="https://lms.sliate.ac.lk" target="_blank" rel="noopener">SLIATE LMS</a></li>
          <li><a href="https://www.sliate.ac.lk" target="_blank" rel="noopener">SLIATE Head Office</a></li>
          <li><a href="https://moe.gov.lk" target="_blank" rel="noopener">Ministry of Education</a></li>
          <li><a href="https://www.ugc.ac.lk" target="_blank" rel="noopener">UGC</a></li>
        </ul>
      </div>

      <!-- Contact Us -->
      <div class="footer-contact">
        <h4>Contact Us</h4>
        <div><span class="ic">&#128205;</span>
             <span>Advanced Technological Institute, Green Lane Drive, Badulla, Sri Lanka</span></div>
        <div><span class="ic">&#128222;</span>
             <span>+94 055 2 228478<br>+94 055 2 230218<br>+94 055 2 223818</span></div>
        <div><span class="ic">&#9993;</span>
             <span><a href="mailto:atibadulla@sliate.ac.lk">atibadulla@sliate.ac.lk</a></span></div>
      </div>

    </div>
    <div class="footer-bottom">
        &copy; <%= java.time.Year.now() %> Advanced Technological Institute, Badulla. All rights reserved.
    </div>
  </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
