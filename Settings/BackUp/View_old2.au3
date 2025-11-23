
#include-once

#Region - Settings View

Func Settings_View()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "Settings_View_Create")
	
	_AutoItObject_AddMethod($this, "Handler", "Settings_View_Handler")

	_AutoItObject_AddProperty($this, "ThemeLight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ThemeDark", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ThemeSystem", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridShow", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridSnap", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "GridSize", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>Settings_View

Func Settings_View_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.GridShow
			If $this.GetState($event.ID) Then
				GUICtrlSetState($this.GridSnap, @SW_DISABLE)
				
				GUICtrlSetState($this.GridSize, @SW_DISABLE)
		EndIf
		
			Return True
	EndSwitch
	
	Return False
EndFunc

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
EndFunc   ;==>Settings_View_Create

Func Settings_View_GetState(ByRef $this, Const ByRef $ctrl)
	Return 
EndFunc

#EndRegion - Settings View
