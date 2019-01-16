#!/bin/bash

# get current directory
configDir=$(cd "$(dirname "$0")";pwd)
myHome=~


# TODO
# awesome: add program setting
# function comment
# Program dependency comment

# config file path and backup path
fileLists=(
$myHome/.config/i3
.
$myHome/.config/awesome
.
$myHome/.zshrc
.
$myHome/.vimrc.local
./vim_spf13
$myHome/.emacs
.
$myHome/.vimrc
.
$myHome/quick_start
.
)

# 暂时停用spacemacs，启动速度略慢而且基本用不上太多的功能
# 如Python c++依赖的简单编写偶尔会出bug略不稳定
# 对.emacs文件进行了简单的改装，使用自己配置的emacs
#$myHome/.spacemacs.d 
#.


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
                    if [ -h ${fileLists[i]} ] ; then
                        rm ${fileLists[i]}
                    fi
                    # backup the file if exist
                    if [ -f ${fileLists[i]} ] || [ -d ${fileLists[i]} ]; then
                        mv ${fileLists[i]} ${fileLists[i]}.bak
                    fi

                    lnFile=$(cd "${fileLists[i+1]}";pwd)/${fileLists[i]##*/}
                    ln -s $lnFile ${fileLists[i]}
                fi
            fi
		}

    if [ -h  /etc/shadowsocks/config.json ]; then
        sudo rm /etc/shadowsocks/config.json
    fi
    sudo ln -s $configDir/ss/config.json /etc/shadowsocks/config.json

}


deploy_settings

