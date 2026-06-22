# man 1 bash
eval "$(direnv hook bash)"

set -a
CDPATH=.:~/Workspace
GLOBSORT=-mtime
set +a

shopt -s autocd cdspell dirspell
shopt -s extglob globstar progcomp_alias
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

alias zl='chezmoi status'
alias za='chezmoi add'
alias zar='chezmoi re-add'
alias zs='chezmoi apply'
alias zi="chezmoi init --source-path ~/.Profile"

source /usr/share/bash-completion/helpers/complete_alias
complete -F _complete_alias "${!BASH_ALIASES[@]}"
