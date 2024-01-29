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


; Open and Minimize Telegram from Task Bar
F15::ToggleApp("C:\Tools\Telegram.TelegramDesktop\", "Telegram.exe")


; Open and Minimize Spotify from Task Bar
^F15::ToggleApp("C:\Users\zadykian\AppData\Roaming\Spotify\", "Spotify.exe")


; Open and Minimize HWMonitorPro from Task Bar
F16::ToggleApp("C:\Program Files\HWMonitorPro\", "HWMonitorPro.exe")


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


ToggleApp(rootDir, exeName)
{
    windowTitle := "ahk_exe " . exeName

    if (!ProcessExist(exeName))
    {
        Run(rootDir . exeName)
        Sleep(100)
        WinWait(windowTitle,, 1.0)
        return
    }

    if (!WinExist(windowTitle))
    {
        ; For some reason application is still not running,
        ; try again manually in a few seconds...
        return
    }

    WinGetPos &X, &Y,,, windowTitle

    ; Window is minimized
    if (X = -32000 and Y = -32000)
    {
        ; WinRestore(windowTitle)
        PostMessage 0x0112, 0xF120,,, windowTitle
        return
    }

    ; WinMinimize(windowTitle)
    PostMessage 0x0112, 0xF020,,, windowTitle
    return
}