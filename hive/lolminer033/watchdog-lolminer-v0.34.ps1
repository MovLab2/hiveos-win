# watchdog for lolMiner-mnx
# version: 0.34
# Based on work of ninjam

############################## Modify the following line to set your config file name ########################################
$global:paramsList = @('--use-config','example_config.cfg')
#@('--use-config','example_config.cfg')
##############################################################################################################################

$logfilename = "miner.log"
#$fullpath = "$PSScriptRoot\$filename"
$logpath = "$PSScriptRoot\$logfilename"
$oldLogsFolderPath = Join-Path -path $PSScriptRoot -ChildPath oldlogs
$global:minername = "lolMiner-mnx.exe"
$global:minerPath = Join-Path -path $PSScriptRoot -ChildPath $minername

$global:maxRestarts=10
$global:allowReboot=$false
$global:allowScreenshot=$false

function screenshot {
    if ($allowScreenshot)
    {
    Add-Type -AssemblyName System.Windows.Forms;
    Add-type -AssemblyName System.Drawing;

    $d = Get-Date
    [string]$timestamp=$d.Month.tostring() + "." + $d.Day.ToString() + "." + $d.hour +"." +$d.Minute
    
    $scrDir = Join-Path $PSScriptRoot -ChildPath "scrns"
   

    [string]$FileNamePattern = 'screenshot_{0}.png'
    $fileName = $FileNamePattern -f (Get-Date).ToString('MM.dd.HH.mm')
    $path = Join-Path $scrDir -ChildPath $fileName
 
    $b = New-Object System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height)
    $g = [System.Drawing.Graphics]::FromImage($b)
    $g.CopyFromScreen((New-Object System.Drawing.Point(0,0)), (New-Object System.Drawing.Point(0,0)), $b.Size)
    $g.Dispose()

    try {
        $b.Save($path)
    } catch {
        New-Item -Path $scrDir -ItemType Directory
        $b.Save($path)
    } 
    write-host -ForegroundColor Green "$fileName saved"
    }
}

function clearJobs {
    Get-Job | Stop-Job
    Get-Job | Remove-Job
}

function RebootRig {
    Get-Process *miner* | Stop-Process
    clearJobs
    Restart-Computer -Force
}

