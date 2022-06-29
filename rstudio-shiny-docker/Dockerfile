FROM rocker/rstudio:4.2.0

MAINTAINER Choonghyun Ryu <"choonghyun.ryu@gmail.com">

# shiny server 설치
RUN /rocker_scripts/install_shiny_server.sh
# tidyverse 패키지군 설치
RUN /rocker_scripts/install_tidyverse.sh

# latex과 퍼블리싱관련 툴/패키지 설치
ENV CTAN_REPO=https://mirror.ctan.org/systems/texlive/tlnet
ENV PATH=$PATH:/usr/local/texlive/bin/linux
ENV QUARTO_VERSION=latest
RUN /rocker_scripts/install_verse.sh
RUN /rocker_scripts/install_quarto.sh

# system libraries of general use
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    htop \
    readline-common

# Install Korean language pack
RUN apt-get install -y language-pack-ko && \
    locale-gen ko_KR.UTF-8

# Install Korean fonts
RUN apt-get install -y fonts-nanum* && \
    fc-cache -fv

# 설치할 파일을 저장할 디렉토리 생성 
RUN mkdir /usr/local/install_resources
COPY NIADic/*.csv /usr/local/install_resources/

# 형태소분석기 설치
COPY install_morphology.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_morphology.sh
RUN /usr/local/bin/install_morphology.sh

# google chrome 설치 for pagedown 
RUN curl -L http://bit.ly/google-chrome-stable -o google-chrome-stable.deb && \
    apt-get -y install ./google-chrome-stable.deb && \
    rm google-chrome-stable.deb

COPY google-chrome /usr/local/bin/

# R 패키지 설치
COPY install_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_packages.sh
RUN /usr/local/bin/install_packages.sh

# R 환경변수 설정
COPY Renviron /.Renviron

# for shiny server
EXPOSE 3838 

RUN adduser ruser && \
    sh -c 'echo ruser:rworld | sudo chpasswd' && \
    addgroup ruser staff

# web server 설치
COPY install_apache2.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_apache2.sh
RUN /usr/local/bin/install_apache2.sh

EXPOSE 80

# 추가 tex packages 설치
COPY install_tex_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_tex_packages.sh
RUN /usr/local/bin/install_tex_packages.sh

# for tex install by ruser
RUN chown -R ruser /usr/local/texlive/

# server deamon 실행
CMD ["/init"]
