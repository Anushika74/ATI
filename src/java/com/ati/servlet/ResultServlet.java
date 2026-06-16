package com.ati.servlet;

import com.ati.dao.ResultDAO;
import com.ati.model.Result;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

/**
 * Add / delete student results. Supports an optional uploaded result
 * document (PDF / image) handled through the Part interface.
 */
@WebServlet("/ResultServlet")
@MultipartConfig(maxFileSize = 15 * 1024 * 1024)
public class ResultServlet extends HttpServlet {

    private final ResultDAO dao = new ResultDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Result r = new Result();
        r.setStudentIndex(req.getParameter("studentIndex"));
        r.setStudentName(req.getParameter("studentName"));
        r.setCourseName(req.getParameter("courseName"));
        r.setMarks(req.getParameter("marks"));
        r.setGrade(req.getParameter("grade"));

        // Optional result document upload
        try {
            Part filePart = req.getPart("resultFile");
            String fileName = extractFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                String savedName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadDir + File.separator + savedName);
                r.setResultFile("uploads/" + savedName);
            }
        } catch (Exception ignored) { }

        dao.insert(r);
        resp.sendRedirect(req.getContextPath() + "/admin/manage-results.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if ("delete".equals(req.getParameter("action"))) {
            dao.delete(Integer.parseInt(req.getParameter("id")));
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-results.jsp");
    }

    private String extractFileName(Part part) {
        if (part == null) return null;
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                return new File(name).getName();
            }
        }
        return null;
    }
}
