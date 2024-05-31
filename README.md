# My dotfiles

This is the home of my various dev workspace configurations that collectively make up my development environment. Setup guide is included mainly to make it easier to migrate my setup to new systems, but anyone interested is welcome to reference, customize, or take these configurations for themselves.

My workspace/dev environment consists of the following main pieces:

- Notable Apps (Under MacOS)
  - [Raycast](https://www.raycast.com/) - App launcher and quick-commands.
  - [Rectangle Pro](https://rectangleapp.com/pro) - Window management.
  - [Sublime Merge](https://www.sublimemerge.com/) - Git client.
  - [Paw/RapidAPI](https://paw.cloud/) - REST/gRPC/GraphQL client.
  - [Obsidian](https://obsidian.md/) - Markdown note taking.
  - [OpenVPN Client](https://openvpn.net/client/) - VPN client.
  - [TablePlus](https://tableplus.com/) - Database client.
  - [DataGrip](https://www.jetbrains.com/datagrip/?var=light) - Database client
- CLI Setup (what this repo is all about):
  - [Alacritty](https://www.alacritty.org/)
  - [Starship](https://starship.rs/)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [Tmux](https://github.com/tmux/tmux/wiki/Getting-Started)
  - [Neovim](https://neovim.io/)
- Other notable utilities
  - [git-credential-manager](https://github.com/git-ecosystem/git-credential-manager) `brew install --cask git-credential-manager`

# MacOS

1.  Make sure MacOS is up to date.
2.  Download and install [Homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

If using Apple Silicon, you may need to add Homebrew to your $PATH in .zshrc. This is necessary
since MacOS migrated to Zsh as its primary shell during the Apple Silicon transition. Homebrew installs
and adds the path to bash, as that used to be the default.

You can add it to .zshrc path by executing the following:

```bash
export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

# Fonts

1.  I use JetBrainsMono Nerd Font
2.  Install manually via [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or via Homebrew

```bash
brew tap homebrew/cask-fonts
brew install -cask font-jetbrains-mono-nerd-font
```

# Terminal (Alacritty)

1.  Install Alacritty via Homebrew

```bash
brew instal --cask alacritty
```

2.  Copy configuration from `configs/alacritty.toml` of this repo to `~/.alacritty.toml` or run my [disperse script](#Scripts).

```bash
cp configs/tmux.conf ~/.tmux.conf
```

3.  Optional: disable font smoothing. I find that font smoothing on MacOS inside of Alacritty to be a little too fuzzy for my taste.
    - To disable: `defaults write org.alacritty AppleFontSmoothing -int 0`
    - To re-enable: `defaults delete org.alacritty AppleFontSmoothing`

# Sexy Terminal Lines (Starship)

1.  Install [Starship](https://starship.rs/)

```bash
brew instal starship
```

2. Turn it on for your shell. This will change depending on which shell you're using. For zsh, add the following to your `~/.zshrc` file:

```bash
eval "$(starship init zsh)"
```

3. If you're using another shell, consult the [Starship guide](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).
4. Move my Starship config in this repo into your `~/.config` directory or run my [disperse script](#Scripts):

```bash
cp configs/starship.toml ~/.config/starship.toml
```

# Shell Auto Suggestions

1. Install via homebrew

```bash
brew install zsh-autosuggestions
```

2. Add the following to your .zshrc file (most likely in `~`)

```bash
# Use zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Bind "Ctrl+f" to accept a suggestion.
bindkey '^f' autosuggest-accept
```

3. Once added, you should see suggestions based on command history. To accept a suggestion, hit the right arrow key or `Ctl+f`.

# Code Editor (Neovim)

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

# Terminal Window Management (Tmux)

1.  Install Tmux via Homebrew

```bash
brew install tmux
```

2. Install [TPM](https://github.com/tmux-plugins/tpm). This will manage our Tmux plugins. Clone the repo by running the following:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

3.  Copy configuration from `configs/tmux.conf` of this repo to `~/.tmux.conf` or run my [disperse script](#Scripts).
    - This should reside in your home directory.

```bash
cp configs/tmux.conf ~/.tmux.conf
```

3.  Open tmux by running `tmux`
4.  Press `Ctrl+Space`, which is the mapped `<prefix>` for this config, followed by `I` to install plugins.
5.  Press `<prefix>+r` to reload Tmux.

# Scripts

To make it easier to update configs, I wrote simple bash scripts to collect and disperse configs to their default locations. If you're sick and tired of manually moving configs every update, this should make it much easier.

To copy the repo's configs to their default locations, run the following:

```bash
bash disperse.sh
```

# Usage and Workflow

My workflow revolves largely around using Tmux for window management and resurrection features. I don't really prefer to split terminal windows - the only time I do that is during coding, which I let Neovim handle.

## Tmux Keybindings

- `<C>space` - Prefix/Leader
- `<prefix> + c` - Create window
- `<prefix> + l` - Next window
- `<prefix> + h` - Previous window
- `<prefix> + <C>s` - Save session
- `<prefix> + <C>r` - Resurrect session

Everything else should be default.

## Code Editing in Neovim

See [my Neovim config](https://github.com/adamtmorgan/NvAdam) for details on custom Neovim bindings and workflow.
