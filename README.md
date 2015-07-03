Install
=======

### Automatic Install ###

Run this from your terminal:

    curl --silent https://raw.githubusercontent.com/fitoria/dotvim/master/install.sh | sh

### Manual Install ###

Get it from git:

    cd $HOME
    git clone git://github.com/fitoria/dotvim.git .vim

    ln -s $HOME/.vim/vimrc $HOME/.vimrc
    ln -s $HOME/.vim/gvimrc $HOME/.gvimrc
    git submodule init
    git submodule update
