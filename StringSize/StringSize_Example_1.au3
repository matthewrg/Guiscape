#include <GUIConstantsEx.au3>
#include "StringSize.au3"

$sText = " I am a very long line and I am not formatted in any way so that I will not fit within the width of the GUI that surrounds me!"

$hGUI = GUICreate("Test", 500, 500)

; A label with no width or height set
GUICtrlCreateLabel($sText, 10, 10)
GUICtrlSetBkColor(-1, 0xFF8080)

; A label with no height set
GUICtrlCreateLabel($sText, 10, 50, 200)
GUICtrlSetBkColor(-1, 0xC0C0FF)

; A label sized by StringSize
$aSize = _StringSize($sText, Default, Default, Default, Default, 200)
GUICtrlCreateLabel($aSize[0], 10, 90, $aSize[2], $aSize[3])
GUICtrlSetBkColor(-1, 0x80FF80)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd