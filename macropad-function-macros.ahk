#Requires AutoHotkey v2.0

F15::
{
    pathToHwMonitor := "C:\Program Files\HWMonitorPro\HWMonitorPro.exe"
    hwMonitorWindowTitle := "ahk_exe HWMonitorPro.exe"

    Run(pathToHwMonitor)
    WinWait(hwMonitorWindowTitle)

;    if (!ProcessExist("HWMonitorPro.exe"))
;    {
;        Run(pathToHwMonitor)
;        WinWait(hwMonitorWindowTitle)
;        return
;    }

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
