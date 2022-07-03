# R 서버를 위한 docker 이미지

## R 서버 환경

1. Web Server
    - Apache 2
    - 정적 웹 페이지 퍼블리싱
2. RStudio Server
    - 서버에 접속하여 R 분석
3. Shiny Server
    - 개발한 Shiny 앱 배포
4. 퍼블리싱 관련 작업
    - tex
    - Quarto
5. 한글 NLP
    - 은접한닢 형태소분석기
    - Rmecab
6. google chrome
    - pagedown을 이용한 문서의 pdf 출력
7. 한글 폰트 설치
    - 나눔 폰트 시리즈

# docker 이미지의 사용

## docker 이미지 생성하기

다음의 script를 실행하여 docker 이미지를 생성함

````
$ create_image.sh
````

create_image.sh의 내용은 다음과 같음

````
#!/bin/bash

# create docker image
docker build -t rserver:second ./rstudio-shiny-docker

````


## docker 컨테이너 생성하기

다음의 script를 실행하여 docker 컨테이너를 생성함

````
$ create_container.sh
````

create_image.sh의 내용은 다음과 같음

````
#!/bin/bash

# create docker container
docker run -d -p 3838:3838 -p 8787:8787 -p 80:80 \
  -e PASSWORD=rstudio -e ROOT=TRUE \
  --name rstudio-shiny-server \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/shiny-server/:/srv/shiny-server/ \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/web/html/:/var/www/html/ \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/logs/shiny/:/var/log/shiny-server/ \
  rserver:second 
````

1. Web server의 웹 어플리케이션의 경로로 로컬 머신의 
    - `/Users/choonghyunryu/Documents/01_Personal/15_demos/web/html/`과 연결했으며,
2. Shiny server의 어플리케이션 경로로 로컬 머신의
    - `/Users/choonghyunryu/Documents/01_Personal/15_demos/shiny-server/`과 연결했으며,
3. Shiny server의 로그 경로로 로컬 머신의     
    - `/Users/choonghyunryu/Documents/01_Personal/15_demos/logs/shiny/`과 연결했음

만약에 docker 컨테이너 안에 이들 경로를 사용할 경우에는 해당 스크립트를 수정하면 됨

