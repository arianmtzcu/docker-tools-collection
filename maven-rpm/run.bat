@ECHO OFF

REM NOTE:
REM Is necesary have settings.xml file in .m2
REM The first parameter is the absolute path to the project that let's to work.
REM The second parameter is the ID of rpm, if don't exist take default rpm-package.
REM The ID of rpm depends the project, in this case is rpm-package, will be mvd-rpm-package, etc.

REM Backup:
REM docker run -it -v %USERPROFILE%\.m2:/root/.m2 -v %1%:/usr/src/project -w /usr/src/my-project/maven-rpm mvn clean install -U -P rpm-package

REM Example:
REM run.bat C:\dev\project_name

SET RPM_ID=rpm-package

@echo ###############################################
@echo #  	Docker Image of Maven with RPM        #
@echo ###############################################

GOTO START

:START
	@echo:
	SET "PATH_PROJECT="
	set /P PATH_PROJECT=Type absolute PATH to PROJECT: %=%
	cls
	
	IF [%PATH_PROJECT%]==[] @echo: & @echo ****** Path to project is required ****** & GOTO START
	
	@echo:
	
	@echo ###################################################################################
	@echo #                                              Docker Image of Maven with RPM     #
	@echo #      Please select task:                                                        #
	@echo #                                                                                 #
	@echo #          1) CLEAN ... INSTALL                                                   #
	@echo #          2) WITH RPM                                                            # 
	@echo #                                                                                 #
	@echo ###################################################################################

	@echo:
	SET "option="
	SET /P option=Type the option number: %=%
	
	IF [%option%]==[] SET "option=1" & @echo: & @echo Default option: 1) CLEAN, INSTALL, ... & @echo:
	cls
	
	@echo:
	GOTO R-%option%

:R-1
	@echo:
	@echo ###################################################################################
	@echo #                                              Docker Image of Maven with RPM     #
	@echo #      Please select the phase:                                                   #
	@echo #                                                                                 #
	@echo #          1) CLEAN                                                               #
	@echo #          2) COMPILE                                                             #
	@echo #          3) TEST                                                                #
	@echo #          4) PACKAGE                                                             #
	@echo #          5) VERIFY                                                              #
	@echo #          6) INSTALL                                                             # 
	@echo #          7) DEPLOY                                                              #
	@echo #          8) CLEAN INSTALL -DskipTests                                           #
	@echo #          9) CLEAN INSTALL -Dsonar.skip=true                                     #
	@echo #         10) CLEAN INSTALL -Dcheckstyle.skip                                     #
	@echo #                                                                                 #
	@echo ###################################################################################

	@echo:
	SET "maven_option="
	SET /p maven_option=Type the option number: %=%
	
	IF [%maven_option%]==[] SET "maven_option=1" & @echo: & @echo Default option: 1) CLEAN & @echo:
	cls
	
	@echo:
	GOTO M-%maven_option%
	
:R-2
	SET "rpm_option="
	SET /p rpm_option=Type RPM ID, enter to default option (rpm-package): %=%
		
	IF NOT [%rpm_option%]==[] SET "RPM_ID=%rpm_option%"

	docker run -it --name temp_container -v %USERPROFILE%\.m2:/root/.m2 -v %PATH_PROJECT%:/usr/src/project -w /usr/src/my-project/maven-rpm mvn clean install -U -P %RPM_ID%
	
	GOTO DONE
	
:M-1
	SET "MAVEN_PHASE=clean"
	
	GOTO RUN
	
:M-2
	SET "MAVEN_PHASE=compile"
	
	GOTO RUN
	
:M-3
	SET "MAVEN_PHASE=test"
	
	GOTO RUN

:M-4
	SET "MAVEN_PHASE=package"
	
	GOTO RUN
	
:M-5
	SET "MAVEN_PHASE=verify"
	
	GOTO RUN
	
:M-6
	SET "MAVEN_PHASE=install"
	
	GOTO RUN
	
:M-7
	SET "MAVEN_PHASE=deploy"
	
	GOTO RUN
	
:M-8
	SET "MAVEN_PHASE=clean install -DskipTests"
	
	GOTO RUN

:M-9
	SET "MAVEN_PHASE=clean install -Dsonar.skip=true"
	
	GOTO RUN

:M-10
	SET "MAVEN_PHASE=clean install -Dcheckstyle.skip"
	
	GOTO RUN

:RUN 
	docker run -it --name temp_container -v %USERPROFILE%\.m2:/root/.m2 -v %PATH_PROJECT%:/usr/src/project -w /usr/src/my-project/maven-rpm mvn %MAVEN_PHASE%
	
	GOTO DONE

:DONE

@echo:
docker rm temp_container -f
@echo:
@echo "... Fin"

