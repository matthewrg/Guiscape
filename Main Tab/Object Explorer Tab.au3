
#include-once

Func ObjectExplorerTab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "ObjectExplorerTab_Create")
	$this.AddMethod("Show", "ObjectExplorerTab_Show")
	$this.AddMethod("Hide", "ObjectExplorerTab_Hide")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>ObjectExplorerTab

Func ObjectExplorerTab_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate('', ($parent.Width - 105) * $g_iDPI_ratio1, ($parent.Height - 65) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))
EndFunc   ;==>ObjectExplorerTab_Create

Func ObjectExplorerTab_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorerTab_Show

Func ObjectExplorerTab_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorerTab_Hide
