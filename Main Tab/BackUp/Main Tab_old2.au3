
#include-once

#Region - Main Tab

Func MainTab()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainTab_Handler")

	_AutoItObject_AddMethod($this, "Create", "MainTab_Create", True)

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
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Show"))

			Return True

		Case "Parameters Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Parameters)
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Show"))

			Return True

		Case "Script Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Script)
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Show"))

			Return True

		Case "Object Explorer Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.ObjectExplorer)
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Show"))

			Return True

		Case "Settings Tab Selected"
			_GUICtrlTab_ActivateTab($this.Tab, $this.Settings)
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Show"))

			Return True

		Case $GUI_EVENT_PRIMARYUP
			Switch _GUICtrlTab_HitTest($this.Tab, (MouseGetPos(0) - $this.Left), (MouseGetPos(1) - $this.Top))[0]
				Case $this.Canvas			
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Show"))

					Return True

				Case $this.Parameters
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
					$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Show"))

					Return True

				Case $this.Script
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Show"))

					Return True

				Case $this.ObjectExplorer
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Show"))

					Return True

				Case $this.Settings
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Canvas Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Parameters Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Script Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Object Explorer Hide"))
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Settings Show"))

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

#EndRegion - Main Tab
