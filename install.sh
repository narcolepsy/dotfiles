#!/usr/bin/env bash
#Install ruby-dev to ensure we get the interactive editor/awesome_print dependencies installed
#sudo apt-get install ruby-dev
#Install gems for colourised irbrc
#gem install interactive_editor awesome_print


#Now symlink all the dotfiles into place, backing up existing ones (if a genuine file and not already a symlink to the destination!)
#if [ -e $HOME/.irbrc ]
#then echo "Found .irbrc - not adding symlink"
#else echo "No .irbrc found, creating symlink"
#   ln -s irbrc $HOME/.irbrc
#fi
#if [ -e $HOME/.screenrc ]
#then echo "Found .screenrc - not adding symlink"
#else echo "No .screenrc found, creating symlink"
#   ln -s screenrc $HOME/.irbrc
#fi
#if [ -e $HOME/.irbrc ]
#then echo "Found .irbrc - not adding symlink"
#else echo "No .irbrc found, creating symlink"
#   ln -s irbrc $HOME/.irbrc
#fi
#if [ -e $HOME/.irbrc ]
#then echo "Found .irbrc - not adding symlink"
#else echo "No .irbrc found, creating symlink"
#   ln -s irbrc $HOME/.irbrc
#fi

for i in irbrc screenrc inputrc vimrc; do
   if [ -e $HOME/.$i ]
   then echo "Found .$i - not adding symlink"
   else echo "No .$i found - adding symlink"
      ln -s $i $HOME/.$i
   fi
done

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# We need to have autogen installed to get ctags built
sudo apt-get install autogen autoconf
#Now go for the install
git clone https://github.com/universal-ctags/ctags.git ~/build/ctags
cd ~/build/ctags
./autogen.sh && ./configure && make && sudo make install


#Stupid Ubuntu and Mint have bitmapped fonts disabled by default (!)
cd /etc/fonts/conf.d/
sudo rm /etc/fonts/conf.d/10*
sudo rm -rf 70-no-bitmaps.conf
sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
sudo dpkg-reconfigure fontconfig
