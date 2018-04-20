#!/bin/bash

my_home=/home/fly

# awesome  there is also an auto start bash
awesomeDir=$my_home/.config/awesome
awesomeCurDir=./
cp $awesomeDir $awesomeCurDir -r

# i3wm
i3Dir=$my_home/.config/i3
i3CurDir=./

cp $i3Dir $i3CurDir -r

cp $my_home/.i3status.conf ./i3
