# Zsh Terminal Setup Manual

This document describes how to set up a customized Zsh environment using Oh My Zsh and a custom prompt configuration provided in this repository.

---

## 1. Clone the Repository

Clone the repository and navigate to the Zsh configuration directory:

```bash
git clone https://github.com/scap3sh4rk/Terminal.git
cd Terminal/zshrc
```

This directory contains the following file:

* `custom_zsh_prompt.sh` — complete prompt logic and hooks

---

## 2. Install Zsh (If Not Installed)

Update package lists and install Zsh:

```bash
sudo apt update
sudo apt install -y zsh
```

Set Zsh as the default shell:

```bash
chsh -s "$(which zsh)"
```

Log out and log back in before continuing.

---

## 3. Install Oh My Zsh

Install Oh My Zsh using the official installer:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

This creates:

* `~/.oh-my-zsh`
* `~/.zshrc`

---

## 4. Install Required Oh My Zsh Plugins

Install plugins as Oh My Zsh plugins, not via manual sourcing.

### zsh-autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

---

## 5. Configure Plugins in ~/.zshrc

Edit the configuration file:

```bash
nano ~/.zshrc
```

Ensure the plugins line contains only:

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Do not manually source these plugins elsewhere.

---

## 6. Enable Completion System

Ensure the following lines exist once in ~/.zshrc:

```bash
autoload -U compinit
compinit
```

---

## 7. Apply the Custom Prompt Configuration

Append the custom prompt configuration file:

```bash
cat custom_zsh_prompt.sh >> ~/.zshrc
```

Ensure this file is appended only once to avoid duplicate prompt logic.

---

## 8. Apply Changes

Reload the configuration:

```bash
source ~/.zshrc
```

Or open a new terminal session.

---

End of document.
