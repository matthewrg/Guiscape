#include-once

#include <GUIConstantsEx.au3>

#include <WindowsStylesConstants.au3>

#include "..\AutoItObject.au3"

Func CanvasView()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "CanvasView_Create")
	$this.AddMethod("Show", "CanvasView_Show")
	$this.AddMethod("Hide", "CanvasView_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("ContextNewForm", $ELSCOPE_READONLY)
	$this.AddProperty("ContextErase", $ELSCOPE_READONLY)

	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>CanvasView

Func CanvasView_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Canvas", ($parent.Width - 100) * $g_iDPI_ratio1, ($parent.Height - 60) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ContextNewForm = GUICtrlCreateMenuItem("New Form", $contextMenu)
	
	$this.ContextErase = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
EndFunc   ;==>CanvasView_Create

Func CanvasView_Show(ByRef $this)
	If Not $this.Visible Then
		GUISetState(@SW_SHOW, HWnd($this.Hwnd))

		$this.Visible = True
	EndIf
EndFunc   ;==>CanvasView_Show

Func CanvasView_Hide(ByRef $this)
	If $this.Visible Then
		GUISetState(@SW_HIDE, HWnd($this.Hwnd))

		$this.Visible = False
	EndIf
EndFunc   ;==>CanvasView_Hide
