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
$myHome/.spacemacs.d
.
$myHome/.vimrc.local
./vim_spf13
)


# mklink(){
# 	fileNum=${#fileLists[@]}
# 	echo total file number: $(($fileNum/2))
# 	for ((i=0; i<$fileNum; i++))
# 		{
# 			if [ "$(($i%2))" = "0" ]; then
# 
#                 # mkdir for current directory
#                 if [ ! -d ${fileLists[i+1]} ]; then
#                     mkdir ${fileLists[i+1]}
#                 fi
# 
#                 # the linked file will be put in fileLists[i+1]
# 				lnFile=${fileLists[i+1]}/${fileLists[i]##*/}
# 				if [ -f $lnFile ] || [ -d $lnFile ]  ; then
# 					rm $lnFile
# 					echo $lnFile exist, delete it
# 				fi
# 
#                 # create link (file non-exist is not considerred)
# 				ln -s ${fileLists[i]} $lnFile
# 				echo create link from ${fileLists[i]} to $lnFile
# 			fi
#         }
# 
# }
# 
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
    sudo ln -s $configDir/ss/config.json /etc/shadowsocks/config.json

}

getConfigFiles

# deploy_settings
#mklink

# installSoftware  # not test
