#!/usr/bin/env bash
#
# This script basically install the vim config,
# puts your old confirations in a backup folder in home
#

blue="\033[34m"
red="\033[31m"
yellow="\033[33m"
green="\033[32m"

home="$HOME"
main="$HOME/Code"
dotvim="$HOME/Code/dotvim"

clone() {
  mkdir $main
  cd $main
  git clone git://github.com/fitoria/dotvim.git
}

backup() {
  mv ~/.vim ~/.vim.backup
  mv ~/.vimrc ~/.vimrc.backup
  mv ~/.gvim ~/.vimrc.backup
}

if [[ -d "$dotvim" ]]; then
  echo "$yellow Symlinking dotvim from $dotvim"
else
  echo "$red $dotvim does not exist"
  read -p "$blue You want to create this now? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    backup
    clone
  fi
fi

link() {
  from="$1"
  to="$2"
  echo "$yellow Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}


link "$dotvim/vimrc" "$home/.vimrc"
link "$dotvim/gvimrc" "$home/.gvimrc"
link "$dotvim/" "$home/.vim"

echo "$red PRO TIP: You can put your own modifications in the ~/.vimrc.local and ~/.gvimrc.local files"

