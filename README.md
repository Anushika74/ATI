# ATI Badulla Web Portal

A dynamic web application for the Advanced Technological Institute, Badulla, built with
**Java Servlets + JSP**, **MySQL (JDBC)**, **Bootstrap 5** and a **midnight-blue / black** theme.

It has a public website (Home, About, Courses, Gallery, Results, Contact) with a dynamic
Bootstrap carousel, a scrolling newsline, a real-time visitor counter, and a secure
**Admin Panel** for managing notices, gallery images, courses and exam results.

---

## 1. What is in this folder

```
ATIBadulla/
├── database/
│   └── ati_badulla_db.sql          <-- run this in MySQL
├── src/java/com/ati/
│   ├── util/      DBUtil.java, PasswordUtil.java
│   ├── model/     User, Notice, GalleryImage, Course, Result
│   ├── dao/       UserDAO, NoticeDAO, GalleryDAO, CourseDAO, ResultDAO, StatsDAO
│   ├── servlet/   Login, Logout, Notice, Gallery, Course, Result servlets
│   ├── listener/  AppListener.java   (visitor seed + default admin)
│   └── filter/    AuthFilter.java    (protects /admin/*)
└── web/
    ├── WEB-INF/web.xml
    ├── css/style.css
    ├── includes/   header.jsp, footer.jsp
    ├── uploads/    (uploaded images & documents land here)
    ├── index.jsp  about.jsp  courses.jsp  gallery.jsp  results.jsp  contact.jsp
    └── admin/      login, dashboard, manage-notices/gallery/courses/results, admin-header/footer
```

---

## 2. Requirements

- **NetBeans** (with Java EE / "Java with Ant > Java Web" support)
- **Apache Tomcat** (bundled with NetBeans, or add one under *Services > Servers*)
- **JDK 8 or higher**
- **MySQL Server** (you said you start it from cmd)
- **MySQL Connector/J** (the JDBC driver `.jar`) — download from
  https://dev.mysql.com/downloads/connector/j/ (choose "Platform Independent" ZIP and
  take `mysql-connector-j-x.x.x.jar` from inside it).

---

## 3. Step-by-step: create the database (MySQL in cmd)

1. Start MySQL and open the client:
   ```
   mysql -u root -p
   ```
2. Run the script (either paste its contents, or from the OS prompt):
   ```
   mysql -u root -p < database\ati_badulla_db.sql
   ```
3. Verify:
   ```sql
   USE ati_badulla_db;
   SHOW TABLES;
   ```
   You should see: `users, notices, gallery, courses, results, site_stats`.

> The **default admin (admin / admin123)** is created automatically the first time the
> app starts — you do not insert it by hand.

---

## 4. Step-by-step: create the NetBeans project

1. NetBeans → **File ▸ New Project ▸ Java with Ant ▸ Java Web ▸ Web Application** → *Next*.
2. Project Name: `ATIBadulla` → *Next*.
3. Choose your **Server = Apache Tomcat** and **Java EE version** (Java EE 7 or 8 — anything
   that supports Servlet 3.x, so annotations work) → *Finish*.

This gives you an empty web project with `Source Packages` and a `Web Pages` folder.

### Copy the code in

4. **Java code:** copy everything under `src/java/com/ati/` into your project's
   **Source Packages**. Easiest way: in your file system, replace the project's
   `src/java` contents with the `src/java` from this folder. The package `com.ati...`
   structure must be preserved. After refresh you should see packages
   `com.ati.util`, `com.ati.model`, `com.ati.dao`, `com.ati.servlet`, `com.ati.listener`, `com.ati.filter`.

5. **Web pages:** copy everything under this `web/` folder into your project's
   **Web Pages** folder (the folder that already contains `index.html`/`WEB-INF`).
   - Replace the auto-generated `index.html` — we use **`index.jsp`**.
   - Make sure `WEB-INF/web.xml`, `css/`, `includes/`, `admin/`, `uploads/` are all there.

