#/data/data/com.termux/files/usr/bin/bash
#using this path as this would probably be where all termux users bash is

args=$@
ipr=$(ip route show)
device=$(echo "$ipr" | tail -n 1 | awk '{print $3}')
gateway=$(echo "$ipr" | grep "default" | awk '{print $3}')
subnet=$(echo "$ipr" | tail -n 1 | awk '{print $1}')
ip=$(ifconfig $device | grep inet | head -n 1 | awk '{print $2}' | cut -d ":" -f2)

banner="\033[0;97;41mTNT\033[0m - \033[0;97;41mT\033[0mermux \033[0;97;41mN\033[0metworking \033[0;97;41mT\033[0mool\ngithub.com/dosisod/tnt\n"

function main() {
	echo -e $banner
	echo -e "IP\t  $ip"
	echo -e "SUBNET\t  $subnet"
	echo -e "GATEWAY\t  $gateway\n"

	echo -e "USAGE\t  >>> \033[0;97;41mNUM\033[0m [PARAMS]"
	echo -e "EXAMPLE\t  >>> 3 nano\n"
	mods_get
	input
}
function mods_get() {
	while ((i++)); read -r line
	do
		coms[$i]=$(echo $line | cut -d ";" -f 2)
		echo -e "[\033[0;97;41m$i\033[0m] $(echo $line | cut -d ";" -f 1)"
	done < mods/index
	echo ""
	#dir=$(ls -1 mods)
	#echo $dir
}

function input() {
	for((;;))
	do
		echo -n " >>> "
		read input
		echo -e "\033[0;97;41mRUNNING:\033[0m ${coms[$(echo $input | awk '{print $1}')]}$(echo "$input" | awk '{$1=""; print $0}')\n"
		eval "${coms[$(echo $input | awk '{print $1}')]}$(echo "$input" | awk '{$1=""; print $0}')"
		echo ""
	done
}

main
