#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "AppFunctions.ahk"
#Include "AppPaths.ahk"
#Include "FanControl.ahk"

A_HotkeyInterval := 1000
A_MaxHotkeysPerInterval := 100
A_MenuMaskKey := "vkFF" ; vkFF is reserved to mean "no mapping"


; [F13 Single Tap] PowerToys Mute Microphone
F13::#+A

; [F13 Dobule Tap] PowerToys Mute Camera
F19::#+O


; [F15 Double Tap] Open/Minimize HWMonitor
F15::ToggleAppTaskbar(GetHwMonitorRootDir(), HWMonitorExeName)

; [F15 Double Tap] Switch Between FanControl Profiles
F21::SwitchFanControlProfile()
