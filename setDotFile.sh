#!/bin/bash

# get current directory
configDir=$(cd "$(dirname "$0")";pwd)
myHome=$HOME


# TODO
# awesome: add program setting
# function comment
# Program dependency comment

# config file path and backup path
fileLists=(
$myHome/.p10k.zsh
.
$myHome/.config/i3
.
$myHome/.config/trizen/trizen.conf
.
$myHome/.config/awesome
.
$myHome/.zshrc
.
$myHome/.emacs
.
$myHome/.vimrc
./vim
$myHome/.config/nvim/init.vim
./vim
$myHome/.local/share/nvim/site/autoload/plug.vim
./vim
$myHome/.vim/autoload/plug.vim
./vim
$myHome/quick_start
.
"$myHome/.config/Code - OSS/User/keybindings.json"
./vscode
"$myHome/.config/Code - OSS/User/settings.json"
./vscode
)

mkdir -p $myHome/.config/nvim
mkdir -p $myHome/.local/share/nvim/site/autoload
mkdir -p $myHome/.vim/autoload

mkdir -p "$myHome/.config/Code - OSS/User"

# 暂时停用spacemacs，启动速度略慢而且基本用不上太多的功能
# 如Python c++依赖的简单编写偶尔会出bug略不稳定
# 对.emacs文件进行了简单的改装，使用自己配置的emacs
#$myHome/.spacemacs.d 
#.

# 暂停使用vim spf13，感觉没必要
# $myHome/.vimrc.local
# ./vim_spf13


# 从系统中获取配置文件
# 只在初始化仓库时用过，没什么其它用
# 注意在deploy_settings调用后，系统配置文件已经是链接，调用此函数会出问题
getConfigFiles(){
	fileNum=${#fileLists[@]}
	echo total file number: $(($fileNum/2))
	for ((i=0; i<$fileNum; i++))
	{
		if [ "$(($i%2))" = "0" ]; then

            # mkdir for current directory
            if [ ! -d ${fileLists[i+1]} ]; then
                mkdir ${fileLists[i+1]}
            fi

            # the backup file will be put in ./$fileLists[i+1]
			bakFile=${fileLists[i+1]}/${fileLists[i]##*/}
			if [ -f $bakFile ] || [ -d $bakFile ]  ; then
				rm $bakFile -rf
				echo $bakFile exist, delete it
			fi
            echo $bakFile

            # create link (file non-exist is not considerred)
			cp -r ${fileLists[i]} $bakFile
			echo cp from ${fileLists[i]} to $bakFile
		fi
    }
}

deploy_settings(){
	fileNum=${#fileLists[@]}
	for ((i=0; i<$fileNum; i++))
		{
            if [ "$(($i%2))" = "0" ]; then

                # if backup config file exist
                if [ -f ${fileLists[i+1]} ] || [ -d ${fileLists[i+1]} ]; then
                    # rm the link if exist
                    if [ -h "${fileLists[i]}" ] ; then
                        rm "${fileLists[i]}"
                    fi
                    # backup the file if exist
                    if [ -f "${fileLists[i]}" ] || [ -d "${fileLists[i]}" ]; then
                        mv "${fileLists[i]}" "${fileLists[i]}.bak"
                    fi

                    lnFile=$(cd "${fileLists[i+1]}";pwd)/${fileLists[i]##*/}

                    ln -s "$lnFile" "${fileLists[i]}"
                    echo create softlink from "$lnFile" to "${fileLists[i]}"
                fi
            fi
		}

#    if [ -h  /etc/shadowsocks/config.json ]; then
#        sudo rm /etc/shadowsocks/config.json
#    fi
#    sudo ln -s $configDir/ss/config.json /etc/shadowsocks/config.json

    if [ -f  /etc/vsftpd.conf ]; then
        sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
    fi
    if [ -L  /etc/vsftpd.conf ]; then
        sudo rm /etc/vsftpd.conf
    fi
    sudo ln -s $configDir/etc/vsftpd.conf /etc/vsftpd.conf


}


deploy_settings

