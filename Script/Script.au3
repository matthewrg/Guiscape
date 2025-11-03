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
	$this.Hwnd = GUICreate("Script", ($parent.Width - 100), ($parent.Height - 60), 90, 30, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))
	
	GUICtrlCreateTab(5, 5, ($parent.Width - 110), ($parent.Height - 70))
	
	GUICtrlCreateTabItem("Script")
	
	GUICtrlCreateTabItem("Options")
EndFunc

Func Script_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Show

Func Script_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Hide