echo Jekyll termux installer
echo Do you want to replace the bashrc \(recommended\)
read a
if [[ $a = "y" ]]
 then
  if [ -e ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
  fi
  cp bashrc ~/.bashrc
fi
unset a
echo Install required packages ? \(about 250mb total in size use if you want to view the page locally\)
read a
if [[ $a == "y" ]]
 then
  if [ $(./check_battery.sh) == "low" ]
  then
  read -p battery low and not charging 
    apt install -y ruby-dev llvm g++ libffi-dev python git bash-completion
    gem install jekyll
fi
unset a
echo Do you want to setup ssh now ?\(Needed for not entering password everytime\) \(y/n\)
read a
if [[ $a == "y" ]]
 then
  unset a
  ./setup_ssh.sh
fi

