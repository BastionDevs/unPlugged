Set objShell = CreateObject("WScript.Shell")
' Get the user's profile directory
userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")

' Navigate to Chrome Program Files folder
chromePath = objShell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\")

Set fso = CreateObject("Scripting.FileSystemObject")
fso.CreateFolder(userprofile & "\Downloads\Byp4")

' Copy everything in Chrome application folder to the Bypass directory
objShell.Run "xcopy /s /y """ & chromePath & "*.*"" """ & userProfile & "\Downloads\Byp4\""", 0, True

' Rename chrome.exe to policytick.exe in the Bypass directory
Set objFSO = CreateObject("Scripting.FileSystemObject")
chromeExePath = userprofile & "\Downloads\Byp4\chrome.exe"
bypExePath = userprofile & "\Downloads\Byp4\policytick.exe"
objFSO.MoveFile chromeExePath, bypExePath

' Create a shortcut for the copied Chrome executable with the flag --disable-extensions
Set objShortcut = objShell.CreateShortcut(objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk")

' Construct the path to the Downloads folder
downloadsPath = userProfile & "\Downloads\Byp4"

' Set the TargetPath of the shortcut to the Downloads folder
objShortcut.TargetPath = downloadsPath & "\policytick.exe"

objShortcut.Arguments = " --disable-extensions"
objShortcut.Save

' Close all Chrome tabs
objShell.Run "taskkill /f /im chrome.exe", 0, True
MsgBox "All Chrome tabs has been closed"

MsgBox "A Chrome shortcut has been created in your Desktop. Launch the new shortcut for the Blocksi Enterprise Edition bypass"