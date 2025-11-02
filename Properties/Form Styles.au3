#include-once
#include <GuiConstantsEx.au3>
#include <WindowsStylesConstants.au3>

#include "..\AutoItObject.au3"

Func FormStyles()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "FormStyles_Create")
	$this.AddMethod("Handler", "FormStyles_Handler")
	$this.AddMethod("Initialize", "FormStyles_Initialize")

	$this.AddProperty("SS_DEFAULT_GUI", $ELSCOPE_READONLY)
	$this.AddProperty("WS_BORDER", $ELSCOPE_READONLY)
	$this.AddProperty("WS_POPUP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CAPTION", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CLIPCHILDREN", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CLIPSIBLINGS", $ELSCOPE_READONLY)
	$this.AddProperty("WS_DISABLED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_DLGFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_HSCROLL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_MAXIMIZE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_MAXIMIZEBOX", $ELSCOPE_READONLY)
	$this.AddProperty("WS_OVERLAPPED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_POPUPWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_SIZEBOX", $ELSCOPE_READONLY)
	$this.AddProperty("WS_SYSMENU", $ELSCOPE_READONLY)
	$this.AddProperty("WS_THICKFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_VSCROLL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_VISIBLE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CHILD", $ELSCOPE_READONLY)
	$this.AddProperty("WS_GROUP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_TABSTOP", $ELSCOPE_READONLY)
	$this.AddProperty("DS_MODALFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("DS_SETFOREGROUND", $ELSCOPE_READONLY)
	$this.AddProperty("DS_CONTEXTHELP", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>FormStyles

Func FormStyles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID

EndFunc   ;==>FormStyles_Handler

Func FormStyles_Initialize(ByRef $this, Const $styles)
	Local Const $allStyles[] = [$WS_BORDER, _
			$WS_POPUP, _
			$WS_CAPTION, _
			$WS_CLIPCHILDREN, _
			$WS_CLIPSIBLINGS, _
			$WS_DISABLED, _
			$WS_DLGFRAME, _
			$WS_HSCROLL, _
			$WS_MAXIMIZE, _
			$WS_MAXIMIZEBOX, _
			$WS_OVERLAPPED, _
			$WS_OVERLAPPEDWINDOW, _
			$WS_POPUPWINDOW, _
			$WS_SIZEBOX, _
			$WS_SYSMENU, _
			$WS_THICKFRAME, _
			$WS_VSCROLL, _
			$WS_VISIBLE, _
			$WS_CHILD, _
			$WS_GROUP, _
			$WS_TABSTOP, _
			$DS_MODALFRAME, _
			$DS_SETFOREGROUND, _
			$DS_CONTEXTHELP]

	Local Const $vars[] = [$this.WS_BORDER, _
			$this.WS_POPUP, _
			$this.WS_CAPTION, _
			$this.WS_CLIPCHILDREN, _
			$this.WS_CLIPSIBLINGS, _
			$this.WS_DISABLED, _
			$this.WS_DLGFRAME, _
			$this.WS_HSCROLL, _
			$this.WS_MAXIMIZE, _
			$this.WS_MAXIMIZEBOX, _
			$this.WS_OVERLAPPED, _
			$this.WS_OVERLAPPEDWINDOW, _
			$this.WS_POPUPWINDOW, _
			$this.WS_SIZEBOX, _
			$this.WS_SYSMENU, _
			$this.WS_THICKFRAME, _
			$this.WS_VSCROLL, _
			$this.WS_VISIBLE, _
			$this.WS_CHILD, _
			$this.WS_GROUP, _
			$this.WS_TABSTOP, _
			$this.DS_MODALFRAME, _
			$this.DS_SETFOREGROUND, _
			$this.DS_CONTEXTHELP]

;~ 	Local Const $names[] = ["WS_BORDER          ", _
;~ 			                "WS_POPUP           ", _
;~ 			                "WS_CAPTION         ", _
;~ 			                "WS_CLIPCHILDREN    ", _
;~ 			                "WS_CLIPSIBLINGS    ", _
;~ 			                "WS_DISABLED        ", _
;~ 			                "WS_DLGFRAME        ", _
;~ 			                "WS_HSCROLL         ", _
;~ 			                "WS_MAXIMIZE        ", _
;~ 			                "WS_MAXIMIZEBOX     ", _
;~ 			                "WS_OVERLAPPED      ", _
;~ 			                "WS_OVERLAPPEDWINDOW", _
;~ 			                "WS_POPUPWINDOW     ", _
;~ 			                "WS_SIZEBOX         ", _
;~ 			                "WS_SYSMENU         ", _
;~ 			                "WS_THICKFRAME      ", _
;~ 			                "WS_VSCROLL         ", _
;~ 			                "WS_VISIBLE         ", _
;~ 			                "WS_CHILD           ", _
;~ 			                "WS_GROUP           ", _
;~ 			                "WS_TABSTOP         ", _
;~ 			                "DS_MODALFRAME      ", _
;~ 			                "DS_SETFOREGROUND   ", _
;~ 			                "DS_CONTEXTHELP     "]

	GUICtrlSetState($this.SS_DEFAULT_GUI, $GUI_CHECKED + $GUI_DISABLE)

	Local Const $upBound = UBound($allStyles)

	For $i = 0 To $upBound - 1
		If BitAND($styles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_MAXIMIZEBOX, $WS_OVERLAPPEDWINDOW, $WS_SIZEBOX, $WS_THICKFRAME, $WS_CHILD, $WS_TABSTOP
					;ConsoleWrite($names[$i] & " False" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					;ConsoleWrite($names[$i] & " True" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch

		Else
			Switch $allStyles[$i]
				Case $WS_POPUP, $WS_OVERLAPPED
					;ConsoleWrite($names[$i] & " True" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					;ConsoleWrite($names[$i] & " False" & @CRLF)

					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormStyles_Initialize

Func FormStyles_Create(ByRef $this)
	GUICtrlCreateTabItem("Styles")

	$this.SS_DEFAULT_GUI = GUICtrlCreateCheckbox("SS_DEFAULT_GUI", 10, 30)
	$this.WS_BORDER = GUICtrlCreateCheckbox("WS_BORDER", 10, 50)
	$this.WS_POPUP = GUICtrlCreateCheckbox("WS_POPUP", 10, 70)
	$this.WS_CAPTION = GUICtrlCreateCheckbox("WS_CAPTION", 10, 90)
	$this.WS_CLIPCHILDREN = GUICtrlCreateCheckbox("WS_CLIPCHILDREN", 10, 110)
	$this.WS_CLIPSIBLINGS = GUICtrlCreateCheckbox("WS_CLIPSIBLINGS", 10, 130)
	$this.WS_DISABLED = GUICtrlCreateCheckbox("WS_DISABLED", 10, 150)
	$this.WS_DLGFRAME = GUICtrlCreateCheckbox("WS_DLGFRAME", 10, 170)
	$this.WS_HSCROLL = GUICtrlCreateCheckbox("WS_HSCROLL", 10, 190)
	$this.WS_MAXIMIZE = GUICtrlCreateCheckbox("WS_MAXIMIZE", 10, 210)
	$this.WS_MAXIMIZEBOX = GUICtrlCreateCheckbox("WS_MAXIMIZEBOX", 10, 230)
	$this.WS_OVERLAPPED = GUICtrlCreateCheckbox("WS_OVERLAPPED", 10, 250)
	$this.WS_OVERLAPPEDWINDOW = GUICtrlCreateCheckbox("WS_OVERLAPPEDWINDOW", 10, 270)
	$this.WS_POPUPWINDOW = GUICtrlCreateCheckbox("WS_POPUPWINDOW", 10, 290)
	$this.WS_SIZEBOX = GUICtrlCreateCheckbox("WS_SIZEBOX", 10, 310)
	$this.WS_SYSMENU = GUICtrlCreateCheckbox("WS_SYSMENU", 10, 330)
	$this.WS_THICKFRAME = GUICtrlCreateCheckbox("WS_THICKFRAME", 10, 350)
	$this.WS_VSCROLL = GUICtrlCreateCheckbox("WS_VSCROLL", 10, 370)
	$this.WS_VISIBLE = GUICtrlCreateCheckbox("WS_VISIBLE", 10, 390)
	$this.WS_CHILD = GUICtrlCreateCheckbox("WS_CHILD", 10, 410)
	$this.WS_GROUP = GUICtrlCreateCheckbox("WS_GROUP", 10, 430)
	$this.WS_TABSTOP = GUICtrlCreateCheckbox("WS_TABSTOP", 10, 450)
	$this.DS_MODALFRAME = GUICtrlCreateCheckbox("DS_MODALFRAME", 10, 470)
	$this.DS_SETFOREGROUND = GUICtrlCreateCheckbox("DS_SETFOREGROUND", 10, 490)
	$this.DS_CONTEXTHELP = GUICtrlCreateCheckbox("DS_CONTEXTHELP", 10, 510)

	GUICtrlCreateTabItem('')
EndFunc   ;==>FormStyles_Create
