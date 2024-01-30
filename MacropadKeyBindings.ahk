#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "AppFunctions.ahk"
#Include "AppPaths.ahk"
#Include "FanControl.ahk"

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
