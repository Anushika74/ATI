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
#  Override paths if needed, e.g.:
#    TOMCAT=~/apache-tomcat-9.0.117 ./build-and-run.sh
# =====================================================================
set -e

# ===== CONFIG: change if your Tomcat lives elsewhere =================
TOMCAT="${TOMCAT:-$HOME/Downloads/apache-tomcat-9.0.117}"
# =====================================================================

SRC="$(cd "$(dirname "$0")" && pwd)"     # this repo folder
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

# --- build an exploded webapp in /tmp -------------------------------
APP="/tmp/ATIBadulla"
rm -rf "$APP"
mkdir -p "$APP"

# 1. web resources (jsp, css, includes, admin, uploads, WEB-INF/web.xml)
cp -r "$SRC"/web/. "$APP"/

# 2. make sure WEB-INF/classes and lib exist, add the JDBC driver
mkdir -p "$APP/WEB-INF/classes" "$APP/WEB-INF/lib"
cp "$CONNECTOR" "$APP/WEB-INF/lib/"

# 3. compile all Java against the servlet API + connector
find "$SRC/src/java" -name '*.java' > /tmp/ati_sources.txt
javac -cp "$SERVLET_API:$CONNECTOR" -d "$APP/WEB-INF/classes" @/tmp/ati_sources.txt
echo ">> Compiled $(wc -l < /tmp/ati_sources.txt) Java files OK."

# 4. deploy to Tomcat (remove any old NetBeans deployment first)
rm -f  "$TOMCAT/conf/Catalina/localhost/ATIBadulla.xml" 2>/dev/null || true
rm -rf "$TOMCAT/webapps/ATIBadulla" "$TOMCAT/webapps/ATIBadulla.war"
cp -r "$APP" "$TOMCAT/webapps/ATIBadulla"
echo ">> Deployed to $TOMCAT/webapps/ATIBadulla"

# 5. run Tomcat in the foreground (press Ctrl+C to stop)
echo ">> Starting Tomcat ... open  http://localhost:8080/ATIBadulla/"
chmod +x "$TOMCAT/bin/"*.sh 2>/dev/null || true
exec "$TOMCAT/bin/catalina.sh" run
