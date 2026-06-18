#!/usr/bin/env bash
# =====================================================================
#  Build and run the ATI Badulla portal WITHOUT NetBeans.
#
#  Requirements:
#    - JDK (java + javac on PATH)
#    - Apache Tomcat 9.x  (uses javax.servlet)
#    - MySQL Connector/J .jar somewhere in your home folder
#    - MySQL server running, ati_badulla_db created
#
#  Usage:
#    chmod +x build-and-run.sh
#    ./build-and-run.sh
#
#  IMPORTANT: CLOSE NetBeans completely before running this, otherwise
#  NetBeans keeps re-deploying an old copy of the app over this one.
# =====================================================================
set -e

# ===== CONFIG: change if your Tomcat lives elsewhere =================
TOMCAT="${TOMCAT:-$HOME/Downloads/apache-tomcat-9.0.117}"
# =====================================================================

SRC="$(cd "$(dirname "$0")" && pwd)"     # this repo folder
DEPLOY="$TOMCAT/webapps/ATIBadulla"
echo ">> Repo source : $SRC"
echo ">> Tomcat home : $TOMCAT"

# --- locate the MySQL Connector/J jar (searches your home dir) -------
CONNECTOR="${CONNECTOR:-$(find "$HOME" -name 'mysql-connector-j-*.jar' 2>/dev/null | head -1)}"
if [ -z "$CONNECTOR" ]; then
  echo "!! Could not find a mysql-connector-j-*.jar in your home folder."
  echo "   Download it, then run:  CONNECTOR=/full/path/to/jar ./build-and-run.sh"
  exit 1
fi
echo ">> Connector   : $CONNECTOR"

SERVLET_API="$TOMCAT/lib/servlet-api.jar"
if [ ! -f "$SERVLET_API" ]; then
  echo "!! servlet-api.jar not found at: $SERVLET_API"
  echo "   Check your TOMCAT path (must be Tomcat 9.x)."
  exit 1
fi

# --- stop any standalone Tomcat that might be running ----------------
"$TOMCAT/bin/shutdown.sh" 2>/dev/null || true
sleep 2

# --- PRESERVE previously uploaded files (images, result docs) --------
# Uploaded files live in the deployed app's /uploads folder, NOT in git.
# Back them up so a rebuild does not delete them.
UPLOAD_BACKUP="/tmp/ati_uploads_backup"
rm -rf "$UPLOAD_BACKUP"
if [ -d "$DEPLOY/uploads" ]; then
  echo ">> Preserving existing uploaded files ..."
  cp -r "$DEPLOY/uploads" "$UPLOAD_BACKUP"
fi

# --- REMOVE every old/stale deployment of this app -------------------
echo ">> Removing any old deployments of ATIBadulla ..."
rm -f  "$TOMCAT/conf/Catalina/localhost/ATIBadulla.xml" 2>/dev/null || true
rm -rf "$DEPLOY" "$TOMCAT/webapps/ATIBadulla.war" 2>/dev/null || true
rm -rf "$TOMCAT/work/Catalina/localhost/ATIBadulla" 2>/dev/null || true

# --- build an exploded webapp in /tmp -------------------------------
APP="/tmp/ATIBadulla"
rm -rf "$APP"
mkdir -p "$APP"

# 1. web resources (jsp, css, images, includes, admin, uploads, WEB-INF/web.xml)
cp -r "$SRC"/web/. "$APP"/

# 2. make sure WEB-INF/classes and lib exist, add the JDBC driver
mkdir -p "$APP/WEB-INF/classes" "$APP/WEB-INF/lib" "$APP/uploads"
cp "$CONNECTOR" "$APP/WEB-INF/lib/"

# 3. restore the preserved uploads back into the new build
if [ -d "$UPLOAD_BACKUP" ]; then
  echo ">> Restoring preserved uploaded files ..."
  cp -r "$UPLOAD_BACKUP/." "$APP/uploads/"
fi

# 4. compile all Java against the servlet API + connector
find "$SRC/src/java" -name '*.java' > /tmp/ati_sources.txt
javac -cp "$SERVLET_API:$CONNECTOR" -d "$APP/WEB-INF/classes" @/tmp/ati_sources.txt
echo ">> Compiled $(wc -l < /tmp/ati_sources.txt) Java files OK."

# 5. deploy to Tomcat
cp -r "$APP" "$DEPLOY"
echo ">> Deployed to $DEPLOY"

# 6. VERIFY the deployed DBUtil contains the connection fix + LMS link
echo ">> Verifying deployment ..."
if strings "$DEPLOY/WEB-INF/classes/com/ati/util/DBUtil.class" | grep -q "allowPublicKeyRetrieval=true"; then
  echo "   OK: allowPublicKeyRetrieval=true present in DBUtil."
else
  echo "   !! WARNING: DB fix missing. Run 'git pull' and re-run."
fi
if grep -q "lms.sliate.ac.lk" "$DEPLOY/includes/header.jsp" 2>/dev/null; then
  echo "   OK: LMS link present in header."
else
  echo "   !! WARNING: LMS link missing in deployed header.jsp - run 'git pull' first."
fi

# 7. run Tomcat in the foreground (press Ctrl+C to stop)
echo ">> Starting Tomcat ... open  http://localhost:8080/ATIBadulla/"
chmod +x "$TOMCAT/bin/"*.sh 2>/dev/null || true
exec "$TOMCAT/bin/catalina.sh" run
