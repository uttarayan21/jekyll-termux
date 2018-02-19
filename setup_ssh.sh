echo Installing openssh
apt install -y openssh
echo Adding ssh-agent to termux boot
mkdir -p ~/.termux/boot
cp ssh-agent ~/.termux/boot/ssh-agent

key_name=git_rsa

read -n 1 -p "Do you want to make a new ssh key ? (y/n) " a
echo
if [[ $a == "y" ]];then
  read -p "Please enter your GitHub.com email address : " email
  if [[ $email == "" ]];then
    echo "The email can't be blank "
    exit 1
  fi
  email_check=$(echo $email | sed -r "s/.*@.*\..*/true/")
##echo $email_check
  if [[ $email_check != "true" || $email == $email_check ]];then
    echo Please enter a valid email
    exit 1
  fi
  read -p "Please enter your GitHub.com username : " username
  if [[ $username == "" ]];then
    echo "The username blank "
    exit 1
  fi
  read -n 1 -p "Do you want to change the name of the file ? (y/n) (Default is $key_name) " a
  echo
  if [[ $a == "y" ]];then
    read -p "Enter the new name for the key without the path : " key_name
    if [[ $key_name == "" ]];then
      echo "The name of the name of the key can't be blank "
      exit 1
    fi
  else
    echo Using the default key name $key_name
  fi

  echo Running ssh-keygen -t rsa -b 4096 -f ~/.ssh/$key_name -C $email
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/$key_name -C $email
else
  exit 1
fi
unset a
read -n 1 -p "Do you want to add the public key to your GitHub account ? (y/n) : " a
echo
if [[ $a == "y" ]];then
  cat ~/.ssh/$key_name.pub | termux-clipboard-set
  echo "Copied the pub key to clipboard"
  echo "Paste it in the key block of the opened page"
  echo "And type in a title"
  xdg-open https://github.com/settings/ssh/new
  echo "Once it's added press anykey"
  read -s -n 1 a
  unset a
  echo Starting ssh-agent
  eval "$(ssh-agent -s)"
  echo Adding the ~/.ssh/$key_name to the ssh-agent
  ssh-add ~/.ssh/$key_name
  echo Testing the connection
  ssh -T git@github.com
  if [[ $? != 1 ]];then
    echo "An unexpected error occured please report this problem to github.com/jekyll-termux/issues"
  fi
fi

if [ $(pm list packages | grep com.termux.boot | cut -d: -f2) == "com.termux.boot" ];then
  echo Termux Boot Already installed, no need to run ssh-agent fron elsewhere
else
  read -n 1 -p "Do you plan on installing termux-boot ? (y/n)" a
  if [[ $a == "y" ]];then
    echo 1. from Play Store
    echo 2. from F-Droid
    echo 3. do not install now
    read -n 1 -p "Enter you choice" a
    case "$a" in

    1)  echo Opening the PlayStore link
        xdg-open https://play.google.com/store/apps/details?id=com.termux.boot
        ;;
    2)  echo Opening the F-Droid link
        xdg-open https://f-droid.org/packages/com.termux.boot/
        ;;
    3)  echo Okay you can install it later but remember that if you will need to start the ssh-agent manually until then
        ;;
    *)  echo Invalid choice
        ;;
    esac
  else
    echo Trying to start the ssh-agent using a script and a lock file to prevent multiple instances of it
    sed -i -e "s/git_rsa/$key_name/g" ~/.termux/boot/ssh-agent
    echo 'source ~/.termux/boot/ssh-agent' >> ~/.bashrc
  fi
fi
