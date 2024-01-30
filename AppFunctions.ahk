#Requires AutoHotkey v2.0

ToggleAppTaskbar(rootDir, exeName)
{
    wasAlreadyRunning := AppIsOpened(exeName)

    if (!TryRunApp(rootDir, exeName))
    {
        ; Try again manually in a few seconds
        return
    }

    if (!wasAlreadyRunning)
    {
        ; Soundn't be minimized/maximized
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
    if (AppIsOpened(exeName))
    {
        return true
    }

    attemptsLeft := 3
    while (!AppIsOpened(exeName) and attemptsLeft != 0)
    {
        Run(rootDir . exeName)
        Sleep(100)
        WinWait("ahk_exe " . exeName,, 1.0)
        attemptsLeft--
    }

    if (attemptsLeft)
    {
        TrayTip("Failed to start the application. Attempts are exhausted.", exeName, "Icon!")
    }

    return AppIsOpened(exeName)
}

MinimizeApp(exeName)
{
    if (!AppIsOpened(exeName))
    {
        return
    }

    windowTitle := "ahk_exe " . exeName
    ; WinMinimize(windowTitle)
    PostMessage 0x0112, 0xF020,,, windowTitle
}

TerminateApp(exeName)
{
    ProcessClose(exeName)
    ProcessWaitClose(exeName, 3.0)
}

AppIsOpened(exeName)
{
    return WinExist("ahk_exe " . exeName)
}