echo Installing openssh
apt install -y openssh
echo Adding ssh-agent to termux boot
mkdir -p ~/.termux/boot
cp ssh-agent ~/.termux/boot/ssh-agent

default_key=git_rsa

read -n 1 -p "Do you want to make a new ssh key ? (y/n) " a
echo
if [[ $a == "y" ]];then
  read -p "Please enter your GitHub.com email address : " email
  read -p "Please enter your GitHub.com username" username
  read -n 1 -p "Do you want to change the name of the file ? (y/n) (Default is $default_key) "
  if [[ $a == "y" ]];then
    read -p "Enter the new name for the key without the path" default_key
    if [[ $default_key == "" ]];then
      echo "The name of the name of the key can't be blank "
      exit 1
    fi
  fi
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/git_rsa -C $email
else
  exit 1
fi
unset a
read -n 1 -p "Do you want to add the public key to your GitHub account ? (y/n) : " a
if [[ $a == "y" ]];then
  cat ~/.ssh/git_rsa.pub | termux-clipboard-set
  echo "Copied the pub key to clipboard"
  echo "Paste it in the key block of the opened page"
  echo "And type in a title"
  xdg-open https://github.com/settings/ssh/new
  echo "Once it's added press anykey"
  read -s -n 1 a
  unset a
  echo Testing the connection
  ssh -T git@github.com
  if [[ $? != 1 ]];then
    echo "An unexpected error occured please report this problem to github.com/jekyll-termux/issues"
  fi
fi
