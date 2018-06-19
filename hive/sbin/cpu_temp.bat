@echo off
for /f "skip=1 tokens=2 delims==" %%A in ('wmic /namespace:\\root\wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature /value') do set /a "HunDegCel=(%%~A*10)-27315"
if "%HunDegCel%"=="" (
  for /L %%B in (1, 1, %NUMBER_OF_PROCESSORS%) do echo 0
) else (
  for /L %%B in (1, 1, %NUMBER_OF_PROCESSORS%) do echo %HunDegCel:~0,-2%.%HunDegCel:~-2%
)
