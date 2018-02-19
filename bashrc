function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}
export 
inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

parse_git_branch() {
  if [ "inside_git_repo" ];then
       git branch 2> /dev/null | sed -r "/^[^*].*/d;s/^\*.(.*)/@\(\1\)/"
  fi
}
local_commits() {
  if [ "inside_git_repo" ];then
    git status 2> /dev/null | sed -r '/^Your/!d;s/^Your.*by.(.*).commit./\^\1/;/^Your/d'
  fi
}
PS1="[\[\e[36m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]]:\[\e[31m\]\`nonzero_return\`\[\e[m\]:\[\e[32m\]\w\[\e[m\]\$(parse_git_branch)\[\033[00m\]\$(local_commits)$ "
#nougat doesnt let find out other apps find processes so use termux boot
#//if [ $(ps -A | grep ssh-agent | grep -v grep) ] 
#//then echo 'ssh-agent already running'
#//else eval "$(ssh-agent -s)"
#//fi
source ~/.termux/boot/ssh-agent
