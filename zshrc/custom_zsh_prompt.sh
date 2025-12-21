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

# ============================================================
#  GLOBALS
# ============================================================

elapsed_display=""

# ============================================================
#  TIMER LOGIC (ROUNDED + COLORED)
# ============================================================

preexec() {
    timer_start=$EPOCHREALTIME
}

precmd() {
    print ""

    if [[ -n "$timer_start" ]]; then
        local now=$EPOCHREALTIME
        local elapsed_sec=$(( now - timer_start ))
        local elapsed_ms=$(( elapsed_sec * 1000 ))

        # Choose color based on time
        if (( elapsed_ms < 500 )); then
            local COLOR="%F{green}"
        elif (( elapsed_ms < 2000 )); then
            local COLOR="%F{yellow}"
        else
            local COLOR="%F{red}"
        fi

        if (( elapsed_ms >= 1000 )); then
            elapsed_display="${COLOR}$(printf "%.1f s" "$elapsed_sec")%f"
        else
            elapsed_display="${COLOR}$(printf "%.1f ms" "$elapsed_ms")%f"
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

    RPROMPT="[ ⚡ ${elapsed_display} ] ${COLOR_CYAN}[ %D{%I:%M %p} ]${COLOR_RESET}"
}

# Initial prompt
set_prompt

# Update prompt on directory change
chpwd() {
    set_prompt
}

# ============================================================
#  MY SETTINGS
# ============================================================

export IP=$(hostname -I | awk '{print $1}')
