
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func EmbeddedObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Init", "EmbeddedObject_Init")
	_AutoItObject_AddMethod($this, "Create", "EmbeddedObject_Create")

	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabItem", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabLeft", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabTop", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>EmbeddedObject

Func EmbeddedObject_Init(ByRef $this, Const ByRef $event)
	Do 
		Switch $event.ID
			Case "Canvas Tab Item Requested"
				$messageQueue.Push($messageQueue.CreateEvent("Canvas", "Canvas Tab Item Request")
				
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
	Until False
	
	Return False
EndFunc   ;==>EmbeddedObject_MainHandler

Func EmbeddedObject_Create(Const ByRef $this)
	#forceref $this
	
	Print("Must override 'Create' method.")
EndFunc   ;==>EmbeddedObject_Create

#EndRegion - Embedded Object