function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE)
    {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else
    {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}


function resetGpus {
    $gpus = Get-PnpDevice -Class Display
    foreach($g in $gpus) {
        $gname=$g.FriendlyName
        if ($gname -notmatch "Intel") {
            $g | Disable-PnpDevice -Confirm:$false
            write-host -ForegroundColor Red "$gname Disabled"
            sleep -Milliseconds 200
            $g | Enable-PnpDevice -Confirm:$false
            write-host -ForegroundColor Green "$gname Enabled"
            sleep -Milliseconds 200
        } else {
            Write-host -ForegroundColor Yellow "skipping $gname"
            sleep -Milliseconds 200
        }
    }
}

function SaveOldLog {
    Write-host "Saving old log..."
    $d = Get-Date
        [string]$timestamp=$d.Month.tostring() + "." + $d.Day.ToString() + "." + $d.hour +"." +$d.Minute
    try {
        Copy-Item -Path $logpath -Destination (Join-Path -Path $oldLogsFolderPath -ChildPath "$timestamp.log") -ErrorAction SilentlyContinue
    } catch {
        New-Item -Path $oldLogsFolderPath -ItemType Directory
        Copy-Item -Path $logpath -Destination (Join-Path -Path $oldLogsFolderPath -ChildPath "$timestamp.log")
    }
}

function killMiner {
    try {
        Get-Process *miner* -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Write-Host -ForegroundColor Green "miner not running"
    } catch {
        write-host -ForegroundColor Red "Error Cannot kill the miner process"
    }
}

function startMiner
{
    Write-host -ForegroundColor Yellow -BackgroundColor Black "Starting miner..."
     try {
        Test-Path $minerPath
        Start-Process -FilePath $minerPath -RedirectStandardOutput $logpath -WindowStyle Minimized -ArgumentList $paramsList -WorkingDirectory $PSScriptRoot
        Write-Host -ForegroundColor Green "miner started..."
    } catch {
        write-host -ForegroundColor Red "Error, minner not found, check your config!"
        Pause "Press any key to exit script"
        Exit
    }
}

function noDeviceError {
    "$time $line Critical error, GPU missing, check your PCIe extenders and cables. Rebooting rig in 10 second" |
        Out-File -FilePath "$PSScriptRoot\watchdog.log" -Append |
        Write-Host -ForegroundColor Red      
    screenshot
    sleep 10
	if ($allowReboot)
    {
        RebootRig
	} else {
		Write-Host -fore Red "Reboot disabled in watchdog, exiting watchdog."
		killMiner
        clearJobs
        Pause "Press any key to exit watchdog" 
		Exit
	}
}

function noAuthorizedError ($line) {
                $t = Get-Date
                "$t $line Error: Worker address not correct or pool offline. Closing Watchdog." |
                    Tee-Object -FilePath "$PSScriptRoot\watchdog.log" -Append |
                    Write-Host -ForegroundColor Red
                screenshot
		        killMiner
                clearJobs
                Pause "Press any key to exit script"
                Exit
}

function watchdog
{
    $latest = start-job -ArgumentList $logpath -ScriptBlock {
            param($file)
            Get-Content $file -Wait -tail 1
    }

    $zeroSol = " 0 sol"
    $zeroSol2 = " 0.0 sol"
    $zeroSol3 = " 0.00 sol"
    $noDevice = "Error: There is no device"
    $noAuthorize = "Authorization problem on all configured pools"
    $maxEmptyLines=2400; #  120 sec
    $waitForJob = 50 # ms
    $emptyLines=0;
    $firstTime = $true;
    $lineNumber = 0;
    while ($true)
    {
        if($firstTime) {
            Start-Sleep 2
            $line = Get-Content -Path $logpath;
            $firstTime = $false;
            $line
            if($line -match $noDevice) { noDeviceError }
            if($line -match $noAuthorize) { noAuthorizedError $line }      
        }
          
        $line = Receive-Job -Job $latest
        Start-Sleep -Milliseconds $waitForJob

        if($line.Length -gt 0)
        {
            $emptyLines = 0; # reset counter, miner not stuck
            $lineNumber++;
            $time = get-date;

        if($line -match $noDevice){ noDeviceError }
        if($line -match $noAuthorize) { noAuthorizedError }              

        if($line -match $zeroSol) # zero sol detected
        {
            Write-host -ForegroundColor Red -BackgroundColor White $line
            Write-Host -ForegroundColor Red -BackgroundColor black "ERROR 0 HASH! at line $lineNumber `nRestarting miner in 10 seconds!";
                
            "$time 0 sol/s detected, restarting miner..." | Out-File -FilePath "$PSScriptRoot\watchdog.log" -Append
            screenshot
            Start-Sleep 10
            return;
        }

	if($line -match $zeroSol2) # zero sol detected
        {
            Write-host -ForegroundColor Red -BackgroundColor White $line
            Write-Host -ForegroundColor Red -BackgroundColor black "ERROR 0 HASH! at line $lineNumber `nRestarting miner in 10 seconds!";
                
            "$time 0 sol/s detected, restarting miner..." | Out-File -FilePath "$PSScriptRoot\watchdog.log" -Append
            screenshot
            Start-Sleep 10
            return;
        }

	 if($line -match $zeroSol3) # zero sol detected
        {
            Write-host -ForegroundColor Red -BackgroundColor White $line
            Write-Host -ForegroundColor Red -BackgroundColor black "ERROR 0 HASH! at line $lineNumber `nRestarting miner in 10 seconds!";
                
            "$time 0 sol/s detected, restarting miner..." | Out-File -FilePath "$PSScriptRoot\watchdog.log" -Append
            screenshot
            Start-Sleep 10
            return;
        }
	
         
        $line # no error detected, display line
            
        } else { # line is empty
            $emptyLines++;
            if ($emptyLines -gt $maxEmptyLines) { # miner stuck
                $time = get-date;
                "$time Miner stuck, restarting miner..." | Tee-Object -FilePath "$PSScriptRoot\watchdog.log" -Append | write-host -ForegroundColor Red
                screenshot
                Start-Sleep 5
                return;
            }
        } # else

    } # while

}
###### MAIN #######

while($restatedTimes -lt $maxRestarts) { 
    killMiner
    SaveOldLog
    resetGpus
    startMiner
    clearJobs
    watchdog
}

if ($allowReboot) {
	Write-Host -ForegroundColor Red "miner restarted $maxRestarts times, Restarting rig in 10 second"
	"miner restarted $maxRestarts times, Restarting rig..." | Out-File -FilePath "$PSScriptRoot\watchdog.log" -Append
	screenshot
	sleep 10
	RebootRig 
} else {
    Write-host -ForegroundColor Red "miner restarted $maxRestarts times. Miner is not running!"
    Pause "Press any key to close watchdog"
}

######## END #####
