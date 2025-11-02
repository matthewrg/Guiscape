; StringSize example ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#include <GUIConstantsEx.au3>
#include "StringSize.au3"

Global $aFont[4] = ["Arial", "Tahoma", "Courier New", "Comic Sans MS"]
Global $aSize[4] = [9, 12, 10, 15]
Global $aWeight[4] = [200, 400, 600, 800]
Global $aAttrib[4] = [0, 2, 4, 0]
Global $aMaxWidth[4] = [250, 300, 400, 500]
Global $aColour[4] = [0xFFFF88, 0xBBFF88, 0xBB88FF, 0xFF88FF]
Global $aButMsg[4] = ["Press for next example", "Click here", "Please push", "And the next one please..."]

$sLabelMsg  = "This is a message with very long lines which are unlikely to fit within a GUI of a specified maximum width.  " & _
"This UDF will return the size of rectangle needed to display the message in a selected font and size." & @CRLF & @CRLF & _
"The GUI can then be sized to fit and accurately placed on screen.  Other controls, such as the automatically " & _
"sized button under this label, can also be accurately positioned relative to the text."

$hGUI = GUICreate("String Sizing Test", 500, 500)

$hLabel = GUICtrlCreateLabel("", 10, 10, -1, -1, 1)
$hNext = GUICtrlCreateButton("", 210, 460, 80, 30)

GUISetState(@SW_HIDE)

While 1

	$sFont = $aFont[Random(0, 3, 1)]
	$iSize = $aSize[Random(0, 3, 1)]
	$iWeight = $aWeight[Random(0, 3, 1)]
	$iAttrib = $aAttrib[Random(0, 3, 1)]
	$iMaxWidth = Random(200, 850, 1)
	$iColour = $aColour[Random(0, 3, 1)]
	$sButMsg = $aButMsg[Random(0, 3, 1)]

	$aButReturn = _StringSize($sButMsg)
	$aMsgReturn = _StringSize($sLabelMsg, $iSize, $iWeight, $iAttrib, $sFont, $iMaxWidth)
	$iError = @error

	If IsArray($aMsgReturn) = 1 Then

		WinMove("String Sizing Test", "", (@DesktopWidth - ($aMsgReturn[2] + 25)) / 2, (@DesktopHeight - ($aMsgReturn[3] + 85)) / 2, $aMsgReturn[2] + 25, $aMsgReturn[3] + 85 )
		GUISetState(@SW_SHOW, $hGUI)

		ControlMove($hGUI, "", $hLabel, 10, 10, $aMsgReturn[2], $aMsgReturn[3])
			GUICtrlSetData($hLabel, $aMsgReturn[0])
			GUICtrlSetFont($hLabel, $iSize, $iWeight, $iAttrib, $sFont)
			GUICtrlSetBkColor($hLabel, $iColour)
		ControlMove($hGUI, "", $hNext, ($aMsgReturn[2] - $aButReturn[2]) / 2, $aMsgReturn[3] + 20, $aButReturn[2] + 20, 30)
			GUICtrlSetData($hNext, $aButReturn[0])

		While 1
			Switch GUIGetMsg()
				Case $GUI_EVENT_CLOSE
					Exit
				Case $hNext
					ExitLoop
			EndSwitch
		WEnd
	Else
		MsgBox(0, "Error", "Code = " & $iError)
	EndIf
WEnd

Exit

; End of example ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

