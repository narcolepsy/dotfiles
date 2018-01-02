#Install ruby-dev to ensure we get the interactive editor/awesome_print dependencies installed
#sudo apt-get install ruby-dev
#Install gems for colourised irbrc
#gem install interactive_editor awesome_print


#Now symlink all the dotfiles into place, backing up existing ones (if a genuine file and not already a symlink to the destination!)
if [ -e $HOME/.irbrc ]
then echo "Found .irbrc - not adding symlink"
else echo "No .irbrc found, creating symlink"
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

git clone https://github.com/universal-ctags/ctags.git ~/build/ctags
# We need to have autogen installed to get ctags built
sudo apt-get install autogen autoconf
#Now go for the install
cd ~/build/ctags
./autogen.sh && ./configure && make && sudo make install


