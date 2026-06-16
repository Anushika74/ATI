package com.ati.dao;

import com.ati.model.Result;
import com.ati.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    private Result map(ResultSet rs) throws Exception {
        Result r = new Result();
        r.setId(rs.getInt("id"));
        r.setStudentIndex(rs.getString("student_index"));
        r.setStudentName(rs.getString("student_name"));
        r.setCourseName(rs.getString("course_name"));
        r.setMarks(rs.getString("marks"));
        r.setGrade(rs.getString("grade"));
        r.setResultFile(rs.getString("result_file"));
        return r;
    }

    public List<Result> findAll() {
        List<Result> list = new ArrayList<>();
        String sql = "SELECT * FROM results ORDER BY uploaded_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /** Public search by student index (used on the results page). */
    public List<Result> searchByIndex(String index) {
        List<Result> list = new ArrayList<>();
        String sql = "SELECT * FROM results WHERE student_index LIKE ? ORDER BY uploaded_at DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + index + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insert(Result r) {
        String sql = "INSERT INTO results (student_index, student_name, course_name, marks, grade, result_file) "
                   + "VALUES (?,?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getStudentIndex());
            ps.setString(2, r.getStudentName());
            ps.setString(3, r.getCourseName());
            ps.setString(4, r.getMarks());
            ps.setString(5, r.getGrade());
            ps.setString(6, r.getResultFile());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        String sql = "DELETE FROM results WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
