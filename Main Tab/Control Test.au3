; *** Start added by AutoIt3Wrapper ***
#include <WindowsStylesConstants.au3>
; *** End added by AutoIt3Wrapper ***
#AutoIt3Wrapper_Add_Constants=n

#include <GUIConstantsEx.au3>
#include <GuiTab.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("Tab Control Insert Item (v" & @AutoItVersion & ")", 450, 300, 100, 100)

	Local $idTab = GUICtrlCreateTab(2, 2, 446, 266)

	GUISetState(@SW_SHOW)

	_GUICtrlTab_InsertItem($idTab, 0, "Tab 0")
	
	Local $test =GUICreate( _
			"Parameters", _
			200, _
			200, _
			10, _
			30, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW)
			
	GUISetState(@SW_SHOW, $test)

	_GUICtrlTab_InsertItem($idTab, 1, "Tab 1")

	_GUICtrlTab_InsertItem($idTab, 2, "Tab 2")
	
	Sleep(5000)
EndFunc   ;==>Example
