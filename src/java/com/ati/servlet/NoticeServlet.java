package com.ati.servlet;

import com.ati.dao.NoticeDAO;
import com.ati.model.Notice;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/** Handles add / update / delete of notices from the admin panel. */
@WebServlet("/NoticeServlet")
public class NoticeServlet extends HttpServlet {

    private final NoticeDAO dao = new NoticeDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Notice n = new Notice();
            n.setTitle(req.getParameter("title"));
            n.setContent(req.getParameter("content"));
            n.setPriority(req.getParameter("priority"));
            dao.insert(n);

        } else if ("update".equals(action)) {
            Notice n = new Notice();
            n.setId(Integer.parseInt(req.getParameter("id")));
            n.setTitle(req.getParameter("title"));
            n.setContent(req.getParameter("content"));
            n.setPriority(req.getParameter("priority"));
            dao.update(n);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-notices.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if ("delete".equals(req.getParameter("action"))) {
            dao.delete(Integer.parseInt(req.getParameter("id")));
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-notices.jsp");
    }
}