### Add the MySQL driver

6. Right-click the project → **Properties ▸ Libraries ▸ Add JAR/Folder** → select the
   `mysql-connector-j-x.x.x.jar` you downloaded → OK.
   (Without this you get *"MySQL JDBC Driver not found"*.)

---

## 5. Configure the database connection

Open `com/ati/util/DBUtil.java` and edit the three constants to match your MySQL:

```java
private static final String URL  = "jdbc:mysql://localhost:3306/ati_badulla_db?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASS = "";   // <-- put YOUR MySQL root password here
```

---

## 6. Run it

1. Right-click the project → **Run** (or press F6). NetBeans builds, deploys to Tomcat,
   and opens the browser.
2. The homepage opens at something like:
   ```
   http://localhost:8080/ATIBadulla/
   ```
3. On first start, the console prints:
   `[ATI] Default admin created -> username: admin / password: admin123`

---

## 7. Using the site

**Public site**
- **Home** — Bootstrap carousel (top 10 carousel images, newest first), scrolling newsline,
  live visitor counter, featured courses.
- **Courses / Gallery / Results / About / Contact** — informational pages.
- **Results** — visitors can search by their student index number.

**Admin panel** — click **Admin Login** (top-right) or go to `/ATIBadulla/admin/login.jsp`
- Login with **admin / admin123**.
- **Manage Notices** — add/edit/delete notices (these feed the newsline).
- **Event Gallery** — upload images; tick **"Show in carousel"** or use **"Add to Top 10"**
  to make an image appear in the homepage slider.
- **Manage Courses** — add/edit/delete programmes.
- **Exam Results** — add/delete results and optionally attach a PDF/image document.
- Any attempt to open an admin page without logging in redirects to the login page
  (handled by `AuthFilter` + `HttpSession`).

---

## 8. How the key requirements are implemented

| Requirement | Where |
|---|---|
| Dynamic carousel (Top 10, newest first) | `GalleryDAO.findCarousel()` → `SELECT ... WHERE is_carousel=1 ORDER BY upload_date DESC LIMIT 10`, rendered in `index.jsp` |
| Newsline / news ticker | `NoticeDAO.findRecent()` + CSS animation in `style.css` (`.newsline .track`) |
| Visitor counter | `StatsDAO.incrementAndGet()` called every time `index.jsp` loads (row in `site_stats`) |
| File uploads | `GalleryServlet` / `ResultServlet` using `@MultipartConfig` + the `Part` interface |
| Secure login | `LoginServlet` + `HttpSession` + `AuthFilter` on `/admin/*` |
| Encrypted passwords | `PasswordUtil` (SHA-256); admin seeded by `AppListener` |
| Carousel control | "Add to Top 10" toggle in `manage-gallery.jsp` → `GalleryServlet?action=carousel` |

---

## 9. Submission deliverables checklist

1. **Source code** — the whole `ATIBadulla` NetBeans project folder.
2. **Database script** — `database/ati_badulla_db.sql`.
3. **Documentation** — take screenshots of the **Home Page** (carousel + newsline + counter)
   and the **Admin Panel** (dashboard + a manage page) and add them to your report.

---

## 10. Troubleshooting

- **"MySQL JDBC Driver not found"** → add the Connector/J jar (Step 4.6).
- **"Access denied for user 'root'"** → fix `USER`/`PASS` in `DBUtil.java`.
- **"Unknown database 'ati_badulla_db'"** → you didn't run the SQL script (Step 3).
- **Uploaded images don't show** → confirm the `web/uploads` folder exists and was deployed;
  the DB stores paths like `uploads/<filename>`.
- **Carousel is empty** → upload an image in the admin panel and mark it "Top 10".
- **Annotations ignored / 404 on servlets** → make sure the project's Java EE version
  supports Servlet 3.x (Java EE 6/7/8) and you're on Tomcat 7+.
