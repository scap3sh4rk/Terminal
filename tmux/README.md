[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](#) 
[![Kali Linux](https://img.shields.io/badge/Kali_Linux-268BEE?style=for-the-badge&logo=kali-linux&logoColor=white)](#) 
[![Tmux](https://img.shields.io/badge/Tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)](#) 
[![Terminal](https://img.shields.io/badge/Terminal-black?style=for-the-badge&logo=gnome-terminal&logoColor=white)](#) 
[![Zsh](https://img.shields.io/badge/Zsh-FFD500?style=for-the-badge&logo=gnu-bash&logoColor=black)](#) 
[![Syntax Highlighting](https://img.shields.io/badge/Syntax_Highlighting-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)](#) 
[![Terminal Plugins](https://img.shields.io/badge/Terminal_Plugins-1E90FF?style=for-the-badge&logo=plug&logoColor=white)](#) 
[![Tmux Config](https://img.shields.io/badge/Tmux_Config-2F4F4F?style=for-the-badge&logo=tmux&logoColor=white)](#) 
[![Shortcuts](https://img.shields.io/badge/Shortcuts-FFA500?style=for-the-badge&logo=shortcuts&logoColor=white)](#) 
[![Shell Script (sh)](https://img.shields.io/badge/Sh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](#) 
[![Xclip](https://img.shields.io/badge/Xclip-4682B4?style=for-the-badge&logo=clip&logoColor=white)](#)

# Manual

### Installation of `tmux` on Linux and configuring.
clone to the repository
```bash
 git clone "https://github.com/scap3sh4rk/Terminal.git" && cd terminal/tmux
```

Install tmux 
```bash
sudo apt install tmux
``` 
Install a Clipboard Integration Tool
#### Linux
```bash
# Install xclip
sudo apt install xclip  # For Ubuntu/Debian
```

copy the configuration file to home directory
```bash
cat .tmux.conf >> ~/.tmux.conf
```

Reload tmux configuration
```bash
tmux source-file ~/.tmux.conf
```
### Copying text in tmux
1. Enter copy mode: Ctrl-b [
2. Navigate and select using `space key` and,
3. Press `y` to `copy` the selection to the system clipboard.
4. Paste is as usual `ctrl + shift + v`
---
## or
### Set Tmux to Automatically Use the Clipboard
To make Tmux always copy to the system clipboard without extra bindings, use this configuration:

```bash
# Automatically use the system clipboard
set-option -g set-clipboard on
```
This tells Tmux to integrate directly with the system clipboard when copying text. Ensure your Tmux version supports this (Tmux 2.6 or newer).

## Some basic shortcuts

`<leader> = ctrl + b` will be refered to `lead` in the following context.

| **Shortcut**              | **Description**                                                                          |
|----------------------------|------------------------------------------------------------------------------------------|
| tmux new -t <session_name> | Creates a session along with the window.                                               |
| tmux kill-server         | Kills the tmux server and all associated sessions.                                       |
| `lead` new -s <session_name> | Creates a new tmux session.                                                           |
| `lead` ls                  | Lists available sessions.                                                               |
| `lead` d                  | Detaches from the current session.                                                      |
| `lead` a -t <session_name> | Attaches to the specified session.                                                      |
| `lead` ,                   | Renames the current window.                                                             |
| `lead` %                   | Splits the terminal horizontally into panes.                                            |
| `lead` "                   | Splits the terminal vertically into panes.                                              |
| `lead` q                   | Displays numbers for panes; press the number to switch to the corresponding pane.       |
| `lead` x                   | Closes the current pane.                                                                |
| `lead` c                   | Creates a new window.                                                                   |
| `lead` <arrow keys>        | Navigates between panes using arrow keys.                                               |
| `lead` n                   | Switches to the next window.                                                            |
| `lead` p                   | Switches to the previous window.                                                        |
| `lead` ]                   | Enters copy mode; use `space` to select text and `y` to copy.                           |



**Source:** [tmuxcheatsheet.com](https://tmuxcheatsheet.com/)


