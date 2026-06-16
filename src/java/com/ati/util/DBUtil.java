package com.ati.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Central JDBC connection helper.
 *
 *  >>> EDIT THE THREE CONSTANTS BELOW to match your MySQL setup <<<
 */
public class DBUtil {

    // --- Change these to match your MySQL server ---------------------
    private static final String URL =
            "jdbc:mysql://localhost:3306/ati_badulla_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "";   // <-- put your MySQL root password here
    // -----------------------------------------------------------------

    static {
        try {
            // Load the MySQL JDBC driver (Connector/J must be on the classpath)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. "
                    + "Add the MySQL Connector/J .jar to the project Libraries.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
