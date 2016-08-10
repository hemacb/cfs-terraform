#!/bin/bsh -f
if [ "$3" = "2" ]
then
		if [ "$2" = "java" ] || [ "$2" = "php" ]
		then
				if [ "$1" = "development" ] || [ "$1" = "qa" ]
				then
						echo -n "Do you want to take backup before Destroy[y/n]:"
						read value
						if [ "$value" = "y" ]
						then
								cd $2
								cat terraform.tfstate | grep \"id\" | cut -d":" -f2 | cut -d"\"" -f2 | uniq > id.txt
								cat terraform.tfstate | grep \"name\" | cut -d":" -f2 | cut -d"\"" -f2 > name.txt
								export name1=`sed -n '1p' name.txt`
								export dbname=`sed -n '2p' name.txt`
								export id1=`sed -n '1p' id.txt`
								export id2=`sed -n '2p' id.txt`
								slcli vs capture $id1 -n $name1
								imgid=$(slcli image list | grep $name1 | cut -d" " -f1)
								echo "Backup in progress for the server" "$name1"
								for i in {1..600}
								do
									sleep 1
									imgid1=$(slcli image detail $imgid | grep disk | tr -d ' '| cut -d"e" -f2)
									if [ "$imgid1" != "0" ]
									then
											echo "Backup Completed successfully :" "$name1"
											terraform destroy -force
											break
									fi
								done

								slcli vs capture $id2 -n $dbname
								imgdbid=$(slcli image list | grep $dbname | cut -d" " -f1)
								echo "Backup in progress for the server" "$dbname"
								for i in {1..600}
								do
										sleep 1
										imgdbid1=$(slcli image detail $imgdbid | grep disk | tr -d ' '| cut -d"e" -f2)
										if [ "$imgdbid1" != "0" ]
										then
												echo "Backup Completed successfully :" "$dbname"
												terraform destroy -force
												break
										fi
								done
								cd ..
								rm -fr $2
						elif [ "$value" = "n" ]
						then
								cd $2
								terraform destroy -force
								cd ..
								rm -rf $2
						else
								echo "right selection is y/n"
						fi

				else
					echo "Current POC code supports only Development and QA environment, Please select Accordingly..."
				fi
		else
			echo "Current POC Code supports Java and PHP runtime envs only. Please select accordingly...!"
		fi
elif [ "$3" = "1" ]
then
		if [ "$2" = "java" ] || [ "$2" = "php" ]
		then
				if [ "$1" = "development" ] || [ "$1" = "qa" ]
				then
						echo -n "Do you want to take backup before Destroy[y/n]:"
						read value
						if [ "$value" = "y" ]
						then
								cd $2/$1/
								id=$(cat terraform.tfstate | grep \"id\" | cut -d":" -f2 | cut -d"\"" -f2 | uniq)
								name=$(cat terraform.tfstate | grep \"name\" | cut -d":" -f2 | cut -d"\"" -f2 | uniq)
								slcli vs capture $id -n $name
								sleep 10
								imgid=$(slcli image list | grep $name | cut -d" " -f1)
								sleep 5
								echo "Backup in progress for the server" "$name"
								for i in {1..600}
								do
										sleep 1
										imgid1=$(slcli image detail $imgid | grep disk | tr -d ' '| cut -d"e" -f2)
										if [ "$imgid1" != "0" ]
										then
												echo "Backup Completed successfully :" "$name"
												terraform destroy -force
												break
										fi
								done
								cd ../
								rm -rf $1
								cd ../
								rm -d $2
						elif [ "$value" = "n" ]
						then
								cd $2/$1/
								terraform destroy -force
								cd ../
								rm -rf $1
								cd ../
								rm -d $2
						else
								echo "right selection is y/n"
						fi
				else
						echo "Current POC code supports only Development and QA environment, Please select Accordingly..."
				fi
		else
			echo "Current POC Code supports Java and PHP runtime envs only. Please select accordingly...!"
		fi	
else
	echo "Current POC code supports Single Tier or 2 Tier servers only. Please select accordingly...!"
fi

