#! /bin/bash

rm -rf hdd
mkdir hdd
sudo losetup -o 2097152 /dev/loop2 hdd.raw
sudo mount /dev/loop2 hdd
