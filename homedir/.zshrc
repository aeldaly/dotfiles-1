setopt nonomatch
setopt re_match_pcre
setopt EXTENDED_GLOB

zstyle ':completion:*' rehash true

export GREP_OPTIONS='--color=always'
export DISABLE_UPDATE_PROMPT=true
export DISABLE_AUTO_UPDATE=true
export HOMEBREW_BRWEFILE_APPSTORE=0
export HOMEBREW_BREWFILE_APPSTORE=0

# # # Credit: https://kev.inburke.com/kevin/profiling-zsh-startup-time/

export PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_startup.$$"
    setopt xtrace prompt_subst
fi

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
RobSis/zsh-reentry-hook
the8/terminal-app.zsh
unixorn/tumult.plugin.zsh
ruby
gem
ssh-agent
rake-fast
osx
brew
colored-man-pages
Tarrasch/zsh-autoenv
extract
emoji
gitfast
git-extras
aws
gpg-agent
jsontools
golang
sudo
xcode
python
pyenv
gnu-utils
bundler
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions

zsh-users/zsh-syntax-highlighting

zsh-users/zsh-history-substring-search

tylerreckart/odin
wesbos/Cobalt2-iterm.git
EOBUNDLES

# antigen use git
# antigen use command-not-found
# antigen use gulp
# antigen use history
# antigen use cp
# antigen use colorize
# antigen use compleat
# antigen use dirpersist
# antigen use autojump

antigen theme agnoster

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /usr/local/opt/nvm/nvm.sh

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    nvm use default &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
fortune

antigen apply
