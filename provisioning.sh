#!/bin/bash -f
if [ "$3" = "2" ]
then
        if [ "$2" = "java" ] || [ "$2" = "php" ]
        then
                if [ "$1" = "development" ] || [ "$1" = "qa" ]
                then
						webcpu=$( cat json/"$1"-"$2".json | grep webcpu | cut -d":" -f2)
						webmemory=$( cat json/"$1"-"$2".json | grep webmemory | cut -d":" -f2 )
						webimage=$( cat json/"$1"-"$2".json | grep webimage | cut -d":" -f2)
						webhostname=$( cat json/"$1"-"$2".json | grep webhostname | cut -d":" -f2 )
						webdisk=$( cat json/"$1"-"$2".json | grep webdisk | cut -d":" -f2 )
						webpostinstall=$(cat json/"$1"-"$2".json | grep webpostinstall | cut -d":" -f2,3)
						webuserdata=$(cat json/"$1"-"$2".json | grep webuserdata | cut -d":" -f2,3,4,5,6)
						dbcpu=$( cat json/"$1"-"$2".json | grep dbcpu | cut -d":" -f2)
						dbmemory=$( cat json/"$1"-"$2".json | grep dbmemory | cut -d":" -f2 )
						dbimage=$( cat json/"$1"-"$2".json | grep dbimage | cut -d":" -f2)
						dbhostname=$( cat json/"$1"-"$2".json | grep dbhostname | cut -d":" -f2 )
						dbdisk=$( cat json/"$1"-"$2".json | grep dbdisk | cut -d":" -f2 )
						dbpostinstall=$(cat json/"$1"-"$2".json | grep dbpostinstall | cut -d":" -f2,3)
						dbuserdata=$(cat json/"$1"-"$2".json | grep dbuserdata | cut -d":" -f2,3,4,5)
						cp tf/sl_2.tf sl_webdb.tf
						sed -i s/webhostname/"$webhostname"/g sl_webdb.tf
						sed -i s/webcpucount/"$webcpu"/g sl_webdb.tf
						sed -i s/webramsize/"$webmemory"/g sl_webdb.tf
						sed -i s/webosname/"$webimage"/g sl_webdb.tf
						sed -i s/webrootdisk/"$webdisk"/g sl_webdb.tf
						sed -i s/webpiscript/"$webpostinstall"/g sl_webdb.tf
						sed -i s/webuserdata/"$webuserdata"/g sl_webdb.tf
						sed -i s/dbhostname/"$dbhostname"/g sl_webdb.tf
						sed -i s/dbcpucount/"$dbcpu"/g sl_webdb.tf
						sed -i s/dbramsize/"$dbmemory"/g sl_webdb.tf
						sed -i s/dbosname/"$dbimage"/g sl_webdb.tf
						sed -i s/dbrootdisk/"$dbdisk"/g sl_webdb.tf
						sed -i s/dbpiscript/"$dbpostinstall"/g sl_webdb.tf
						sed -i s/dbuserdata/"$dbuserdata"/g sl_webdb.tf
						#echo $dbuserdata
						sed -i s/pass_phrase/"$4"/g sl_webdb.tf
						sed -i s/dbhost/"$dbhostname"/g sl_webdb.tf
						mkdir -p $2
                                                mv sl_webdb.tf $2
                                                cd $2
						terraform plan
						terraform apply
				else
					echo "Current POC code supports only Development and QA environment, Please select Accordingly..."
				fi
		else
				echo "Current POC code supports only Java and PHP Applications, Please select Accordingly..."
		fi
elif [ "$3" = "1" ]
then
	if [ "$2" = "java" ]	|| [ "$2" = "php" ]
	then	
		if [ "$1" = "development" ] || [ "$1" = "qa" ]
		then
			cpu=$( cat json/"$1"-"$2".json | grep webcpu | cut -d":" -f2)
			memory=$( cat json/"$1"-"$2".json | grep webmemory | cut -d":" -f2 )
			image=$( cat json/"$1"-"$2".json | grep webimage | cut -d":" -f2)
			hostname=$( cat json/"$1"-"$2".json | grep webhostname | cut -d":" -f2 )
			disk=$( cat json/"$1"-"$2".json | grep webdisk | cut -d":" -f2 )
			piscript=$( cat json/"$1"-"$2".json | grep webpostinstall | cut -d":" -f2,3)
			echo $piscript				
			userdata=$( cat json/"$1"-"$2".json | grep webuserdata | cut -d":" -f2,3,4)
			echo $userdata
			cp tf/sl.tf sl1.tf
			sed -i s/hostname/"$hostname"/g sl1.tf
			sed -i s/cpucount/"$cpu"/g sl1.tf
			sed -i s/ramsize/"$memory"/g sl1.tf
			sed -i s/osname/"$image"/g sl1.tf
			sed -i s/rootdisk/"$disk"/g sl1.tf
			echo `grep postinstall sl.tf`
			#sed -i s/postinstall/"$postinstalls"/g sl1.tf
			sed -i s/piscript/"$piscript"/g sl1.tf
			sed -i s/userdata/"$userdata"/g sl1.tf
			mkdir -p $2/$1/
			mv sl1.tf $2/$1/
			cd $2/$1/
			terraform plan
			#terraform apply
		else
			echo "Current POC code supports only Development and QA environment, Please select Accordingly..."
		fi
	else
			echo "Current POC code supports only Java and PHP Applications, Please select Accordingly..."
	fi
else
	echo "Current POC code supports Single or 2-tier architecture only. Please choose accordingly..!"
fi
