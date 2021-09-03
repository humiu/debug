FROM alpine:latest

LABEL maintainer="Paul Miu <miu.manu@gmx.de>"

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  # basics
  apk add --no-cache bash fish git fzf bat fd ripgrep ncurses vim tmux jq procps && \
  # build/code
  # apk add --no-cache build-base && \
  # network
  apk add --no-cache bind-tools iputils tcpdump curl nmap tcpflow iftop net-tools mtr netcat-openbsd bridge-utils iperf ngrep && \
  # certificates
  apk add --no-cache ca-certificates openssl && \
  # processes/io
  apk add --no-cache htop atop strace sysstat ltrace ncdu logrotate hdparm pciutils psmisc tree pv && \
  # iotop needs full python3 which increases the image size by ~50MB
  # apk add --no-cache iotop && \
  # not found
  # apk add --no-cache dstat && \
  # add mamiu/dotfiles
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick && \
  "$HOME/.homesick/repos/homeshick/bin/homeshick" clone -b mamiu/dotfiles && \
  "$HOME/.homesick/repos/homeshick/bin/homeshick" link -f dotfiles && \
  rm -rf "$HOME/.homesick/repos/homeshick/.git" && \
  rm -rf "$HOME/.homesick/repos/dotfiles/.git" && \
  # install tmux plugins
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm && \
  tmux new-session -s setup -d "$HOME/.tmux/plugins/tpm/tpm && $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh" && sleep 15 && \
  # install vim plugins
  echo | echo | vim +PluginInstall +qall &>/dev/null && \
  # install fisher and plugins
  fish -c "curl -sL https://git.io/fisher | source && fisher update" && \
  # set fish as default shell
  sed 1d /etc/passwd | echo -e "root:x:0:0:root:/root:/usr/bin/fish\n$(cat -)" > /etc/passwd

WORKDIR "/root"

ENTRYPOINT fish