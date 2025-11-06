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
	$this.AddProperty("Edit", $ELSCOPE_READONLY)
	$this.AddProperty("Open", $ELSCOPE_READONLY)
	$this.AddProperty("Save", $ELSCOPE_READONLY)
	$this.AddProperty("SaveAs", $ELSCOPE_READONLY)
	$this.AddProperty("", $ELSCOPE_READONLY)
	
	$this.AddProperty("", $ELSCOPE_PRIVATE)
	
	Return $this.Object
EndFunc

Func Script_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Script", ($parent.Width - 105) * $g_iDPI_ratio1, ($parent.Height - 85) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))
	
	GUICtrlCreateTab(5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, ($parent.Width - 115) * $g_iDPI_ratio1, ($parent.Height - 95) * $g_iDPI_ratio1)
	
	GUICtrlCreateTabItem("Script")
	
	$this.Edit = GUICtrlCreateEdit('', 15 * $g_iDPI_ratio1, 35 * $g_iDPI_ratio1, ($parent.Width - 135) * $g_iDPI_ratio1, ($parent.Height - 165) * $g_iDPI_ratio1, BitOR($GUI_SS_DEFAULT_EDIT, $ES_MULTILINE, $ES_WANTRETURN, $ES_AUTOVSCROLL, $WS_VSCROLL))
	
	$this.Open = GUICtrlCreateButton("Open", 20, ($parent.Height - 123) * $g_iDPI_ratio1, 50 * $g_iDPI_ratio1, 25 * $g_iDPI_ratio1)
	
	$this.Save = GUICtrlCreateButton("Save", 80, ($parent.Height - 123) * $g_iDPI_ratio1, 50 * $g_iDPI_ratio1, 25 * $g_iDPI_ratio1)
	
	$this.SaveAs = GUICtrlCreateButton("Save As", 140, ($parent.Height - 123) * $g_iDPI_ratio1, 50 * $g_iDPI_ratio1, 25 * $g_iDPI_ratio1)
	
	GUICtrlCreateTabItem('')
	
	GUICtrlCreateTabItem("Options")

	GUICtrlCreateTabItem('')
EndFunc

Func Script_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Show

Func Script_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Hide