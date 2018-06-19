#!/usr/bin/env bash
cd `dirname $0`

export LD_LIBRARY_PATH=../xmr-stak

./xmrig.exe | tee /var/log/miner/xmrig/xmrig.log
