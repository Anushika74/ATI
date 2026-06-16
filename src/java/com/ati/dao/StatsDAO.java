package com.ati.dao;

import com.ati.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/** Handles the visitor counter (single-row site_stats table). */
public class StatsDAO {

    /** Increments the visit count by 1 and returns the new total. */
    public long incrementAndGet() {
        try (Connection con = DBUtil.getConnection()) {
            try (PreparedStatement up =
                         con.prepareStatement("UPDATE site_stats SET visits = visits + 1 WHERE id = 1")) {
                up.executeUpdate();
            }
            try (PreparedStatement sel =
                         con.prepareStatement("SELECT visits FROM site_stats WHERE id = 1");
                 ResultSet rs = sel.executeQuery()) {
                if (rs.next()) return rs.getLong("visits");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public long getCount() {
        String sql = "SELECT visits FROM site_stats WHERE id = 1";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getLong("visits");
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
