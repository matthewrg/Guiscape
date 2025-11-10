#include-once

#include <GuiConstantsEx.au3>

Func MenubarView()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "MenubarView_Create")
	$this.AddMethod("Toggle", "MenubarView_Toggle")
	$this.AddMethod("Initialize", "MenubarView_Initialize")

	$this.AddProperty("Save", $ELSCOPE_READONLY)
	$this.AddProperty("Load", $ELSCOPE_READONLY)
	$this.AddProperty("Exit", $ELSCOPE_READONLY)
	$this.AddProperty("Canvas", $ELSCOPE_READONLY)
	$this.AddProperty("Parameters", $ELSCOPE_READONLY)
	$this.AddProperty("Script", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY)
	$this.AddProperty("About", $ELSCOPE_READONLY)
	$this.AddProperty("ShowGrid", $ELSCOPE_READONLY)
	$this.AddProperty("GridSnap", $ELSCOPE_READONLY)
	$this.AddProperty("PastePos", $ELSCOPE_READONLY)
	$this.AddProperty("ShowControl", $ELSCOPE_READONLY)
	$this.AddProperty("ShowHidden", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>MenubarView

Func MenubarView_Create(ByRef $this)
	Local Const $menu_file = GUICtrlCreateMenu("&File")
	$this.Save = GUICtrlCreateMenuItem("&Save", $menu_file) ; Roy add-on
	$this.Load = GUICtrlCreateMenuItem("&Load", $menu_file) ; Roy add-on
	GUICtrlCreateMenuItem('', $menu_file)                   ; Roy add-on
	$this.Exit = GUICtrlCreateMenuItem("E&xit", $menu_file)

	Local Const $menu_edit = GUICtrlCreateMenu("&Edit")
	$this.Canvas = GUICtrlCreateMenuItem("&Canvas", $menu_edit)
	$this.Parameters = GUICtrlCreateMenuItem("&Parameters", $menu_edit)
	$this.Script = GUICtrlCreateMenuItem("&Script", $menu_edit)
	$this.ObjectExplorer = GUICtrlCreateMenuItem("&Object Explorer", $menu_edit) ; added by: TheSaint
	$this.About = GUICtrlCreateMenuItem("About", $menu_edit)                     ; added by: TheSaint

	Local Const $menu_settings = GUICtrlCreateMenu("Settings")
	$this.ShowGrid = GUICtrlCreateMenuItem("Show grid", $menu_settings)
	$this.GridSnap = GUICtrlCreateMenuItem("Snap to grid", $menu_settings)
	$this.PastePos = GUICtrlCreateMenuItem("Paste at mouse position", $menu_settings)
	$this.ShowControl = GUICtrlCreateMenuItem("Show control when moving", $menu_settings)
	$this.ShowHidden = GUICtrlCreateMenuItem("Show hidden controls", $menu_settings)
EndFunc   ;==>MenubarView_Create

Func MenubarView_Toggle(Const ByRef $this, Const $menuItem)
	#forceref $this
	
	Local Const $state = GUICtrlRead($menuItem)

	Select
		Case BitAND($state, $GUI_CHECKED) = $GUI_CHECKED
			GUICtrlSetState($menuItem, $GUI_UNCHECKED)

			Return $GUI_UNCHECKED

		Case BitAND($state, $GUI_UNCHECKED) = $GUI_UNCHECKED
			GUICtrlSetState($menuItem, $GUI_CHECKED)

			Return $GUI_CHECKED
	EndSelect
EndFunc   ;==>MenubarView_Toggle

Func MenubarView_Initialize(Const ByRef $this, Const $settings)
	Local Const $menuItems[] = [$this.ShowGrid, $this.GridSnap, $this.PastePos, $this.ShowControl, $this.ShowHidden]

	Local Const $itemCount = UBound($menuItems)

	For $i = 1 To $itemCount
		If $settings[$i][1] = 1 Then
			GUICtrlSetState($menuItems[$i - 1], $GUI_CHECKED)
		Else
			GUICtrlSetState($menuItems[$i - 1], $GUI_UNCHECKED)
		EndIf
	Next
EndFunc   ;==>GuiscapeModel_Initialize
