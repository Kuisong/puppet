#!/bin/bash -ex
apt-get install -y puppet

wget -P /home/ubuntu https://raw.github.com/Kuisong/puppet/master/manifests/bootstrap.pp
puppet apply /home/ubuntu/bootstrap.pp

