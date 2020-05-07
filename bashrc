# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias c='clear'
myrm() { Recycle=/tmp/$(date +%Y%m%d); mkdir -p $Recycle; mv $@ $Recycle && echo "moved $@ to $Recycle ok"; }
alias rm='myrm'
alias rmm='/usr/bin/rm'
alias vi='/usr/local/vim/bin/vim'

#[[ -s /home/smaug/.autojump/etc/profile.d/autojump.sh ]] && source /home/smaug/.autojump/etc/profile.d/autojump.sh


alias findch='find ./ -name "*.cc" -o -name "*.h" -o -name "*.cpp" -o -name "*.c" -o -name "*.hpp" '
alias grepch='find ./ -name "*.cc" -o -name "*.h" -o -name "*.cpp" -o -name "*.c" -o -name "*.hpp" |xargs grep '
alias grepc='find ./ -name "*.cc" -o -name "*.cpp" -o -name "*.c" |xargs grep '
alias greph='find ./ -name "*.h" -o -name "*.hpp" |xargs grep '
alias amosh='automosh'

alias syncmac='rsync  -rptgoDvH --delete --exclude "cbuild" /root/top/xchain/ /mnt/centos-share/top/xchain_github/ '

hostname Jiao
export PATH=/usr/local/vim/bin:/usr/local/bin:/usr/loca/python3/bin:$PATH
export ANDROID_NDK=/root/smaug/software/android-ndk-r16b
export ANDROID_NDK_TOOLCHAIN_ROOT=/root/smaug/software/android-ndk-r16b/toolchains
#export PS1='[\[\e[33;40m\]\u@\h \W]# '
#export PS1='\[\e[32;1m\][\u@\h \W]\$ \[\e[0m\]' 
export PS1='\[\e[32;1m\][\u@\h \w]\$ \[\e[0m\]' 

export LD_LIBRARY_PATH=/usr/local/python3/lib:$LD_LIBRARY_PATH

ulimit -c unlimited

export MARKPATH=$HOME/.marks
function j { 
	cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
	mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
	/usr/bin/rm -i "$MARKPATH/$1"
}
function marks {
	ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks j unmark

