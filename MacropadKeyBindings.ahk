#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "AppFunctions.ahk"
#Include "AppPaths.ahk"
#Include "FanControl.ahk"

A_HotkeyInterval := 1000
A_MaxHotkeysPerInterval := 100
A_MenuMaskKey := "vkFF" ; vkFF is reserved to mean "no mapping"

; Central Encoder

; [Rotate Left] Decrease Volume
!F20::Volume_Down

; [Push] Mute / Unmute Volume
^F20::Volume_Mute

; [Rotate Right] Increase Volume
+F20::Volume_Up


; [Single Tap] Play / Pause
!F13::Media_Play_Pause

; [Double Tap] Next Track
^F13::Media_Next

; [Triple Tap] Previous Track
+F13::Media_Prev

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
