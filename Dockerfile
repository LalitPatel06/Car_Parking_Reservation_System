# Base image
FROM tomcat:9.0

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your war file into Tomcat's webapps
COPY ./dist/CarParkingSystem.war /usr/local/tomcat/webapps/ROOT.war
