#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "AppFunctions.ahk"
#Include "AppPaths.ahk"

; Central Encoder
!F20::Volume_Down ; [Rotate Left]
^F20::Volume_Mute ; [Push]
+F20::Volume_Up   ; [Rotate Right]


; Any Key
!F13::Media_Play_Pause ; [Single Tap]
^F13::Media_Next       ; [Double Tap]
+F13::Media_Prev       ; [Triple Tap]

; [Single Hold] Open/Minimize Spotify
!+F13::ToggleAppTaskbar(GetSpotifyRootDir(), SpotifyExeName)

; [Double Hold] Close Spotify
^+F13::TerminateApp(SpotifyExeName)

; [Single Tap] PowerToys Mute Microphone
!F14::#+A

; [Dobule Tap] PowerToys Mute Camera
^F14::#+O

; [Single Hold] PowerToys Mute Microphone and Camera
!+F14::#+Q

; [Single Tap] Open/Minimize Telegram
!F15::ToggleAppTaskbar(GetTelegramRootDir(), TelegramExeName)

; [Double Tap] Open/Minimize Discord
^F15::ToggleAppTaskbar(GetDiscordRootDir(), DiscordExeName)

; [Single Tap] Open/Minimize HWMonitorPro
!F16::ToggleAppTaskbar(GetHwMonitorRootDir(), HWMonitorExeName)

; [Single Hold] Switch Between FanControl Profiles
!+F16:: SwitchFanControlProfile()


SwitchFanControlProfile()
{
    rootDir := GetFanControlRootDir()
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
    Run(rootDir . FanControlExeName . " --config " . targetConfigName)
    TrayTip("Switched to " . targetConfigName . " configuration", "FanControl")
}
