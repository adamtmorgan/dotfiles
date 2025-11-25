# My dotfiles

This is the home of my various dev workspace configurations that collectively make up my development environment. Setup guide is included mainly to make it easier to migrate my setup to new systems, but anyone interested is welcome to reference or fork these configurations for themselves.

My workspace/dev environment consists of the following main pieces:

- Notable Apps (Under MacOS)
  - [Raycast](https://www.raycast.com/) - App launcher and quick-commands.
  - [Rectangle Pro](https://rectangleapp.com/pro) - Window management.
  - [Paw/RapidAPI](https://paw.cloud/) - REST/gRPC/GraphQL client.
  - [Obsidian](https://obsidian.md/) - Markdown note taking.
  - [OpenVPN Client](https://openvpn.net/client/) - VPN client.
  - [TablePlus](https://tableplus.com/) - Database client.
- CLI Setup (what this repo is mainly about):
  - [Ghostty](https://ghostty.org/) or [Wezterm](https://wezfurlong.org/wezterm/) - Terminal.
  - [Mise](https://mise.jdx.dev/getting-started.html) - Env setup.
  - [Lazygit](https://github.com/jesseduffield/lazygit) - Git client.
  - [fzf](https://github.com/junegunn/fzf) - Fuzzy search and ranking.
  - [fd](https://github.com/sharkdp/fd) - Regex File system searching.
  - [bat](https://github.com/sharkdp/bat) - cat repacement with syntax highlighting.
  - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - Pretty terminal colors.
  - [Starship](https://starship.rs/) - Fancy status line.
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Command history.
  - [Neovim](https://neovim.io/) - Text editor.
- Other notable utilities
  - [git-credential-manager](https://github.com/git-ecosystem/git-credential-manager) `brew install --cask git-credential-manager`

## MacOS

1.  Make sure MacOS is up to date.
2.  Download and install [Homebrew](https://brew.sh/)
3.  Download and install [Mise](https://mise.jdx.dev/installing-mise.html). Can be done via homebrew or curl.

```bash
$ curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
$ curl https://mise.run | sh
```

### Hoembrew troubleshooting

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

### Mise-managed CLIs

The mise global config manages most of the CLIs here. Calling `mise install` will
install all of these CLIs in one go.

```bash
$ mise install
```

## Fonts

1.  I use JetBrainsMono Nerd Font
2.  Install manually via [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or via Homebrew

```bash
$ brew tap homebrew/cask-fonts
$ brew install -cask font-jetbrains-mono-nerd-font
```

## Terminal (Ghostty or Wezterm)

No, I don't use Tmux... It's slow.

1.  Install Ghostty or Wezterm via Homebrew

```bash
# For Ghostty
$ brew install --cask ghostty
# For Wezterm
$ brew install --cask wezterm

```

2. Link or copy configuration or run my [disperse script](#Scripts).

```bash
# For Ghostty
$ ln -s configs/ghostty ~/Library/Application\ Support/com.mitchellh.ghostty/config

# For Wezterm
$ ln -s configs/wezterm ~/.config/wezterm

```

## fd + fzf - file and directory searching

`fd` is a very fast alternative to `find`. `fzf` will fuzzy-find in those results and rank them.

Installed via `mise`. Once installed, add the following to your `.zshrc` file...

```bash
[ -f [path-to-repo]/configs/fzf_zsh.sh ] && source [path-to-repo]/configs/fzf_zsh.sh
```
... and then either restart your terminal or run `source ~/.zshrc`.

Once this is done, you should have access to the `ff` function for searching files in the CWD, and `ffd` function for
searching directories. These are custom functions that I (with help from ChatGPT) put together to pipe `fd` results into
the `fzf` view, giving us the best of both worlds.

## Lazygit (Git client)

Lazygit is my Git client of choice. Great for quick commits, diffing, etc.
[View the readme](https://github.com/jesseduffield/lazygit/blob/master/README.md) for usage.

Installed via `mise`.

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

Installed via `mise`. Once installed:

1. Turn it on for your shell. This will change depending on which shell you're using. For zsh, add the following to the END of your `~/.zshrc` file. If not at the end, `ohmyzsh` will overwrite your power line:

```bash [.zshrc]
# https://github.com/starship/starship/issues/560
precmd() { precmd() { echo "" } }
alias clear="precmd() { precmd() { echo } } && clear"
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

## Other misc. CLI tools

### bat

`bat` is a `cat` replacement that has syntax highlighting and other modern features. This is used to 
preview files inside of fzf and can also be used directly if peeking into files.

Installed via `mise`. Once installed:

1. Link or move the config in this repo into your `~/.config` directory or run my [disperse script](#Scripts):
```bash
$ ln -s configs/bat ~/.config/bat
```

2. Build the bat cache. This will tell bat to use the kanagawa theme included with this config.
```bash
$ bat cache --build
```

## Code Editor (Neovim)

Installed via `mise`. Once installed:

1. Clone my [NvStache](https://github.com/adamtmorgan/NvStache) repo from Github into your `~/.config` directory or wherever you store your Neovim configuration.
2. Back up your old config, if present, and replace config directly with my NvStache repo or link it from a custom location.

```bash [link]
$ mv ~/.config/nvim ~/.config/nvim-bak
$ ln -s [path-to-nvstache-config-dir] ~/.config/nvim
```

3. Run `nvim` and follow instructions in the [NvStache Readme](https://github.com/adamtmorgan/NvStache)
4. Make sure `lazy-nvim` propery loaded plugins and that necessary LSPs are installed via `Mason`.

## Scripts

To speed up installs, I wrote a simple bash script to symlink configs to their default locations from the directory of this repo. This way you can manage dotfiles in a single space and changes will be updated automatically when updating.
To create symlinks for all configs in this repo, run the following:

```bash
$ bash disperse.sh
```

## Usage and Workflow

My workflow revolves largely around using Ghostty or Wezterm for tab and split management. Most shortcuts are default, except for the following:

Ghostty:

1. Split vertical - `Cmd+d`
2. Split horizontal - `Cmd+D`
3. Navigate left pane - `Cmd+shift+h`
4. Navigate right pane - `Cmd+shift+l`
5. Navigate up pane - `Cmd+shift+k`
6. Navigate down pane - `Cmd+shift+j`
7. Focus/Zoom pane - `Cmd+shift+f`

Wezterm (leader = `Ctrl+Space`):

1. Split vertical - `Cmd+|`
2. Split horizontal - `Cmd+-`
3. Navigate horizontal pane - `Cmd+h`-`Cmd+l`
4. Navigate vertical pane - `Cmd+k`-`Cmd+j`
5. Resize Vertical = `Cmd+shift+k`-`Cmd+shift+j`
6. Resize Horizontal = `Cmd+shift+h`-`Cmd+shift+l`
7. Focus/Zoom pane - `Cmd+shift+f`
8. Hide Wezterm - `<leader>h`

## Code Editing in Neovim

See [my Neovim config](https://github.com/adamtmorgan/NvStache) for details on custom Neovim bindings and workflow.
