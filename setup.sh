#!/bin/bash

RC_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
POWERLINE_DIR="${HOME}/.local/powerline"
echo "Resources dir: ${RC_DIR}"

sed -i "s:RCDIR=.*:RCDIR=$RC_DIR:" ${RC_DIR}/bashrc ${RC_DIR}/zshrc
# sed -i "s:ZDOTDIR=.*:ZDOTDIR=$RC_DIR:" ${RC_DIR}/zshrc

echo "Creating links in home dir..."
ln -frs $RC_DIR/bash_profile.sh ${HOME}/.bash_profile
ln -frs $RC_DIR/bash_logout.sh ${HOME}/.bash_logout
ln -frs $RC_DIR/bashrc ${HOME}/.bashrc
ln -frs $RC_DIR/zshrc ${HOME}/.zshrc
ln -frs $RC_DIR/tmux.conf ${HOME}/.tmux.conf
ln -frs $RC_DIR/vimrc ${HOME}/.vimrc
ln -frs $RC_DIR/minimal.bashrc ${HOME}/.sshrc
mkdir -p ~/.local/bin; mv $RC_DIR/progress ~/.local/bin/

# [ -d ${POWERLINE_DIR} ] || \
#   git clone https://github.com/powerline/powerline.git ${POWERLINE_DIR} && \
#   ln -rsf ${POWERLINE_DIR}/scripts/* ${HOME}/.local/bin/

if [[ ! -d ~/.local/powerline-shell ]]; then
  echo "Installing powerline-shell"
  git clone https://github.com/milkbikis/powerline-shell ~/.local/powerline-shell
  cd ~/.local/powerline-shell 
  ~/.local/powerline-shell/install.py
  cd - || cd 
fi


# Iteresting system monitor (useful for servers)
# wget -O- https://bit.ly/glances | /bin/bash || \
#   curl -L https://bit.ly/glances | bash

[ -f ~/.vim/autoload/plug.vim ] || mkdir -p ~/.vim/autoload && \
  echo "Installing vim.plug..." &&\  
  wget -O ~/.vim/autoload/plug.vim \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || \
    curl -o ~/.vim/autoload/plug.vim \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


[ -f ~/.config/nvim/autoload/plug.vim ] || mkdir -p ~/.config/nvim/autoload && \
  echo "Installing nvim.plug" &&\  
  wget -O ~/.config/nvim/autoload/plug.vim \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || \
    curl -o ~/.config/nvim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ ! -d ~/.fzf ]]; then
  echo "Installing fzf"  
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  bash ~/.fzf/install --all --no-update-rc
  ln -rsf ~/.fzf/bin/fzf-tmux ~/.local/bin/ && ln -rsf ~/.fzf/bin/fzf ~/.local/bin/ 
fi

app_list=( most multitail pydf htop vim dstat inxi )
[ -x "`which apt 2>&1`" ] && sudo apt install "${app_list[@]}" 
[ -x "`which dnf 2>&1`" ] && sudo dnf install "${app_list[@]}"
