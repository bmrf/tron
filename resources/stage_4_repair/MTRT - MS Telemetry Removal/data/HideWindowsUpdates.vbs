On Error Resume Next
If Wscript.Arguments.Count < 1 Then
    WScript.Quit 1
End If

Dim fso, updateSession, updateSearcher, dt
Set fso = CreateObject("Scripting.FileSystemObject")
Set updateSession = CreateObject("Microsoft.Update.Session")
Set updateSearcher = updateSession.CreateUpdateSearcher()

Dim logPath
set logPath = fso.OpenTextFile(Wscript.Arguments(Wscript.Arguments.Count - 1), 8, True)

Dim kbList()
For i = 0 to Wscript.Arguments.Count - 2
    Redim Preserve kbList(i)
    kbList(i) = Wscript.Arguments(i)
Next

'Log ("                            - Searching for updates (Please wait)"), True
Dim searchResult
Set searchResult = updateSearcher.Search("IsInstalled=0")
'Log ("                            - " & CStr(searchResult.Updates.Count) & " found"), True
Log ("                            - Hiding Updates"), True

Dim index, index2, update, kbArticleId
For index = 0 To searchResult.Updates.Count - 1
    Set update = searchResult.Updates.Item(index)
	For index2 = 0 To update.KBArticleIDs.Count - 1
		kbArticleId = update.KBArticleIDs(index2)
		found = False
		For Each hotfixId in kbList
			If hotfixId = kbArticleId Then
				found = True
				If update.IsHidden = False Then
					Log ("                            - Hiding KB" & hotfixId), True
					Set update.IsHidden = True
				Else
					Log ("                            - KB" & hotfixId & " already hidden"), True
				End If          
			End If          
		Next
		'If found = False Then
			'Log ("                            - KB" & kbArticleId & " not found"), True
		'End If
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