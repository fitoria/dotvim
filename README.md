Here we dragons

Install
=======

### Automatic Install ###

Run this from your terminal:

    curl https://raw.github.com/fitoria/dotvim/master/install.rb | ruby

Y U NO TRUST ME?

### Manual Install ###

Get it from git:

    cd $HOME
    git clone git://github.com/fitoria/dotvim.git .vim

    ln -s $HOME/.vim/vimrc $HOME/.vimrc
    ln -s $HOME/.vim/gvimrc $HOME/.gvimrc
    git submodule init
    git submodule update
