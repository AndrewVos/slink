# dotfile-symlinker

Helps to symlink dotfiles that may be stored somewhere else.

## Usage

Rename your directories and files with the extension .symlink
and they will automatically be symlinked to your home directory
when you run ```./symlink```.

# Examples
    ssh/.ssh/config.symlink        => ~/.ssh/config
    i3/.i3.symlink                 => ~/.i3
    vimfiles/.vim.symlink          => ~/.vim
    vimfiles/.vimrc.symlink        => ~/.vimrc
