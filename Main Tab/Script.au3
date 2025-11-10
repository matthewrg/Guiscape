

#include-once

Func Script()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Script_Create")
	$this.AddMethod("Show", "Script_Show")
	$this.AddMethod("Hide", "Script_Hide")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Edit", $ELSCOPE_READONLY)
	$this.AddProperty("Open", $ELSCOPE_READONLY)
	$this.AddProperty("Save", $ELSCOPE_READONLY)
	$this.AddProperty("SaveAs", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>Script

Func Script_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate("Script", ($parent.Width - 105) * $DPIRatio, ($parent.Height - 85) * $DPIRatio, 90 * $DPIRatio, 30 * $DPIRatio, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	GUICtrlCreateTab(5 * $DPIRatio, 5 * $DPIRatio, ($parent.Width - 115) * $DPIRatio, ($parent.Height - 95) * $DPIRatio)

	GUICtrlCreateTabItem("Script")

	$this.Edit = GUICtrlCreateEdit('', 15 * $DPIRatio, 35 * $DPIRatio, ($parent.Width - 135) * $DPIRatio, ($parent.Height - 165) * $DPIRatio, BitOR($GUI_SS_DEFAULT_EDIT, $ES_MULTILINE, $ES_WANTRETURN, $ES_AUTOVSCROLL, $WS_VSCROLL))

	$this.Open = GUICtrlCreateButton("Open", 20, ($parent.Height - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	$this.Save = GUICtrlCreateButton("Save", 80, ($parent.Height - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	$this.SaveAs = GUICtrlCreateButton("Save As", 140, ($parent.Height - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Options")

	GUICtrlCreateTabItem('')
EndFunc   ;==>Script_Create

Func Script_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Script_Show

Func Script_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Script_Hide
