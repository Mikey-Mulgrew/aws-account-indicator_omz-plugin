# aws-account-indicator plugin

# AWS Account prompt flag for OMZ plugin (Powerlevel10k compatible)

function aws_account_indicator_prompt_segment() {
    if [[ -n $AWS_ACCOUNT_ID && -n $AWS_ACCOUNT_ALIAS && -n $AWS_SESSION_EXPIRATION ]]; then
        local last_command=$(tail -n 1 ~/.zsh_history | cut -d ";" -f2)
        if [[ $last_command == *"-mfa"* || $IS_MFA == 1 ]]; then 
            AWS_ACCOUNT_INDICATOR_PROMPT="%B%F{208}[$AWS_ACCOUNT_ALIAS -mfa]%f%b"
            IS_MFA=1;
        else
            AWS_ACCOUNT_INDICATOR_PROMPT="%B%F{yellow}[$AWS_ACCOUNT_ALIAS]%f%b"
        fi
        # Calculate expiration
        export AWS_ACCOUNT_INDICATOR_EXPIRATION_UNIX=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%S" ${AWS_SESSION_EXPIRATION%%.*} "+%s" 2>/dev/null)
        # If expired, clear the segment
        if [[ -n $AWS_ACCOUNT_INDICATOR_EXPIRATION_UNIX && $(TZ=UTC date +%s) -ge $AWS_ACCOUNT_INDICATOR_EXPIRATION_UNIX ]]; then
            unset AWS_ACCOUNT_INDICATOR_PROMPT
            IS_MFA=0
        fi
    else
        unset AWS_ACCOUNT_INDICATOR_PROMPT
        IS_MFA=0
    fi
}

# Register the hook (only once)
if ! [[ "$(add-zsh-hook -L precmd)" == *aws_account_indicator_prompt_segment* ]]; then
    add-zsh-hook precmd aws_account_indicator_prompt_segment
fi