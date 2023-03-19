#!/bin/bash


# Stop on error
set -e

cd

while :; do
    echo
    echo
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

cd /home/steam

sudo apt update -y 
sudo apt install git git-lfs screen net-tools -y 

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install lib32gcc-s1 steamcmd -y 


# 스팀 SDK 설치

cd /home/steam
mkdir steamcmd-source
cd /home/steam/steamcmd-source
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +force_install_dir . +login anonymous +app_update 1007 +quit



# Copying Steam SDK to the right place
cd /home/steam/.steam
mkdir sdk64
cp /home/steam/steamcmd-source/linux64/steamclient.so /home/steam/.steam/sdk64/



#서버 설치
cd /home/steam
git clone https://github.com/Uuvana-Studios/longvinter-linux-server.git
sudo chmod -R ugo+rwx longvinter-linux-server/


# 환경 변수 파일 

cat <<-EOF > /home/steam/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini
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



## systemd 등록 ##
sudo cp /home/steam/longvinter-linux-server/longvinter.service /etc/systemd/system/longvinter.service
sudo cp /home/steam/longvinter-linux-server/longvinter.socket /etc/systemd/system/longvinter.socket
sudo systemctl daemon-reload




clear

## 완료 ##
echo "---------------------------------------------------------------------------"
echo "설치가 완료 되었습니다 아래 명령어를 사용하여 서버 설정을 마무리 하세요" 
echo "---------------------------------------------------------------------------"
echo "nano ~/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini"
echo
echo "---------------------------------------------------------------------------"
echo "서버 실행"
echo "---------------------------------------------------------------------------"
echo "sudo systemctl start longvinter.service"    
echo
echo "---------------------------------------------------------------------------"
echo "실시간 서버 로그 추적"
echo "---------------------------------------------------------------------------"
echo "sudo journalctl -u longvinter -f"
echo
echo "---------------------------------------------------------------------------"
echo "전체 서버 로그 확인"
echo "---------------------------------------------------------------------------"
echo "sudo journalctl -u longvinter"
echo
echo "---------------------------------------------------------------------------"
echo "서버 종료"
echo "---------------------------------------------------------------------------"
echo "sudo systemctl stop longvinter.service"
echo
echo "---------------------------------------------------------------------------"
echo "서버 상태확인"
echo "---------------------------------------------------------------------------"
echo "sudo systemctl status longvinter.service"
echo
echo "---------------------------------------------------------------------------"
echo "서버 업데이트"
echo "---------------------------------------------------------------------------"
echo "bash /home/steam/longvinter-linux-server/LongvinterUpdate.sh"
echo 
echo "---------------------------------------------------------------------------"
echo "서버 백업"
echo "---------------------------------------------------------------------------"
echo "bash /home/steam/longvinter-linux-server/LongvinterBackup.sh"
