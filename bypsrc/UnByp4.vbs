' Create an instance of the WScript.Shell object
Set objShell = CreateObject("WScript.Shell")

' Get the current user's profile directory
userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")

' Define paths for the "Byp4" directory and the shortcut
byp4Path = userProfile & "\Downloads\Byp4"
shortcutPath = objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk"

' Create an instance of the FileSystemObject
Set fso = CreateObject("Scripting.FileSystemObject")

' Kill any running instances of Chrome
objShell.Run "taskkill /f /im policytick.exe", 0, True

MsgBox "All policytick.exe/Byp4 instances closed."

' Check if the "Byp4" folder exists and delete it if it does
If fso.FolderExists(byp4Path) Then
    fso.DeleteFolder byp4Path, True
End If

' Check if the shortcut exists and delete it if it does
If fso.FileExists(shortcutPath) Then
    fso.DeleteFile shortcutPath
End If

' Display a message box indicating that the cleanup is complete
MsgBox "Chrome clone and shortcut have been deleted."
