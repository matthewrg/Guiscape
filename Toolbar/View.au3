#include-once

#include <ButtonConstants.au3>

Func ToolbarView()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "ToolbarView_Create")

	$this.AddProperty("Form", $ELSCOPE_READONLY)
	$this.AddProperty("Group", $ELSCOPE_READONLY)
	$this.AddProperty("Button", $ELSCOPE_READONLY)
	$this.AddProperty("Checkbox", $ELSCOPE_READONLY)
	$this.AddProperty("Radio", $ELSCOPE_READONLY)
	$this.AddProperty("Edit", $ELSCOPE_READONLY)
	$this.AddProperty("Input", $ELSCOPE_READONLY)
	$this.AddProperty("Label", $ELSCOPE_READONLY)
	$this.AddProperty("UpDown", $ELSCOPE_READONLY)
	$this.AddProperty("List", $ELSCOPE_READONLY)
	$this.AddProperty("Combo", $ELSCOPE_READONLY)
	$this.AddProperty("Date", $ELSCOPE_READONLY)
	$this.AddProperty("Treeview", $ELSCOPE_READONLY)
	$this.AddProperty("Progress", $ELSCOPE_READONLY)
	$this.AddProperty("Avi", $ELSCOPE_READONLY)
	$this.AddProperty("Icon", $ELSCOPE_READONLY)
	$this.AddProperty("Pic", $ELSCOPE_READONLY)
	$this.AddProperty("Slider", $ELSCOPE_READONLY)
	$this.AddProperty("Menu", $ELSCOPE_READONLY)
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY)
	$this.AddProperty("Tab", $ELSCOPE_READONLY)

	$this.AddMethod("CreateTool", "ToolbarView_CreateTool", True)

	Return $this.Object
EndFunc   ;==>ToolbarView

Func ToolbarView_Create(ByRef $this, Const $resourcesDir)	
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
EndFunc   ;==>ToolbarView_Create

Func ToolbarView_CreateTool(Const ByRef $this, Const $name, Const $left, Const $top, Const $resourcesDir)
	#forceref $this
	
	Local Const $tool = GUICtrlCreateButton($name, $left * $DPIRatio, $top * $DPIRatio, 40 * $DPIRatio, 40 * $DPIRatio, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_ICON))

	GUICtrlSetResizing($tool, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	GUICtrlSetImage($tool, $resourcesDir & "\Icons\" & $name & ".ico")

	GUICtrlSetTip($tool, $name)

	Return $tool
EndFunc   ;==>ToolbarView_CreateTool
