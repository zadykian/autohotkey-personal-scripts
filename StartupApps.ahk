#Requires AutoHotkey v2.0
#SingleInstance Force

#Include AppFunctions.ahk
#Include AppPaths.ahk


RunAndMinimize(GetDiscordRootDir(), DiscordExeName)
RunAndMinimize(GetHwMonitorRootDir(), HWMonitorExeName)


RunAndMinimize(rootDir, exeName)
{
    if (!TryRunApp(rootDir, exeName))
    {
        return
    }

    MinimizeApp(exeName)
}
