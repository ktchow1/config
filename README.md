# Suppose we have git server

git@xxx.yyy.zzz:my_fork/my_repository.git



# Inside ~/.ssh/config

Host xxx.yyy.zzz
    HostName xxx.yyy.zzz
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/my_git_key
    ServerAliveInterval 15
    ServerAliveCountMax 10



# Generate ~/.ssh/my_git_key and ~/.ssh/my_git_key.pub

ssh-keygen -t rsa -b 4096 -C "ssh key for gitlab server"


# Inside ~/.gitconfig

[user]
    name = Peter Chan
    email = peter.chan@google.com
[core]
editor = nvim
[merge]
tool = meld



# Inside ~/.config/nvim/init.vim]
...


# Inside ~/.bashrc, append the following lines

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
ulimit -c unlimited
