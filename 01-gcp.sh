# 계정 생성 및 권한 설정
echo "-----------------------------------------"
echo "steam ID를 생성합니다. 계정의 비밀번호를 지정해주세요"
echo "계정 생성이 완료되고 나며 반드시 cd 커맨드를 한버 입력해주세요"
echo "-----------------------------------------"
echo 

sudo useradd -m -d /home/steam steamcmd
sudo passwd steamcmd
sudo usermod -aG sudo steamcmd
sudo su steamcmd
