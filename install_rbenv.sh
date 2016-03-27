#!/bin/sh

INST_DIR=/usr/local
RBENV_DIR=${INST_DIR}/rbenv
PLUGIN_DIR=${RBENV_DIR}/plugins

# rbenv
git clone https://github.com/sstephenson/rbenv.git ${RBENV_DIR}
cat <<EOF > /etc/profile.d/rbenv.sh
export RBENV_ROOT="/usr/local/rbenv"
export PATH="/usr/local/rbenv/bin:$PATH"
eval "\$(rbenv init -)"
EOF

# ruby-build
mkdir ${PLUGIN_DIR}
git clone https://github.com/sstephenson/ruby-build.git ${PLUGIN_DIR}/ruby-build
sh ${PLUGIN_DIR}/ruby-build/install.sh

yum -y install gcc zlib-devel openssl-devel sqlite sqlite-devel mysql-devel readline-devel libffi-devel libxml2-devel libxslt-devel

source /etc/profile.d/rbenv.sh
