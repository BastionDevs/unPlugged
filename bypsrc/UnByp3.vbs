Set objShell = CreateObject("WScript.Shell")
userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")
filePath = userProfile & "\Downloads\abc.exe"


Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(filePath) Then
    MsgBox "File found! Please continue with uninstallation."
Else
    MsgBox "File not found."
    WScript.Quit
End If

Dim response
response = MsgBox("Are you sure you want to proceed with the uninstallation?(Save your work)", vbYesNo + vbQuestion, "Confirm Uninstallation")

If response = vbYes Then
    ' Closes all Chrome tabs currently open
    objShell.Run "taskkill /F /IM chrome.exe", 0, True
    objShell.Run "taskkill /F /IM abc.exe", 0, True
    MsgBox "All open tabs have been closed"

    ' Removes Byp3
	objShell.Run "cmd /c del /f """ & filePath & """", 0, True

    MsgBox "abc.exe has been removed from your computer"
    MsgBox "Uninstallation has been complete. You may remove the shortcut and the orginal Byp3 + UnByp3 file now."

Else
    MsgBox "Uninstallation has been canceled."
    WScript.Quit
End If
