# dotfiles

## 1. Requirements

- make

## 2. Installation

### 2.1. WSL2 (Ubuntu)

1. Install Alacritty.
    - `winget install Alacritty.Alacritty`
1. Install WSL2.
    - cf. [WSL2 のセットアップ | i9wa4’s blog](https://i9wa4.github.io/blog/2024/03/25/setup-wsl2.html)
1. Execute `make wsl2`.
1. Install VS Code extension "Remote Development".
    - cf. [WSL で VS Code の使用を開始する | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-vscode)

### 2.2. Ubuntu

1. Install Alacritty.
    - cf. [alacritty/INSTALL.md at master · alacritty/alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu)
1. Execute `make ubuntu`.

### 2.3. Mac

1. Execute `make mac`.
