#!/bin/bash

RPM_ID=rpm-package
PATH_M2=~/.m2/
main() {
	wellcome
	select_path

}

wellcome() {
	echo "###############################################"
	echo "#  	Docker Image of Maven with RPM        #"
	echo "###############################################"
}

select_path() {
	read -r -p "Type absolute PATH to PROJECT:" PATH_PROJECT
	clear
	
	if [ -z "$PATH_PROJECT" ]
	then
		  echo "****** Path to project is required ******"
		  select_path
	else
		select_task
	fi
}

select_task() {
	echo "###################################################################################"
	echo "#                                              Docker Image of Maven with RPM     #"
	echo "#      Please select task:                                                        #"
	echo "#                                                                                 #"
	echo "#          1) CLEAN ... INSTALL                                                   #"
	echo "#          2) WITH RPM                                                            #" 
	echo "#                                                                                 #"
	echo "###################################################################################"

	read -r -p "Type the option number:" option
	clear
	
	if [ -z "$option" ]
	then
		  echo "Default option: 1) CLEAN, INSTALL, ..."
		  clear
	else
		execute_task
	fi

}

execute_task() {
	case "$option" in
	
	1)
		echo "###################################################################################"
		echo "#                                              Docker Image of Maven with RPM     #"
		echo "#      Please select the phase:                                                   #"
		echo "#                                                                                 #"
		echo "#          1) CLEAN                                                               #"
		echo "#          2) COMPILE                                                             #"
		echo "#          3) TEST                                                                #"
		echo "#          4) PACKAGE                                                             #"
		echo "#          5) VERIFY                                                              #"
		echo "#          6) INSTALL                                                             #" 
		echo "#          7) DEPLOY                                                              #"
		echo "#          8) CLEAN INSTALL -DskipTests                                           #"
		echo "#          9) CLEAN INSTALL -Dsonar.skip=true                                     #"
		echo "#         10) CLEAN INSTALL -Dcheckstyle.skip                                     #"
		echo "#                                                                                 #"
		echo "###################################################################################"

		read -r -p "Type the option number:" maven_option
		clear
		
		if [ -z "$maven_option" ]
		then
			  echo "Default option: 1) CLEAN"
			  maven_option="1"
			  clear
		else
			execute_maven_phase
		fi
		;;
		
	2)
		read -r -p "Type RPM ID, enter to default option (rpm-package):" rpm_option
		clear
		
		if [ ! -z "$rpm_option" ]
		then
			  RPM_ID=$rpm_option
		fi

		docker run -it --name temp_container -v $PATH_M2:/root/.m2 -v $PATH_PROJECT:/usr/src/project -w /usr/src/my-project/maven-rpm mvn clean install -U -P $RPM_ID
		
		execute_done
		;;
	
	esac
}

execute_maven_phase() {
	case "$maven_option" in
	
	1)
		$MAVEN_PHASE="clean"
		;;	
	2)
		$MAVEN_PHASE="compile"
		;;
	3)
		MAVEN_PHASE="test"
		;;
	4)
		MAVEN_PHASE="package"
		;;
	5)
		MAVEN_PHASE="verify"
		;;
	6)
		MAVEN_PHASE="install"
		;;
	7)
		MAVEN_PHASE="deploy"
		;;
	8)
		MAVEN_PHASE="clean install -DskipTests"
		;;
	9)
		MAVEN_PHASE="clean install -Dsonar.skip=true"
		;;
	10)
		MAVEN_PHASE="clean install -Dcheckstyle.skip"
		;;
	esac
	
	execute_run
	
}

execute_run(){
	docker run -it --name temp_container -v $PATH_M2:/root/.m2 -v $PATH_PROJECT:/usr/src/project -w /usr/src/my-project/maven-rpm mvn $MAVEN_PHASE
	
	execute_done
}

execute_done() {
	docker rm temp_container -f
	echo "... Fin"
}

main
