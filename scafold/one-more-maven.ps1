
Set-Location -Path  .\\nimbus

${env:MAVEN_OPTS}  = "-ea -Xss1536k -Xmx8g"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.io=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.lang.reflect=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.lang=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.net=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.util.concurrent=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/java.util=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.base/sun.net=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.management/com.sun.jmx.mbeanserver=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.management/java.lang.management=ALL-UNNAMED"
${env:MAVEN_OPTS} += " --add-opens=java.management/sun.management=ALL-UNNAMED"
echo "MAVEN_OPTS=${env:MAVEN_OPTS}"
mvn -T 1C --batch-mode clean install -DskipTests #  | Tee-Object {{ user `CACHE_FOLDER` }}\\mvn-first-install.log" ] },
