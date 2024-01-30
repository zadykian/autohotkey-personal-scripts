$baseDir = "C:\Tools\AutohotkeyScripts"

$scriptsToExecute = @(
    "MacropadKeyBindings.ahk",
    "StartupApps.ahk"
)

foreach ($scriptName in $scriptsToExecute) {
    $scriptFullPath = Join-Path $baseDir $scriptName
    AutoHotkey.exe $scriptFullPath
}

