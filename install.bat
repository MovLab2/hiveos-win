echo %USERPROFILE%
schtasks /create /sc HOURLY /RL HIGHEST /tn "hive_agent" /tr "c:\cygwin64\hive_agent_autorun.bat" /F
schtasks /create /sc Onlogon /RL HIGHEST /tn "hive" /tr "c:\cygwin64\_hive.bat" /F
schtasks /create /sc Onlogon /RL HIGHEST /tn "hive_ohm" /tr "c:\cygwin64\hive\opt\OpenHardwareMonitor\OpenHardwareMonitor.bat" /F