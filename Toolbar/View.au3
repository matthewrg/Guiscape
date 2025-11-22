#include-once

#include <ButtonConstants.au3>

Func Toolbar_View()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "Toolbar_View_Create")
	
	_AutoItObject_AddProperty($this, "Form", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Group", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Button", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Checkbox", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Radio", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Edit", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Input", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Label", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "UpDown", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "List", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Combo", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Date", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Treeview", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Progress", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Avi", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Icon", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Pic", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Slider", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Menu", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "ContextMenu", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_READONLY)
	
	_AutoItObject_AddMethod($this, "CreateTool", "Toolbar_View_CreateTool", True)

	Return $this
EndFunc   ;==>Toolbar_View

Func Toolbar_View_Create(ByRef $this, Const $resourcesDir)	
	Local Const $start = 5, $add = 20

	$this.Form = $this.CreateTool("Form", 5, $start, $resourcesDir)
	$this.Group = $this.CreateTool("Group", 45, $start, $resourcesDir)
	$this.Button = $this.CreateTool("Button", 5, $start + ($add * 2), $resourcesDir)
	$this.Checkbox = $this.CreateTool("Checkbox", 45, $start + ($add * 2), $resourcesDir)
	$this.Radio = $this.CreateTool("Radio", 5, $start + ($add * 4), $resourcesDir)
	$this.Edit = $this.CreateTool("Edit", 45, $start + ($add * 4), $resourcesDir)
	$this.Input = $this.CreateTool("Input", 5, $start + ($add * 6), $resourcesDir)
	$this.Label = $this.CreateTool("Label", 45, $start + ($add * 6), $resourcesDir)
	$this.UpDown = $this.CreateTool("UpDown", 5, $start + ($add * 8), $resourcesDir)
	$this.List = $this.CreateTool("List", 45, $start + ($add * 8), $resourcesDir)
	$this.Combo = $this.CreateTool("Combo", 5, $start + ($add * 10), $resourcesDir)
	$this.Date = $this.CreateTool("Date", 45, $start + ($add * 10), $resourcesDir)
	$this.Treeview = $this.CreateTool("Treeview", 5, $start + ($add * 12), $resourcesDir)
	$this.Progress = $this.CreateTool("Progress", 45, $start + ($add * 12), $resourcesDir)
	$this.Avi = $this.CreateTool("Avi", 5, $start + ($add * 14), $resourcesDir)
	$this.Icon = $this.CreateTool("Icon", 45, $start + ($add * 14), $resourcesDir)
	$this.Pic = $this.CreateTool("Pic", 5, $start + ($add * 16), $resourcesDir)
	$this.Slider = $this.CreateTool("Slider", 45, $start + ($add * 16), $resourcesDir)
	$this.Tab = $this.CreateTool("Tab", 5, $start + ($add * 18), $resourcesDir)
EndFunc   ;==>Toolbar_View_Create

Func Toolbar_View_CreateTool(Const ByRef $this, Const $name, Const $left, Const $top, Const $resourcesDir)
	#forceref $this
	
	Local Const $tool = GUICtrlCreateButton($name, $left * $DPIRatio, $top * $DPIRatio, 40 * $DPIRatio, 40 * $DPIRatio, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_ICON))

	GUICtrlSetResizing($tool, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	GUICtrlSetImage($tool, $resourcesDir & "\Icons\" & $name & ".ico")

	GUICtrlSetTip($tool, $name)

	Return $tool
EndFunc   ;==>Toolbar_View_CreateTool
