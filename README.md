# Dotfiles

My dotfiles

## Install

`install.sh` links setting files in `dotfiles` into your home directory.
So, **DO NOT** delete cloned folder.

`zprezto` is automatically installed after running `install.sh`.



The installation will complete with just typing the following command.

```sh
$ cd dotfiles
$ ./install.sh
```

In your first launch of `vim`, some packages for vim are installed.
It takes a few minutes.

## Uninstall

`uninstall.sh` unlinks dotfiles in your home directory.

```sh
$ ./uninstall.sh
```

## Brewfile

```plaintext
$ brew bundle --global
```

## Available dotfiles

This repository includes the dotfiles or setting files for...

- `bash`
- `zsh`
- `zprezto` will be installed via `install.sh`
- `screen`
- `tmux`
- `vim`
- `brew`
- `Terminal` for MacOS
- `Rectangle` will be installed via `brew bundle` for MacOS
- `i3wm` for linux