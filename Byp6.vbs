' Confirmation message for copying files
copyConfirmation = MsgBox("Do you want to copy the Chrome installation files to the Byp6 folder?", vbYesNo + vbQuestion, "Confirm File Copy")

If copyConfirmation = vbYes Then
    ' Perform the file copying process once
    Set objShell = CreateObject("WScript.Shell")
    userProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")
    chromePath = objShell.ExpandEnvironmentStrings("%ProgramFiles%\Google\Chrome\Application\")
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' Create new directory for files
    fso.CreateFolder(userProfile & "\Downloads\Byp6")
    
    ' Copy files from Chrome installation directory to new directory
    objShell.Run "xcopy /s /y """ & chromePath & "*.*"" """ & userProfile & "\Downloads\Byp6\""", 0, True
    
    ' Rename Chrome executable
    chromeExePath = userProfile & "\Downloads\Byp6\chrome.exe"
    bypExePath = userProfile & "\Downloads\Byp6\policytick.exe"
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    objFSO.MoveFile chromeExePath, bypExePath
    
    MsgBox "Files have been successfully copied and Chrome has been renamed.", vbInformation, "Copy Complete"
    
    ' Ask for option selection to create a shortcut
    userChoice = MsgBox("Do you want to run Option 1 (Disable ExtensionManifestV2)?", vbYesNo + vbQuestion, "Choose Option")

    ' Create the shortcut based on user's choice
    If userChoice = vbYes Then
        ' Option 1: Create shortcut with --enable-features=ExtensionManifestV2DeprecationDisabled
        Set objShortcut = objShell.CreateShortcut(objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk")
        downloadsPath = userProfile & "\Downloads\Byp6"
        objShortcut.TargetPath = downloadsPath & "\policytick.exe"
        objShortcut.Arguments = " --enable-features=ExtensionManifestV2DeprecationDisabled"
        objShortcut.Save

        MsgBox "Option 1: Shortcut created on Desktop with ExtensionManifestV2DeprecationDisabled."

    ElseIf userChoice = vbNo Then
        ' Option 2: Create shortcut with --disable-extensions
        Set objShortcut = objShell.CreateShortcut(objShell.SpecialFolders("Desktop") & "\Google Chrome.lnk")
        downloadsPath = userProfile & "\Downloads\Byp6"
        objShortcut.TargetPath = downloadsPath & "\policytick.exe"
        objShortcut.Arguments = " --disable-extensions"
        objShortcut.Save

        MsgBox "Option 2: Shortcut created on Desktop with extensions disabled."
    Else
        MsgBox "No option selected. Exiting script.", vbExclamation, "Exit"
    End If

    ' Kill any running Chrome instances
    objShell.Run "taskkill /f /im chrome.exe", 0, True
    MsgBox "All Chrome tabs have been closed."

Else
    ' Exit if the user chooses not to copy files
    MsgBox "File copying process canceled. Exiting script.", vbExclamation, "Exit"
End If
