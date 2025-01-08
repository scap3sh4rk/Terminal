
## MANUAL
clone to the repository
```bash
 git clone "https://github.com/scap3sh4rk/Terminal.git" && cd Terminal/zshrc
```

Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```
After installation, add the following plugins in the ~/.zshrc file to enhance autocompletion:
```bash
echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc

```
Add the following lines to your .zshrc file:
```bash
echo "# Enable command auto-completion
autoload -U compinit
compinit" >> ~/.zshrc
```
- Make sure to install the zsh-autosuggestions and zsh-syntax-highlighting plugins if you haven't done so
Install zsh-autosuggestions:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

```
Install zsh-syntax-highlighting:
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

```
edit the zshrc.
```bash
cat custom_zsh_prompt.sh >> ~/.zshrc
```
Apply changes

```bash
source ~/.zshrc

```
