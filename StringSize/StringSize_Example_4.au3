

#include <GUIConstantsEx.au3>

#include "StringSize.au3"

; Declare arrays to hold parameters
Global $aFont[4] = ["Arial", "Tahoma", "Courier New", "Comic Sans MS"]
Global $aWeight[4] = [200, 400, 600, 800]
Global $aAttrib[4] = [0, 2, 4, 0]
Global $aColour[4] = [0xFFFFD0, 0xD0FFD0, 0xD0D0FF, 0xFFD0FF]

$sText = "The UDF will calculate the largest possible font size which will allow this text to fit in the randomly sized label.  " & _
	"Pressing the 'Increase' button will use the next size up so you can see how successful it was.  " & @CRLF & _
	"Note that the UDF is pessimistic and will leave small borders to the right and at the bottom of the text, so you might " & _
	"be able to go one size up in a few cases, although this risks clipping the trailing edges of italic letters or the tails of letters such as 'g'."

$hGUI = GUICreate("Test", 500, 500, 100, 100)

$hButton_Next = GUICtrlCreateButton("Next", 10, 10, 80, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$hLabel_Size = GUICtrlCreateLabel("", 100, 10, 40, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetFont(-1, 24)

$hButton_Increase = GUICtrlCreateButton("Increase", 150, 10, 80, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

GUISetState()

While 1

	; Choose parameter values

	$iX = 10 * Random(25, 50, 1)
	$iY = 10 * Random(10, 40, 1)
	$sFont = $aFont[Random(0, 3, 1)]
	$iWeight = $aWeight[Random(0, 3, 1)]
	$iAttrib = $aAttrib[Random(0, 3, 1)]
	$iColour = $aColour[Random(0, 3, 1)]

	WinMove($hGUI, "", 100, 100, $iX + 26, $iY + 85)
	$hLabel = GUICtrlCreateLabel("", 10, 50, $iX, $iY)
	GUICtrlSetBkColor(-1, $iColour)

	For $iSize = 5 To 50
		$aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
	If $aSize[3] > $iY Then
			$iSize -= 1
			ExitLoop
		EndIf
	Next

	GUICtrlSetData($hLabel_Size, $iSize)
	GUICtrlSetFont($hLabel, $iSize, $iWeight, $iAttrib, $sFont)
	$aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
	GUICtrlSetData($hLabel, $aSize[0])

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
			Case $hButton_Next
				GUICtrlDelete($hLabel)
				GUICtrlSetData($hLabel_Size, "")
				ExitLoop
			Case $hButton_Increase
				GUICtrlSetData($hLabel, "")
				$iSize += 1
				GUICtrlSetData($hLabel_Size, $iSize)
				GUICtrlSetFont($hLabel, $iSize, $iWeight, $iAttrib, $sFont)
				$aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
				GUICtrlSetData($hLabel, $aSize[0])
		EndSwitch
	WEnd

WEnd