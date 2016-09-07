#!/usr/bin/env bash

TEMP_LIB_DIR=zk-artifacts
mkdir -p $TEMP_LIB_DIR

docker run -i -v ${PWD}/${TEMP_LIB_DIR}:/mnt/${TEMP_LIB_DIR}/ wickr/zookeeper-lib:latest bash << COMMANDS
ls -l /opt/zookeeper/build/contrib/zkpython/lib.linux-x86_64-2.7/zookeeper.so
cp -f /opt/zookeeper/build/contrib/zkpython/lib.linux-x86_64-2.7/zookeeper.so /mnt/${TEMP_LIB_DIR}/
chown -R $(id -u):$(id -u) /mnt/${TEMP_LIB_DIR}
chmod -R 755 /mnt/${TEMP_LIB_DIR}
COMMANDS

cd ${TEMP_LIB_DIR}

if [ `uname` = "Darwin" ]; then
    xattr -d com.docker.owner zookeeper.so
fi

echo "zookeeper.so successfully copied to ./${TEMP_LIB_DIR}/"
