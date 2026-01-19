# abhiyan.zsh - A ZSH Prompt Theme

A lightweight Zsh prompt theme focused on a clean two-line layout with Git and virtualenv context.

Listed in the themes section of [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins).

![zsh-theme-preview](https://github.com/abhiyandhakal/abhiyan.zsh/blob/master/zsh-theme.png)

## Features

- Two-line prompt with user, host, and current directory
- Git work-tree info: branch, staged, unstaged, and untracked counts
- Bare-repo indicator with worktree count
- Python virtualenv name when active
- Right prompt shows last exit status (on error) and time

## Requirements

Your terminal should support a Nerd Font or Powerline-compatible font (for the glyphs used in the prompt). You can install a Powerline font as follows (package name varies by distro):

**Arch Linux**: `sudo pacman -S powerline-fonts`

**Debian/Ubuntu**: `sudo apt install fonts-powerline`

## Installation

Clone the repo and source the plugin file from your `~/.zshrc`:

```sh
git clone https://github.com/abhiyandhakal/abhiyan.zsh.git ~/zsh-theme
echo source ~/zsh-theme/zsh-theme.plugin.zsh >> ~/.zshrc
```
