# 계정 생성 및 권한 설정
echo "-----------------------------------------"
echo "steam ID를 생성합니다. 계정의 비밀번호를 지정해주세요"
echo "-----------------------------------------"
echo 


sudo useradd -m -d /home/steam steamcmd
sudo passwd steamcmd
sudo usermod -aG sudo steamcmd
sudo su steamcmd
cd ~
