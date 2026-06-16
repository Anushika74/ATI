<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("active", "about"); %>
<jsp:include page="includes/header.jsp"/>

<div class="section">
  <div class="container-ati">
    <div class="section-divider"></div>
    <h2>About Us</h2>
    <p class="sub">Advanced Technological Institute &mdash; Badulla</p>

    <div class="card-ati" style="margin-bottom:22px;">
        <p>The Advanced Technological Institute (ATI), Badulla is a leading state higher-education
        institute affiliated to the Sri Lanka Institute of Advanced Technological Education (SLIATE)
        under the Ministry of Higher Education. We provide nationally recognised Higher National
        Diplomas and certificate courses to students of the Uva Province and beyond.</p>
    </div>

    <div class="grid grid-3">
        <div class="card-ati">
            <h3>Our Vision</h3>
            <p>To be the centre of excellence in technological and professional education in the region.</p>
        </div>
        <div class="card-ati">
            <h3>Our Mission</h3>
            <p>To produce competent, employable graduates through quality teaching, research and industry links.</p>
        </div>
        <div class="card-ati">
            <h3>Our Values</h3>
            <p>Discipline, innovation, integrity and commitment to lifelong learning.</p>
        </div>
    </div>
  </div>
</div>

<jsp:include page="includes/footer.jsp"/>
