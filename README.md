# slink

Helps to symlink dotfiles that may be stored somewhere else.

## Installation

### From binaries:

#### 64 bit

```
wget https://raw.githubusercontent.com/AndrewVos/slink/master/bin/64/slink
chmod +x slink
sudo mv slink /usr/local/bin
```

#### 32 bit

```
wget https://raw.githubusercontent.com/AndrewVos/slink/master/bin/32/slink
chmod +x slink
sudo mv slink /usr/local/bin
```

### From Source:

First, you need to install [nim](http://nim-lang.org/download.html).

Then:

```
git clone https://github.com/AndrewVos/slink
cd slink
nim compile -d:release
sudo mv slink /usr/local/bin
```

## Usage

Rename your directories and files with the extension .symlink
and they will automatically be symlinked to your home directory
when you run ```./symlink```.

# Examples
    ssh/.ssh/config.symlink        => ~/.ssh/config
    i3/.i3.symlink                 => ~/.i3
    vimfiles/.vim.symlink          => ~/.vim
    vimfiles/.vimrc.symlink        => ~/.vimrc
