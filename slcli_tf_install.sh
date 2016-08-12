#!/bin/bash

uname -a > osname.txt
cat osname.txt | grep 'Ubuntu'
osname=`echo $?`
rm -f osname.txt
slcli --version &> /dev/null
check1=`echo $?`
if [ $check1 == 0 ]
        then
        echo "Softlayer CLI is already installed!"
else
        echo "Installing Softlayer CLI. Please sit back and Relax..!!!"
		echo
		echo
        curl -OL https://github.com/softlayer/softlayer-python/zipball/master
        unzip master
        con1=`echo $?`
        if [ $con1 == 0 ]
                then                
                cd softlayer-softlayer-python-4932cac
                        python setup.py install
                        con2=`echo $?`
                        if [ $con2 == 0 ]
                        then
                                echo "Installation Complete"
						else	
							if [ $osname == 0 ]
							then 
								apt-get install python-setuptools -y
                                python setup.py install
							else
                                yum install python-setuptools -y
                                python setup.py install
							fi
						fi
		else
			if [ $osname == 0 ]
			then 
				apt-get update -y
                apt-get install unzip -y
			else
				yum update -y
				yum install unzip -y
			fi
            unzip master
			cd softlayer-softlayer-python-4932cac
				python setup.py install
				con3=`echo $?`
				if [ $con3 == 0 ]
				then
						echo "Installation Complete"
				else
					if [ $osname == 0 ]
					then
						apt-get install python-setuptools -y
                        python setup.py install
					else	
						yum install python-setuptools -y
						python setup.py install
                    fi
				fi	
        fi
fi
echo "Version details are as follows:"
slcli --version
echo
echo
terraform --version &> /dev/null
check1=`echo $?`
if [ $check1 == 0 ]
        then
        echo "Terraform is already installed!"
else
        echo "Installing Terraform... Sit back and relax!"
		cd /root
        mkdir terraform_dir
        cd terraform_dir
        wget https://releases.hashicorp.com/terraform/0.7.0/terraform_0.7.0_linux_amd64.zip
        unzip terraform_0.7.0_linux_amd64.zip
    if [ $osname == 0 ]
	then
		echo "export PATH=$PATH:/root/terraform_dir" >> /root/.bashrc
		source /root/.bashrc
	else
		echo "export PATH=$PATH:/root/terraform_dir" >> /root/.bash_profile
		source /root/.bash_profile		
    fi
	echo "Terraform installation is complete!"
fi
echo "Version details are as follows:"
terraform --version
