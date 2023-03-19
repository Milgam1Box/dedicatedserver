# 계정 생성 및 권한 설정
echo "--------------------------------------------------------"
echo "Tech Tim 채널 구독과 좋아요 부탁 드립니다."
echo "https://www.youtube.com/channel/UCTKC1JQaVY-QvLKyGt84I5w"
echo "steamcmd 계정을 생성합니다. 패스워드를 입력해 주세요"
echo "--------------------------------------------------------"
echo 
sleep 2


sudo useradd -m -d /home/steam steamcmd
sudo passwd steamcmd
sudo usermod -aG sudo steamcmd
sudo chsh -s /bin/bash steamcmd 
sudo su - steamcmd


