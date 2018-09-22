#/data/data/com.termux/files/usr/bin/bash
#using this path as this would probably be where all termux users bash is

args=$@
ipr=$(ip route show)
device=$(echo "$ipr" | head -n 1 | awk '{print $5}')
gateway=$(echo "$ipr" | head -n 1 | awk '{print $3}')
subnet=$(echo "$ipr" | tail -n 1 | awk '{print $1}')
ip=$(ifconfig $device | grep inet | head -n 1 | awk '{print $2}')

banner="\033[0;97;41mTNT\033[0m - Termux Networking Tool\ngithub.com/dosisod/tnt\n"

function main() {
	echo -e $banner
	echo -e "IP\t  $ip"
	echo -e "SUBNET\t  $subnet"
	echo -e "GATEWAY\t  $gateway\n"
	mods_get
}
function mods_get() {
	while ((i++)); read -r line
	do
		echo -e "[\033[0;97;41m$i\033[0m] $(echo $line | cut -d ";" -f 1)"
	done < mods/index
	#dir=$(ls -1 mods)
	#echo $dir
}

main
