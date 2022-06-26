FROM rocker/rstudio:4.2.0

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
    htop

# Install Korean language pack
RUN apt-get install -y language-pack-ko && \
    locale-gen ko_KR.UTF-8

# Install Korean fonts
RUN apt-get install -y fonts-nanum* && \
    fc-cache -fv

# 은전한닙 형태소분석기 설치
RUN wget https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz && \
    tar xzvf mecab-0.996-ko-0.9.2.tar.gz && \
    cd mecab-0.996-ko-0.9.2 && \   
    ./configure && \
    make && \
    make install && \
    ldconfig && \
    cd

# 은전한닙 형태소분석기 사전 설치
RUN wget https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz && \
    tar xvfz mecab-ko-dic-2.1.1-20180720.tar.gz && \
    cd mecab-ko-dic-2.1.1-20180720 && \   
    autoreconf && \ 
    ./configure && \
    make && \
    make install      

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

# server deamon 실행
CMD ["/init"]
