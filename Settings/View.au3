
#include-once

#Region - Settings View

Func Settings_View()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "Settings_View_Create")

	_AutoItObject_AddMethod($this, "Handler", "Settings_View_Handler")
	
	_AutoItObject_AddMethod($this, "IsChecked", "Settings_View_IsChecked")

	_AutoItObject_AddProperty($this, "ThemeLight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ThemeDark", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ThemeSystem", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridShow", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridSnap", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridSize", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ShowHidden", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>Settings_View

Func Settings_View_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.GridShow
			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, "Show Grid Setting", "ShowGrid", $this.IsChecked()))
			
			Return True
			
		Case $this.GridSnap
			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, "Grid Snap Setting", "GridSnap", $this.IsChecked()))
			
			Return True
			
		Case $this.GridSize
			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, "Grid Size Setting", "GridSize", GUICtrlRead($event.ID)))
			
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Settings_View_Handler

Func Settings_View_Create(ByRef $this)
	Local Const $themeGroupLeft = 10
	Local Const $themeGroupTop = 10

	CreateGroup("Theme", $themeGroupLeft, $themeGroupTop, 60, 90)

	$this.ThemeLight = CreateRadio("Light", $themeGroupLeft + 5, $themeGroupTop + 15)

	$this.ThemeDark = CreateRadio("Dark", $themeGroupLeft + 5, $themeGroupTop + 40)

	$this.ThemeSystem = CreateRadio("System", $themeGroupLeft + 5, $themeGroupTop + 65)

	EndGroup()

	Local Const $gridGroupLeft = 10
	Local Const $gridGroupTop = 110

	CreateGroup("Grid", $gridGroupLeft, $gridGroupTop, 70, 95)

	$this.GridShow = CreateCheckbox("Show", $gridGroupLeft + 5, $gridGroupTop + 15)

	$this.GridSnap = CreateCheckbox("Snap", $gridGroupLeft + 5, $gridGroupTop + 40)

	$this.GridSize = CreateInput('', $gridGroupLeft + 5, $gridGroupTop + 65, 30)

	CreateLabel("Size", $gridGroupLeft + 40, $gridGroupTop + 68)

	EndGroup()
	
	$this.ShowHidden = CreateCheckbox("Show Hidden Controls", 15, 215)
EndFunc   ;==>Settings_View_Create

Func Settings_View_IsChecked(ByRef $this, Const ByRef $ctrl)
	#forceref $this
	
	Return BitAnd(GUICtrlRead($ctrl), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>Settings_View_GetState

#EndRegion - Settings View
