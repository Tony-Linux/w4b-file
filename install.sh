#!/usr/bin/env bash

############################################################################
#                      © 2023 Tony-Linux. All Rights Reserved.             #
#          For inquiries regarding this project, kindly reach out to:      #
#                    Email: mrhunter5@proton.me                            #
#                                                                          #
#    This content is protected by copyright law and may not be replicated  #
#     or altered without the explicit written consent of the copyright     #
#                               holder.                                    #
############################################################################

green='\033[1;32m'
red='\033[1;31m'
white='\033[1;37m'

if [[ -d /usr/bin ]]; then
	if [ $(id -u) -ne 0 ]; then
		echo -e "${white} [${red}+${white}] ${red}This script necessitates root access to execute."
		exit
	fi
	system_path="/usr/bin"
elif [[ -d /data/data/com.termux/files/usr/bin ]]; then
	system_path="/data/data/com.termux/files/usr/bin"
fi
mv .tool/w4b-file $system_path
if [[ $(command -v php) && $(command -v curl) && $(command -v unzip) ]]; then
	echo -e "${white} [${green}+${white}] ${green}Packages already installed."
else
	pkgs=(ruby php wget)
	for pkg in "${pkgs[@]}"; do
		type -p "$pkg" &>/dev/null || {
			echo -e "${white} [${red}+${white}] ${red}Installing packages"
			if [[ $(command -v pkg) ]]; then
				pkg install "$pkg" -y
			elif [[ $(command -v apt) ]]; then
				sudo apt install "$pkg" -y
			elif [[ $(command -v apt-get) ]]; then
				sudo apt-get install "$pkg" -y
			elif [[ $(command -v pacman) ]]; then
				sudo pacman -S "$pkg" --noconfirm
			elif [[ $(command -v dnf) ]]; then
				sudo dnf -y install "$pkg"
			elif [[ $(command -v yum) ]]; then
				sudo yum -y install "$pkg"
			fi
		}
	done
fi

chmod +x $system_path/w4b-file
clear

if [[ $(command -v w4b-file) ]]; then
	echo ""
else
	mv -f .tool/w4b-file $system_path/
	chmod +x $system_path/w4b-file
fi
clear

if [[ $(command -v ruby) ]]; then
	echo ""
else
	echo -e "${white} [${red}+${white}] ${red}Manually install the Ruby program on your system"
fi
