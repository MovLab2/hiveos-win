#!/usr/bin/env bash

[[ ! -e ./zm.conf ]] && echo "No zm.conf, exiting" && exit 1

winpty.exe ./zm.exe --cfg-file=zm.conf
