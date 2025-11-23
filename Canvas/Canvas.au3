
#include-once

#Region - Canvas

#include <MsgBoxConstants.au3>

Func Canvas()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "Canvas_Handler")

	_AutoItObject_OverrideMethod($this, "Create", "Canvas_Create")

	_AutoItObject_AddProperty($this, "ContextCreateForm", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ContextErase", $ELSCOPE_PRIVATE, Null)
	
	$this.TabItemName = "Canvas"
	
	Return $this
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	Switch $event.ID
		Case $this.ContextCreateForm
			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, "Form Create Request"))

			Return True

		Case $this.ContextErase
			MsgBox($MB_YESNO + $MB_ICONQUESTION, "Are you sure?", "This action cannot be undone unless you save your progress.", 0, HWnd($this.TabItemHwnd))

			Return True

		Case $GUI_EVENT_PRIMARYUP
			Switch WinGetTitle($event.Form)
				Case $this.TabItemName
					$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, $this.TabItemName & " Clicked"))

					Return True
			EndSwitch
			
			Return False
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this)	
	Local Const $prevHwnd = GUISwitch(HWnd($this.TabItemHwnd))
	
	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ContextCreateForm = GUICtrlCreateMenuItem("Create Form", $contextMenu)

	$this.ContextErase = GUICtrlCreateMenuItem("Erase " & $this.TabItemName, $contextMenu)

	GUISwitch($prevHwnd)
EndFunc   ;==>Canvas_Create

#EndRegion - Canvas
