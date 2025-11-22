
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func EmbeddedObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Init", "EmbeddedObject_Init")
	_AutoItObject_AddMethod($this, "Create", "EmbeddedObject_Create")

	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabItemHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabLeft", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabTop", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "RequestedTabItem", $ELSCOPE_PUBLIC, False)
	_AutoItObject_AddProperty($this, "RequestedMainForm", $ELSCOPE_PUBLIC, False)
	_AutoItObject_AddProperty($this, "RequestedMainTab", $ELSCOPE_PUBLIC, False)

	Return $this
EndFunc   ;==>EmbeddedObject

Func EmbeddedObject_Init(ByRef $this, Const ByRef $event)	
	$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Tab Item Request"))	
	
		Switch $event.ID			
			Case $this.Name & " Tab Item Requested"
				Print($event.ID)
				
				$this.TabItemHwnd = $event.TabItemHwnd
				
				$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Main Form Request"))
				
			Case "Main Form Requested"
				Print($event.ID)
				
				$this.ParentHwnd = $event.Form

				$this.ParentWidth = $event.Width

				$this.ParentHeight = $event.Height
				
				$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Create"))
				
				Return True
		EndSwitch

	Return False
EndFunc   ;==>EmbeddedObject_Init

Func EmbeddedObject_Create(Const ByRef $this)
	#forceref $this

	Print("Must override 'Create' method.")
EndFunc   ;==>EmbeddedObject_Create

#EndRegion - Embedded Object
