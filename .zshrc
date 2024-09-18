#Terminal Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{cyan}%1~%f%b %F{yellow}${vcs_info_msg_0_}%f %# '
RPROMPT='%*'

#Shared zshrc config for commands with username
USER=${"$(id -un)"}

#Ascii Emojis
alias shrug='echo "¯\_(ツ)_/¯"'
alias meh='echo "┐(￣ヮ￣)┌"'
alias run='echo "ᕕ( ᐛ )ᕗ"'

#Games
# https://github.com/JosefZIla/bash2048
games() { cd "/Users/$USER/Documents/Development/zsh/games/"; }
playgame() { "/Users/$USER/Documents/Development/zsh/games/"$1".sh"; }

#Shell Script Movies
alias shells='cd /Users/$USER/Documents/Development/Shell && ll'
play() { cd /Users/$USER/Documents/Development/Shell && bash play.sh $1 } #play ascii animation

#Terminal
alias zsh="code ~/.zshrc"
alias refresh="source ~/.zshrc"
alias ll='ls -FGlAhp'
f() { open -a "Finder" $1 } #open directory in finder
t() { open -a "Terminal" $1 } #open new terminal window
findoldfiles() {  find ./ -type f -mtime "+$1" -name "*$2*" -ls } #$findoldfiles DAYS SEARCHTERM $findoldfiles 7 .gz
deleteoldfiles() {  find ./ -type f -mtime "+$1" -name "*$2*" -delete }
#Terminal Navigation
alias home='cd ~ && pwd'
docs() { cd /Users/$USER/Documents && ll }
dev() { cd /Users/$USER/Documents/Development && ll }
alias repos='cd /Users/$USER/Documents/Development/Git/repos && pwd && ll'
repo() { 
    if [[ "$1" == "zsh" ]]; then 
        cd ~ 
    else 
        cd /Users/$USER/Documents/Development/Git/repos/"$1" 
    fi 
    ll 
}

#Visual Studio Code
code() {open -a "Visual Studio Code" $1;} #open a file using VSC

#Brew
alias brewtaps='cd /usr/local/Homebrew/Library/Taps && ll'

#Networking
alias hosts='code /etc/hosts'
alias mylocalip='ifconfig |grep broadcast'
alias mypublicip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"
alias myip='echo "Local IP:  " && mylocalip && echo "Public IP: " && mypublicip'
alias flushdns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

#Git
alias checkout='git checkout'
alias status='git status'
alias add='git add'
alias commit='git commit'
alias fetch='git fetch'
alias push='git push'
alias pull='git pull'
alias merge='git merge'
alias stash='git stash'
alias branch='git branch'
alias config='git config'
alias tag='git tag'
alias gc='git gc --aggressive'
alias gitopt='gc && branchcleanref && branchclean && gitpruneauto'
alias gitpruneauto='git config remote.origin.prune true && git config -l'
alias branchcleanref='git remote update origin --prune'
alias branchlist='git branch -r'

#webp image format: webp filename.jpg || webp filename.jpg 70
webp() {
    local filename="${1%.*}"
    local quality=${2:-80}
    cwebp -quiet -q $quality "$1" -o "${filename}-q${quality}.webp"
}
