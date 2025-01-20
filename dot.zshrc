# Keybind
bindkey -v
# https://bbs.archlinux.org/viewtopic.php?id=52173
bindkey '\e[3~' delete-char


# Completion
# https://wiki.archlinux.jp/index.php/Zsh
autoload -Uz compinit promptinit
compinit
promptinit
# https://qiita.com/ToruIwashita/items/5cfa382e9ae2bd0502be
zstyle ':completion:*' menu select interactive
setopt menu_complete
zmodload zsh/complist
bindkey -M menuselect '^y' accept-and-infer-next-history
bindkey -M menuselect '^n' down-line-or-history
bindkey -M menuselect '^p' up-line-or-history


# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_allow_clobber
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history


# Prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
# prompt bigfade
if [[ -n "${SSH_CONNECTION}" || -n "${SSH_TTY}" || -n "${SSH_CLIENT}" ]]; then
  # remote host
  # PROMPT="%F{red}█▓▒░%f%F{black}%K{red}%n@%m%k%f%F{red}░▒▓█%f%F{white}█▓▒░ %f"
  PROMPT="%F{red}█▓▒░%f%F{black}%K{red}%m%k%f%F{red}░▒▓█%f%F{white}█▓▒░ %f"
else
  # local host
  # PROMPT="%F{green}█▓▒░%f%F{black}%K{green}%n@%m%k%f%F{green}░▒▓█%f%F{white}█▓▒░ %f"
  PROMPT="%F{blue}█▓▒░%f%F{black}%K{blue}%m%k%f%F{blue}░▒▓█%f%F{white}█▓▒░ %f"
fi
# _SHELL_TYPE="$(ps -o comm -p $$ | tail -n 1 | sed -e 's/.*\///g')"
# PROMPT="${PROMPT}%F{#696969}%D{[%Y-%m-%d %H:%M:%S]} (${_SHELL_TYPE}-%L)%f
PROMPT="${PROMPT}%F{#696969}%D{[%Y-%m-%d %H:%M:%S]} (%x-%L)%f
%F{yellow}[%~]%f "'${vcs_info_msg_0_}'"
$ "


# Git
# https://hirooooo-lab.com/development/git-terminal-customize-zsh/
# https://qiita.com/ono_matope/items/55d9dac8d30b299f590d
# https://qiita.com/mollifier/items/8d5a627d773758dd8078
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f %F{#696969}%m%f"
zstyle ':vcs_info:*' actionformats '[%b|%a] %F{#696969}%m%f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}*"
# zstyle ':vcs_info:git+set-message:*' hooks git-config-user
# function +vi-git-config-user(){
#   hook_com[misc]+='<'`git config user.name`'>'
#   hook_com[misc]+=' '
#   hook_com[misc]+='<'`git config user.email`'>'
# }
_vcs_precmd(){ vcs_info }
add-zsh-hook precmd _vcs_precmd


# zeno.zsh
zinit ice lucid depth"1" blockf
zinit light yuki-yano/zeno.zsh
# https://qiita.com/obake_fe/items/da8f861eed607436b91c
if [[ -n "${ZENO_LOADED}" ]]; then
  bindkey ' '  zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^g' zeno-ghq-cd
  bindkey '^r' zeno-history-selection
  bindkey '^x' zeno-insert-snippet
else
  # https://wayohoo.com/article/6922
  bindkey '\e[3~' delete-char
  bindkey '^r' history-incremental-search-backward
  bindkey '^s' history-incremental-search-forward
fi

# zsh-vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
ZVM_CURSOR_STYLE_ENABLED=false

# Other Plugins
zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-syntax-highlighting


# OS-specific settings
# https://obel.hatenablog.jp/entry/20200214/1581620400
# https://qiita.com/reoring/items/47689c23d2e31035720b
_uname="$(uname -a)"
if [ "$(echo "${_uname}" | grep Darwin)" ]; then
  echo 'Hello, macOS!'
  alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql
elif [ "$(echo "${_uname}" | grep Ubuntu)" ]; then
  echo 'Hello, Ubuntu'
  alias pbcopy='xclip -selection clipboard'
elif [ "$(echo "${_uname}" | grep WSL2)" ]; then
  echo 'Hello, WSL2!'
  alias pbcopy='xclip -selection clipboard'
elif [ "$(echo "${_uname}" | grep arm)" ]; then
  echo 'Hello, Raspberry Pi!'
elif [ "$(echo "${_uname}" | grep el7)" ]; then
  echo 'Hello, CentOS!'
else
  echo 'Which OS are you using?'
fi

# End of Settings
cd

# tmux
if [[ -n "${SSH_CONNECTION}" || -n "${SSH_TTY}" || -n "${SSH_CLIENT}" ]]; then
  # remote host
else
  # local host
  if [ "${SHLVL}" -eq 1 ]; then
    tmux
  fi
fi
