#include-once
#include <GuiConstantsEx.au3>
#include <WindowsStylesConstants.au3>

#include "..\AutoItObject.au3"

Func FormExStyles()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "FormExStyles_Create")
	$this.AddMethod("Handler", "FormExStyles_Handler")
	$this.AddMethod("Initialize", "FormExStyles_Initialize")

	$this.AddProperty("WS_EX_ACCEPTFILES", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_APPWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CLIENTEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_COMPOSITED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTEXTHELP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTROLPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_DLGMODALFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYERED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYOUTRTL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LTRREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_MDICHILD", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOACTIVATE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOINHERITLAYOUT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOPARENTNOTIFY", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOREDIRECTIONBITMAP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_PALETTEWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RTLREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_STATICEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOOLWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOPMOST", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TRANSPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_WINDOWEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("GUI_WS_EX_PARENTDRAG", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>FormExStyles

Func FormExStyles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID

EndFunc   ;==>FormExStyles_Handler

Func FormExStyles_Create(ByRef $this)
	GUICtrlCreateTabItem("Extended Styles")

	$this.WS_EX_ACCEPTFILES = GUICtrlCreateCheckbox("WS_EX_ACCEPTFILES", 10, 30)
	$this.WS_EX_APPWINDOW = GUICtrlCreateCheckbox("WS_EX_APPWINDOW", 10, 50)
	$this.WS_EX_CLIENTEDGE = GUICtrlCreateCheckbox("WS_EX_CLIENTEDGE", 10, 70)
	$this.WS_EX_COMPOSITED = GUICtrlCreateCheckbox("WS_EX_COMPOSITED", 10, 90)
	$this.WS_EX_CONTEXTHELP = GUICtrlCreateCheckbox("WS_EX_CONTEXTHELP", 10, 110)
	$this.WS_EX_CONTROLPARENT = GUICtrlCreateCheckbox("WS_EX_CONTROLPARENT", 10, 130)
	$this.WS_EX_DLGMODALFRAME = GUICtrlCreateCheckbox("WS_EX_DLGMODALFRAME", 10, 150)
	$this.WS_EX_LAYERED = GUICtrlCreateCheckbox("WS_EX_LAYERED", 10, 170)
	$this.WS_EX_LAYOUTRTL = GUICtrlCreateCheckbox("WS_EX_LAYOUTRTL", 10, 190)
	$this.WS_EX_LEFT = GUICtrlCreateCheckbox("WS_EX_LEFT", 10, 210)
	$this.WS_EX_LEFTSCROLLBAR = GUICtrlCreateCheckbox("WS_EX_LEFTSCROLLBAR", 10, 230)
	$this.WS_EX_LTRREADING = GUICtrlCreateCheckbox("WS_EX_LTRREADING", 10, 250)
	$this.WS_EX_MDICHILD = GUICtrlCreateCheckbox("WS_EX_MDICHILD", 10, 270)
	$this.WS_EX_NOACTIVATE = GUICtrlCreateCheckbox("WS_EX_NOACTIVATE", 10, 290)
	$this.WS_EX_NOINHERITLAYOUT = GUICtrlCreateCheckbox("WS_EX_NOINHERITLAYOUT", 10, 310)
	$this.WS_EX_NOPARENTNOTIFY = GUICtrlCreateCheckbox("WS_EX_NOPARENTNOTIFY", 10, 330)
	$this.WS_EX_NOREDIRECTIONBITMAP = GUICtrlCreateCheckbox("WS_EX_NOREDIRECTIONBITMAP", 10, 350)
	$this.WS_EX_OVERLAPPEDWINDOW = GUICtrlCreateCheckbox("WS_EX_OVERLAPPEDWINDOW", 10, 370)
	$this.WS_EX_PALETTEWINDOW = GUICtrlCreateCheckbox("WS_EX_PALETTEWINDOW", 10, 390)
	$this.WS_EX_EX_RIGHT = GUICtrlCreateCheckbox("WS_EX_RIGHT", 10, 410)
	$this.WS_EX_RIGHTSCROLLBAR = GUICtrlCreateCheckbox("WS_EX_RIGHTSCROLLBAR", 10, 430)
	$this.WS_EX_RTLREADING = GUICtrlCreateCheckbox("WS_EX_RTLREADING", 10, 450)
	$this.WS_EX_STATICEDGE = GUICtrlCreateCheckbox("WS_EX_STATICEDGE", 10, 470)
	$this.WS_EX_TOOLWINDOW = GUICtrlCreateCheckbox("WS_EX_TOOLWINDOW", 10, 490)
	$this.WS_EX_TOPMOST = GUICtrlCreateCheckbox("WS_EX_TOPMOST", 10, 510)
	$this.WS_EX_TRANSPARENT = GUICtrlCreateCheckbox("WS_EX_TRANSPARENT", 10, 530)
	$this.WS_EX_WINDOWEDGE = GUICtrlCreateCheckbox("WS_EX_WINDOWEDGE", 10, 550)
	$this.GUI_WS_EX_PARENTDRAG = GUICtrlCreateCheckbox("GUI_WS_EX_PARENTDRAG", 10, 570)

	GUICtrlCreateTabItem('')
EndFunc   ;==>FormExStyles_Create

Func FormExStyles_Initialize(ByRef $this, Const $exStyles)
	Local Const $allStyles[] = [$WS_EX_ACCEPTFILES, _
			$WS_EX_APPWINDOW, _
			$WS_EX_CLIENTEDGE, _
			$WS_EX_COMPOSITED, _
			$WS_EX_CONTEXTHELP, _
			$WS_EX_CONTROLPARENT, _
			$WS_EX_DLGMODALFRAME, _
			$WS_EX_LAYERED, _
			$WS_EX_LAYOUTRTL, _
			$WS_EX_LEFT, _
			$WS_EX_LEFTSCROLLBAR, _
			$WS_EX_LTRREADING, _
			$WS_EX_MDICHILD, _
			$WS_EX_NOACTIVATE, _
			$WS_EX_NOINHERITLAYOUT, _
			$WS_EX_NOPARENTNOTIFY, _
			$WS_EX_NOREDIRECTIONBITMAP, _
			$WS_EX_OVERLAPPEDWINDOW, _
			$WS_EX_PALETTEWINDOW, _
			$WS_EX_RIGHT, _
			$WS_EX_RIGHTSCROLLBAR, _
			$WS_EX_RTLREADING, _
			$WS_EX_STATICEDGE, _
			$WS_EX_TOOLWINDOW, _
			$WS_EX_TOPMOST, _
			$WS_EX_TRANSPARENT, _
			$WS_EX_WINDOWEDGE, _
			$GUI_WS_EX_PARENTDRAG]

	Local Const $vars[] = [$this.WS_EX_ACCEPTFILES, _
			$this.WS_EX_APPWINDOW, _
			$this.WS_EX_CLIENTEDGE, _
			$this.WS_EX_COMPOSITED, _
			$this.WS_EX_CONTEXTHELP, _
			$this.WS_EX_CONTROLPARENT, _
			$this.WS_EX_DLGMODALFRAME, _
			$this.WS_EX_LAYERED, _
			$this.WS_EX_LAYOUTRTL, _
			$this.WS_EX_LEFT, _
			$this.WS_EX_LEFTSCROLLBAR, _
			$this.WS_EX_LTRREADING, _
			$this.WS_EX_MDICHILD, _
			$this.WS_EX_NOACTIVATE, _
			$this.WS_EX_NOINHERITLAYOUT, _
			$this.WS_EX_NOPARENTNOTIFY, _
			$this.WS_EX_NOREDIRECTIONBITMAP, _
			$this.WS_EX_OVERLAPPEDWINDOW, _
			$this.WS_EX_PALETTEWINDOW, _
			$this.WS_EX_RIGHT, _
			$this.WS_EX_RIGHTSCROLLBAR, _
			$this.WS_EX_RTLREADING, _
			$this.WS_EX_STATICEDGE, _
			$this.WS_EX_TOOLWINDOW, _
			$this.WS_EX_TOPMOST, _
			$this.WS_EX_TRANSPARENT, _
			$this.WS_EX_WINDOWEDGE, _
			$this.GUI_WS_EX_PARENTDRAG]

;~ 	Local Const $names[] = ["WS_EX_ACCEPTFILES        ", _
;~ 			"WS_EX_APPWINDOW          ", _
;~ 			"WS_EX_CLIENTEDGE         ", _
;~ 			"WS_EX_COMPOSITED         ", _
;~ 			"WS_EX_CONTEXTHELP        ", _
;~ 			"WS_EX_CONTROLPARENT      ", _
;~ 			"WS_EX_DLGMODALFRAME      ", _
;~ 			"WS_EX_LAYERED            ", _
;~ 			"WS_EX_LAYOUTRTL          ", _
;~ 			"WS_EX_LEFT               ", _
;~ 			"WS_EX_LEFTSCROLLBAR      ", _
;~ 			"WS_EX_LTRREADING         ", _
;~ 			"WS_EX_MDICHILD           ", _
;~ 			"WS_EX_NOACTIVATE         ", _
;~ 			"WS_EX_NOINHERITLAYOUT    ", _
;~ 			"WS_EX_NOPARENTNOTIFY     ", _
;~ 			"WS_EX_NOREDIRECTIONBITMAP", _
;~ 			"WS_EX_OVERLAPPEDWINDOW   ", _
;~ 			"WS_EX_PALETTEWINDOW      ", _
;~ 			"WS_EX_RIGHT              ", _
;~ 			"WS_EX_RIGHTSCROLLBAR     ", _
;~ 			"WS_EX_RTLREADING         ", _
;~ 			"WS_EX_STATICEDGE         ", _
;~ 			"WS_EX_TOOLWINDOW         ", _
;~ 			"WS_EX_TOPMOST            ", _
;~ 			"WS_EX_TRANSPARENT        ", _
;~ 			"WS_EX_WINDOWEDGE         ", _
;~ 			"GUI_WS_EX_PARENTDRAG     "]

	Local Const $upBound = UBound($allStyles)

	For $i = 0 To $upBound - 1
		If BitAND($exStyles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_EX_OVERLAPPEDWINDOW, $WS_EX_PALETTEWINDOW
					;ConsoleWrite($names[$i] & " False" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					;ConsoleWrite($names[$i] & " True" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch
		Else
			Switch $allStyles[$i]
				Case $WS_EX_LEFT, $WS_EX_LTRREADING, $WS_EX_RIGHTSCROLLBAR
					;ConsoleWrite($names[$i] & " True" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					;ConsoleWrite($names[$i] & " False" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormExStyles_Initialize

; Native
;~ WS_EX_ACCEPTFILES         False
;~ WS_EX_APPWINDOW           False
;~ WS_EX_CLIENTEDGE          False
;~ WS_EX_COMPOSITED          False
;~ WS_EX_CONTEXTHELP         False
;~ WS_EX_CONTROLPARENT       False
;~ WS_EX_DLGMODALFRAME       False
;~ WS_EX_LAYERED             False
;~ WS_EX_LAYOUTRTL           False
;~ WS_EX_LEFT                True
;~ WS_EX_LEFTSCROLLBAR       False
;~ WS_EX_LTRREADING          True
;~ WS_EX_MDICHILD            False
;~ WS_EX_NOACTIVATE          False
;~ WS_EX_NOINHERITLAYOUT     False
;~ WS_EX_NOPARENTNOTIFY      False
;~ WS_EX_NOREDIRECTIONBITMAP False
;~ WS_EX_OVERLAPPEDWINDOW    False
;~ WS_EX_PALETTEWINDOW       False
;~ WS_EX_RIGHT               False
;~ WS_EX_RIGHTSCROLLBAR      True
;~ WS_EX_RTLREADING          False
;~ WS_EX_STATICEDGE          False
;~ WS_EX_TOOLWINDOW          False
;~ WS_EX_TOPMOST             False
;~ WS_EX_TRANSPARENT         False
;~ WS_EX_WINDOWEDGE          True
;~ GUI_WS_EX_PARENTDRAG      False

;~ WS_EX_ACCEPTFILES         False
;~ WS_EX_APPWINDOW           False
;~ WS_EX_CLIENTEDGE          False
;~ WS_EX_COMPOSITED          False
;~ WS_EX_CONTEXTHELP         False
;~ WS_EX_CONTROLPARENT       False
;~ WS_EX_DLGMODALFRAME       False
;~ WS_EX_LAYERED             False
;~ WS_EX_LAYOUTRTL           False
;~ WS_EX_LEFT                False
;~ WS_EX_LEFTSCROLLBAR       False
;~ WS_EX_LTRREADING          False
;~ WS_EX_MDICHILD            False
;~ WS_EX_NOACTIVATE          False
;~ WS_EX_NOINHERITLAYOUT     False
;~ WS_EX_NOPARENTNOTIFY      False
;~ WS_EX_NOREDIRECTIONBITMAP False
;~ WS_EX_OVERLAPPEDWINDOW    True
;~ WS_EX_PALETTEWINDOW       True
;~ WS_EX_RIGHT               False
;~ WS_EX_RIGHTSCROLLBAR      False
;~ WS_EX_RTLREADING          False
;~ WS_EX_STATICEDGE          False
;~ WS_EX_TOOLWINDOW          False
;~ WS_EX_TOPMOST             False
;~ WS_EX_TRANSPARENT         False
;~ WS_EX_WINDOWEDGE          True
;~ GUI_WS_EX_PARENTDRAG      False
