
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func EmbeddedObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "EmbeddedObject_Handler")
	
	_AutoItObject_AddMethod($this, "Create", "EmbeddedObject_Create", True)
	
	_AutoItObject_AddProperty($this, "TabItemHwnd", $ELSCOPE_PRIVATE, Null)

	Return $this
EndFunc   ;==>EmbeddedObject

Func EmbeddedObject_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID					
		Case "Init"			
			$this.Create()

			Return True
			
		Case $this.ContextCreateForm
			$messageQueue.Push($messageQueue.CreateEvent("EmbeddedObject", "Form Create Request"))
			
			Return "Context Create Form"

		Case $this.ContextErase
			MsgBox($MB_YESNO + $MB_ICONQUESTION, "Are you sure?", "This action cannot be undone unless you save your progress.")
			
			Return "Context Erase EmbeddedObject"
	EndSwitch

	Return False
EndFunc   ;==>EmbeddedObject_Handler

Func EmbeddedObject_Create(ByRef $this)	
EndFunc   ;==>EmbeddedObject_Create

#EndRegion - Embedded Object
