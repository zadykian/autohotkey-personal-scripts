#Requires AutoHotkey v2.0

F15::
{
    pathToHwMonitor := "C:\Program Files\HWMonitorPro\HWMonitorPro.exe"
    hwMonitorWindowTitle := "ahk_exe HWMonitorPro.exe"

    if (!ProcessExist("HWMonitorPro.exe"))
    {
        Run(pathToHwMonitor)
        WinWait(hwMonitorWindowTitle)
        return
    }

    if (WinExist(hwMonitorWindowTitle))
    {
        ; WinMinimize(hwMonitorWindowTitle)
        PostMessage 0x0112, 0xF020,,, hwMonitorWindowTitle
        return
    }

    SendInput "#b{Enter}+{F10}"       ; Open Tray Hidden Icons
    Sleep 100
    SendInput "{Up}{Up}{Enter}" ; Navigate to "Restore"
    return
}
