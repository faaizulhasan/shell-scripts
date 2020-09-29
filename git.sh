#!/bin/sh

#sh ./check-user.sh


#Setting up project name
PN=$1

if ! [ $PN ]
then echo "Enter Project name in argument"; exit 0;
fi


#initialize git project
sudo git --bare init /opt/repos/$PN.git --shared=group

#make directory in srv folder
sudo mkdir /srv/$PN
sudo chown -R $USER:$USER /srv/$PN

#post receive file
sudo touch /opt/repos/$PN.git/hooks/post-receive
sudo chown $USER:$USER -R /opt/repos/$PN.git
sudo printf "#!/bin/bash\ngit --work-tree=/srv/$PN --git-dir=/opt/repos/$PN.git checkout -f\nchown -R $USER:$USER /srv/$PN" > /opt/repos/$PN.git/hooks/post-receive
sudo chmod +x /opt/repos/$PN.git/hooks/post-receive
sudo chown $USER:$USER -R /opt/repos/$PN.git
sudo chown $USER:$USER -R /srv/$PN/
sudo chmod -R g+w /srv/$PN

printf "=========COPY GIT URL=========\n"
printf "ssh://$USER@0.0.0.0/opt/repos/$PN.git\n"
printf "==============================\n"