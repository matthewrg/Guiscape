
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

		Case "Canvas Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Canvas)
			
					$this.ShowCanvas()

			Return True

		Case "Parameters Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Parameters)
			
					$this.ShowParameters()

			Return True

		Case "Script Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Script)
			
					$this.ShowScript()

			Return True

		Case "Object Explorer Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.ObjectExplorer)
			
					$this.ObjectExplorer()

			Return True

		Case "Settings Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Settings)
			
					$this.Settings()

			Return True

		Case $GUI_EVENT_PRIMARYUP
			Switch _GUICtrlTab_HitTest($this.Tab, (MouseGetPos(0) - $this.Left), (MouseGetPos(1) - $this.Top))[0]
				Case $this.Canvas
					$this.ShowCanvas()

					Return True

				Case $this.Parameters
					$this.ShowParameters()

					Return True

				Case $this.Script
					$this.ShowScript()

					Return True

				Case $this.ObjectExplorer
					$this.ObjectExplorer()

					Return True

				Case $this.Settings
					$this.Settings()

					Return True
			EndSwitch

			Return False
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab($this.Left, $this.Top, 350 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.Canvas = _GUICtrlTab_InsertItem($this.Tab, 0, "Canvas")

	$this.Parameters = _GUICtrlTab_InsertItem($this.Tab, 1, "Parameters")

	$this.Script = _GUICtrlTab_InsertItem($this.Tab, 2, "Script")

	$this.ObjectExplorer = _GUICtrlTab_InsertItem($this.Tab, 3, "Object Explorer")

	$this.Settings = _GUICtrlTab_InsertItem($this.Tab, 4, "Settings")
EndFunc   ;==>MainTab_Create

Func MainTab_Show_Canvas(ByRef $this)
	#forceref $this
	
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Show"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
EndFunc   ;==>MainTab_Show_Canvas

Func MainTab_Show_Parameters(ByRef $this)
	#forceref $this
	
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Show"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
EndFunc   ;==>MainTab_Show_Parameters

Func MainTab_Show_Script(ByRef $this)
	#forceref $this
	
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Show"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
EndFunc   ;==>MainTab_Show_Script

Func MainTab_Show_ObjectExplorer(ByRef $this)
	#forceref $this
	
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Show"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
EndFunc   ;==>MainTab_Show_ObjectExplorer

Func MainTab_Show_Settings(ByRef $this)
	#forceref $this
	
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
	$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Show"))
EndFunc   ;==>MainTab_Show_Settings

#EndRegion - Main Tab
