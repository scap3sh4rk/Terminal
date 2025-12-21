# ============================================================
#  ZSH / OH-MY-ZSH BASE
# ============================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

autoload -U compinit
compinit

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ============================================================
#  GLOBALS
# ============================================================

elapsed_display=""

# ============================================================
#  TIMER LOGIC (ROUNDED + CLEAN)
# ============================================================

preexec() {
#    __COMMAND_RAN=1
    timer_start=$EPOCHREALTIME
}


precmd() {
    print ""

    if [[ -n "$timer_start" ]]; then
        local now=$EPOCHREALTIME
        local elapsed_sec=$(( now - timer_start ))
        local elapsed_ms=$(( elapsed_sec * 1000 ))

        if (( elapsed_ms >= 1000 )); then
            # Show seconds, 1 decimal
            elapsed_display="$(printf "%.1f s" "$elapsed_sec")"
        else
            # Show milliseconds, 1 decimal
            elapsed_display="$(printf "%.1f ms" "$elapsed_ms")"
        fi

        unset timer_start
    else
        elapsed_display=""
    fi

    set_prompt
}




# ============================================================
#  PROMPT
# ============================================================

set_prompt() {
    local COLOR_BLUE="%F{blue}"
    local COLOR_GREEN="%F{green}"
    local COLOR_YELLOW="%F{yellow}"
    local COLOR_CYAN="%F{cyan}"
    local COLOR_RESET="%f"

    local ip_address=$(hostname -I | awk '{print $1}')
    local user_host="${USER}@${HOST}"
    local dir=$(pwd)

    local hacker=$(printf '\uf21b')

    PROMPT="┌──${COLOR_YELLOW}${hacker} ${COLOR_RESET}${COLOR_GREEN}${user_host} ${COLOR_BLUE}on ${COLOR_YELLOW}[${ip_address}]${COLOR_RESET}
├──${COLOR_GREEN} ${COLOR_BLUE}${dir}${COLOR_RESET}
└──${COLOR_YELLOW} ${COLOR_RESET} "

    RPROMPT="[ ⚡${elapsed_display} ] ${COLOR_CYAN}[ %D{%I:%M %p} ]${COLOR_RESET}"
}

# Initial prompt
set_prompt

# Update prompt on directory change
chpwd() {
    set_prompt
}

# ============================================================
#  My Settings and Aliases
# ============================================================
export IP=$(hostname -I | awk '{print $1}')
