
#include-once

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")
	$this.AddMethod("Move", "Canvas_Move")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Tab", $ELSCOPE_READONLY)

	$this.AddProperty("NewForm", $ELSCOPE_READONLY)
	$this.AddProperty("Erase", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate( _
			"Canvas", _
			($parent.Width - 100) * $DPIRatio, _
			($parent.Height - 60) * $DPIRatio, _
			90 * $DPIRatio, _
			30 * $DPIRatio, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($parent.Hwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.NewForm = GUICtrlCreateMenuItem("New Form", $contextMenu)

	$this.Erase = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
EndFunc   ;==>Canvas_Create

Func Canvas_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Canvas_Hide

Func Canvas_Move(ByRef $this, Const ByRef $sizePos)
	WinMove( _
			HWnd($this.Hwnd), _
			'', _
			90 * $DPIRatio, _
			30 * $DPIRatio, _
			($sizePos[2] - 112) * $DPIRatio, _
			($sizePos[3] - 95) * $DPIRatio)
EndFunc   ;==>Canvas_Move
