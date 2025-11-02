
#include-once

Func Form(Const $parent)
	Local Const $hwnd = GUICreate('', 400, 600, 5, 5, BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), -1, HWnd($parent))

	Local Const $title = WinGetTitle($hwnd)

	Local Const $pos = WinGetPos($hwnd)

	Local Const $styles = GUIGetStyle($hwnd)
	
	Local Const $prevHwnd = GUISwitch($hwnd)
	
	Local Const $contextMenu = GUICtrlCreateContextMenu()

	GUICtrlCreateMenuItem("Child Form", $contextMenu)
	GUICtrlCreateMenuItem("Properties", $contextMenu)
	GUICtrlCreateMenuItem("Script", $contextMenu)
	
	GUISwitch($prevHwnd)
	
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Form_Handler")
	$this.AddMethod("SetName", "Form_SetName")
	$this.AddMethod("SetTitle", "Form_SetTitle")
	$this.AddMethod("GetLeft", "Form_GetLeft")
	$this.AddMethod("GetTop", "Form_GetTop")
	$this.AddMethod("GetWidth", "Form_GetWidth")
	$this.AddMethod("GetHeight", "Form_GetHeight")
	$this.AddMethod("GetStyle", "Form_GetStyle")
	$this.AddMethod("GetExStyle", "Form_GetExStyle")
	$this.AddMethod("Show", "Form_Show")
	$this.AddMethod("Hide", "Form_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY, $hwnd)
	$this.AddProperty("Name", $ELSCOPE_READONLY, '')
	$this.AddProperty("Title", $ELSCOPE_READONLY, $title)
	$this.AddProperty("Left", $ELSCOPE_READONLY, $pos[0])
	$this.AddProperty("Top", $ELSCOPE_READONLY, $pos[1])
	$this.AddProperty("Width", $ELSCOPE_READONLY, $pos[2])
	$this.AddProperty("Height", $ELSCOPE_READONLY, $pos[3])
	$this.AddProperty("Style", $ELSCOPE_READONLY, $styles[0])
	$this.AddProperty("ExStyle", $ELSCOPE_READONLY, $styles[1)

	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, $parent)

	GUISetState(@SW_SHOWNORMAL, HWnd($this.Hwnd))
	
	Return $this.Object
EndFunc   ;==>Form

Func Form_Handler(ByRef $this, Const ByRef $event)	
	If $event.ControlHwnd = 0 Then Return False
	
	If HWnd($event.ControlHwnd) <> GUICtrlGetHandle($this.ButtonID) Then Return False
	
	ConsoleWrite($event.X & " -- " & $event.Y & @CRLF)
	
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Form_Handler

Func Form_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Form_Show

Func Form_Hide(Const ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Form_Show

Func Form_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetStyle

Func Form_SetTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Hwnd), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>Form_SetTitle

Func Form_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetLeft

Func Form_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetTop

Func Form_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[2]
EndFunc   ;==>Form_GetWidth

Func Form_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[3]
EndFunc   ;==>Form_GetHeight

Func Form_GetExStyle(ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetExStyle
