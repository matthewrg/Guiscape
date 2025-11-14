
#include-once

#region - Object Explorer

Func ObjectExplorer()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "ObjectExplorer_Handler")
	$this.AddMethod("Create", "ObjectExplorer_Create")
	$this.AddMethod("Show", "ObjectExplorer_Show")
	$this.AddMethod("Hide", "ObjectExplorer_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)
	$this.AddProperty("Parent", $ELSCOPE_PRIVATE)	
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>ObjectExplorer

Func ObjectExplorer_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event
	
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Return True
	EndSwitch
	
	Return False
EndFunc

Func ObjectExplorer_Create(ByRef $this, Const ByRef $parent)		
	$this.Parent = $parent 
	
	$this.Hwnd = $parent.CreateImbeddedWindow("Object Explorer")

	GUISetBkColor($COLOR_RED, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorer_Create

Func ObjectExplorer_Show(ByRef $this)	
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorer_Show

Func ObjectExplorer_Hide(ByRef $this)	
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorer_Hide
#endregion - Object Explorer
