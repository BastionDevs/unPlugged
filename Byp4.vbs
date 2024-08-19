' Create an instance of the WScript.Shell object
Set objShell = CreateObject("WScript.Shell")

' Get the current user's profile directory
userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")

' Get the path to the Google Chrome installation directory
chromePath = objShell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\")

' Create an instance of the FileSystemObject
Set fso = CreateObject("Scripting.FileSystemObject")

' Create a new directory in the user's Downloads folder named "Byp4"
fso.CreateFolder(userProfile & "\Downloads\Byp4")

' Copy all files from the Chrome installation directory to the new "Byp4" directory
objShell.Run "xcopy /s /y """ & chromePath & "*.*"" """ & userProfile & "\Downloads\Byp4\""", 0, True

' Define paths for the new locations of the Chrome executable and the renamed executable
Set objFSO = CreateObject("Scripting.FileSystemObject")
chromeExePath = userProfile & "\Downloads\Byp4\chrome.exe"
bypExePath = userProfile & "\Downloads\Byp4\policytick.exe"

' Rename the Chrome executable to "policytick.exe"
objFSO.MoveFile chromeExePath, bypExePath

' Create a shortcut on the desktop for the renamed Chrome executable
Set objShortcut = objShell.CreateShortcut(objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk")

' Set the path to the new "Byp4" directory
downloadsPath = userProfile & "\Downloads\Byp4"

' Set the target path of the shortcut to the renamed executable
objShortcut.TargetPath = downloadsPath & "\policytick.exe"

' Add command line arguments to disable extensions
objShortcut.Arguments = " --disable-extensions"
objShortcut.Save

' Kill any running instances of Chrome
objShell.Run "taskkill /f /im chrome.exe", 0, True

' Display a message box indicating all Chrome tabs have been closed
MsgBox "All Chrome tabs have been closed"

' Display a message box indicating the shortcut creation and usage
MsgBox "A Chrome shortcut has been created on your Desktop. Launch the new shortcut for the Blocksi Enterprise Edition bypass"
