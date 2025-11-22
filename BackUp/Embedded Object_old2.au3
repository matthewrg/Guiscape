
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func EmbeddedObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "MainHandler", "EmbeddedObject_MainHandler")	
	_AutoItObject_AddMethod($this, "Create", "EmbeddedObject_Create")
	
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)	
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PUBLIC, Null)	
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PRIVATE, Null)

	Return $this
EndFunc   ;==>EmbeddedObject

Func EmbeddedObject_MainHandler(ByRef $this, Const ByRef $event)
	Switch $event.ID	
		Case "Create"
			$this.Create()

			Return True	
			
		Case "Main Form Broadcast"
			$this.ParentHwnd = $event.Form
			
			$this.ParentWidth = $event.Width
			
			$this.ParentHeight = $event.Height
			
			Return True
			
		Case "Main Tab Broadcast"
			$this.Tab = $event.Tab
			
			$this.TabLeft = $event.Left
			
			$this.TabTop = $event.Top
			
			Return True	
	EndSwitch

	Return False
EndFunc   ;==>EmbeddedObject_Handler

Func EmbeddedObject_Create(Const ByRef $this)
	Print("Must override 'Create' method.")
EndFunc

#EndRegion - Embedded Object
