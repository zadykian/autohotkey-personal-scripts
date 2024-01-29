#Requires AutoHotkey v2.0
#SingleInstance Force

F14::
{
    ; todo: mute / unmute microphone
}

^F14::
{
    ; todo: open / close mixer (Settings -> System -> Sound -> Volume Mixer)
}

; Open and Minimize HWMonitorPro from Task Bar
F16::
{
    pathToHwMonitor := "C:\Program Files\HWMonitorPro\HWMonitorPro.exe"
    hwMonitorWindowTitle := "ahk_exe HWMonitorPro.exe"

    Run(pathToHwMonitor)
    Sleep(100)
    WinWait(hwMonitorWindowTitle,, 1.0)

    if (!WinExist(hwMonitorWindowTitle))
    {
        ; For some reason HWMonitorPro is still not running,
        ; try again manually in a few seconds...
        return
    }

    WinGetPos &X, &Y,,, hwMonitorWindowTitle

    ; Window is minimized
    if (X = -32000 and Y = -32000)
    {
        ; WinRestore(hwMonitorWindowTitle)
        PostMessage 0x0112, 0xF120,,, hwMonitorWindowTitle
        return
    }

    ; WinMinimize(hwMonitorWindowTitle)
    PostMessage 0x0112, 0xF020,,, hwMonitorWindowTitle
    return
}

; Switch Between FanControl Profiles
^F16::
{
    rootDir := "C:\Program Files (x86)\FanControl\"
    configDir := rootDir . "Configurations\"

    configFiles := []
    loop files configDir "*.json"
    {
        configFiles.Push(A_LoopFileName)
    }

    if (configFiles.Length == 0)
    {
        TrayTip("No any configuration files found", "FanControl")
        return
    }

    targetConfigName := configFiles[1]
    pathToLastSelected := configDir . "LastSelected.config"
    if (FileExist(pathToLastSelected))
    {
        lastSelectedConfig := FileRead(pathToLastSelected)
        ; Selecting the next (i + 1) configuration
        for index, value in configFiles
        {
            if (value == lastSelectedConfig)
            {
                targetIndex := index + 1 > configFiles.Length ? 1 : index + 1
                targetConfigName := configFiles[targetIndex]
                break
            }
        }

        FileDelete(pathToLastSelected)
    }

    FileAppend(targetConfigName, pathToLastSelected)
    Run(rootDir . "FanControl.exe --config " . targetConfigName)
    TrayTip("Switched to " . targetConfigName . " configuration", "FanControl")
}