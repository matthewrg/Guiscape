
#include-once

Func MenubarModel(Const $resourcesDir)
  Local $this = _AutoItObject_Class()
  
  $this.Create()
  
  $this.AddMethod("GetSettings" , "MenubarModel_GetSettings" )  
  $this.AddMethod("WriteSetting", "MenubarModel_WriteSetting")
  
  $this.AddProperty("INI", $ELSCOPE_PRIVATE, $resourcesDir & "\Settings.ini")
  
  Return $this.Object
EndFunc

Func MenubarModel_GetSettings(Const ByRef $this)  
  Return IniReadSection($this.INI, "Settings")
EndFunc

Func MenubarModel_WriteSetting(Const ByRef $this, Const $key, Const $value)
  Local $setting
  
  Switch $value
	Case $GUI_CHECKED
	  $setting = 1
	  
	Case $GUI_UNCHECKED
	  $setting = 0
  EndSwitch
  
  IniWrite($this.INI, "Settings", $key, $setting)
EndFunc