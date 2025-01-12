Sub forceCScriptExecution
    Dim Arg, Str
    If Not LCase( Right( WScript.FullName, 12 ) ) = "\cscript.exe" Then
        For Each Arg In WScript.Arguments
            If InStr( Arg, " " ) Then Arg = """" & Arg & """"
            Str = Str & " " & Arg
        Next
        CreateObject( "WScript.Shell" ).Run _
            "cscript //nologo """ & _
            WScript.ScriptFullName & _
            """ " & Str
        WScript.Quit
    End If
End Sub
forceCScriptExecution

Wscript.Echo "BSG WinInfo"
Wscript.Echo "(C) 2025 Bastion Faculty of Computer Science"
Wscript.Echo ""
Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")
 
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
 
Set colOperatingSystems = objWMIService.ExecQuery _
    ("Select * from Win32_OperatingSystem")
 
For Each objOperatingSystem in colOperatingSystems
    Wscript.Echo "Boot Device: " & objOperatingSystem.BootDevice
    Wscript.Echo "Build Number: " & objOperatingSystem.BuildNumber
    Wscript.Echo "Build Type: " & objOperatingSystem.BuildType
    Wscript.Echo "Caption: " & objOperatingSystem.Caption
    Wscript.Echo "Code Set: " & objOperatingSystem.CodeSet
    Wscript.Echo "Country Code: " & objOperatingSystem.CountryCode
    Wscript.Echo "Debug: " & objOperatingSystem.Debug
    Wscript.Echo "Encryption Level: " & objOperatingSystem.EncryptionLevel
    dtmConvertedDate.Value = objOperatingSystem.InstallDate
    dtmInstallDate = dtmConvertedDate.GetVarDate
    Wscript.Echo "Install Date: " & dtmInstallDate
    Wscript.Echo "Licensed Users: " & _
        objOperatingSystem.NumberOfLicensedUsers
    Wscript.Echo "Organization: " & objOperatingSystem.Organization
    Wscript.Echo "OS Language: " & objOperatingSystem.OSLanguage
    Wscript.Echo "OS Product Suite: " & objOperatingSystem.OSProductSuite
    Wscript.Echo "OS Type: " & objOperatingSystem.OSType
    Wscript.Echo "Primary: " & objOperatingSystem.Primary
    Wscript.Echo "Registered User: " & objOperatingSystem.RegisteredUser
    Wscript.Echo "Serial Number: " & objOperatingSystem.SerialNumber
    Wscript.Echo "Version: " & objOperatingSystem.Version
Next

Set colSettings = objWMIService.ExecQuery _
    ("Select * from Win32_ComputerSystem")
For Each objComputer in colSettings
    Wscript.Echo "System Name: " & objComputer.Name
    Wscript.Echo "System Manufacturer: " & objComputer.Manufacturer
    Wscript.Echo "System Model: " & objComputer.Model
    Wscript.Echo "Time Zone: " & objComputer.CurrentTimeZone
    Wscript.Echo "Total Physical Memory: " & _
    objComputer.TotalPhysicalMemory
Next

Set colSettings = objWMIService.ExecQuery _
    ("Select * from Win32_Processor")
For Each objProcessor in colSettings
    Wscript.Echo "System Type: " & objProcessor.Architecture
    Wscript.Echo "Processor: " & objProcessor.Description
Next
    Set colSettings = objWMIService.ExecQuery _
    ("Select * from Win32_BIOS")
For Each objBIOS in colSettings
    Wscript.Echo "BIOS Version: " & objBIOS.Version
Next

Wscript.Echo ""
Wscript.Echo "Press [Enter] to quit."

WScript.StdIn.ReadLine