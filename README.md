# My dotfiles

This is the home of my various dev workspace configurations that collectively make up my development environment. Setup guide is included mainly to make it easier to migrate my setup to new systems, but anyone interested is welcome to reference or fork these configurations for themselves.

My workspace/dev environment consists of the following main pieces:

- Notable Apps (Under MacOS)
  - [Raycast](https://www.raycast.com/) - App launcher and quick-commands.
  - [Rectangle Pro](https://rectangleapp.com/pro) - Window management.
  - [Sublime Merge](https://www.sublimemerge.com/) - Git client.
  - [Paw/RapidAPI](https://paw.cloud/) - REST/gRPC/GraphQL client.
  - [Obsidian](https://obsidian.md/) - Markdown note taking.
  - [OpenVPN Client](https://openvpn.net/client/) - VPN client.
  - [TablePlus](https://tableplus.com/) - Database client.
- CLI Setup (what this repo is mainly about):
  - [Wezterm](https://wezfurlong.org/wezterm/)
  - [fzf](https://github.com/junegunn/fzf)
  - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
  - [Starship](https://starship.rs/)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [Neovim](https://neovim.io/)
- Other notable utilities
  - [git-credential-manager](https://github.com/git-ecosystem/git-credential-manager) `brew install --cask git-credential-manager`

## MacOS

1.  Make sure MacOS is up to date.
2.  Download and install [Homebrew](https://brew.sh/)

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

If using Apple Silicon, you may need to add Homebrew to your $PATH in .zshrc. This is necessary
since MacOS migrated to Zsh as its primary shell during the Apple Silicon transition. Homebrew installs
and adds the path to bash, as that used to be the default.

You can add it to .zshrc path by executing the following:

```bash
$ export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

If things still aren't working, try adding the following to your `.zprofile` file:

```bash
$ eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Fonts

1.  I use JetBrainsMono Nerd Font
2.  Install manually via [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or via Homebrew

```bash
$ brew tap homebrew/cask-fonts
$ brew install -cask font-jetbrains-mono-nerd-font
```

## Terminal (Wezterm)

I used to use Alacritty + Tmux, but noticed some pretty significant latency when working in NeoVim with this combo. Switching to Wezterm and using its built-in tabs and window splits has sped things up for me considerably. I do miss some Tmux perks, but ultimately the additional performance overhead wasn't worth it to me.

1.  Install Wezterm via Homebrew

```bash
$ brew instal --cask wezterm
```

2. Link or copy configuration from `configs/wezterm.lua` of this repo to `~/.wezterm.lua` or run my [disperse script](#Scripts).

```bash [link.sh]
$ ln -s configs/wezterm.lua ~/.wezterm.lua
```

3. Tab renaming. Wezterm provides a CLI command for this, but it's a bit wordy for my taste. I instead recommend creating a function in your `.zshrc` file to make this faster.

```bash [.zshrc]
$ rename-tab() {
$   wezterm cli set-tab-title "$1"
$ }
```

With this done, you can now rename a tab by running `rename-tab [tab-name]`.

## fzf - file and directory searching

fzf is for fuzzy file-system searching.

```bash
$ brew install fzf
```

Then add the following to your `.zshrc` file...

```bash
[ -f [path-to-repo]/configs/fzf_zsh.sh ] && source [path-to-repo]/configs/fzf_zsh.sh
```

... and then either restart your terminal or run `source ~/.zshrc`.

Once this is done, you should have access to the `ff` function, which will open fzf and
allow you to search the CWD for files and directories.

## Oh My Zsh (zsh themes)

1.  Install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

```bash
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Pick your theme from [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) and add it to your `~/.zshrc` file:

```bash [.zshrc]
ZSH_THEME="gallois"
```

## Sexy Terminal Lines (Starship)

1.  Install [Starship](https://starship.rs/)

```bash
$ brew instal starship
```

2. Turn it on for your shell. This will change depending on which shell you're using. For zsh, add the following to the END of your `~/.zshrc` file. If not at the end, `ohmyzsh` will overwrite your power line:

```bash [.zshrc]
eval "$(starship init zsh)"
```

3. If you're using another shell, consult the [Starship guide](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).
4. Link or move my Starship config in this repo into your `~/.config` directory or run my [disperse script](#Scripts):

```bash [link]
ln -s configs/starship.toml ~/.config/starship.toml
```

## Shell Auto Suggestions

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

## Code Editor (Neovim)

1.  Install Neovim via Homebrew

```bash
$ brew install neovim
```

2. Clone my [NvStache](https://github.com/adamtmorgan/NvStache) repo from Github into your `~/.config` directory or wherever you store your Neovim configuration.
3. Back up your old config, if present, and replace config directly with my NvStache repo or link it from a custom location.

```bash [link]
$ mv ~/.config/nvim ~/.config/nvim-bak
$ ln -s [path-to-nvstache-config-dir] ~/.config/nvim
```

5. Run `nvim` and follow instructions in the [NvStache Readme](https://github.com/adamtmorgan/NvStache)
6. Make sure `lazy-nvim` propery loaded plugins and that necessary LSPs are installed via `Mason`.

## Scripts

To speed up installs, I wrote a simple bash script to symlink configs to their default locations from the directory of this repo. This way you can manage dotfiles in a single space and changes will be updated automatically when updating.
To create symlinks for all configs in this repo, run the following:

```bash
$ bash disperse.sh
```

## Usage and Workflow

My workflow revolves largely around using Wezterm for tab and split management. Most shortcuts are default, except for the following:

1. Split vertical - `Cmd+Shift+|`
2. Navigate left pane - `Cmd+Shift+h`
3. Navigate right pane - `Cmd+Shift+l`
4. Move Tab Left - `Cmd+Shift+(`
5. Move Tab Right - `Cmd+Shift+)`

## Code Editing in Neovim

See [my Neovim config](https://github.com/adamtmorgan/NvStache) for details on custom Neovim bindings and workflow.
