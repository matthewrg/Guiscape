
#include-once

#Region - Main Tab

Func MainTab()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainTab_Handler")

	_AutoItObject_AddMethod($this, "Create", "MainTab_Create", True)
	_AutoItObject_AddMethod($this, "ShowCanvas", "MainTab_Show_Canvas", True)
	_AutoItObject_AddMethod($this, "ShowParameters", "MainTab_Show_Parameters", True)
	_AutoItObject_AddMethod($this, "ShowScript", "MainTab_Show_Script", True)
	_AutoItObject_AddMethod($this, "ShowObjectExplorer", "MainTab_Show_ObjectExplorer", True)
	_AutoItObject_AddMethod($this, "ShowSettings", "MainTab_Show_Settings", True)

	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_PRIVATE, 92 * $DPIRatio)
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_PRIVATE, 5 * $DPIRatio)
	_AutoItObject_AddProperty($this, "Canvas", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Parameters", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Script", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ObjectExplorer", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Settings", $ELSCOPE_PRIVATE, Null)

	Return $this
EndFunc   ;==>MainTab

Func MainTab_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = "Main Tab" Then Return False

	Switch $event.ID
		Case "Init View"
			$this.Create()

			Return True
			
		Case "Main Tab Request"
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Main Tab Requested"), "Tab", $this.Tab, "Left", $this.Left, "Top", $this.Top)
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab($this.Left, $this.Top, 350 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.Parameters = _GUICtrlTab_InsertItem($this.Tab, 1, "Parameters")

	$this.Script = _GUICtrlTab_InsertItem($this.Tab, 2, "Script")

	$this.ObjectExplorer = _GUICtrlTab_InsertItem($this.Tab, 3, "Object Explorer")

	$this.Settings = _GUICtrlTab_InsertItem($this.Tab, 4, "Settings")
EndFunc   ;==>MainTab_Create

Func MainTab_Show_Canvas(ByRef $this)
	#forceref $this

	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Tab Show"))
EndFunc   ;==>MainTab_Show_Canvas

Func MainTab_Show_Parameters(ByRef $this)
	#forceref $this

	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Tab Show"))
EndFunc   ;==>MainTab_Show_Parameters

Func MainTab_Show_Script(ByRef $this)
	#forceref $this

	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Tab Show"))
EndFunc   ;==>MainTab_Show_Script

Func MainTab_Show_ObjectExplorer(ByRef $this)
	#forceref $this

	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Tab Show"))
EndFunc   ;==>MainTab_Show_ObjectExplorer

Func MainTab_Show_Settings(ByRef $this)
	#forceref $this

	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Tab Show"))
EndFunc   ;==>MainTab_Show_Settings

#EndRegion - Main Tab
