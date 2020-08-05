#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
    echo start $@
  fi
}

# ===== run (only once) processes which spawn with different name
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
    gnome-keyring-daemon --daemonize --login &
fi
if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi


# run /usr/lib/polkit-kde-authentication-agent-1  # for root grant in GUI
if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
    /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi
if (command -v  xfce4-power-manager && ! pgrep xfce4-power-man) ; then
    xfce4-power-manager &
fi



# ===== application daemons
run light-locker # lock the screen when suspend
run thunar --daemon
run compton --shadow-exclude '!focused'  # 窗口透明效果
run fcitx -r
run xfsettingsd # for xfce4
# run /usr/lib/gsd-xsettings
# run /usr/lib/cinnamon-settings-daemon/csd-xsettings  # for deepin wine
run xfce4-power-manager

# ===== applet 右下角
run pa-applet
run nm-applet # for network manger system tray | not used much
run blueman-applet

# ===== some applications
# run xfce4-clipman
run nutstore
run albert  # app launcher
# run "sslocal -c /etc/shadowsocksr/config.json"
# run "v2ray -c /home/fly/.config/v2ray/config.json"
# run klipper
# run screen1   # xrand setting for rate


# 关闭屏幕保护和省电模式
xset -dpms
xset s off
