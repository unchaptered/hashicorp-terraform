#! /bin/bash
# 이 스크립트는 AWS의 EC2 인스턴스에 Apache HTTP 서버를 설치하고 구성합니다.
# 인스턴스 ID 메타데이터 참조 - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

# yum 패키지 관리자를 사용하여 운영 체제 패키지 업데이트
sudo yum update -y

# yum 패키지 관리자를 사용하여 Apache HTTP 서버 설치
sudo yum install -y httpd

# systemctl 명령을 사용하여 시스템 부팅 시 httpd 서비스가 자동으로 시작되도록 설정합니다
sudo systemctl enable httpd

# service 명령을 사용하여 httpd 서비스 시작
sudo service httpd start

# echo 명령 및 sudo 권한이 있는 tee 명령을 사용하여 /var/www/html/ 디렉토리에 "StackSimplify에 오신 것을 환영합니다 - APP-1" 내용의 HTML 파일을 만듭니다
sudo echo '<h1>Welcome to StackSimplify - APP-1</h1>' | sudo tee /var/www/html/index.html

# sudo 권한이 있는 mkdir 명령을 사용하여 /var/www/html/ 디렉토리에 "app1"이라는 디렉토리를 생성합니다
sudo mkdir /var/www/html/app1

# echo 명령과 sudo 권한이 있는 tee 명령을 사용하여 /var/www/html/app1/ 디렉토리에 "Stack Simply - APP-1><p>Terraform Demo</p>"라는 내용의 HTML 파일을 만듭니다
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html

# sudo 권한이 있는 curl 명령을 사용하여 인스턴스 ID 문서를 /var/www/html/app1/ 디렉토리로 다운로드합니다
sudo curl http://15.164.129.107/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html