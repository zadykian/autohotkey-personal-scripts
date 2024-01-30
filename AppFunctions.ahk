#Requires AutoHotkey v2.0

ToggleAppTaskbar(rootDir, exeName)
{
    if (!TryRunApp(rootDir, exeName))
    {
        ; Try again manually in a few seconds...
        return
    }

    windowTitle := "ahk_exe " . exeName

    WinGetPos &X, &Y,,, windowTitle

    ; Window is minimized
    if (X = -32000 and Y = -32000)
    {
        ; WinRestore(windowTitle)
        PostMessage 0x0112, 0xF120,,, windowTitle
        return
    }

    MinimizeApp(exeName)
}

TryRunApp(rootDir, exeName)
{
    windowTitle := "ahk_exe " . exeName

    if (WinExist(windowTitle))
    {
        return true
    }

    attemptsLeft := 3
    while (!WinExist(windowTitle) and attemptsLeft != 0)
    {
        Run(rootDir . exeName)
        Sleep(100)
        WinWait(windowTitle,, 1.0)
        attemptsLeft--
    }

    return WinExist(windowTitle)
}

MinimizeApp(exeName)
{
    windowTitle := "ahk_exe " . exeName

    if (!WinExist(windowTitle))
    {
        return
    }

    ; WinMinimize(windowTitle)
    PostMessage 0x0112, 0xF020,,, windowTitle
}

TerminateApp(exeName)
{
    ProcessClose(exeName)
    ProcessWaitClose(exeName, 3.0)
}
