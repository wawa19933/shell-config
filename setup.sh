#!/bin/bash

RC_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Resources dir: ${RC_DIR}"

sed -i "s/RCDIR=.*/RCDIR=$RC_DIR" ${RC_DIR}/bashrc
sed -i "s/ZDOTDIR=.*/ZDOTDIR=$RC_DIR" ${RC_DIR}/zshrc

ln -frs $RC_DIR/bashrc ${HOME}/.bashrc
ln -frs $RC_DIR/zshrc ${HOME}/.zshrc
ln -frs $RC_DIR/tmux.conf ${HOME}/.tmux.conf
ln -frs $RC_DIR/vimrc ${HOME}/.vimrc
