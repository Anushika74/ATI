package com.ati.servlet;

import com.ati.dao.CourseDAO;
import com.ati.model.Course;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Add / update / delete courses from the admin panel. */
@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {

    private final CourseDAO dao = new CourseDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        Course c = new Course();
        c.setName(req.getParameter("name"));
        c.setDescription(req.getParameter("description"));
        c.setDuration(req.getParameter("duration"));
        c.setFee(req.getParameter("fee"));

        if ("update".equals(action)) {
            c.setId(Integer.parseInt(req.getParameter("id")));
            dao.update(c);
        } else {
            dao.insert(c);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-courses.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if ("delete".equals(req.getParameter("action"))) {
            dao.delete(Integer.parseInt(req.getParameter("id")));
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-courses.jsp");
    }
}
