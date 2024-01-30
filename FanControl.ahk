#Requires AutoHotkey v2.0

#Include "AppPaths.ahk"

SwitchFanControlProfile()
{
    rootDir := GetFanControlRootDir()
    configDir := rootDir . "Configurations\"

    configFiles := []
    loop files configDir "*.json"
    {
        configFiles.Push(A_LoopFileName)
    }

    if (configFiles.Length == 0)
    {
        TrayTip("No any configuration files found", "FanControl")
        return
    }

    targetConfigName := configFiles[1]
    pathToLastSelected := configDir . "LastSelected.config"
    if (FileExist(pathToLastSelected))
    {
        lastSelectedConfig := FileRead(pathToLastSelected)
        ; Selecting the next (i + 1) configuration
        for index, value in configFiles
        {
            if (value == lastSelectedConfig)
            {
                targetIndex := index + 1 > configFiles.Length ? 1 : index + 1
                targetConfigName := configFiles[targetIndex]
                break
            }
        }

        FileDelete(pathToLastSelected)
    }

    FileAppend(targetConfigName, pathToLastSelected)
    Run(rootDir . FanControlExeName . " --config " . targetConfigName)
    TrayTip("Switched to " . targetConfigName . " configuration", "FanControl")
}
