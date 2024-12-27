################################################################ CUSTOM THEME https://github.com/parthivkumarnikku #################################################
# Global variable to store elapsed time display
elapsed_display=""

# Function to calculate and display the time taken after the command finishes
precmd() {
	echo
    if [ -n "$timer_start" ]; then
        timer_end=$(date +%s%N)
        elapsed=$(( (timer_end - timer_start) / 1000000 ))  # Calculate elapsed time in milliseconds
        if [ "$elapsed" -ge 1000 ]; then
            elapsed_display="${elapsed}ms"  # Display time in milliseconds
        else
            elapsed_display="${elapsed}ms"  # Display time in milliseconds
        fi
    else
        elapsed_display=""  # Reset elapsed_display if timer_start is not set
    fi

    # Set the prompt
    set_prompt

    # Ensure the existing 'precmd' functionality is kept
    print -Pnr -- "$TERM_TITLE"

    if [ "$new_line_before_prompt" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# Function to set the prompt
set_prompt() {
    # Define color variables for easy customization
    local COLOR_BLUE="%F{blue}"
    local COLOR_GREEN="%F{green}"
    local COLOR_RED="%F{red}"
    local COLOR_YELLOW="%F{yellow}"
    local COLOR_CYAN="%F{cyan}"
    local COLOR_RESET="%f"

    # Get the current IP address
    local ip_address=$(hostname -I | awk '{print $1}')
    # Get the username and hostname
    local user_host="${USER}@${HOST}"
    # Get the current directory
    local dir=$(pwd)
    kali=$(printf '\uf327')
    hacker=$(printf '\uf21b')

    # Customize your prompt to enhance separation between elements
    PROMPT="┌──${COLOR_YELLOW}${hacker} ${COLOR_RESET}${COLOR_GREEN}${user_host} ${COLOR_BLUE}on ${COLOR_YELLOW}[${ip_address}]${COLOR_RESET} $
├──${COLOR_GREEN} ${COLOR_BLUE}${dir}${COLOR_RESET}
└──${COLOR_RED}${kali} ${COLOR_RESET} "  # Changed the prompt icon to arrows ❯❯❯

    # Set the time in 12-hour format with AM/PM on the right side of the prompt
    RPROMPT="[ ⚡${elapsed_display} ] ${COLOR_CYAN}[ %D{%I:%M %p} ]${COLOR_RESET}"

}

# Call the function to set the prompt initially
set_prompt

# Automatically update the prompt when changing directories
chpwd() {
    set_prompt
}

# Start the timer at the beginning of the command
preexec() {
    timer_start=$(date +%s%N)  # Start the timer in nanoseconds
}

# Reset the timer when a command is interrupted
function reset_timer {
    unset timer_start
    elapsed_display=""
}

# Bind the reset function to interrupt signals (Ctrl+C, etc.)
#trap reset_timer INT

