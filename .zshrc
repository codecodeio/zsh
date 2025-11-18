#Terminal Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{cyan}%1~%f%b %F{yellow}${vcs_info_msg_0_}%f %# '
PROMPT='%(?.%F{green}✅.%F{red}❌)%f %B%F{cyan}%1~%f%b %F{yellow}${vcs_info_msg_0_}%f %# '
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

#Editor
code() {open -a "Visual Studio Code" $1;} #open a file using VSC

#Terminal
#export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
export LSCOLORS="GxFxCxDxBxegedabagacad"
alias zsh="code ~/.zshrc"
alias zshp="code ~/.zprofile"
alias zshw="code ~/.zshrcwork"
alias refresh="source ~/.zshrc"
alias ll='ls -FGlAhp'
alias lsbysize='ls -lahS'
f() { open -a "Finder" $1 } #open dir in Finder
t() { open -a "Terminal" $1 } #open dir in new Terminal window
p() { open -a "Preview" $1 } #open file in Preview
findoldfiles() {  find ./ -type f -mtime "+$1" -name "*$2*" -ls } #$findoldfiles DAYS SEARCHTERM $findoldfiles 7 .gz
deleteoldfiles() {  find ./ -type f -mtime "+$1" -name "*$2*" -delete }
findfilesnotmatching() { find . ! -name "$1" -type f }
deletefilesnotmatching() { find . ! -name "$1" -type f -exec rm {} + }
alias findhere="mdfind $1 -onlyin ./"		# Search current directory using spotlight index
del() {
  if [ -d "$1" ]; then
    rm -rf "$1"
    echo "✅ Directory '$1' and its contents have been deleted."
  elif [ -f "$1" ]; then
    rm "$1"
    echo "✅ File '$1' has been deleted."
  else
    echo "🚫 Error: '$1' is not a valid file or directory."
  fi
}
#Terminal Navigation
alias ..='cd ../' # Go back 1 directory level
alias ...='cd ../../' # Go back 2 directory levels
docs() { cd /Users/$USER/Documents && ll }
dev() { cd /Users/$USER/Documents/Development && ll }
dl() { cd /Users/$USER/Downloads && ll }
dt() { cd /Users/$USER/Desktop && ll }
me() { cd ~ && ll }

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
commit() {
  if [ $# -eq 0 ]; then
    echo "❌ Error: Commit message required."
    return 1
  fi
  git commit -m "$*"
}

alias fetch='git fetch'
alias push='git push'
alias pull='git pull'
alias pullf="git pull --rebase --autostash" #auto stash and stash apply
alias merge='git merge'
alias stash='git stash'
alias branch='git branch'
alias config='git config'
alias tag='git tag'
tagsearch() { git tag -l -n1 | grep $1 }
alias tagdel="git fetch && git tag -d $1 && git push origin -d $1" #delete tag locally and remotely
alias gopen='code $(git diff --name-only)' #open files that have been changed in git
openrepo() {
    # Get the remote URL from git config
    REMOTE_URL=$(git config --get remote.origin.url)

    if [[ $REMOTE_URL == git@github.com:* ]]; then
        # Convert SSH URL to HTTPS URL
        BROWSER_URL="https://github.com/${REMOTE_URL#git@github.com:}"
        BROWSER_URL="${BROWSER_URL%.git}"
    elif [[ $REMOTE_URL == https://github.com/* ]]; then
        # If it's already HTTPS, just clean up any trailing .git
        BROWSER_URL="${REMOTE_URL%.git}"
    else
        echo "❌ Not a valid GitHub URL."
        return 1
    fi

    # Open the URL in the default browser
    echo "🌐 Opening $BROWSER_URL"
    open "$BROWSER_URL"
}

#GIT REPOS
alias repos='cd /Users/$USER/Documents/Development/Git/repos && ll'
repo() {
    if [[ "$1" == "zsh" ]]; then
        cd ~
    else
        cd /Users/$USER/Documents/Development/Git/repos/"$1"
    fi
    ll
}

#GIT OPTIMIZATION
alias gc='git gc --aggressive'
#update the local list of remote git branches automatically every time we run git pull or git fetch
alias gitpruneauto='git config remote.origin.prune true && git config -l'
#Remove Local References to Remote Branches
alias branchcleanref='git remote update origin --prune' #Update local list of remote branches
alias branchlist='git branch -r' #list remote branches
#Remove local GIT branches that were deleted on the remote repository
branchcleanlist() { git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' }
branchclean() { git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -d }
#clean everything
alias gitopt='gc && branchcleanref && branchclean && gitpruneauto'

#webp image format: webp filename.jpg || webp filename.jpg 70
webp() {
    local filename="${1%.*}"
    local quality=${2:-80}
    cwebp -quiet -q $quality "$1" -o "${filename}-q${quality}.webp"
}

#iCloud
alias icloud='cd "/Users/$USER/Library/Mobile Documents/com~apple~CloudDocs/Files" && ll'
alias emails="code /Users/$USER/Library/Mobile\ Documents/com~apple~CloudDocs/Files/Notes/emails"

#SSH
alias sshconf='code ~/.ssh/config' #load ssh keys so you do not have to type passphrase
alias sshsysconf='code /private/etc/ssh/ssh_config'

#COMPOSER
alias composerd='composer diagnose' #diagnose composer issues
alias composercreds='cd ~/.composer && ll'

#DOCKER
alias d='docker'
alias dc='docker-compose'
#ssh into a named docker container easily using sh
function dshell() {
    docker exec -it $1 sh
}
#ssh into a named docker container easily using bash
function dbash() {
    docker exec -it $1 bash
}
#ssh into a mysql docker container as root
function dsql() {
    docker exec -it $1 mysql -u root -prootpass
}

#ollama
#ollama run deepseek-r1:7b

# Source the .zshrcwork file if it exists
if [ -f ~/.zshrcwork ]; then
  source ~/.zshrcwork
fi

#mydiff
# Diff two files, write a patch, open it in VS Code.
mydiff() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: mydiff <file1> <file2> [out.patch]" >&2
    return 2
  fi

  local f1="$1"
  local f2="$2"
  local out="${3:-$HOME/Downloads/diff-output.patch}"

  # Run diff; treat exit code 1 (files differ) as success, but surface real errors (2).
  ( diff -u "$f1" "$f2" > "$out" ) || [[ $? -eq 1 ]] || return 2

  # Open with VS Code if available; otherwise fall back to macOS 'open'.
  if command -v code >/dev/null 2>&1; then
    code "$out"
  else
    open -a "Visual Studio Code" "$out"
  fi
}


# pnpm
export PNPM_HOME="/Users/$USER/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
