# abhiyan.zsh - A ZSH Prompt Theme

This is custom zsh theme that I created when looking for minimalism, away from [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh), which is a great project, but a bloat in my opinion.

![zsh-theme-preview](https://github.com/abhiyandhakal/abhiyan.zsh/blob/master/zsh-theme.png)

## Requirements

Your terminal should support [powerline fonts](https://github.com/powerline/fonts). You can install the package as follows (the exact name of the package varies from distro to distro):

**ArchLinux**: sudo pacman -S powerline-fonts
**Debian/Ubuntu**: sudo apt install fonts-powerline

## Installation

You just need to clone it in a directory, and then source `zsh-theme.plugin.zsh`. For example,
```
git clone https://github.com/abhiyandhakal/abhiyan.zsh.git ~/zsh-theme
echo source ~/zsh-theme/zsh-theme.plugin.zsh >> ~/.zshrc
```

## Git Features
1. Git Branch
2. Staged Files Count
3. Unstaged Files Count
4. Untracked Files Count
