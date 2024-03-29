# dotfiles

![banner](images/banner.png)

This repo currently only contains dotfiles for Mac setup, may update for other OS, e.g. ArchLinux,
in the future.

-   [CLI Tools](#cli-tools)
-   [System Info](#system-info)
-   [Dotfiles](#dotfiles-1)
-   [Terminal](#terminal)
    -   [WezTerm](#wezterm)
    -   [Oh My Zsh](#oh-my-zsh)
    -   [Tmux](#tmux)
-   [Programming Languages](#programming-languages)
    -   [Rust](#rust)
    -   [Python](#python)
    -   [NodeJS](#nodejs)
    -   [Solidity](#solidity)
-   [NeoVim](#neovim)
-   [Mac UI/UX](#mac-uiux)

## CLI

### Setup

Install `Xcode Command Line Tools` and [`Homebrew`](https://brew.sh).

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### CLI Tools

```bash
brew install asciinema direnv gh glow jq tmux yq

# nix
sh <(curl -L https://nixos.org/nix/install)

# gh extensions
gh extension install dlvhdr/gh-dash
gh extension install seachicken/gh-poi
gh extension install gh-markdown-preview

# just for fun!
brew install cmatrix figlet lolcat nyanca
figlet hello, world\! | lolcat
```

More CLI tools can be found in the [Rust section](#more-cli-tools-in-rust).

### System Info

```bash
brew install neofetch
neofetch
```

![neofetch](images/neofetch.png)

## Dotfiles

Clone this repo and use `stow` to link the config files to their respective locations.

```bash
brew install stow
git clone https://github.com/0xYYY/dotfiles .dotfiles
cd .dotfiles && stow $(ls -d */ | grep -v 'images\|cargo') && cd ~
```

## Terminal

### WezTerm

My terminal of choice is [WezTerm](https://wezfurlong.org/wezterm/), for it's rich features, ease of
configuration, and support for tabs and ligature (which
[Alacritty](https://github.com/alacritty/alacritty/issues/50) lacks).

```bash
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font font-codicon
```

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
    --unattended
mv .zshrc.pre-oh-my-zsh .zshrc
git clone https://github.com/zsh-users/zsh-completions \
    ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/jeffreytse/zsh-vi-mode \
    ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-vi-mode
```

### Tmux

```bash
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
bash $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
```

![terminal](images/terminal.png)

## Programming Languages

### Rust

Install Rust and [`sccache`](https://github.com/mozilla/sccache) for faster compilation.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --verbose -y --no-modify-path
rustup component add rust-src
rustup toolchain install nightly
cargo install sccache cargo-binstall cargo-update
cd .dotfiles && stow cargo && cd ~
```

#### More CLI Tools in Rust

I like to explore CLI tools implemented in Rust, since

1. they are often faster and more user-friendly after the re-implementation, and
2. I would like to contribute to open-source Rust projects, and these tools give me a lot of great
   starting points.

```bash
cargo bi atuin bat bottom cargo-nextest choose dua-cli exa fd-find git-delta gitui gping heh hexyl \
    huniq hyperfine jless jql just macchina mdcat ouch procs pueue ripgrep rm-improved rnr rustcat \
    sd skim starship tokei tuc watchexec-cli xcp xh xsv zoxide
```

### Python

Install Python and [Mamba](https://mamba.readthedocs.io/en/latest/index.html) for package
management, [Poetry](https://python-poetry.org/) for project management.

```bash
curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest | tar -xvj bin/micromamba
mkdir -p $HOME/.local/bin && mv bin/micromamba $HOME/.local/bin && rm -r bin
mamba install -n base python=3.10 ipython --yes
curl -sSL https://install.python-poetry.org | POETRY_HOME=$HOME/.poetry python -
```

### NodeJS

Install NodeJS and [Volta](https://volta.sh) for tool management.

```bash
curl https://get.volta.sh | bash -s -- --skip-setup
volta install node
volta install yarn
```

### Go

Install Go and [`goenv`](https://github.com/syndbg/goenv) for version management.

```bash
git clone https://github.com/syndbg/goenv.git ~/.goenv
latest=$(goenv install -l | rg -v '(beta|rc)' | tail -1 | tr -d ' ')
goenv install $latest && goenv global $latest
unset latest
```

### Solidity

Install Solidity and [solc-select](https://github.com/crytic/solc-select) for version management.

```bash
pip install solc-select
solc-select install $(solc-select install | tail -1)
curl -L https://foundry.paradigm.xyz | bash
fup
```

## NeoVim

### Setup

I'm using the nightly version of NeoVim (for `winbar` support, requires `neovim >= 0.8`) and
[`packer`](https://github.com/wbthomason/packer.nvim) for plugin management.

```bash
brew install --HEAD neovim
pip install pynvim
yarn global add neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 .local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -u .config/nvim/packer_install.lua > /dev/null 2>&1
```

### LSP Tools

```bash
brew install golangci-lint lua-language-server rust-analyzer shfmt shellharden stylua
mamba install black mypy ruff
yarn global add bash-language-server prettier prettier-plugin-solidity pyright \
    solidity-language-server typescript typescript-language-server
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
```

### Plugins

The list of plugins can be found [here](neovim/.config/nvim/lua/settings/plugins.lua).

![neovim](images/neovim.png)

## Mac UI/UX

Not actually part of the dotfiles, but useful applications for improving Mac UI/UX.

-   [AltTab](https://alt-tab-macos.netlify.app)
-   [BetterDisplay](https://github.com/waydabber/BetterDisplay#readme)
-   [BetterTouchTool](https://folivora.ai)
-   [DisplayPlacer](https://github.com/jakehilborn/displayplacer)
-   [Moom](https://manytricks.com/moom/)
-   [Phoenix](https://github.com/kasper/phoenix)
-   [Raycast](https://www.raycast.com)
-   [Rectengle](https://rectangleapp.com)
-   [Vimari](https://github.com/televator-apps/vimari)

## License

Dual licensed under either [MIT License](./LICENSE-MIT) or [Apache License, Version 2.0](./LICENSE-APACHE).
