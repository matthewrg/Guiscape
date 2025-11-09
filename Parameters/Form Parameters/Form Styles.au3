#include-once

Func Styles()
	Local $this = _AutoItObject_Create(ExStyles())

	_AutoItObject_AddMethod($this, "Create", "Styles_Create")
	_AutoItObject_AddMethod($this, "Handler", "Styles_Handler")
	_AutoItObject_AddMethod($this, "Initialize", "Styles_Initialize")
	_AutoItObject_AddMethod($this, "Show", "Styles_Show")
	_AutoItObject_AddMethod($this, "Hide", "Styles_Hide")
	
	_AutoItObject_AddProperty($this, "SS_DEFAULT_GUI", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_BORDER", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_POPUP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_CAPTION", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_CLIPCHILDREN", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_CLIPSIBLINGS", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_DISABLED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_DLGFRAME", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_HSCROLL", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_MAXIMIZE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_MAXIMIZEBOX", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_OVERLAPPED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_POPUPWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_SIZEBOX", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_SYSMENU", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_THICKFRAME", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_VSCROLL", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_VISIBLE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_CHILD", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_GROUP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_TABSTOP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "DS_MODALFRAME", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "DS_SETFOREGROUND", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "DS_CONTEXTHELP", $ELSCOPE_READONLY)
	
	_AutoItObject_AddProperty($this, "Styles", $ELSCOPE_READONLY)
	
	_AutoItObject_AddMethod($this, "CreateCheckbox", "Styles_CreateCheckbox", True)

	Return $this
EndFunc   ;==>Styles

Func Styles_Create(ByRef $this)
	$this.SS_DEFAULT_GUI = $this.CreateCheckbox("SS_DEFAULT_GUI", 10, 30)
	$this.WS_BORDER = $this.CreateCheckbox("WS_BORDER", 10, 50)
	$this.WS_POPUP = $this.CreateCheckbox("WS_POPUP", 10, 70)
	$this.WS_CAPTION = $this.CreateCheckbox("WS_CAPTION", 10, 90)
	$this.WS_CLIPCHILDREN = $this.CreateCheckbox("WS_CLIPCHILDREN", 10, 110)
	$this.WS_CLIPSIBLINGS = $this.CreateCheckbox("WS_CLIPSIBLINGS", 10, 130)
	$this.WS_DISABLED = $this.CreateCheckbox("WS_DISABLED", 10, 150)
	$this.WS_DLGFRAME = $this.CreateCheckbox("WS_DLGFRAME", 10, 170)
	$this.WS_HSCROLL = $this.CreateCheckbox("WS_HSCROLL", 10, 190)
	$this.WS_MAXIMIZE = $this.CreateCheckbox("WS_MAXIMIZE", 10, 210)
	$this.WS_MAXIMIZEBOX = $this.CreateCheckbox("WS_MAXIMIZEBOX", 10, 230)
	$this.WS_OVERLAPPED = $this.CreateCheckbox("WS_OVERLAPPED", 10, 250)
	$this.WS_OVERLAPPEDWINDOW = $this.CreateCheckbox("WS_OVERLAPPEDWINDOW", 10, 270)
	$this.WS_POPUPWINDOW = $this.CreateCheckbox("WS_POPUPWINDOW", 10, 290)
	$this.WS_SIZEBOX = $this.CreateCheckbox("WS_SIZEBOX", 10, 310)
	$this.WS_SYSMENU = $this.CreateCheckbox("WS_SYSMENU", 10, 330)
	$this.WS_THICKFRAME = $this.CreateCheckbox("WS_THICKFRAME", 10, 350)
	$this.WS_VSCROLL = $this.CreateCheckbox("WS_VSCROLL", 10, 370)
	$this.WS_VISIBLE = $this.CreateCheckbox("WS_VISIBLE", 10, 390)
	$this.WS_CHILD = $this.CreateCheckbox("WS_CHILD", 10, 410)
	$this.WS_GROUP = $this.CreateCheckbox("WS_GROUP", 10, 430)
	$this.WS_TABSTOP = $this.CreateCheckbox("WS_TABSTOP", 10, 450)
	$this.DS_MODALFRAME = $this.CreateCheckbox("DS_MODALFRAME", 10, 470)
	$this.DS_SETFOREGROUND = $this.CreateCheckbox("DS_SETFOREGROUND", 10, 490)
	$this.DS_CONTEXTHELP = $this.CreateCheckbox("DS_CONTEXTHELP", 10, 510)
EndFunc   ;==>Styles_Create

Func Styles_CreateCheckbox(ByRef $this, Const $text, Const $left, Const $top)
	#forceref $this
	
	Return GUICtrlCreateCheckbox($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1)
EndFunc

Func Styles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID
		
	; When the GUI designer wants to enable or disable styles then this function will 
	; report back to the main loop. At that point Guiscape will communicate with the
	; form to have the form change it's styles to suit.
EndFunc   ;==>Styles_Handler

Func Styles_Initialize(ByRef $this, Const $styles)
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
EndFunc   ;==>Styles_Initialize

Func Styles_Show(ByRef $this)
	#forceref $this
	
	; Show the styles checkboxes when a form is active and the designer clicks the Styles tab.
EndFunc

Func Styles_Hide(ByRef $this)
	#forceref $this
	
	; Hide the styles checkboxes for when a control is active.
EndFunc
