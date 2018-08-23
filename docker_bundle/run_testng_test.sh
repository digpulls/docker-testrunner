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
#   - test_jar :  url of test jar
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
#  Download Test Jars  #
######################################
echo "########## Downloading Test code Jar ##########"
wget $2 -O ${TEST_JAR_NAME}

######################################
###    Initialize Test Execution   ###
######################################
echo "########## Running TestNG tests ##########"
java -cp ${TEST_JAR_NAME} org.testng.TestNG testNG.xml
echo "########## Execution completed ##########"