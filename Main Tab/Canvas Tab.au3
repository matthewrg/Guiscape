#include-once

Func CanvasTab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "CanvasTab_Create")
	$this.AddMethod("Show", "CanvasTab_Show")
	$this.AddMethod("Hide", "CanvasTab_Hide")
	$this.AddMethod("Move", "CanvasTab_Move")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Tab", $ELSCOPE_READONLY)

	$this.AddProperty("NewForm", $ELSCOPE_READONLY)
	$this.AddProperty("Erase", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>CanvasTab

Func CanvasTab_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate('', ($parent.Width - 100) * $g_iDPI_ratio1, ($parent.Height - 60) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.NewForm = GUICtrlCreateMenuItem("New Form", $contextMenu)

	$this.Erase = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
EndFunc   ;==>CanvasTab_Create

Func CanvasTab_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>CanvasTab_Show

Func CanvasTab_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>CanvasTab_Hide

Func CanvasTab_Move(ByRef $this, Const ByRef $sizePos)
	WinMove(HWnd($this.Hwnd), '', _
			90 * $g_iDPI_ratio1, _
			30 * $g_iDPI_ratio1, _
			($sizePos[2] - 112) * $g_iDPI_ratio1, _
			($sizePos[3] - 95) * $g_iDPI_ratio1)
EndFunc   ;==>CanvasTab_Move
