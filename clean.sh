#!/usr/bin/env bash

sudo apt-get -y remove libopencv
sudo apt-get -y remove opencv

sudo find / -name "*opencv*" -exec rm -i {} \;
sudo ldconfig && sudo ldconfig -vp