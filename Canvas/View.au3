#include-once
#include <WindowsStylesConstants.au3>

#include "..\AutoItObject.au3"

Func CanvasView()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "CanvasView_Create")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("ContextNewForm", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>CanvasView

Func CanvasView_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Canvas", ($parent.Width - 100), ($parent.Height - 60), 90, 30, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ContextNewForm = GUICtrlCreateMenuItem("New Form", $contextMenu)
EndFunc   ;==>CanvasView_Create
