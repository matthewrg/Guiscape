
#include-once

#include "..\AutoItObject.au3"

Func ObjectExplorer()
	Local $this = _AutoItObject_Class()
	
	$this.Create()
	
	$this.AddMethod("Create", "ObjectExplorer_Create")
	$this.AddMethod("Show", "ObjectExplorer_Show")
	$this.AddMethod("Hide", "ObjectExplorer_Hide")
	$this.AddMethod("", "ObjectExplorer_")
	
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("", "")
	
	Return $this.Object
EndFunc

Func ObjectExplorer_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Object Explorer", ($parent.Width - 105) * $g_iDPI_ratio1, ($parent.Height - 85) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))
EndFunc

Func ObjectExplorer_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Show

Func ObjectExplorer_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Hide