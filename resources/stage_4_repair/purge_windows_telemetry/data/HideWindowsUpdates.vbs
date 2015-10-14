On Error Resume Next
If Wscript.Arguments.Count < 1 Then
    WScript.Quit 1
End If

Dim fso, logPath
Set fso = CreateObject("Scripting.FileSystemObject")
set logPath = fso.OpenTextFile(Wscript.Arguments(Wscript.Arguments.Count - 1), 8, True)

Dim hideupdates()
For i = 0 to Wscript.Arguments.Count - 2
    Redim Preserve hideupdates(i)
    hideupdates(i) = Wscript.Arguments(i)
Next


set updateSession = createObject("Microsoft.Update.Session")
set updateSearcher = updateSession.CreateupdateSearcher()

Set searchResult = updateSearcher.Search("IsInstalled=0 and IsHidden=0")
Log ("                             - Hiding Updates"), True

For i = 0 To searchResult.Updates.Count-1
	set update = searchResult.Updates.Item(i)
	For j = LBound(hideupdates) To UBound(hideupdates)
		if instr(1, update.Title, hideupdates(j), vbTextCompare) = 0 then
				'Wscript.echo "No match found for " & hideupdates(j)
			else
				Log ("                              - Hiding KB" & hideupdates(j)), True
				update.IsHidden = True
		end if
	Next
Next


'Function for logging
Function log(logStr, toConsole)
    If toConsole Then
        WScript.Echo logStr
        logPath.WriteLine logStr
    Else
        logPath.WriteLine logStr
    End If
End Function

'Close log file
logPath.Close
'// EOF