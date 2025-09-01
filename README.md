# aws-account-indicator_omz-plugin

A [Oh My Zsh](https://ohmyz.sh/) / [p10k](https://github.com/romkatv/powerlevel10k) plugin to highlight the current AWS account for which you have credentials.

## Manual Installation

1. Move `aws-account-indicator` to your custom plugins directory:

   ```zsh
   cp -r aws-account-indicator $HOME/.oh-my-zsh/custom/plugins/aws-account-indicator
   ```

2. Add `aws_account_indicator` to the `plugins` array in your `.zshrc`:

   ```zsh
   plugins=(... aws_account_indicator ...)
   ```

3. If using p10k, open your `.p10k.zsh` file. Search for `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` and add `aws_account_indicator` to the list (recommended just before `prompt_char`):

   ```zsh
   typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
     # ...existing elements...
     aws_account_indicator
     prompt_char
   )
   ```

4. Add the following function to your `.p10k.zsh` file:

   ```zsh
   function prompt_aws_account_indicator() {
     [[ -n $AWS_ACCOUNT_INDICATOR_PROMPT ]] && p10k segment -t "$AWS_ACCOUNT_INDICATOR_PROMPT"
   }
   ```

## Usage

Once installed and configured, your prompt will display the current AWS account information whenever credentials are available.
