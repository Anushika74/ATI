package com.ati.dao;

import com.ati.model.Notice;
import com.ati.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO {

    private Notice map(ResultSet rs) throws Exception {
        Notice n = new Notice();
        n.setId(rs.getInt("id"));
        n.setTitle(rs.getString("title"));
        n.setContent(rs.getString("content"));
        n.setPriority(rs.getString("priority"));
        // 'link' column is optional - tolerate databases that don't have it yet
        try { n.setLink(rs.getString("link")); } catch (Exception ignore) { }
        n.setNoticeDate(String.valueOf(rs.getDate("notice_date")));
        return n;
    }

    public List<Notice> findAll() {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /** Used by the newsline (most recent first, limited). */
    public List<Notice> findRecent(int limit) {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC LIMIT ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Notice findById(int id) {
        String sql = "SELECT * FROM notices WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(Notice n) {
        String sql = "INSERT INTO notices (title, content, priority, link) VALUES (?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());
            ps.setString(3, n.getPriority());
            ps.setString(4, n.getLink());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Notice n) {
        String sql = "UPDATE notices SET title=?, content=?, priority=?, link=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());
            ps.setString(3, n.getPriority());
            ps.setString(4, n.getLink());
            ps.setInt(5, n.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        String sql = "DELETE FROM notices WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
