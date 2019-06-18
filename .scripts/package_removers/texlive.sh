#!/bin/bash

sudo apt-get purge texlive*
sudo rm -rf /usr/local/texlive/* and rm -rf ~/.texlive*
sudo rm -rf /usr/local/share/texmf
sudo rm -rf /var/lib/texmf
sudo rm -rf /etc/texmf
sudo apt-get remove tex-common --purge
sudo rm -rf ~/.texlive
sudo find -L /usr/local/bin/ -lname /usr/local/texlive/*/bin/* | xargs rm
