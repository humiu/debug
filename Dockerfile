FROM alpine:latest

MAINTAINER Manu Miu <miu.manu@gmx.de>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

# basics
RUN apk add --no-cache bash fish git fzf bat fd ripgrep ncurses vim tmux jq
# build/code
# RUN apk add --no-cache build-base
# network
RUN apk add --no-cache bind-tools iputils tcpdump curl nmap tcpflow iftop net-tools mtr netcat-openbsd bridge-utils iperf ngrep
# certificates
RUN apk add --no-cache ca-certificates openssl
# processes/io
RUN apk add --no-cache htop atop strace sysstat ltrace ncdu logrotate hdparm pciutils psmisc tree pv
# needs full python3 which increases the image size by almost 50MB
# RUN apk add --no-cache iotop
# not found
# apk add --no-cache dstat

RUN git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
RUN "$HOME/.homesick/repos/homeshick/bin/homeshick" clone -b mamiu/dotfiles
RUN "$HOME/.homesick/repos/homeshick/bin/homeshick" link -f dotfiles
RUN rm -rf "$HOME/.homesick/repos/homeshick/.git"
RUN rm -rf "$HOME/.homesick/repos/dotfiles/.git"
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
RUN tmux new-session -s setup -d '~/.tmux/plugins/tpm/tpm; ~/.tmux/plugins/tpm/scripts/install_plugins.sh' && sleep 25
RUN echo | echo | vim +PluginInstall +qall &>/dev/null
RUN curl https://git.io/fisher --create-dirs -sLo "$HOME/.config/fish/functions/fisher.fish"
RUN fish -c fisher
RUN sed 1d /etc/passwd | echo -e "root:x:0:0:root:/root:/usr/bin/fish\n$(cat -)" > /etc/passwd

ENTRYPOINT fish