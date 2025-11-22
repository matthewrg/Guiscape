
#include-once

#Region - Canvas

#include <MsgBoxConstants.au3>

#include "..\Embedded Object.au3"

Func Canvas()
	Local $this = _AutoItObject_Create(EmbeddedObject())

	_AutoItObject_AddMethod($this, "Handler", "Canvas_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "Canvas_Create")
	
	_AutoItObject_AddProperty($this, "ContextCreateForm", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ContextErase", $ELSCOPE_PRIVATE, Null)
	
	Return $this
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const ByRef $event)	
	Switch $event.ID	
		Case "Init"
			$this.Name = "Canvas"
			
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Tab Item Request"))	

			Return True
			
		Case $this.Name & " Tab Item Requested"				
			$this.TabItemHwnd = $event.TabItemHwnd
			
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Main Form Request"))
			
		Case "Main Form Requested"				
				$this.ParentHwnd = $event.Form

				$this.ParentWidth = $event.Width

				$this.ParentHeight = $event.Height
				
			$this.Create()

			Return True
			
		
	$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Tab Item Request"))	
	
	Print($this.Name & " Tab Item Request")
			
		Case $this.ContextCreateForm
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Form Create Request"))
			
			Return True

		Case $this.ContextErase
			MsgBox($MB_YESNO + $MB_ICONQUESTION, "Are you sure?", "This action cannot be undone unless you save your progress.")
			
			Return True
			
		Case $GUI_EVENT_PRIMARYUP	
			Switch WinGetTitle($event.Form)
				Case $this.Name
					$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Clicked"))
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this)	
	Local Const $prevHwnd = GUISwitch($this.TabItemHwnd)
	
	GUISetBkColor($COLOR_WHITE, HWnd($this.TabItemHwnd))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ContextCreateForm = GUICtrlCreateMenuItem("Create Form", $contextMenu)

	$this.ContextErase = GUICtrlCreateMenuItem("Erase " & $this.Name, $contextMenu)
	
	GUISwitch($prevHwnd)
EndFunc   ;==>Canvas_Create

#EndRegion - Canvas
