#!/bin/bash


####Description: This is the Script that automates jenkins installation on centOS 7 server
####Author: Sam Oni
####Date: February 19 2022

echo -e "\nThe installtion of jenkins is in progress, please wait...\n"

if
    [ ${USER} = root ]
then
       echo -e "\n Since you are a root user with root access, you have permission to run this script\n"
else
       echo -e "\n Regular user are not permitted to run this script\n "
       exit 9
fi
sleep 3

echo -e "\nJava Runtime Enviroment is required on centOS 7 for Jenkins Automation Server installation, lets install java\n"

yum install java-1.8.0-openjdk-devel -y

if
    [ $? -eq 0 ]
then
      echo -e "\nJava is successful, please, go to the next step\n"
fi

echo -e "\nEnabling Jenkins repo with wget is a must before Jenkins Automation Server installation\n"
sleep 3

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

if
    [ $? -eq 0 ]
then
      echo -e "\n Install jenkins repo and proceed to the next step, if the repo fail to install, install wget with yum install wget -y command and proceed..."        
elif
     [ $? -ne 0 ]
then
    sudo yum install wget -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
fi
if
    [ $? -eq 0 ]
then
      echo -e "\nEnabling jenkins repository was successfull\n"
fi

echo -e "\nUse the sed command to dissable key check on the jenkins repository\n"

sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo

if
    [ $? -eq 0 ]
then
      echo -e "\nDisabling key check on the repository was successful, please take not of the sed command here\n"
fi

sleep 3
echo -e "\n It is time to install the latest stable version of Jenkins Automation Server, lets go\n"
echo -e "\n<<<<<<<<<..HELLO!!! WELLCOME  TO JENKINS AUTOMATION  SERVER INSTALLATION..>>>>>>>>>\n"
sudo yum install jenkins -y

if
    [ $? -eq 0 ]
then
     echo -e "\nJenkins installation has no issue\n"
fi

sleep 3
echo -e "\nAfter the installation go ahead, start and enable the Jenkins service using systemctl command\n"
sudo systemctl start jenkins && sudo systemctl enable jenkins
if
     [ $? -eq 0 ]
then
      echo -e "\njenkins automation server was started and enabled for persistency on the next reboot\n"
fi

sleep 3
echo -e "\nNow open the port jenkins will listen to using the firewall command\n"
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

if
    [ $? -eq 0 ]
then
      echo -e "\nthere is no issue with opening the port\n"
fi

sudo firewall-cmd --reload
if
    [ $? -eq 0 ]
then
      echo -e "\n there is no issuie reloading firewall\n"
fi

