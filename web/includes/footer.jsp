<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String fctx = request.getContextPath(); %>
<footer class="footer-ati">
    <div class="container-ati" style="display:flex;justify-content:space-between;flex-wrap:wrap;gap:16px;">
        <div>
            <strong style="color:#fff;">Advanced Technological Institute - Badulla</strong><br>
            Affiliated to SLIATE, Ministry of Higher Education.<br>
            Badulla, Sri Lanka.
        </div>
        <div>
            <strong style="color:#fff;">Quick Links</strong><br>
            <a href="<%= fctx %>/courses.jsp">Courses</a> &middot;
            <a href="<%= fctx %>/gallery.jsp">Gallery</a> &middot;
            <a href="<%= fctx %>/results.jsp">Results</a> &middot;
            <a href="<%= fctx %>/contact.jsp">Contact</a>
        </div>
        <div>
            &copy; <%= java.time.Year.now() %> ATI Badulla. All rights reserved.
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
