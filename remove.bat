echo %USERPROFILE%
schtasks /delete /tn "hive" /F
schtasks /delete /tn "hive_agent" /F
schtasks /delete /tn "hive_ohm" /F
c:\cygwin64\bin\bash.exe --login -i -c "pkill screen";"screen -wipe"
