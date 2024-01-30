#Requires AutoHotkey v2.0

DiscordExeName := "Discord.exe"

GetDiscordRootDir()
{
    rootDir := ""

    loop files EnvGet("LocalAppData") . "\Discord" . "\app-*", "D"
    {
        rootDir := A_LoopFileFullPath . "\"
    }

    if (rootDir == "")
    {
        throw Error("Failed to find Discord.exe directory!")
    }

    return rootDir
}


FanControlExeName := "FanControl.exe"

GetFanControlRootDir()
{
    return "C:\Program Files (x86)\FanControl\"
}


HWMonitorExeName := "HWMonitorPro.exe"

GetHwMonitorRootDir()
{
    return "C:\Program Files\HWMonitorPro\"
}


SpotifyExeName := "Spotify.exe"

GetSpotifyRootDir()
{
    return "C:\Users\zadykian\AppData\Roaming\Spotify\"
}


TelegramExeName := "Telegram.exe"

GetTelegramRootDir()
{
    return "C:\Tools\Telegram.TelegramDesktop\"
}