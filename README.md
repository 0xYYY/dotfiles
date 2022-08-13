# dotfiles

```
brew isntall stow
git clone dotfiles .dotfiles
cd .dotfiles && stow $(ls -d */) && cd ~
```

# oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mv .zshrc.pre-oh-my-zsh .zshrc
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```

# Tmux

```
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
bash $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
```

# `homebrew`

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

# Rust

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
sh rustup.sh --verbose -y --no-modify-path
rm rustup.sh
$HOME/.cargo/bin/rustup component add rust-src
$HOME/.cargo/bin/rustup toolchain install nightly
cargo install sccache
```

# Python

```
curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest | tar -xvj bin/micromamba
mv bin/micromamba $HOME/.local/micromamba
mamba install -n base python=3.10 --yes
```

# NodeJS

```
curl https://get.volta.sh | bash -s -- --skip-setup
```

# Solidity

```
pip install solc-select
solc-select install $(solc-select install | tail -1)
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

# Terminal

## Basic Dependencies

```
xcode-select --install
```

## `wezterm`

### Font

```
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

# Command Line Tools

## Utilities

```
brew install gh tmux glow jq
```

## 🦀 Rust

I like to explore CLI tools implemented in Rust, since

1. they are often faster and more user-friendly after the re-implementation
2. I would like to contribute to open-source Rust projects, and these tools give me a lot of great starting points.

### List

atuin bat bottom choose exa fd-find git-delta gitui jless pueue procs ripgrep sd starship tokei tuc xsv zoxide xcp dua-cli skim hexyl heh xh fnm volta rnr rm-improved huniq jql just

## Just for Fun!

```
brew install cmatrix figlet lolcat nyancat
filget hello, world\! | lolcat
```

# NeoVim

```
brew install --HEAD neovim
mamba install pynvim
yarn install neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    .local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -u .config/nvim/packer_install.lua > /dev/null 2>&1
brew install rust-analyzer shfmt stylua shellcheck shfmt
mamba install black
yarn global add prettier prettier-plugin-solidity typescript typescript-language-server
```

## UI/UX

Rectengle BetterDisplay AltTab
