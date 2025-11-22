
#include-once

#include "Form Parameters.au3"

#Region - Parameters

Func Parameters()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "Parameters_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "Parameters_Create")

	_AutoItObject_AddProperty($this, "ActiveParameters", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Form", $ELSCOPE_PRIVATE, FormParameters())
	_AutoItObject_AddProperty($this, "Group", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Button", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Checkbox", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Radio", $ELSCOPE_PRIVATE, Null)
	
	$this.Name = "Parameters"

	Return $this
EndFunc   ;==>Parameters

Func Parameters_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	Switch $event.ID
		Case $this.Name & " Selected"
			If $this.ActiveParameters Then
				$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.ActiveParameters & " Hide"))
				
				$this.ActiveParameters = Null
			EndIf
			
			$this.Show()

			Return True

		Case "Form Selected"
			$this.ActiveParameters = "Form Parameters"

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Parameters_Handler

Func Parameters_Create(ByRef $this)
	#forceref $this
	
	Local Const $prevHwnd = GUISwitch($this.TabItemHwnd)
	


	GUISwitch($prevHwnd)
EndFunc   ;==>Parameters_Create

#EndRegion - Parameters
