#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" ' 


if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
fi

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

#ui customizations
export PS1="\[\e[01;31m\][\[\e[m\]\[\e[01;31m\]\u\[\e[m\]\[\e[01;31m\]@\[\e[m\]\[\e[01;31m\]\h\[\e[m\]:\[\e[01;36m\]\w\[\e[m\] \[\e[33m\]\`parse_git_branch\`\[\e[m\]\[\e[01;31m\]]\[\e[m\]\[\e[01;31m\]\\$\[\e[m\] "


alias pacin="sudo pacman -S"
alias pacrem="sudo pacman -Rns"
alias pacup="sudo pacman -Syyu"
alias code="code-insiders"
alias myip='curl ipinfo.io/ip'
alias scan='scanimage --format=png --output-file file.png --progress'



#path declarations
export nvimrc="$HOME/.config/nvim/init.vim"
export PATH="$PATH/usr/bin/elixir"
export PATH="$PATH/usr/bin/mix"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"
