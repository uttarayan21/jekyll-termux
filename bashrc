function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}
export 
PS1="[\[\e[36m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]]:\[\e[31m\]\`nonzero_return\`\[\e[m\]:\[\e[32m\]\w\[\e[m\]\\$ "
#nougat doesnt let find out other apps find processes so use termux boot
#//if [ $(ps -A | grep ssh-agent | grep -v grep) ] 
#//then echo 'ssh-agent already running'
#//else eval "$(ssh-agent -s)"
#//fi
