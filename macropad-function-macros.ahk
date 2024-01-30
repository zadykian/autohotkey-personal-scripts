#Requires AutoHotkey v2.0
#SingleInstance Force


; Central Encoder
!F20::Volume_Down ; [Rotate Left]
^F20::Volume_Mute ; [Push]
+F20::Volume_Up   ; [Rotate Right]


; Any Key
!F13::Media_Play_Pause ; [Single Tap]
^F13::Media_Next       ; [Double Tap]
+F13::Media_Prev       ; [Triple Tap]

; [Single Hold] Open/Minimize Spotify
!+F13::ToggleAppTaskbar("C:\Users\zadykian\AppData\Roaming\Spotify\", "Spotify.exe")

; [Double Hold] Close Spotify
^+F13::TerminateApp("Spotify.exe")

; [Single Tap] PowerToys Mute Microphone
!F14::#+A

; [Dobule Tap] PowerToys Mute Camera
^F14::#+O

; [Single Hold] PowerToys Mute Microphone and Camera
!+F14::#+Q

; [Single Tap] Open/Minimize Telegram
!F15::ToggleAppTaskbar("C:\Tools\Telegram.TelegramDesktop\", "Telegram.exe")

; [Double Tap] Open/Minimize Discord
^F15::ToggleAppTaskbar(
    "",
    "Discord.exe",
    "pwsh.exe -c `"ii \`"C:\Users\zadykian\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk\`"`""
)


; [Single Tap] Open/Minimize HWMonitorPro
!F16::ToggleAppTaskbar("C:\Program Files\HWMonitorPro\", "HWMonitorPro.exe")

; [Single Hold] Switch Between FanControl Profiles
!+F16::
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


ToggleAppTaskbar(rootDir, exeName, runCommand := "")
{
    windowTitle := "ahk_exe " . exeName

    if (!WinExist(windowTitle))
    {
        Run(runCommand == "" ? rootDir . exeName : runCommand)
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

TerminateApp(exeName)
{
    ProcessClose(exeName)
    ProcessWaitClose(exeName, 3.0)
}
