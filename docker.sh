#!/bin/bash


####Description: This is Script automates Docker configuration on centOS 7 server
####Author: Sam Oni
####Date: March 30 2022

if
	[ ${USER} != root ]
then
	echo -e "\n Since you are a root user with root access permissions        , you are restricted from running this script\n"
	exit 1
else
        echo -e "\n Regular user without root access permission are only p        ermitted to run this SonarQube installation script\n "       
fi

echo -e "\nUninstall old version of docker and all associated dependecies if these are install earlier on the machine\n"
sleep 2
sudo yum remove docker \
	                docker-client \
			docker-client-latest \
	                docker-common \
			docker-latest \
			docker-latest-logrotate \
			docker-logrotate \
			docker-engine
if
	[ $? -eq 0 ]
then
        echo -e ""\nOld version of docker uninstalled successfully\n
else
        echo -e "\nUninstallting old version of docker ha issues\n"
fi

echo -e "\nSet up the Docker repository where you will later install Docker Engine from the repository\n"
sleep 3
echo -e "\ninstall yum-utils the provide yum-config-manager required before setting up a stable docker repo \n"
sudo yum install -y yum-utils
if
         [ $? -eq 0 ]
 then
         echo -e ""\nyum-config-manager provision was  successfully\n
else
         echo -e "\nyum-config-manager provision has issues\n"
fi

sudo yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
sleep 3
if
        [ $? -eq 0 ]
then
        echo -e ""\nDocker repository set up worked\n
else
        echo -e "\nthere is a challenge setting up Docker repository\n"
fi
echo -e "\nPlease enable the nightly repository or test repositories alongside the provisioned stabled Docker repository \n"
sleep 3

sudo yum-config-manager --enable docker-ce-nightly
if
        [ $? -eq 0 ]
then
        echo -e ""\nDocker nightly or repositories enabled successfully\n
else
        echo -e "\nthere is an issue enabling Docker hightly repos\n"

fi
echo -e "\nenable the test channel, run the following command\n"
sleep 3

sudo yum-config-manager --enable docker-ce-test
if
        [ $? -eq 0 ]
then
        echo -e ""\ndocker-ce-test  enabled successfully\n
else
        echo -e "\nenabling docker-ce-test did not works\n"
fi

echo -e "\nYou can now disable the nightly or test repository by running the yum-config-manager, lets do it\n"

sudo yum-config-manager --disable docker-ce-nightly

if
        [ $? -eq 0 ]
then
        echo -e ""\nYes!! it worked!!!!, nightly or test repository has been dissabled successfully\n

else
        echo -e "\noh-oh!!! nightly or test repository did not dissable\n"
fi

echo -e "\nInstall the latest version of Docker Engine and containerd\n"
sleep 2
sudo yum install docker-ce docker-ce-cli containerd.io
if
        [ $? -eq 0 ]
then
        echo -e "\nHurray!!!, it is working, the installation latest version of Docker Engine, Dockerd and containerd were is done\n"
else
        echo -e "\noh-oh!!! this installation has issue, please check and redo the installation again\n"
fi

echo -e "\nPlease at this time lets start and enable docker engine and start creating our containers time is money folks\n"
sleep 3
systemctl start docker; systemctl enable docker

if
       [ $? -eq 0 ]
then
       echo -e ""\nIt is do docker engine started and was enabled successfully, we are now 6figure ready \n
else
       echo -e "\noh-oh!!! docker engine failed to start, please check the chat window for team contributione\n"
fi

echo -e "\nCheck the status of docker functionality and inspect, diagnose and isolate the error if there is any guys\n"
sleep 3
systemctl status docker

if
        [ $? -eq 0 ]
then
        echo -e ""\nYes!! it worked!!!!, the output of systemctl command shows docker engine is completely functioning\n
else
        echo -e "\noh-oh!!! read htrough the output and please troubleshoot and fix the error\n"
fi

echo -e "\n<<<<<<<<<THE INSTALLATION OF DOCKER ENGINE, CONTAINERD AND ALL DEPEDENCIES IS UP AND RUNNING, GOOD JOB GUYS....>>>>>>>>>>"
