
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
		Case "Init"
			$this.Create()
			
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Main Tab Broadcast", "Tab", $this.Tab, "Left", $this.Left, "Top", $this.Top))
			
			Return True

		Case "Main Tab Request"
			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Main Tab Broadcast", "Tab", $this.Tab, "Left", $this.Left, "Top", $this.Top))
		
		Case $GUI_EVENT_PRIMARYUP			
			Switch _GUICtrlTab_HitTest($this.Tab, (MouseGetPos(0) - $this.TabLeft), (MouseGetPos(1) - $this.TabTop))[0]
				Case $this.Canvas
					$this.Show()

					Return True
					
				Case Else
					If $event.Form <> $this.Hwnd Then
						$this.Hide()
					EndIf

					Return True
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab($this.Left, $this.Top, 350 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)
	
	$this.Canvas = _GUICtrlTab_InsertItem($this.Tab, 0, "Canvas")

EndFunc   ;==>MainTab_Create

#EndRegion - Main Tab
