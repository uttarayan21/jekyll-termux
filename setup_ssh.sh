echo Installing openssh
apt install -y openssh
echo Adding ssh-agent to termux boot
mkdir -p ~/.termux/boot
cp ssh-agent ~/.termux/boot/ssh-agent

read -n1 -p "Do you want to make a new ssh key ? \(y/n\)" a
if [[ $a == "y" | $a == "Y"]]
 then
  read -p "Please type your email" eml
  if [[ ! -d ~/.ssh ]]
    then mkdir ~/.ssh
    CD = "$PWD"
  fi
  cd ~/.ssh
  ssh-keygen -t rsa -b 4096 -C "$eml"


