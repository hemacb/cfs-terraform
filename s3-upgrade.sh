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
						webuserdata=$(cat json/"$1"-"$2".json | grep webuserdata | cut -d":" -f2,3,4)
						dbcpu=$( cat json/"$1"-"$2".json | grep dbcpu | cut -d":" -f2)
						dbmemory=$( cat json/"$1"-"$2".json | grep dbmemory | cut -d":" -f2 )
						dbimage=$( cat json/"$1"-"$2".json | grep dbimage | cut -d":" -f2)
						dbhostname=$( cat json/"$1"-"$2".json | grep dbhostname | cut -d":" -f2 )
						dbdisk=$( cat json/"$1"-"$2".json | grep dbdisk | cut -d":" -f2 )
						dbpostinstall=$(cat json/"$1"-"$2".json | grep dbpostinstall | cut -d":" -f2,3)
						dbuserdata=$(cat json/"$1"-"$2".json | grep dbuserdata | cut -d":" -f2,3,4)
						cp sl.tf sl1.tf
						sed -i s/hostname/"$webhostname"/g sl1.tf
						sed -i s/cpucount/"$webcpu"/g sl1.tf
						sed -i s/ramsize/"$webmemory"/g sl1.tf
						sed -i s/osname/"$webimage"/g sl1.tf
						sed -i s/rootdisk/"$webdisk"/g sl1.tf
						sed -i s/piscript/"$webpostinstall"/g s11.tf
						sed -i s/userdata/"$webuserdata"/g s11.tf
						mkdir -p $2/$1/web
						mkdir -p $2/$1/db
						mv sl1.tf $2/$1/web/
						cd $2/$1/web
						terraform plan
						terraform apply
						cd ../../../
						cp sl.tf sl1.tf
						sed -i s/hostname/"$dbhostname"/g sl1.tf
						sed -i s/cpucount/"$dbcpu"/g sl1.tf
						sed -i s/ramsize/"$dbmemory"/g sl1.tf
						sed -i s/osname/"$dbimage"/g sl1.tf
						sed -i s/rootdisk/"$dbdisk"/g sl1.tf
						sed -i s/piscript/"$dbpostinstall"/g s11.tf
						sed -i s/userdata/"$dbuserdata"/g s11.tf
						mv sl1.tf $2/$1/db/
						cd $2/$1/db
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
			cp sl.tf sl1.tf
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
#			terraform apply
		else
			echo "Current POC code supports only Development and QA environment, Please select Accordingly..."
		fi
	else
			echo "Current POC code supports only Java and PHP Applications, Please select Accordingly..."
	fi
else
	echo "Current POC code supports Single or 2-tier architecture only. Please choose accordingly..!"
fi
