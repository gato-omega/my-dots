#!/usr/bin/env bash
set -eu

# from https://github.com/fesplugas/rbenv-installer/blob/22cc96aa45d06faca5958b1aa1688596198407a3/bin/rbenv-installer

# Verify Git is installed:
if [ ! $(which git) ]; then
  echo "Git is not installed, can't continue."
  exit 1
fi

set +u
if [ -z "${RBENV_ROOT}" ]; then
  RBENV_ROOT="$HOME/.rbenv"
fi
set -u

# Install rbenv:
if [ ! -d "$RBENV_ROOT" ] ; then
  git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
else
  cd $RBENV_ROOT
  if [ ! -d '.git' ]; then
    git init
    git remote add origin https://github.com/sstephenson/rbenv.git
  fi
  git pull origin master
fi

# Install plugins:
PLUGINS=(
  sstephenson/rbenv-vars
  sstephenson/ruby-build
  sstephenson/rbenv-default-gems
  sstephenson/rbenv-gem-rehash
  fesplugas/rbenv-installer
  fesplugas/rbenv-bootstrap
  rkh/rbenv-update
  rkh/rbenv-whatis
  # tpope/rbenv-ctags
  # rbenv/rbenv-each
)

for plugin in ${PLUGINS[@]} ; do

  KEY=${plugin%%/*}
  VALUE=${plugin#*/}

  RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
  if [ ! -d "$RBENV_PLUGIN_ROOT" ] ; then
    git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
  else
    cd $RBENV_PLUGIN_ROOT
    echo "Pulling $VALUE updates."
    git pull
  fi

done

# Show help if `.rbenv` is not in the path:
if [ ! $(which rbenv) ]; then
  echo "
Seems you still have not added 'rbenv' to the load path:
# ~/.bash_profile:
export RBENV_ROOT=\"\${HOME}/.rbenv\"
if [ -d \"\${RBENV_ROOT}\" ]; then
  export PATH=\"\${RBENV_ROOT}/bin:\${PATH}\"
  eval \"\$(rbenv init -)\"
fi
"
fi
