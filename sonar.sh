#!/bin/bash


####Description: This is Script automates SonarQube configuration on centOS 7 server
####Author: Sam Oni
####Date: February 30 2022

if
	[ ${USER} != root ]
then
        echo -e "\n Since you are a root user with root access permissions        , you are restricted from running this script\n"
        exit 1
else
        echo -e "\n Regular user without root access permission are only p        ermitted to run this SonarQube installation script\n "

fi

echo -e "\nUpdate the centOS 7 server at the beginning of the project to build SonarQube Server\n"

sudo yum update -y

if
	[ $? -eq 0 ]
then
	echo -e "\n centOS 7 updated without issues\n"
else
        echo -e "\n centOS 7 update reported error"
        exit 3
fi
echo -e "\nInstalltion of Java Runtime Environment is a requirement for SonarQube installation on centOS 7\n"
sleep 2

sudo yum install java-11-openjdk-devel -y && sudo yum install java-11-openjdk -y

if
	[ $? -eq 0 ]
then
        echo -e "\nJava installation was successful, please, go to the nex        t step\n"
fi

echo -e "\nStep 2: Navigate to the directory /opt where SonarQube latest version download will be stored to in the system\n"

cd /opt

if
	[ $? -eq 0 ]
then
        echo -e "\n changing directory to /opt was executed successfully\n"
fi
echo -e "\nInstall wget if the package does not exist on the centOS 7 machine\n"

sudo yum install wget -y

if
	[ $? -eq 0 ]
then
        echo -e "\n wget installation was successful"
fi

echo -e "\nDownload SonarQube package using wget command as shown below.....\n"

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
if
	[ $? -eq 0 ]
then
        echo -e "\nSonarQube package downloaded and was stored in /opt dir        ectory successfully\n"
fi

echo "\nStep 3: Extract the packages using unzip software, please install unzip if it is not available on the system\n"

sudo unzip /opt/sonarqube-9.3.0.51899.zip

if
	[ $? -eq 0 ]
then
        echo -e "\nUnzip the sonarqube and go to the next step, if unzip is not available, install it and run the unzip command again and continue\n"
elif 
        [ $? -ne 0 ]
then
sudo yum install unzip -y; sudo unzip /opt/sonarqube-9.3.0.51899.zip
fi


echo -e "\nStep 4: Change the ownership to the user and switch to Linux binaries directory to start the service\n"
sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899

if 
        [ $? -eq 0 ]
then
        echo -e "\nthe ownership was changed to user vagrant\n"
fi
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64

if 
        [ $? -eq 0 ]
then
        echo -e "\nlinux binaries directory was switched to start the sonarqube service\n"

./sonar.sh start

echo -e "\nLets open the port necessary for sonarqube service to work\n"

sudo firewall-cmd --permanent --add-port=9000/tcp

if 
        [ $? -eq 0 ]
then
        echo -e "\n the port opened without error\n"
fi

sudo firewall-cmd --reload

if 
        [ $? -eq 0 ]
then
        echo -e "firewall reloaded successfully\n"
fi

echo -e "\nConnect to SonarQube using the host server ip address and the SonarQube service port number i.e 192.168.56.33:9000\n"

echo -e "http://192.168.56.33:9000\n"

echo -e "\nThe installation and configurtion of SonarQube Server complete\n"
