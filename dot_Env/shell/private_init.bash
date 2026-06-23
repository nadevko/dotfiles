# man 1 bash

set -a
CDPATH=.:~/Workspace
GLOBSORT=-mtime
GPG_TTY=$(tty)
set +a

eval "$(direnv hook bash)"
eval "$(fzf --bash)"
gpg-connect-agent updatestartuptty /bye >/dev/null

shopt -s autocd cdspell dirspell
shopt -s extglob globstar
shopt -s bash_source_fullpath checkjobs lastpipe
shopt -s gnu_errfmt xpg_echo checkwinsize
shopt -s histappend histreedit histverify cmdhist

alias g=git
alias e="$VISUAL"
alias s=sudo
alias se=sudoedit
alias l='ls -lA'

alias spm='sudo emerge'
alias spmw='sudo emerge -uaND @world'

alias czl='chezmoi status'
alias czi='chezmoi init'
alias cza='chezmoi add'
alias czar='chezmoi re-add'
alias czs='chezmoi apply'

source /usr/share/bash-completion/helpers/complete_alias
complete -F _complete_alias "${!BASH_ALIASES[@]}"
