typeset -U path
export PYENV_ROOT=~/.pyenv/
export EDITOR=/usr/bin/nvim
export LC_ALL="$LANG"
export TERM=xterm-256color
export K3D_FIX_MOUNTS=1
export QML_IMPORT_PATH=/usr/lib/qt6/qml
export CMAKE_POLICY_VERSION_MINIMUM="3.10"
export RUST_BACKTRACE="1"
export GOPATH="$HOME/.go"
export MANPAGER='/usr/bin/nvim +Man!'
export AWS_DEFAULT_REGION="eu-west-1"

path=($path[@] ~/.poetry/bin/ ~/.local/bin/ ~/.pyenv/bin ~/.cargo/bin ~/.krew/bin /opt/sonar-scanner/bin ~/.go/bin /opt/google-cloud-cli/bin)
fpath=($fpath[@] ~/.zfunc)
