
#include-once

#Region - Parameters

Func Parameters()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "Parameters_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "Parameters_Create")
	
	$this.TabItemName = "Parameters"

	Return $this
EndFunc   ;==>Parameters

Func Parameters_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	Return False
EndFunc   ;==>Parameters_Handler

Func Parameters_Create(ByRef $this)
	#forceref $this
EndFunc   ;==>Parameters_Create

#EndRegion - Parameters
