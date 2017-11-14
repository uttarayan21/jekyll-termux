echo Installing openssh
apt install -y openssh
echo Adding ssh-agent to termux boot
mkdir -p ~/.termux/boot
cp ssh-agent ~/.termux/boot/ssh-agent

echo Do you want to make a new ssh key ? \(y/n\)

