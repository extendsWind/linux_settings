
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)



# The following lines were added by compinstall
#
autoload -U compinit promptinit

promptinit
# prompt pure

compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fpath=(/usr/local/share/zsh-completions $fpath)


echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)

# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]}'
# zstyle :compinstall filename '/home/fly/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# # Keybinding (emacs)
bindkey -e


## Theme
ZSH_THEME="powerlevel10k"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


## Default alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi




# ===== plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh


# ===== my-settings =====

# z.lua  quick jump to directory
eval "$(lua ~/linux_configs/z.lua --init zsh)"

#export EDITOR=/usr/bin/nano
# ssh
alias ssh1="ssh sparkl@tdh1 -C -Y"
alias ssh2="ssh sparkl@tdh2 -C -Y"
alias ssh3="ssh sparkl@tdh3 -C -Y"
alias ssh4="ssh sparkl@tdh4 -C -Y"
alias sshss="ssh fly@ssserver -p 8888"
alias sshandroid="ssh user@192.168.3.18 -p 8022"

alias cp="cp -i"
alias mv="mv -i"
alias ll='ls -l'                                                # Human-readable sizes

alias sslocal="sslocal -c /etc/shadowsocks/config.json"

alias vim=nvim

export EDITOR=/usr/bin/nvim


# uncompatible processing 
# for example: find / -name *.zsh may not work well
setopt no_nomatch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
