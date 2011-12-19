#!/bin/bash -ex
install()
{
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y \
        -o DPkg::Options::=--force-confdef \
        -o DPkg::Options::=--force-confold \
        install $@
}

# installs puppet && git
install hello git
cd
git clone http://github.com/Kuisong/puppet
cd puppet
git submodule update --init


