package com.ati.dao;

import com.ati.model.GalleryImage;
import com.ati.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GalleryDAO {

    private GalleryImage map(ResultSet rs) throws Exception {
        GalleryImage g = new GalleryImage();
        g.setId(rs.getInt("id"));
        g.setTitle(rs.getString("title"));
        g.setImagePath(rs.getString("image_path"));
        g.setCarousel(rs.getInt("is_carousel") == 1);
        g.setUploadDate(String.valueOf(rs.getTimestamp("upload_date")));
        return g;
    }

    public List<GalleryImage> findAll() {
        List<GalleryImage> list = new ArrayList<>();
        String sql = "SELECT * FROM gallery ORDER BY upload_date DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /** The homepage slider: top 10 most recent carousel images. */
    public List<GalleryImage> findCarousel() {
        List<GalleryImage> list = new ArrayList<>();
        String sql = "SELECT * FROM gallery WHERE is_carousel = 1 ORDER BY upload_date DESC LIMIT 10";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insert(GalleryImage g) {
        String sql = "INSERT INTO gallery (title, image_path, is_carousel) VALUES (?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getTitle());
            ps.setString(2, g.getImagePath());
            ps.setInt(3, g.isCarousel() ? 1 : 0);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    /** Toggle / set the "Top 10" carousel flag for an image. */
    public void setCarousel(int id, boolean carousel) {
        String sql = "UPDATE gallery SET is_carousel = ? WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, carousel ? 1 : 0);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public GalleryImage findById(int id) {
        String sql = "SELECT * FROM gallery WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void delete(int id) {
        String sql = "DELETE FROM gallery WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
