#include-once

#include <GuiConstantsEx.au3>

#include <WinAPISysWin.au3>

#include "AutoItObject.au3"

Func GuiscapeModel()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("GetSettings", "GuiscapeModel_GetSettings")
	$this.AddMethod("WriteSetting", "GuiscapeModel_WriteSetting")
	$this.AddMethod("Initialize", "GuiscapeModel_Initialize")

	Local Const $resourcesDir = @ScriptDir & "\Resources\"

	$this.AddProperty("Title", $ELSCOPE_READONLY, "Guiscape")
	$this.AddProperty("ResourcesDir", $ELSCOPE_READONLY, $resourcesDir)
	
	$this.AddProperty("INI", $ELSCOPE_PRIVATE, $resourcesDir & "\Settings.ini")

	Return $this.Object
EndFunc   ;==>GuiscapeModel

Func GuiscapeModel_GetSettings(Const ByRef $this)
	Return IniReadSection($this.INI, "Settings")
EndFunc   ;==>GuiscapeModel_GetSettings

Func GuiscapeModel_WriteSetting(Const ByRef $this, Const $key, Const $value)
	Local $setting

	Switch $value
		Case $GUI_CHECKED
			$setting = 1

		Case $GUI_UNCHECKED
			$setting = 0
	EndSwitch

	IniWrite($this.INI, "Settings", $key, $setting)
EndFunc   ;==>GuiscapeModel_WriteSetting

Func GuiscapeModel_Initialize(ByRef $this)
	Local Const $settings = $this.GetSettings()

	Local Const $menuItems[] = [$this.View.ShowGrid, $this.View.GridSnap, $this.View.PastePos, $this.View.ShowControl, $this.View.ShowHidden]

	Local Const $itemCount = UBound($menuItems)

	For $i = 1 To $itemCount
		If $settings[$i][1] = 1 Then
			GUICtrlSetState($menuItems[$i - 1], $GUI_CHECKED)
		Else
			GUICtrlSetState($menuItems[$i - 1], $GUI_UNCHECKED)
		EndIf
	Next
EndFunc   ;==>Menubar_Initialize
