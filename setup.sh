#!/bin/bash

RC_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
POWERLINE_DIR="${HOME}/.local/powerline"
echo "Resources dir: ${RC_DIR}"

sed -i "s:RCDIR=.*:RCDIR=$RC_DIR:" ${RC_DIR}/bashrc ${RC_DIR}/zshrc
# sed -i "s:ZDOTDIR=.*:ZDOTDIR=$RC_DIR:" ${RC_DIR}/zshrc

ln -frs $RC_DIR/bashrc ${HOME}/.bashrc
ln -frs $RC_DIR/zshrc ${HOME}/.zshrc
ln -frs $RC_DIR/tmux.conf ${HOME}/.tmux.conf
ln -frs $RC_DIR/vimrc ${HOME}/.vimrc

git clone https://github.com/powerline/powerline.git ${POWERLINE_DIR}
ln -rsf ${POWERLINE_DIR}/scripts/* ${HOME}/.local/bin/

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
