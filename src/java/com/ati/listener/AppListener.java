package com.ati.listener;

import com.ati.dao.UserDAO;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Runs once when the web application starts.
 * If there are no admin users yet, it creates the default account:
 *      username: admin
 *      password: admin123   (stored as a SHA-256 hash)
 */
@WebListener
public class AppListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            UserDAO dao = new UserDAO();
            if (!dao.hasAnyUser()) {
                dao.createUser("admin", "admin123", "Site Administrator");
                System.out.println("[ATI] Default admin created -> username: admin / password: admin123");
            }
        } catch (Exception e) {
            System.err.println("[ATI] Could not seed admin user: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) { }
}
