#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run fcitx -r
#run emacs &
run compton -b
run xfce4-power-manager
run nm-applet
run nutstore
run autokey-gtk
run xfce4-clipman
