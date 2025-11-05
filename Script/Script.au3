#include-once

#include "..\AutoItObject.au3"

Func Script()
	Local $this = _AutoItObject_Class()
	
	$this.Create()
	
	$this.AddMethod("Create", "Script_Create")
	$this.AddMethod("Show", "Script_Show")
	$this.AddMethod("Hide", "Script_Hide")
	$this.AddMethod("", "Script_")
	
	$this.AddMethod("", "Script_", True)
	
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("", $ELSCOPE_READONLY)
	
	$this.AddProperty("", $ELSCOPE_PRIVATE)
	
	Return $this.Object
EndFunc

Func Script_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Script", ($parent.Width - 100) * $g_iDPI_ratio1, ($parent.Height - 60) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))
	
	GUICtrlCreateTab(5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, ($parent.Width - 110) * $g_iDPI_ratio1, ($parent.Height - 70) * $g_iDPI_ratio1)
	
	GUICtrlCreateTabItem("Script")
	
	GUICtrlCreateTabItem("Options")

	GUICtrlCreateTabItem('')
EndFunc

Func Script_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Show

Func Script_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Hide