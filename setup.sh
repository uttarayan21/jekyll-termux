echo Jekyll termux installer
echo Do you want to replace the bashrc \(recommended\)
read a
if [[ $a = "y" ]]
 then
  mv ~/.bashrc ~/.bashrc.bak
  cp bashrc ~/.bashrc
fi
unset a
echo Install required packages ? \(about 250mb total in size use if you want to view the page locally\)
read a
if [[ $a == "y" ]]
 then
  apt install ruby-dev llvm g++ libffi-dev python git
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

