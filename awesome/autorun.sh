#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
    echo start $@
  fi
}

# run nm-applet # for network manger system tray | not used much
# run dbus-launch update-checker
run light-locker # lock the screen when suspend
run compton --shadow-exclude '!focused'
# run /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 # for privilige management??
# run thunar --daemon
# run xrdb merge ~/.Xresources # Load a x resource file, and merge with the current settings, not well for python tk
# run xfsettingsd # for xfce4
# run gnome-keyring-daemon
# run urxvtd # command not found
# run pulseaudio -D # audio control, will case a bug of tim to hang

run fcitx -r
# run xfce4-power-manager
# run xfce4-clipman
run nutstore
# run autokey-gtk
# run xx-net
# run /usr/lib/gsd-xsettings
# run xfsettingsd
run /usr/lib/cinnamon-settings-daemon/csd-xsettings  # for deepin wine


run "sslocal -c /etc/shadowsocks/config.json"
run klipper

run screen1   # xrand setting for rate


# 关闭屏幕保护和省电模式
xset -dpms
xset s off
