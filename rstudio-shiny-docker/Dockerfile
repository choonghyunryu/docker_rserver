FROM rocker/rstudio:4.2.0

MAINTAINER Choonghyun Ryu <"choonghyun.ryu@gmail.com">

# Install shiny server
RUN /rocker_scripts/install_shiny_server.sh
# Install tidyverse packages
RUN /rocker_scripts/install_tidyverse.sh

# Install tinytex and tools/packages related to publishing
ENV CTAN_REPO=https://mirror.ctan.org/systems/texlive/tlnet
ENV PATH=$PATH:/usr/local/texlive/bin/linux
ENV QUARTO_VERSION=latest
RUN /rocker_scripts/install_verse.sh
RUN /rocker_scripts/install_quarto.sh

# Install system libraries of general use
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    htop \
    readline-common

# Install the Korean language pack
RUN apt-get install -y language-pack-ko && \
    locale-gen ko_KR.UTF-8

# Install the Korean fonts
RUN apt-get install -y fonts-nanum* fonts-noto-cjk && \
    fc-cache -fv

# Create a directory to store the files to be installed
RUN mkdir /usr/local/install_resources
COPY NIADic/*.csv /usr/local/install_resources/

# Install the Korean morpheme analyzer
COPY install_morphology.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_morphology.sh
RUN /usr/local/bin/install_morphology.sh

# Install google chrome for pagedown package 
RUN curl -L http://bit.ly/google-chrome-stable -o google-chrome-stable.deb && \
    apt-get -y install ./google-chrome-stable.deb && \
    rm google-chrome-stable.deb

COPY google-chrome /usr/local/bin/

# Set R environment variables
COPY Renviron /.Renviron

# Install web server
COPY install_apache2.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_apache2.sh
RUN /usr/local/bin/install_apache2.sh

# Install additional tex packages
COPY install_tex_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_tex_packages.sh
RUN /usr/local/bin/install_tex_packages.sh

# Install R packages
COPY install_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_packages.sh
RUN /usr/local/bin/install_packages.sh

# Install dsub deamon
COPY install_dsub_deamon.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_dsub_deamon.sh
RUN /usr/local/bin/install_dsub_deamon.sh

# Create user for R analytics
COPY create_user.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_user.sh
RUN /usr/local/bin/create_user.sh

# For servers (rstudio, shiny, web)
EXPOSE 8787 
EXPOSE 3838 
EXPOSE 80

# For Environments
ENV LANG en_US.UTF-8
ENV TZ Asia/Seoul

# Excute server deamons
CMD ["/init"]
