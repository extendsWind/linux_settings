#!/bin/bash

currentHome=~

# config file path and backup path
fileLists=( 
$currentHome/.config/awesome 
.
$currentHome/.config/i3
.
$currentHome/.
)


mklink(){
	fileNum=${#fileLists[@]}
	echo total file number: $(($fileNum/2))
	for ((i=0; i<$fileNum; i++))
		{
			if [ "$(($i%2))" = "0" ]; then
				lnFile=${fileLists[i+1]}/${fileLists[i]##*/}
				if [ -f $lnFile ] ; then
					rm $lnFile
					echo $lnFile exist, delete it
				fi
				if [ -d $lnFile ] ; then
					rm $lnFile
					echo $lnFile exist, delete it
				fi

				ln -s ${fileLists[i]} $lnFile
				echo create link from ${fileLists[i]} to $lnFile
			fi
		}
}


installSoftware(){
    # spf13
    if [ ! -f ~/.vimrc.before ] ; then
      echo install spf13 for vim
      curl http://j.mp/spf13-vim3 -L -o - | sh
    fi

    # spacemacs
    if [ ! -f ~/.emacs.d/spacemacs.mk ] ; then
      echo install spacemacs for emacs
      git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
      git clone git@github.com:extendsWind/.spacemacs.d.git ~/.spacemacs.d/
    fi

    # oh my zsh
    if [ ! -d ~/.oh-my-zsh ] ; then
      echo install oh my zsh
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

}

mklink
# installSoftware  # not test
