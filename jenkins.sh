#!/bin/bash

####Description: This is Script automates jenkins installation on centOS 7 server
####Author: Sam Oni
####Date: February 19 2022

echo -e "\nThe installtion of jenkins is in progress, please wait...\n"     

if
	    [ ${USER} != root ]
    then
	     echo -e "\n you are a regular user you are not permitted to run this script\n" 
	      exit 9
	       else
		        echo -e "\n as a root user you have permission to run this script\n "      
fi
sleep 3

echo -e "\nJava Runtime Enviroment, java-1.8.0-openJDK-devel is required on 
the centOS 7 before installing jenkins automation server, please wait while 
we install java\n"

yum install java-1.8.0-openjdk-devel -y

if
	     [ $? -ne 0 ]
     then
	      echo -e "\nThere is an issue installing java on this system\n"
	       exit 10
fi

echo -e "\nJenkins repository must be enable with wget on this system jenkins automation server installation\n"
sleep 3

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

if
	    [ $? -ne 0 ]

    then
	    sudo yum install wget
	    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo


fi

if
	  [ $? -ne 0 ]

  then
	   echo -e "\nEnabling jenkins repository gave an error, please check that and try again\n"
	   exit 15
fi

echo - e "\n Now we can dissable key check on the repository\n"

sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo       

if
	  [ $? -ne 0 ]

  then
	     echo -e "\nThere vissue with disabling key check on the repository, pleas   e double check the sed command\n"
	        exit 18
fi

sleep 3
echo -e "\nnow lets install the latest stable version of jenkins.\n"        

sudo yum install jenkins -y

if
	   [$? -ne 0 ]

   then
	      echo -e "\nJenkins installation has issue\n"
	         exit 22
fi

sleep 3
echo -e "\Lets start and enable the Jenkins service....\n"

sudo systemctl start jenkins

if
	  [ $? -ne 0 ]
  then
	    echo -e "\nthere is an issue starting jenkins\n"
	      exit 33

	      sleep 3
	      sudo systemctl enable jenkins

	      if
		        [ $? -ne 0 ]
		then
			   echo -e "\nthere is an issue enabling jenkins\n"
			      exit 44
	      fi

	      sleep 3
	      echo -e "\nLets open the port necessary for jenkins to work\n"

	      sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

	      if
		         [ $? -ne 0 ]
		 then
			    echo -e "\nthere is an issue with opening the port\n"
			       exit 55
	      fi

	      sudo firewall-cmd --reload

	      if
		        [ $? -ne 0 ]
		then
			  echo -e "\n there is an issuie reloading firewall\n"
			    exit 66

	      fi
git 