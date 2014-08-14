# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##===========

if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

complete -cf sudo


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s hostcomplete
shopt -s nocaseglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}


export EDITOR="nano"


#=======================================================================
# function: type "path" in terminal for ordered $PATH display:
#-----------------------------------------------------------------------

function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}
#=======================================================================
#-----------------------------------------------------------------------



#=======================================================================
# ex - archive extractor
# usage: ex <file>
#-----------------------------------------------------------------------

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
#=======================================================================
#-----------------------------------------------------------------------


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#=======================================================================
#My crazy smilie prompt
#-----------------------------------------------------------------------

bash_prompt_cmd() {
RTN=$?



smiley() {
    if [ $1 == 0 ] ; then
echo ":)"
    else
echo ":("
       fi
    }
smileyc() {
    if [ $1 == 0 ] ; then
echo $GREEN
else
echo $RED
       fi
    }
 if [ $(tput colors) -gt 0 ] ; then
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RST=$(tput op)
fi
smiley=$(smiley $RTN)
smileyc=$(smileyc $RTN)
        local CY="\[\e[1;31m\]" # Each is 12 chars long
        local BL="\[\e[1;34m\]"
        local WH="\[\e[1;37m\]"
        local BR="\[\e[0;33m\]"
        local RE="\[\e[1;31m\]"
        local PROMPT="${CY}$"
        [ $UID -eq "0" ] && PROMPT="${RE}#"

        # Add the first part of the prompt: username,host, and time
        local PROMPT_PWD=""
        local PS1_T1="$BL.:[ $CY`whoami`@`hostname` $BL: $CY\t $BL:$CY "
        local ps_len=$(( ${#PS1_T1} - 12 * 6 + 6 + 4 )) #Len adjust for colors, time and var
        local PS1_T2=" $BL]:.\n\[\$smileyc\]\$smiley\[$RST\] " 
        local startpos=""

        PROMPT_PWD="${PWD/#$HOME/~}"
        local overflow_prefix="..."
        local pwdlen=${#PROMPT_PWD}
        local maxpwdlen=$(( COLUMNS - ps_len ))
        # Sometimes COLUMNS isn't initiliased, if it isn't, fall back on 80
        [ $maxpwdlen -lt 0 ] && maxpwdlen=$(( 80 - ps_len )) 

        if [ $pwdlen -gt $maxpwdlen ] ; then
                startpos=$(( $pwdlen - maxpwdlen + ${#overflow_prefix} ))
                PROMPT_PWD="${overflow_prefix}${PROMPT_PWD:$startpos:$maxpwdlen}"
        fi      
        export PS1="${PS1_T1}${PROMPT_PWD}${PS1_T2}"
}
PROMPT_COMMAND=bash_prompt_cmd


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
#=======================================================================
# All the aliases you can EAT
#-----------------------------------------------------------------------

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -A --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'


#=========================================================================
# APT-GET AND DPKG STUFF..
#--------------------------
alias Install="sudo apt-get install"   # Regular old install
alias Update="sudo apt-get update"
alias Upgrade="sudo apt-get upgrade"
alias Remove="sudo apt-get remove"
alias Search="sudo apt-cache search"

alias Bashrc="nano ~/.bashrc && source ~/.bashrc"
alias fstab="sudo nano /etc/fstab"
alias Conkyrc="nano ~/.conkyrc"

# Regulators ..... MOUNT UP!
alias Debzzz="sudo mount /dev/sdb3 /home/trey/Debzzz/"
alias Win7="sudo mount /dev/sda2 /run/media/trey/Win7-Ult-x64/"
alias Games="sudo mount /dev/sda3 /run/media/trey/Games/"
alias Backups="sudo mount /dev/sda5 /run/media/trey/Media-Backups/"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi
