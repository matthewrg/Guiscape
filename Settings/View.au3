
#include-once

#Region - Settings View

Func Settings_View()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "Settings_View_Create")

	_AutoItObject_AddProperty($this, "LightTheme", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "DarkTheme", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "SystemTheme", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>Settings_View

Func Settings_View_Create(ByRef $this)
	CreateGroup("Theme", 5, 5, 70, 100)

	$this.LightTheme = CreateRadio("Light", 10, 25)

	$this.DarkTheme = CreateRadio("Dark", 10, 50)

	$this.SystemTheme = CreateRadio("System", 10, 75)

	EndGroup()
EndFunc   ;==>Settings_View_Create

#EndRegion - Settings View
