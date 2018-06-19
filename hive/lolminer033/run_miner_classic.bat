@echo off

setlocal enableDelayedExpansion

Rem #################################
Rem ## Begin of user-editable part ##
Rem #################################

Rem Insert your configuration file name here
set "CNAME=example_config.cfg"										

Rem #################################
Rem ##  End of user-editable part  ##
Rem #################################


set "PARAMS=--use-config %CNAME%"

setx GPU_FORCE_64BIT_PTR 1
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100
:MINE
Start /wait /high lolMiner-mnx.exe !PARAMS! 
goto :MINE
