#!/bin/bash
###################################################################
#  Script     : run_testng_test.sh
#  Author     : Digbijay Shrestha
#  Date       : 12/02/2017
#  Last Edited: 12/02/2017, digbijay.shrestha
#  Description: execute testng tests from user parameters
###################################################################
# Purpose:
#   - jenkins job will pass testng parameters as JSON
#   - script will populate the JSON parameters into testng.xml file
#   - script will then pull framework/test jars and start execution
###################################################################
# Syntax: run_testng_test [json_parameters_file] [test_jar_url]
#   - json_parameters_file : JSON file from jenkins job
#   - test_jar : artifactory url of test jar
###################################################################
# Dependency: load_testng_parameters.py
#   - Python script to create a testng file from Json parameters
###################################################################


######################################
####     Running Python Code      ####
######################################
# populate user given json parameters into testng.xml file
python load_testng_parameters.py $1
echo "########## TestNG file is updated ##########"

######################################
####  Framework Artifactory Kits  ####
######################################
ART_SERVER="https://artifactory.falcon.kronos.com/artifactory/"
ART_REPO_SUITEQA="falconcloud-suiteqa-snapshot/com/kronos/qa/automation/"
UI_CORE_NAME="UICore"
API_CORE_NAME="APICore"
FRAMEWORK_VERSION="/1.0.0/"
JAR_VERSION="-1.0.0.jar"
API_JAR_NAME="api_framework.jar"
UI_JAR_NAME="ui_framework.jar"
TEST_JAR_NAME="test_code.jar"
API_FRAMEWORK_KIT=${ART_SERVER}${ART_REPO_SUITEQA}${API_CORE_NAME}${FRAMEWORK_VERSION}${API_CORE_NAME}${JAR_VERSION}
UI_FRAMEWORK_KIT=${ART_SERVER}${ART_REPO_SUITEQA}${UI_CORE_NAME}${FRAMEWORK_VERSION}${UI_CORE_NAME}${JAR_VERSION}

######################################
#  Download Framework and Test Jars  #
######################################
echo "########## Pulling latest Framework Jars ##########"
wget -q ${API_FRAMEWORK_KIT} -O ${API_JAR_NAME}
wget -q ${UI_FRAMEWORK_KIT} -O ${UI_JAR_NAME}
echo "########## Pulling Product Test code Jar ##########"
wget -q $2 -O ${TEST_JAR_NAME}

######################################
###    Initialize Test Execution   ###
######################################
echo "########## Running TestNG tests ##########"
java -cp ${API_JAR_NAME}:${UI_JAR_NAME}:${TEST_JAR_NAME} org.testng.TestNG testng.xml
echo "########## Execution completed ##########"