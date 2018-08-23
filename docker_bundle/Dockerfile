FROM jenkinsci/ssh-slave:latest
MAINTAINER Digbijay Shrestha <digbijay.shrestha@gmail.com>

RUN mkdir -p /opt/bin/testrunner

COPY run_testng_test.sh /opt/bin/testrunner/run_testng_test.sh
COPY load_testng_parameters.py /opt/bin/testrunner/load_testng_parameters.py
COPY template.xml /opt/bin/testrunner/template.xml

WORKDIR /opt/bin/testrunner/
