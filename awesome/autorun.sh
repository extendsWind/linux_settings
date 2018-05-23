#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
    echo start $@
  fi
}

run nm-applet # for network system tray
# run dbus-launch update-checker
run light-locker # lock the screen when suspend
run pulseaudio -D
run compton --shadow-exclude '!focused'
# run /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 # for privilige management??
run thunar --daemon
# run xrdb merge ~/.Xresources # Load a x resource file, and merge with the current settings, not well for python tk
#run xfsettingsd # for xfce4
run gnome-keyring-daemon
# run urxvtd # command not found

run fcitx -r
run xfce4-power-manager
run nutstore
run autokey-gtk