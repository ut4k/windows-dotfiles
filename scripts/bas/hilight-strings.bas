Sub HighlightStrings()
'Updateby Extendoffice
Application.ScreenUpdating = False
Dim Rng As Range
Dim cFnd As String
Dim xTmp As String
Dim x As Long
Dim m As Long
Dim y As Long
cFnd = InputBox("Enter the text string to highlight")
y = Len(cFnd)
For Each Rng In Selection
  With Rng
    m = UBound(Split(Rng.Value, cFnd))
    If m > 0 Then
      xTmp = ""
      For x = 0 To m - 1
        xTmp = xTmp & Split(Rng.Value, cFnd)(x)
        .Characters(Start:=Len(xTmp) + 1, Length:=y).Font.ColorIndex = 3
        xTmp = xTmp & cFnd
      Next
    End If
  End With
Next Rng
Application.ScreenUpdating = True
End Sub