
#include-once

#region - Script

Func Script()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "Script_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "Script_Create")
	
	_AutoItObject_AddProperty($this, "Editor", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Open", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Save", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "SaveAs", $ELSCOPE_PRIVATE, Null)
	
	$this.TabItemName = "Script"

	Return $this
EndFunc   ;==>Script

Func Script_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = $this.TabItemName Then Return False
	
	$this.InitHandler($event)
	
	Return False
EndFunc

Func Script_Create(ByRef $this)			
	Local Const $prevHwnd = GUISwitch(HWnd($this.TabItemHwnd))
	
	CreateTab(5, 5, $this.ParentWidth - 115, $this.ParentHeight - 95)

	GUICtrlCreateTabItem("Script")

	$this.Editor = CreateEdit(15, 35, $this.ParentWidth - 135, $this.ParentHeight - 165, BitOR($ES_MULTILINE, $ES_WANTRETURN, $ES_AUTOVSCROLL, $WS_VSCROLL))

	$this.Open = CreateButton("Open", 20, $this.ParentHeight - 123)

	$this.Save = CreateButton("Save", 80, $this.ParentHeight - 123)

	$this.SaveAs = CreateButton("Save As", 140, $this.ParentHeight - 123)

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Options")

	GUICtrlCreateTabItem('')

	GUISwitch($prevHwnd)
EndFunc   ;==>Script_Create

#endregion - Script
