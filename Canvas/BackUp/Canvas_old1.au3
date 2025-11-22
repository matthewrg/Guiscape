
#include-once

#Region - Canvas

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	
	$this.AddMethod("Create", "Canvas_Create", True)
	$this.AddMethod("Show", "Canvas_Show", True)
	$this.AddMethod("Hide", "Canvas_Hide", True)
	$this.AddMethod("Resize", "Canvas_Resize", True)

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)		
	$this.AddProperty("Parent", $ELSCOPE_PRIVATE)
	$this.AddProperty("ContextCreateForm", $ELSCOPE_PRIVATE)
	$this.AddProperty("ContextErase", $ELSCOPE_PRIVATE)

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.ContextCreateForm
			Return "Context Create Form"

		Case $this.ContextErase
			Return "Context Erase Canvas"

		Case $GUI_EVENT_PRIMARYUP
			Switch WinGetTitle($event.Form)
				Case "Canvas"
					Return "Canvas Clicked"
			EndSwitch

			Return True

		Case $GUI_EVENT_RESIZED
			$this.Resize($event)

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this)
	$this.Hwnd = GUICreate( _
			"Canvas", _
			($this.Width - 100) * $DPIRatio, _
			($this.Height - 60) * $DPIRatio, _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.Hwnd))

	GUISetBkColor($COLOR_WHITE, $hwnd)

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ContextCreateForm = GUICtrlCreateMenuItem("Create Form", $contextMenu)

	$this.ContextErase = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
EndFunc   ;==>Canvas_Create

Func Canvas_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Canvas_Hide

Func Canvas_Resize(Const ByRef $this, Const ByRef $event)
	WinMove( _
			HWnd($this.Hwnd), _
			"Canvas", _
			90 * $DPIRatio, _
			30 * $DPIRatio, _
			($event.Width - 112) * $DPIRatio, _
			($event.Height - 95) * $DPIRatio)
EndFunc   ;==>Canvas_Resize

#EndRegion - Canvas
