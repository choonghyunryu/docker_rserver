# 표준 R 서버를 위한 Docker 이미지

아직은 표준을 지향하고 있지만, **R과 관련된 표준 환경**을 만들어 가려 합니다. **Docker 기술**을 이용해서 **한국어 기반으로 R 데이터 분석과 프로그램에서 시스템 환경적 문제로 인해서 어려움을 겪는 것을 해결**하고자 합니다. 

## 왜 R 서버 구축을 위한 Docker 이미지를 만들었는가?

### 필요성

- 데이터 분석을 위한 환경 구축 리소스 최소화
  - "패키지가 설치 되지 않아요, 왜 자꾸 에러가 나지요?"
  - "분석 환경 구축이 어렵고, 시간도 많이 걸려요"
- 누구나 동일한 환경에서의 데이터 분석
  - "왜 나는 이런 결과가 나오죠? 비슷하지만 조금 다른 것 같아요."
  - "에러가 난다구요? 내 PC에서는 정상적으로 작동했는데, 패키지 버전이 다른가요?"
- Client/Server 환경에서의 데이터 분석
  - "Server 환경에서는 유용한 기능이 더 있다고 들었어요"
  - "Windows에서는 작동하지 않는다고 하는데, Linux 설치가 어려워요"

### 주요 기능
- R 기반의 데이터 분석 및 프로그래밍 
  - RStudio
  - Shiny
  - R Packages
- Reproducible Research 기반의 저작
  - R Markdown
  - Quarto
- 분석 리소스 관리 및 저작물 퍼블리싱
  - Git 
  
## 표준 R 서버 구축 환경

1. RStudio Server
    - 서버에 접속하여 R 분석
1. Shiny Server
    - 개발한 Shiny 앱 배포
1. 퍼블리싱 관련 작업
    - tex
    - Quarto    
1. 한글 NLP
    - bitNLP 패키지
    - 은전한닢 형태소분석기
1. Web Server
    - Apache 2
    - 정적 웹 페이지 퍼블리싱    
1. google chrome
    - pagedown을 이용한 문서의 pdf 출력
1. 한글 폰트 설치
    - 나눔 폰트 시리즈

## 표준 R 서버 구축 방법

사용자 환경에 git과 docker가 설치되었음을 전제로 합니다.

### Windows 환경
### Docker 이미지 생성

터미널을 실행하고 다음의 명령어를 실행합니다. Windows 환경에서는 git 명령어에 반드시 --config core.autocrlf=input 옵션을 추가해야 합니다.

이 작업은 [표준 R 서버를 위한 Docker 이미지](https://github.com/choonghyunryu/docker_rserver) 리파지토리의 파일들을 여러분의 PC로 가져오는 작업입니다.

````
git clone https://github.com/choonghyunryu/docker_rserver.git --config core.autocrlf=input
````

명령어를 실행하면, docker 이미지 생성을 위한 여러 파일들을 다운로드합니다.

다음의 script를 실행하여 docker 이미지를 생성합니다.

````
cd docker_rserver 
./create_image.cmd
````

이 스크립트는 제법 오랫동안 수행됩니다. 여러 유틸리티와 패키지를 설치하는 작업이라서 만들어진 Docker 이미지의 용량도 6GB가 넘습니다. 명령어를 수행한 후 인내심을 가지고 기다리기 바랍니다. Docker 이미지에 설치되는 프로그램들의 설치 로그들이 터미널에 출력되므로, 어떤 프로그램들이 설치되는 지 살펴보는 것도 좋은 방법입니다.

### Docker 컨테이너 생성

create_container.cmd 스크립트가 Docker 이미지에서 컨테이너를 생성하는 스크립트입니다. 다음과 같이 create_container.cmd를 실행하여, 컨테이너를 생성합니다.

````
./create_container.cmd
````

### Mac/Linux 환경

### Docker 이미지 생성

터미널을 실행하고 다음의 명령어를 실행합니다. 

````
$ git clone https://github.com/choonghyunryu/docker_rserver.git
````

다음의 script를 실행하여 docker 이미지를 생성합니다.

````
$ cd docker_rserver 
$ ./create_image.sh
````

### Docker 컨테이너 생성

create_container.sh 스크립트가 Docker 이미지에서 컨테이너를 생성하는 스크립트입니다. 다음과 같이 create_container.sh를 실행하여, 컨테이너를 생성합니다.

````
$ create_container.sh
````

## 표준 R 서버 활용하기

### RStudio 서버 접속하기
RStudio 서버에 접속하기 위한 URL은 다음과 같습니다.

- [http://localhost:8787/](http://localhost:8787/) 혹은,
- [http://127.0.0.1:8787/](http://127.0.0.1:8787/)

해당 URL로 접속하면 다음처럼 사용자의 아이디와 패스워드를 묻는 다이얼로그가 나타납니다.

로그인을 위한 어카운트는 다음과 같습니다.

- 아이디
    - ruser
- 패스워드
    - rworld
    
### Shiny 앱 접속하기
표준 R 서버를 위한 Docker 이미지 리파지토리에는 다음처럼 샘플 Shiny 앱 파일이 포함되어 있습니다.

```
shiny-server/app/scrap_news/global.R
shiny-server/app/scrap_news/server.R
shiny-server/app/scrap_news/ui.R
```

그리고 create_container.sh이나 create_container.cmd로 컨테이너를 생성했다면 샘플 앱인 scrap_news이 구동됩니다.

이 앱에 접속하기 위해서는 다음의 URL을 이용합니다.

- [http://localhost:3838/scrap_news](http://localhost:3838/scrap_news)

이 앱은 네이버 Open API를 이용해서 뉴스를 스크랩합니다. 그래서 Open API의 ID와 Secret을 입력해야 합니다. 이 정보는 개인 정보이므로, 여러분이 네이버로부터 Open API ID와 Secret를 발급받아야 합니다.
