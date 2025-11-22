
#AutoIt3Wrapper_Add_Constants=y

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
	
	$this.Name = "Script"

	Return $this
EndFunc   ;==>Script

Func Script_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	Return False
EndFunc

Func Script_Create(ByRef $this)			
	Local Const $prevHwnd = GUISwitch($this.TabItemHwnd)
	
	GUICtrlCreateTab(5 * $DPIRatio, 5 * $DPIRatio, ($this.ParentWidth - 115) * $DPIRatio, ($this.ParentHeight - 95) * $DPIRatio)

	GUICtrlCreateTabItem("Script")

	$this.Editor = GUICtrlCreateEdit('', 15 * $DPIRatio, 35 * $DPIRatio, ($this.ParentWidth - 135) * $DPIRatio, ($this.ParentHeight - 165) * $DPIRatio, BitOR($ES_MULTILINE, $ES_WANTRETURN, $ES_AUTOVSCROLL, $WS_VSCROLL))

	$this.Open = GUICtrlCreateButton("Open", 20, ($this.ParentHeight - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	$this.Save = GUICtrlCreateButton("Save", 80, ($this.ParentHeight - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	$this.SaveAs = GUICtrlCreateButton("Save As", 140, ($this.ParentHeight - 123) * $DPIRatio, 50 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Options")

	GUICtrlCreateTabItem('')

	GUISwitch($prevHwnd)
EndFunc   ;==>Script_Create

#endregion - Script
