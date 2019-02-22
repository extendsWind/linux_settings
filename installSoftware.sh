#!/bin/bash

# not test now !!


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


