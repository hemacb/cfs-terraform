#!/bin/bash

echo "Now we will install Softlayer CLI. Please sit back and Relax!"
echo
echo
slcli --version &> /dev/null
check1=`echo $?`
if [ $check1 == 0 ]
        then
        echo "Softlayer CLI is already installed!"
else
        echo "Installing Softlayer CLI. Please sit back and Relax..!!!"
        curl -OL https://github.com/softlayer/softlayer-python/zipball/master
        unzip master
        con1=`echo $?`
        if [ $con1 == 0 ]
                then
                file=`ls | grep 'softlayer'`
                cd $file
                        python setup.py install
                        con2=`echo $?`
                        if [ $con2 == 0 ]
                        then
                                echo "Installation Complete"
                        else
                                yum install python-setuptools
                                python setup.py install
                        fi
        else
                yum install unzip
                unzip master
                cd softlayer-softlayer-python-4932cac
                        python setup.py install
                        con3=`echo $?`
                        if [ $con3 == 0 ]
                        then
                                echo "Installation Complete"
                        else
                                yum install python-setuptools
                                python setup.py install
                        fi
        fi
fi
echo "Version details are as follows:"
slcli --version
echo
echo
echo "Now we will install Terraform. Please sit back and Relax!"
echo
echo
terraform --version &> /dev/null
check1=`echo $?`
if [ $check1 == 0 ]
        then
        echo "Terraform is already installed!"
else
        echo "Installing Terraform... Sit back and relax!"
        mkdir terraform_dir
        cd terraform_dir
        wget https://releases.hashicorp.com/terraform/0.7.0/terraform_0.7.0_linux_amd64.zip
        unzip terraform_0.7.0_linux_amd64.zip
        dir1=`pwd`
        export PATH=$PATH:$dir1
        echo "Installation is complete!"
fi
echo "Version details are as follows:"
terraform --version
