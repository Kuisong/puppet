#!/bin/bash -ex
install()
{
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y \
        -o DPkg::Options::=--force-confdef \
        -o DPkg::Options::=--force-confold \
        install $@
}

# installs puppet
install puppet

wget -P /home/ubuntu https://raw.github.com/Kuisong/puppet/master/manifests/bootstrap.pp
puppet apply --environment=master --manifest=ci.pp /home/ubuntu/bootstrap.pp

