<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("active", "contact"); %>
<jsp:include page="includes/header.jsp"/>

<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>Contact Us</h2>
    <p class="sub">We would love to hear from you.</p>

    <div class="grid grid-3" style="margin-bottom:26px;">
        <div class="card-ati"><h3>Address</h3><p>Advanced Technological Institute,<br>Badulla, Sri Lanka.</p></div>
        <div class="card-ati"><h3>Phone</h3><p>+94 55 222 xxxx</p></div>
        <div class="card-ati"><h3>Email</h3><p>info@atibadulla.edu.lk</p></div>
    </div>

    <form class="form-ati" onsubmit="event.preventDefault(); document.getElementById('cmsg').style.display='block';">
        <label>Your Name</label>
        <input type="text" required>
        <label>Email</label>
        <input type="email" required>
        <label>Message</label>
        <textarea rows="4" required></textarea>
        <button class="btn" type="submit">Send Message</button>
        <p id="cmsg" style="display:none;color:#7CFC9B;margin-top:12px;">Thank you! Your message has been received.</p>
    </form>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
