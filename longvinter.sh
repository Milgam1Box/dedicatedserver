#!/bin/bash


# Stop on error
set -e

cd

while :; do
    echo "롱빈터 서버 구축 스크립트를 동작 합니다 "
    echo -n "시작 하겠습니까? [yes/no]  "

    read -r answer

    case $answer in
        YES|Yes|yes|y)
            break;;
        NO|No|no|n)
            echo Aborting; exit;;
    esac
done

echo


# 패키지 업데이트 & 설치

cd ~

sudo apt update -y 
sudo apt install git git-lfs screen net-tools steamcmd -y 

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install lib32gcc-s1 steamcmd -y 


# 스팀 SDK 설치

cd ~/

mkdir steamcmd-source
cd steamcmd-source
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +force_install_dir . +login anonymous +app_update 1007 +quit


# Copying Steam SDK to the right place
cd ~/.steam
mkdir sdk64
cp ~/steamcmd-source/linux64/steamclient.so ~/.steam/sdk64/


# 방화벽 개방
sudo iptables -I INPUT -p udp --dport 7777 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 27016 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 27016 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 27015 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 27015 -j ACCEPT
sudo ufw allow 7777/udp
sudo ufw allow 27016
sudo ufw allow 27015

#서버 설치
cd ~/
git clone https://github.com/Uuvana-Studios/longvinter-linux-server.git
sudo chmod -R ugo+rwx longvinter-linux-server/


# 환경 변수 파일 

cat <<-EOF > ~/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini
[/Game/Blueprints/Server/GI_AdvancedSessions.GI_AdvancedSessions_C]
ServerName=Unnamed Island
ServerTag=Default
MaxPlayers=32
ServerMOTD=Welcome to Longvinter Island!
Password=
CommunityWebsite=www.longvinter.com

[/Game/Blueprints/Server/GM_Longvinter.GM_Longvinter_C]
AdminSteamID=76561198965966997
PVP=true
TentDecay=true
MaxTents=2
ChestRespawnTime=600
EOF


clear

## 완료 ##
echo
echo
echo
echo
echo
echo "---------------------------------------------------------------------------"
echo "설치가 완료 되었습니다"
echo "아래 명령어를 사용하여 서버 설정을 마무리 하세요" 
echo "---------------------------------------------------------------------------"
echo "nano ~/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini"
echo
echo
echo "---------------------------------------------------------------------------"
echo "서버 실행은 아래 명령어를 사용하세요"
echo "---------------------------------------------------------------------------"
echo "sh ~/longvinter-linux-server/LongvinterServer.sh"    


