#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
if [ "$(whoami)" != 'root' ]; then
  cd ~
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

#ssh
alias vftcssh='ssh ubuntu@23.21.73.194'

#sshfs
alias unmount='sudo umount ~/Mount'
alias vftcfs='sshfs ubuntu@23.21.73.194:/home/ubuntu ~/Mount -C -p 22 -o IdentityFile=~/.ssh/id_rsa,allow_other'

#vpn
psjvpn ()
{
  sudo openvpn --mktun --dev tun0
  sleep 5
  sudo openconnect --interface tun0 --no-cert-check anyconnect.uhsinc.com
  sudo openvpn --rmtun --dev tun0
}

PS1='[\[\e[0;36m\] \w \[\e[0m\]]: '
cat /etc/issue
