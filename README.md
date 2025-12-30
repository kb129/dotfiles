# Dotfiles

[![Neovim Config Check](https://github.com/kb129/dotfiles/actions/workflows/nvim_test.yml/badge.svg)](https://github.com/kb129/dotfiles/actions/workflows/nvim_test.yml)

My dotfiles

## Install

Required packages:
- `brew`

```sh
$ brew install chezmoi
$ chezmoi init git@github.com:kb129/dotfiles.git
$ chezmoi apply
```

In your first launch of `vim`, some packages for vim are installed.
It takes a few minutes.

## Uninstall

```sh
$ chezmoi uninstall
```


## Brewfile

```sh
$ brew bundle --global
```

## Available dotfiles

This repository includes the dotfiles or setting files for...

- `bash`
- `zsh`
- `screen`
- `tmux`
- `vim`
- `brew`
- `Rectangle` will be installed via `brew bundle` for MacOS
