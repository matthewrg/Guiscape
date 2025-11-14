
#include-once

#Region - Canvas

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")
	$this.AddMethod("Resize", "Canvas_Resize")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)	
	
	$this.AddProperty("Parent", $ELSCOPE_PRIVATE)
	$this.AddProperty("CreateForm", $ELSCOPE_PRIVATE)
	$this.AddProperty("Erase", $ELSCOPE_PRIVATE)
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.CreateForm
			Return "Create Form"

		Case $this.Erase
			Return "Erase Canvas"

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

Func Canvas_Create(ByRef $this, Const ByRef $parent)
	$this.Parent = $parent

	$this.Hwnd = $parent.CreateImbeddedWindow("Canvas")

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.CreateForm = GUICtrlCreateMenuItem("Create Form", $contextMenu)

	$this.Erase = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
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
