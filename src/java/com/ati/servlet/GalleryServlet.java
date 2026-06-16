package com.ati.servlet;

import com.ati.dao.GalleryDAO;
import com.ati.model.GalleryImage;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

/**
 * Handles event image uploads, carousel ("Top 10") flag toggling and deletion.
 * Uses the Part interface to receive multipart/form-data file uploads.
 */
@WebServlet("/GalleryServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)   // 10 MB per image
public class GalleryServlet extends HttpServlet {

    private final GalleryDAO dao = new GalleryDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1. Make sure the uploads folder exists inside the deployed app
        String uploadDir = getServletContext().getRealPath("/uploads");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        // 2. Read the uploaded file part
        Part filePart = req.getPart("image");
        String fileName = extractFileName(filePart);

        if (fileName != null && !fileName.isEmpty()) {
            // Make the name unique so uploads never overwrite each other
            String savedName = System.currentTimeMillis() + "_" + fileName;
            filePart.write(uploadDir + File.separator + savedName);

            GalleryImage g = new GalleryImage();
            g.setTitle(req.getParameter("title"));
            g.setImagePath("uploads/" + savedName);   // relative web path
            g.setCarousel("on".equals(req.getParameter("carousel")));
            dao.insert(g);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-gallery.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int id = Integer.parseInt(req.getParameter("id"));

        if ("delete".equals(action)) {
            dao.delete(id);
        } else if ("carousel".equals(action)) {
            // toggle the Top-10 flag
            boolean on = "1".equals(req.getParameter("value"));
            dao.setCarousel(id, on);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-gallery.jsp");
    }

    /** Pulls the original file name out of the content-disposition header. */
    private String extractFileName(Part part) {
        if (part == null) return null;
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                // strip any path that some browsers include
                return new File(name).getName();
            }
        }
        return null;
    }
}
