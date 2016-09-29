#!/bin/bash

RC_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
POWERLINE_DIR="${HOME}/.local/powerline"
echo "Resources dir: ${RC_DIR}"

sed -i "s:RCDIR=.*:RCDIR=$RC_DIR:" ${RC_DIR}/bashrc ${RC_DIR}/zshrc
# sed -i "s:ZDOTDIR=.*:ZDOTDIR=$RC_DIR:" ${RC_DIR}/zshrc

ln -frs $RC_DIR/bash_profile.sh ${HOME}/.bash_profile
ln -frs $RC_DIR/bash_logout.sh ${HOME}/.bash_logout
ln -frs $RC_DIR/bashrc ${HOME}/.bashrc
ln -frs $RC_DIR/zshrc ${HOME}/.zshrc
ln -frs $RC_DIR/tmux.conf ${HOME}/.tmux.conf
ln -frs $RC_DIR/vimrc ${HOME}/.vimrc

# [ -d ${POWERLINE_DIR} ] || \
#   git clone https://github.com/powerline/powerline.git ${POWERLINE_DIR} && \
#   ln -rsf ${POWERLINE_DIR}/scripts/* ${HOME}/.local/bin/

[ -d ~/.local/powerline-shell ] || \
  git clone https://github.com/milkbikis/powerline-shell ~/.local/powerline-shell &&\
    cd ~/.local/powerline-shell; ~/.local/powerline-shell/install.py; cd - || cd 

wget -O- https://bit.ly/glances | /bin/bash || \
  curl -L https://bit.ly/glances | bash

[ -d ~/.vim/autoload ] || makedir -p ~/.vim/autoload && \
  wget -O ~/.vim/autoload/plug.vim \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || \
    curl -o ~/.vim/autoload/plug.vim \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


[ -d ~/.config/nvim/autoload ] || makedir -p ~/.config/nvim/autoload && \
  wget -O ~/.config/nvim/autoload/plug.vim \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || \
    curl -o ~/.config/nvim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  bash ~/.fzf/install --all --no-update-rc
  ln -rsf ~/.fzf/bin/fzf-tmux ~/.local/bin/ && ln -rsf ~/.fzf/bin/fzf ~/.local/bin/ 
fi

function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }
app_list=( most multitail pydf mtr htop vim dstat inxi )
[ -x "`which apt 2>&1`" ] && sudo apt install join_by ' ' "${app_list[@]}" 
[ -x "`which dnf 2>&1`" ] && sudo dnf install join_by ' ' "${app_list[@]}"