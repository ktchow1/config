Suppose we have git server :
git@xxx.yyy.zzz:my_fork/my_repository.git

[~/.ssh/config]
Host xxx.yyy.zzz
    HostName xxx.yyy.zzz
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/my_git_key
    ServerAliveInterval 15
    ServerAliveCountMax 10

[~/.ssh/my_git_key]
[~/.ssh/my_git_key.pub]
ssh-keygen -t rsa -b 4096 -C "ssh key for gitlab server"

[~/.gitconfig]
[user]
    name = Peter Chan
    email = peter.chan@google.com
[core]
editor = nvim
[merge]
tool = meld

[~/.config/nvim/init.vim]
...

[~/.bashrc] append lines
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
ulimit -c unlimited
