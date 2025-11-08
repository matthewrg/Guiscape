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
	$this.AddMethod("Move", "CanvasView_Move")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("NewForm", $ELSCOPE_READONLY)
	$this.AddProperty("EraseCanvas", $ELSCOPE_READONLY)

	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>CanvasView

Func CanvasView_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Canvas", ($parent.Width - 100) * $g_iDPI_ratio1, ($parent.Height - 60) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.NewForm = GUICtrlCreateMenuItem("New Form", $contextMenu)	
	$this.EraseCanvas = GUICtrlCreateMenuItem("Erase Canvas", $contextMenu)
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

Func CanvasView_Move(ByRef $this, Const ByRef $sizePos)
	WinMove(HWnd($this.Hwnd), '', 90 * $g_iDPI_ratio1, _ 
	                              30 * $g_iDPI_ratio1, _ 
								  ($sizePos[2] - (110 * $g_iDPI_ratio1)) * $g_iDPI_ratio1, _ 
								  ($sizePos[3] - (95 * $g_iDPI_ratio1)) * $g_iDPI_ratio1)
EndFunc
