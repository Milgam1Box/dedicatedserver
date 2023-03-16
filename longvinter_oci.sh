# 계정 생성 및 권한 설정
echo "--------------------------------------------------------"
echo "Tech Tim 채널 구독과 좋아요 부탁 드립니다."
echo "--------------------------------------------------------"
echo 
sleep 2



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


sudo useradd -m -d /home/steam steamcmd
sudo passwd steamcmd
sudo usermod -aG sudo steamcmd
sudo chsh -s /bin/bash steamcmd 
sudo su - steamcmd -c 'cd && bash <(curl -s https://raw.githubusercontent.com/KorTechTim/dedicatedserver/main/longvinter_oci_bg.sh)'


