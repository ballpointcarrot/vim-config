# To Install

Vim:
  Symlink the init.vim within this repository as follows:
  cd /path/to/repo/init.vim ~/.vimrc

Nvim:
  Symlink the init.vim within this repository as follows:
  cd /path/to/repo/init.vim ~/$XDG\_CONFIG\_HOME/nvim/init.vim

Launch your editor. On the first run, there may be an error about a missing colorscheme.
Once started, run the command :PlugInstall, and let the installation run. Restart your editor.
Have fun with the new scripts. :D

# Updating

For plugin updates, simply run :PlugUpdate in the editor to update to the latest versions of those plugins.

For vimrc updates, just run `git pull` in the repository to receive any updates from the remote side.
