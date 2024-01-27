#Requires AutoHotkey v2.0

F15::
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
