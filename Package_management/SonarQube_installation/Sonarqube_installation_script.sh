#!/bin/bash

#   Organization: United Core Systems, Worcester, Massachusetts.
##  Contacts: Phone: 774-515-0044, 617-955-5115 WebSite : http://unitedcoresystem.com Email: info@unicoresystem.com
### Authors : Emmanuel Mortoo, Ben Otoo Isaac Ntim and Theophilus Akonnor 

# 1. Create sonar user to manage the SonarQube server
sudo useradd sonar
# Grand sudo access to sonar user
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
# set hostname for the sonarqube server
sudo hostnamectl set-hostname sonar 

# 2. Enable PasswordAuthentication in the server
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart

# 3. Install Java JDK 1.8+ required for sonarqube to start
cd /opt
sudo yum -y install unzip wget git
sudo yum install  java-11-openjdk-devel -y

# 4. Download and extract the SonarqQube Server software.
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo rm -rf sonarqube-7.8.zip
sudo mv sonarqube-7.8 sonarqube

# 5. Grant file permissions for sonar user to start and manage sonarQube
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/

# 6. start sonarQube server
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start 
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
