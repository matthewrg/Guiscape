#include-once

#include <GuiConstantsEx.au3>

Func MenubarView()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Menubar_View_Create")
	$this.AddMethod("Toggle", "Menubar_View_Toggle")
	$this.AddMethod("Initialize", "Menubar_View_Initialize")

	$this.AddProperty("New", $ELSCOPE_READONLY)
	$this.AddProperty("Open", $ELSCOPE_READONLY)
	$this.AddProperty("Save", $ELSCOPE_READONLY)
	$this.AddProperty("SaveAs", $ELSCOPE_READONLY)
	$this.AddProperty("Load", $ELSCOPE_READONLY)
	$this.AddProperty("Exit", $ELSCOPE_READONLY)
	$this.AddProperty("Canvas", $ELSCOPE_READONLY)
	$this.AddProperty("Parameters", $ELSCOPE_READONLY)
	$this.AddProperty("Script", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY)
	$this.AddProperty("Settings", $ELSCOPE_READONLY)
	$this.AddProperty("About", $ELSCOPE_READONLY)
	$this.AddProperty("ShowGrid", $ELSCOPE_READONLY)
	$this.AddProperty("GridSnap", $ELSCOPE_READONLY)
	$this.AddProperty("ShowHidden", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>MenubarView

Func Menubar_View_Create(ByRef $this)	
	Local Const $menu_file = GUICtrlCreateMenu("&File")
	
	$this.New = GUICtrlCreateMenuItem("&New", $menu_file) 
	$this.Open = GUICtrlCreateMenuItem("&Open", $menu_file)
	$this.Save = GUICtrlCreateMenuItem("&Save", $menu_file) ; Roy add-on
	$this.SaveAs = GUICtrlCreateMenuItem("Save &As", $menu_file) ; Roy add-on
	GUICtrlCreateMenuItem('', $menu_file) ; Roy add-on
	$this.Exit = GUICtrlCreateMenuItem("&Exit", $menu_file)

	Local Const $menu_edit = GUICtrlCreateMenu("&Edit")
	
;~ 	$this.Canvas = GUICtrlCreateMenuItem("&Canvas", $menu_edit)
;~ 	$this.Parameters = GUICtrlCreateMenuItem("&Parameters", $menu_edit)
;~ 	$this.Script = GUICtrlCreateMenuItem("&Script", $menu_edit)
;~ 	$this.ObjectExplorer = GUICtrlCreateMenuItem("&Object Explorer", $menu_edit) ; added by: TheSaint
;~ 	$this.Settings = GUICtrlCreateMenuItem("Se&ttings", $menu_edit)
	GUICtrlCreateMenuItem('', $menu_edit)
	$this.About = GUICtrlCreateMenuItem("&About", $menu_edit) ; added by: TheSaint

	Local Const $menu_settings = GUICtrlCreateMenu("&Settings")
	
	$this.ShowGrid = GUICtrlCreateMenuItem("Show grid", $menu_settings)
	$this.GridSnap = GUICtrlCreateMenuItem("Snap to grid", $menu_settings)
	$this.ShowHidden = GUICtrlCreateMenuItem("Show hidden controls", $menu_settings)
EndFunc   ;==>MenubarView_Create

Func Menubar_View_Toggle(Const ByRef $this, Const ByRef $menuItem)
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

Func Menubar_View_Initialize(Const ByRef $this, Const ByRef $settings)
	Local Const $menuItems[] = [$this.ShowGrid, $this.GridSnap, $this.ShowHidden]

	Local Const $itemCount = UBound($menuItems)

	For $i = 1 To $itemCount
		If $settings[$i][1] = 1 Then
			GUICtrlSetState($menuItems[$i - 1], $GUI_CHECKED)
		Else
			GUICtrlSetState($menuItems[$i - 1], $GUI_UNCHECKED)
		EndIf
	Next
EndFunc   ;==>MenubarView_Initialize
