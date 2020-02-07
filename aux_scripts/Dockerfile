# base image https://hub.docker.com/u/rocker/
FROM r-base:latest

# create directories
RUN mkdir -p /opt/software/setup/R
ADD install_packages.R /opt/software/setup/R/
RUN Rscript /opt/software/setup/R/install_packages.R
