; SizeString Test New ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <GUIConstantsEx.au3>
#Include <GuiStatusBar.au3>

#include "StringSize.au3"

; Declare arrays to hold parameters
Global $aFont[4] = ["Arial", "Tahoma", "Courier New", "Comic Sans MS"]
Global $aSize[4] = [9, 12, 10, 15]
Global $aWeight[4] = [200, 400, 600, 800]
Global $aAttrib[4] = [0, 2, 4, 0]
Global $aMaxWidth[4] = [250, 300, 400, 500]
Global $aColour[4] = [0xFFFFD0, 0xD0FFD0, 0xD0D0FF, 0xFFD0FF]
Global $aButMsg[4] = ["Press for next example", "Click here", "Please push", "And the next one please..."]

; Declare preformatted and unformatted strings
$FormatMsg = _
"This is a pre-formatted message with lines of pre-set " & @CRLF & _
"lengths which will not be wrapped. The UDF will " & @CRLF & _
"return the size of rectangle needed to display it " & @CRLF & _
"in a selected font and size." & @CRLF & @CRLF & _
"The GUI can then be sized to fit and accurately placed " & @CRLF & _
"on screen.  Other controls, such as the automatically " & @CRLF & _
"sized button under this label, can also be accurately " & @CRLF & _
"positioned relative to the text."

$UnformatMsg = _
"This is an unformatted message with 2 very long lines which are unlikely to fit within the maximum width specified. The UDF will return the size of rectangle needed to display it in a selected font and size." & @CRLF & @CRLF & _
"The GUI can then be sized to fit and accurately placed on screen.  Other controls, such as the automatically sized button under this label, can also be accurately positioned relative to the text."

; Create GUI
$hGUI = GUICreate("SizeString Test", 500, 500)

; Create radios to select mode of UDF
GUIStartGroup()
$hRadio_Pre = GUICtrlCreateRadio(" Preformatted", 10, 5, 85, 20)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hRadio_Un = GUICtrlCreateRadio(" Unformatted", 95, 5, 85, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUIStartGroup()
$hWidth_Label = GUICtrlCreateLabel("W:900", 460, 8, 40, 20)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT + $GUI_DOCKWIDTH)

; Create and hide status bar
Local $aStatus_Parts[4] = [20, 50, 120, -1]
Global $hStatus_Bar = _GUICtrlStatusBar_Create($hGUI, $aStatus_Parts)
Global $iStatus_Depth = _GUICtrlStatusBar_GetHeight($hStatus_Bar) + 5
_GUICtrlStatusBar_ShowHide($hStatus_Bar, @SW_SHOW)

GUISetState()

While 1

	; Choose parameter values
	$sFont = $aFont[Random(0, 3, 1)]
	$iSize = $aSize[Random(0, 3, 1)]
	$iWeight = $aWeight[Random(0, 3, 1)]
	$iAttrib = $aAttrib[Random(0, 3, 1)]
	$iMaxWidth = 10 * Random(20, 85, 1)
	$iColour = $aColour[Random(0, 3, 1)]
	$sButMsg = $aButMsg[Random(0, 3, 1)]

	; Run UDF,
	$aButReturn = _StringSize($sButMsg)
	If GUICtrlRead($hRadio_Pre) = 1 Then
		$aMsgReturn = _StringSize($FormatMsg, $iSize, $iWeight, $iAttrib, $sFont)
	Else
		$aMsgReturn = _StringSize($UnformatMsg, $iSize, $iWeight, $iAttrib, $sFont, $iMaxWidth)
	EndIf
	$iError = @error

	; If no error
	If IsArray($aMsgReturn) = 1 Then

		; Size GUI as required
		WinMove($hGUI, "", (@DesktopWidth - ($aMsgReturn[2] + 25)) / 2, (@DesktopHeight - ($aMsgReturn[3] + 105)) / 2, $aMsgReturn[2] + 25, $aMsgReturn[3] + 105  + $iStatus_Depth)
		; Resize and fill status bar
		_GUICtrlStatusBar_Resize ($hStatus_Bar)
		_GUICtrlStatusBar_SetText($hStatus_Bar, $iSize,   0)
		_GUICtrlStatusBar_SetText($hStatus_Bar, $iWeight, 1)
		$sAttrib = "Normal"
		Switch $iAttrib
			Case 2
				$sAttrib = "Italic"
			Case 4
				$sAttrib = "Underline"
		EndSwitch
		_GUICtrlStatusBar_SetText($hStatus_Bar, $sAttrib, 2)
		_GUICtrlStatusBar_SetText($hStatus_Bar, $sFont,   3)

		If GUICtrlRead($hRadio_Un) = 1 Then
			GUICtrlSetData($hWidth_Label, "W:" & $iMaxWidth); _GUICtrlStatusBar_SetText($hStatus_Bar, $iMaxWidth & " wide", 4)
		Else
			GUICtrlSetData($hWidth_Label, "");_GUICtrlStatusBar_SetText($hStatus_Bar, "", 4)
		EndIf


		; Create correctly sized label to fit text
		$hLabel = GUICtrlCreateLabel($aMsgReturn[0], 10, 30, $aMsgReturn[2], $aMsgReturn[3], 1)
			GUICtrlSetFont(-1, $iSize, $iWeight, $iAttrib, $sFont)
			GUICtrlSetBkColor(-1, $iColour)
		; Create correctly sized and positioned button
		$hNext = GUICtrlCreateButton($sButMsg, ($aMsgReturn[2] - $aButReturn[2]) / 2, $aMsgReturn[3] + 40, $aButReturn[2] + 20, 30)

		While 1
			Switch GUIGetMsg()
				Case $GUI_EVENT_CLOSE
					Exit
				Case $hNext, $hRadio_Pre, $hRadio_Un
					ExitLoop
			EndSwitch
		WEnd
		; Delete label and button
		GUICtrlDelete($hNext)
		GUICtrlDelete($hLabel)

	Else
		MsgBox(0, "Error", "Code = " & $iError)
	EndIf

WEnd