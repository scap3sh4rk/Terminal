# =========================
# Author : scap3sh4rk
# github : https://github.com/scap3sh4rk
# =========================

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

source "$ZSH/oh-my-zsh.sh"

autoload -U compinit
compinit

# ============================================================
#  GLOBALS
# ============================================================

elapsed_display=""
exit_display=""
ssh_display=""
tmux_display=""
last_exit=0
timer_start=""

# ============================================================
#  TIMER + STATUS LOGIC
# ============================================================

preexec() {
    timer_start=$EPOCHREALTIME
}

precmd() {
    last_exit=$?
    print ""

    # Exit code
    if (( last_exit != 0 )); then
        exit_display="%F{red}✗ ${last_exit}%f"
    else
        exit_display=""
    fi

    # Execution time
    if [[ -n "$timer_start" ]]; then
        local now elapsed_sec elapsed_ms COLOR
        now=$EPOCHREALTIME
        elapsed_sec=$(( now - timer_start ))
        elapsed_ms=$(( elapsed_sec * 1000 ))

        if (( elapsed_ms < 500 )); then
            COLOR="%F{green}"
        elif (( elapsed_ms < 2000 )); then
            COLOR="%F{yellow}"
        else
            COLOR="%F{red}"
        fi

        if (( elapsed_ms >= 1000 )); then
            elapsed_display="${COLOR}$(printf "%.1f s" "$elapsed_sec")%f"
        else
            elapsed_display="${COLOR}$(printf "%.1f ms" "$elapsed_ms")%f"
        fi

        timer_start=""
    else
        elapsed_display=""
    fi

    # SSH indicator
    if [[ -n "$SSH_CONNECTION" ]]; then
        ssh_display="%F{cyan}⛓ hop:1%f"
    else
        ssh_display=""
    fi

    # TMUX indicator (session:window:pane)
    if [[ -n "$TMUX" ]]; then
        local tmux_info session window pane
        tmux_info=$(tmux display-message -p '#S:#I:#P' 2>/dev/null)
        if [[ -n "$tmux_info" ]]; then
            session="${tmux_info%%:*}"
            window="${tmux_info#*:}"
            window="${window%%:*}"
            pane="${tmux_info##*:}"
            session="${session:0:4}"
            tmux_display="%F{magenta}${session}:${window}:${pane}%f"
        else
            tmux_display=""
        fi
    else
        tmux_display=""
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

    local ip_address user_host dir
    ip_address=$(hostname -I | awk '{print $1}')
    user_host="${USER}@${HOST}"
    dir="${PWD}"

    PROMPT=$'┌──'"${COLOR_YELLOW} ${COLOR_RESET}${COLOR_GREEN}${user_host} ${COLOR_BLUE}on ${COLOR_YELLOW}[${ip_address}]${COLOR_RESET}"$'\n'"├──${COLOR_GREEN} ${COLOR_BLUE}${dir}${COLOR_RESET}"$'\n'"└──${COLOR_YELLOW}${COLOR_BLUE}  ${COLOR_RESET}"

    RPROMPT="${exit_display:+$exit_display  }⚡ ${elapsed_display}${tmux_display:+  $tmux_display}${ssh_display:+  $ssh_display}  ${COLOR_CYAN}%D{%I:%M %p}${COLOR_RESET}"
}

# Initial prompt
set_prompt

chpwd() {
    set_prompt
}

# ============================================================
#  MY SETTINGS
# ============================================================

export IP="$(hostname -I | awk '{print $1}')"
