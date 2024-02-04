#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "AppFunctions.ahk"
#Include "AppPaths.ahk"
#Include "FanControl.ahk"

A_HotkeyInterval := 1000
A_MaxHotkeysPerInterval := 100


; Central Encoder

; [Rotate Left] Decrease Volume
!F20::
{
    Send("{Volume_Down}")
    ReleaseModifierKeys()
}

; [Push] Mute / Unmute Volume
^F20::
{
    Send("{Volume_Mute}")
    ReleaseModifierKeys()
}

; [Rotate Right] Increase Volume
+F20::Volume_Up
{
    Send("{Volume_Up}")
    ReleaseModifierKeys()
}


; [Single Tap] Play / Pause
!F13::
{
    Send("{Media_Play_Pause}")
    ReleaseModifierKeys()
}

; [Double Tap] Next Track
^F13::
{
    Send("{Media_Next}")
    ReleaseModifierKeys()
}

; [Triple Tap] Previous 
+F13::
{
    Send("{Media_Prev}")
    ReleaseModifierKeys()
}

; [Single Hold] Open/Minimize Spotify
!+F13::
{
    ToggleAppTaskbar(GetSpotifyRootDir(), SpotifyExeName)
    ReleaseModifierKeys()
}

; [Double Hold] Close Spotify
^+F13::
{
    TerminateApp(SpotifyExeName)
    ReleaseModifierKeys()
}

; [Single Tap] PowerToys Mute Microphone
; !F14::#+A

; [Dobule Tap] PowerToys Mute Camera
; ^F14::#+O

; [Single Hold] PowerToys Mute Microphone and Camera
;!+F14::#+Q


; [Single Tap] Open/Minimize Telegram
!F15::ToggleAppTaskbar(GetTelegramRootDir(), TelegramExeName)

; [Double Tap] Open/Minimize Discord
^F15::ToggleAppTaskbar(GetDiscordRootDir(), DiscordExeName)


; [Single Tap] Open/Minimize HWMonitorPro
!F16::ToggleAppTaskbar(GetHwMonitorRootDir(), HWMonitorExeName)

; [Single Hold] Switch Between FanControl Profiles
!+F16:: SwitchFanControlProfile()

ReleaseModifierKeys()
{
    for key in [ "LAlt", "RAlt", "LControl", "RControl", "LShift", "RShift", "LWin", "RWin" ]
    {
        Send("{" . key . " up}")
    }
}
