#!/bin/bash

x11vnc -display :0 -viewpasswd 123456 -passwd 1234567 -shared -forever
