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
	$this.AddMethod("Show", "FormStyles_Show")
	$this.AddMethod("Hide", "FormStyles_Hide")

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

Func FormStyles_Create(ByRef $this)
	GUICtrlCreateTabItem("Styles")

	$this.SS_DEFAULT_GUI = GUICtrlCreateCheckbox("SS_DEFAULT_GUI", 10 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1)
	$this.WS_BORDER = GUICtrlCreateCheckbox("WS_BORDER", 10 * $g_iDPI_ratio1, 50 * $g_iDPI_ratio1)
	$this.WS_POPUP = GUICtrlCreateCheckbox("WS_POPUP", 10 * $g_iDPI_ratio1, 70 * $g_iDPI_ratio1)
	$this.WS_CAPTION = GUICtrlCreateCheckbox("WS_CAPTION", 10 * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1)
	$this.WS_CLIPCHILDREN = GUICtrlCreateCheckbox("WS_CLIPCHILDREN", 10 * $g_iDPI_ratio1, 110 * $g_iDPI_ratio1)
	$this.WS_CLIPSIBLINGS = GUICtrlCreateCheckbox("WS_CLIPSIBLINGS", 10 * $g_iDPI_ratio1, 130 * $g_iDPI_ratio1)
	$this.WS_DISABLED = GUICtrlCreateCheckbox("WS_DISABLED", 10 * $g_iDPI_ratio1, 150 * $g_iDPI_ratio1)
	$this.WS_DLGFRAME = GUICtrlCreateCheckbox("WS_DLGFRAME", 10 * $g_iDPI_ratio1, 170 * $g_iDPI_ratio1)
	$this.WS_HSCROLL = GUICtrlCreateCheckbox("WS_HSCROLL", 10 * $g_iDPI_ratio1, 190 * $g_iDPI_ratio1)
	$this.WS_MAXIMIZE = GUICtrlCreateCheckbox("WS_MAXIMIZE", 10 * $g_iDPI_ratio1, 210 * $g_iDPI_ratio1)
	$this.WS_MAXIMIZEBOX = GUICtrlCreateCheckbox("WS_MAXIMIZEBOX", 10 * $g_iDPI_ratio1, 230 * $g_iDPI_ratio1)
	$this.WS_OVERLAPPED = GUICtrlCreateCheckbox("WS_OVERLAPPED", 10 * $g_iDPI_ratio1, 250 * $g_iDPI_ratio1)
	$this.WS_OVERLAPPEDWINDOW = GUICtrlCreateCheckbox("WS_OVERLAPPEDWINDOW", 10 * $g_iDPI_ratio1, 270 * $g_iDPI_ratio1)
	$this.WS_POPUPWINDOW = GUICtrlCreateCheckbox("WS_POPUPWINDOW", 10 * $g_iDPI_ratio1, 290 * $g_iDPI_ratio1)
	$this.WS_SIZEBOX = GUICtrlCreateCheckbox("WS_SIZEBOX", 10 * $g_iDPI_ratio1, 310 * $g_iDPI_ratio1)
	$this.WS_SYSMENU = GUICtrlCreateCheckbox("WS_SYSMENU", 10 * $g_iDPI_ratio1, 330 * $g_iDPI_ratio1)
	$this.WS_THICKFRAME = GUICtrlCreateCheckbox("WS_THICKFRAME", 10 * $g_iDPI_ratio1, 350 * $g_iDPI_ratio1)
	$this.WS_VSCROLL = GUICtrlCreateCheckbox("WS_VSCROLL", 10 * $g_iDPI_ratio1, 370 * $g_iDPI_ratio1)
	$this.WS_VISIBLE = GUICtrlCreateCheckbox("WS_VISIBLE", 10 * $g_iDPI_ratio1, 390 * $g_iDPI_ratio1)
	$this.WS_CHILD = GUICtrlCreateCheckbox("WS_CHILD", 10 * $g_iDPI_ratio1, 410 * $g_iDPI_ratio1)
	$this.WS_GROUP = GUICtrlCreateCheckbox("WS_GROUP", 10 * $g_iDPI_ratio1, 430 * $g_iDPI_ratio1)
	$this.WS_TABSTOP = GUICtrlCreateCheckbox("WS_TABSTOP", 10 * $g_iDPI_ratio1, 450 * $g_iDPI_ratio1)
	$this.DS_MODALFRAME = GUICtrlCreateCheckbox("DS_MODALFRAME", 10 * $g_iDPI_ratio1, 470 * $g_iDPI_ratio1)
	$this.DS_SETFOREGROUND = GUICtrlCreateCheckbox("DS_SETFOREGROUND", 10 * $g_iDPI_ratio1, 490 * $g_iDPI_ratio1)
	$this.DS_CONTEXTHELP = GUICtrlCreateCheckbox("DS_CONTEXTHELP", 10 * $g_iDPI_ratio1, 510 * $g_iDPI_ratio1)

	GUICtrlCreateTabItem('')
EndFunc   ;==>FormStyles_Create

Func FormStyles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID
		
	; When the GUI designer wants to enable or disable styles then this function will 
	; report back to the main loop. At that point Guiscape will communicate with the
	; form to have the form change it's styles to suit.
		
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

	GUICtrlSetState($this.SS_DEFAULT_GUI, $GUI_CHECKED + $GUI_DISABLE)

	Local Const $upBound = UBound($allStyles)
	
	; This loop just makes the windows that Guiscape creates look like a regular window when
	; looking at the Styles tab under the Properties tab. Not sure yet if this will cause 
	; problems down the road!
	For $i = 0 To $upBound - 1
		If BitAND($styles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_MAXIMIZEBOX, $WS_OVERLAPPEDWINDOW, $WS_SIZEBOX, $WS_THICKFRAME, $WS_CHILD, $WS_TABSTOP
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch

		Else
			Switch $allStyles[$i]
				Case $WS_POPUP, $WS_OVERLAPPED
					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormStyles_Initialize

Func FormStyles_Show(ByRef $this)
	; Show the styles checkboxes when a form is active and the designer clicks the Styles tab.
EndFunc

Func FormStyles_Hide(ByRef $this)
	; Hide the styles checkboxes for when a control is active.
EndFunc
