# My dotfiles

This is the home of my various dev workspace configurations that collectively make up my development environment. Setup guide is included mainly to make it easier to migrate my setup to new systems, but anyone interested is welcome to reference, customize, or take these configurations for themselves.

## Overview

My workspace/dev environment consists of the following main pieces:

- MacOS
- [Alacritty](https://www.alacritty.org/)
- [Starship](https://starship.rs/)
- [Tmux](https://github.com/tmux/tmux/wiki/Getting-Started)
- [Neovim](https://neovim.io/)

# Setup

### MacOS

1.  Make sure MacOS is up to date.
2.  Download and install [Homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

If using Apple Sillicon, you may need to add Homebrew to your $PATH in .zshrc. This is necessary
since MacOS migrated to Zsh as its primary shell during the Apple Sillicon transition. Homebrew installs
and adds the path to bash, as that used to be the default.

You can add it to .zshrc path by executing the following:

```bash
export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

## Fonts

1.  I use JetBrainsMono Nerd Font
2.  Install manually via [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or via Homebrew

```bash
brew tap homebrew/cask-fonts`
brew install -cask font-jetbrains-mono-nerd-font
```

### Terminal (Alacritty)

1.  Install Alacritty via Homebrew

```bash
brew instal --cask alacritty
```

2.  Copy configuration from `configs/alacritty.toml` of this repo to `~/.alacritty.toml`
    1. This should reside in your home directory.
3.  Optional: disable font smoothing. I find that font smoothing on MacOS inside of Alacritty to be a little too fuzzy for my taste.
    - To disable: `defaults write org.alacritty AppleFontSmoothing -int 0`
    - To re-enable: `defaults delete org.alacritty AppleFontSmoothing`

### Sexy Terminal Lines (Starship)

1.  Install [Starship](https://starship.rs/)

```bash
brew instal starship
```

2. Turn it on for your shell. This will change depending on which shell you're using. For zsh, use the following:

```bash
eval "$(starship init zsh)"
```

3. If you're using another shell, consult the [Starship guide](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).
4. Move my Starship config in this repo into your `~/.config` directory:

```bash
cp configs/starship.toml ~/.config/starship.toml
```

### Code Editor (Neovim)

1.  Install Neovim via Homebrew

```bash
brew install neovim
```

2. Clone my [NvAdam](https://github.com/adamtmorgan/NvAdam) repo from Github into your `~/.config` directory or wherever you store your Neovim configuration.
3. Back up your old config, if present, and replace config with my NvAdam repo.

```bash
mv ~/.config/nvim ~/.config/nvim-bak
mv ~/.config/NvAdam ~/.config/nvim
```

5. Run `nvim` and follow instructions in the [NvAdam Readme](https://github.com/adamtmorgan/NvAdam)
6. Make sure `lazy-nvim` propery loaded plugins and that necessary LSPs are installed via `Mason`.

### Terminal Window Management (Tmux)

1.  Install Tmux via Homebrew

```bash
brew install tmux
```

2.  Copy configuration from `configs/tmux.conf` of this repo to `~/.tmux.conf`
    1. This should reside in your home directory.
3.  Open tmux by running `tmux`
4.  Press `Ctrl+Space`, which is the mapped prefix for this config, followed by `I` to install plugins.
