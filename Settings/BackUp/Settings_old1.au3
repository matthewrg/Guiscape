
#include-once

#region - Settings

Func Settings()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Settings_Handler")
	
	$this.AddMethod("Create", "Settings_Create", True)
	$this.AddMethod("Show", "Settings_Show", True)
	$this.AddMethod("Hide", "Settings_Hide", True)

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)
	$this.AddProperty("Model", $ELSCOPE_PRIVATE, SettingsModel())
	$this.AddProperty("Parent", $ELSCOPE_PRIVATE)	
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>Settings

Func Settings_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event
	
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP			
			Return True
	EndSwitch
	
	Return False
EndFunc

Func Settings_Create(ByRef $this, Const ByRef $parent)	
	$this.Parent = $parent 
	
	$this.Hwnd = $parent.CreateImbeddedWindow("Settings")
EndFunc   ;==>Settings_Create

Func Settings_Show(ByRef $this)	
			GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Settings_Show

Func Settings_Hide(ByRef $this)	
			GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Settings_Hide

#endregion - Settings
