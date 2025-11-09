

#include-once

Func ScriptTab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "ScriptTab_Create")
	$this.AddMethod("Show", "ScriptTab_Show")
	$this.AddMethod("Hide", "ScriptTab_Hide")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Edit", $ELSCOPE_READONLY)
	$this.AddProperty("Open", $ELSCOPE_READONLY)
	$this.AddProperty("Save", $ELSCOPE_READONLY)
	$this.AddProperty("SaveAs", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>ScriptTab

Func ScriptTab_Create(ByRef $this, Const ByRef $parent)
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
EndFunc   ;==>ScriptTab_Create

Func ScriptTab_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ScriptTab_Show

Func ScriptTab_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ScriptTab_Hide
