#include-once

Func ExStyles()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "ExStyles_Create")
	_AutoItObject_AddMethod($this, "Handler", "ExStyles_Handler")
	_AutoItObject_AddMethod($this, "Initialize", "ExStyles_Initialize")
	_AutoItObject_AddMethod($this, "CreateCheckbox", "ExStyles_CreateCheckbox")
	
	_AutoItObject_AddProperty($this, "WS_EX_ACCEPTFILES", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_APPWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CLIENTEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_COMPOSITED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CONTEXTHELP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CONTROLPARENT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_DLGMODALFRAME", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LAYERED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LAYOUTRTL", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LEFT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LEFTSCROLLBAR", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LTRREADING", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_MDICHILD", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOACTIVATE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOINHERITLAYOUT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOPARENTNOTIFY", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOREDIRECTIONBITMAP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_PALETTEWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RIGHT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RIGHTSCROLLBAR", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RTLREADING", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_STATICEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TOOLWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TOPMOST", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TRANSPARENT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_WINDOWEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "GUI_WS_EX_PARENTDRAG", $ELSCOPE_READONLY)
	
	_AutoItObject_AddProperty($this, "ExStyles", $ELSCOPE_READONLY)

	Return $this
EndFunc   ;==>ExStyles

Func ExStyles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID

EndFunc   ;==>ExStyles_Handler

Func ExStyles_CreateCheckbox(ByRef $this, Const $text, Const $left, Const $top)
	#forceref $this
	
	Return GUICtrlCreateCheckbox($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1)
EndFunc

Func ExStyles_Create(ByRef $this)
	$this.ExStyles = GUICtrlCreateTabItem("Extended Styles")

	$this.WS_EX_ACCEPTFILES = $this.CreateCheckbox("WS_EX_ACCEPTFILES", 10, 30)
	$this.WS_EX_APPWINDOW = $this.CreateCheckbox("WS_EX_APPWINDOW", 10, 50)
	$this.WS_EX_CLIENTEDGE = $this.CreateCheckbox("WS_EX_CLIENTEDGE", 10, 70)
	$this.WS_EX_COMPOSITED = $this.CreateCheckbox("WS_EX_COMPOSITED", 10, 90)
	$this.WS_EX_CONTEXTHELP = $this.CreateCheckbox("WS_EX_CONTEXTHELP", 10, 110)
	$this.WS_EX_CONTROLPARENT = $this.CreateCheckbox("WS_EX_CONTROLPARENT", 10, 130)
	$this.WS_EX_DLGMODALFRAME = $this.CreateCheckbox("WS_EX_DLGMODALFRAME", 10, 150)
	$this.WS_EX_LAYERED = $this.CreateCheckbox("WS_EX_LAYERED", 10, 170)
	$this.WS_EX_LAYOUTRTL = $this.CreateCheckbox("WS_EX_LAYOUTRTL", 10, 190)
	$this.WS_EX_LEFT = $this.CreateCheckbox("WS_EX_LEFT", 10, 210)
	$this.WS_EX_LEFTSCROLLBAR = $this.CreateCheckbox("WS_EX_LEFTSCROLLBAR", 10, 230)
	$this.WS_EX_LTRREADING = $this.CreateCheckbox("WS_EX_LTRREADING", 10, 250)
	$this.WS_EX_MDICHILD = $this.CreateCheckbox("WS_EX_MDICHILD", 10, 270)
	$this.WS_EX_NOACTIVATE = $this.CreateCheckbox("WS_EX_NOACTIVATE", 10, 290)
	$this.WS_EX_NOINHERITLAYOUT = $this.CreateCheckbox("WS_EX_NOINHERITLAYOUT", 10, 310)
	$this.WS_EX_NOPARENTNOTIFY = $this.CreateCheckbox("WS_EX_NOPARENTNOTIFY", 10, 330)
	$this.WS_EX_NOREDIRECTIONBITMAP = $this.CreateCheckbox("WS_EX_NOREDIRECTIONBITMAP", 10, 350)
	$this.WS_EX_OVERLAPPEDWINDOW = $this.CreateCheckbox("WS_EX_OVERLAPPEDWINDOW", 10, 370)
	$this.WS_EX_PALETTEWINDOW = $this.CreateCheckbox("WS_EX_PALETTEWINDOW", 10, 390)
	$this.WS_EX_EX_RIGHT = $this.CreateCheckbox("WS_EX_RIGHT", 10, 410)
	$this.WS_EX_RIGHTSCROLLBAR = $this.CreateCheckbox("WS_EX_RIGHTSCROLLBAR", 10, 430)
	$this.WS_EX_RTLREADING = $this.CreateCheckbox("WS_EX_RTLREADING", 10, 450)
	$this.WS_EX_STATICEDGE = $this.CreateCheckbox("WS_EX_STATICEDGE", 10, 470)
	$this.WS_EX_TOOLWINDOW = $this.CreateCheckbox("WS_EX_TOOLWINDOW", 10, 490)
	$this.WS_EX_TOPMOST = $this.CreateCheckbox("WS_EX_TOPMOST", 10, 510)
	$this.WS_EX_TRANSPARENT = $this.CreateCheckbox("WS_EX_TRANSPARENT", 10, 530)
	$this.WS_EX_WINDOWEDGE = $this.CreateCheckbox("WS_EX_WINDOWEDGE", 10, 550)
	$this.GUI_WS_EX_PARENTDRAG = $this.CreateCheckbox("GUI_WS_EX_PARENTDRAG", 10, 570)

	GUICtrlCreateTabItem('')
EndFunc   ;==>ExStyles_Create

Func ExStyles_Initialize(ByRef $this, Const $exStyles)
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

	Local Const $upBound = UBound($allStyles)

	; This loop just makes the windows that Guiscape creates look like a regular window when
	; looking at the Styles tab under the Properties tab. Not sure yet if this will cause 
	; problems down the road!
	For $i = 0 To $upBound - 1
		If BitAND($exStyles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_EX_OVERLAPPEDWINDOW, $WS_EX_PALETTEWINDOW
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch
		Else
			Switch $allStyles[$i]
				Case $WS_EX_LEFT, $WS_EX_LTRREADING, $WS_EX_RIGHTSCROLLBAR
					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>ExStyles_Initialize
