#!/usr/bin/env bash

mkdir -p zk-artifacts

docker run -i -v ${PWD}/zk-artifacts:/mnt/zk-artifacts/ wickr/zookeeper-lib:latest bash << COMMANDS
ls -l /opt/zookeeper/build/contrib/zkpython/lib.linux-x86_64-2.7/zookeeper.so
cp -f /opt/zookeeper/build/contrib/zkpython/lib.linux-x86_64-2.7/zookeeper.so /mnt/zk-artifacts/
chown -R $(id -u):$(id -u) /mnt/zk-artifacts
chmod -R 755 /mnt/zk-artifacts
COMMANDS

cd zk-artifacts

if [ `uname` = "Darwin" ]; then
    xattr -d com.docker.owner zookeeper.so
fi

