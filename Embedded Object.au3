
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func TabItemObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "TabItemObject_Create")
	_AutoItObject_AddMethod($this, "InitHandler", "TabItemObject_InitHandler")

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
	_AutoItObject_AddProperty($this, "Initialized", $ELSCOPE_PUBLIC, False)

	Return $this
EndFunc   ;==>TabItemObject

Func TabItemObject_InitHandler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Init"			
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $this.Name & " Tab Item Request"))
			
			Return True

		Case $this.Name & " Tab Item Requested"			
			$this.TabItemHwnd = $event.TabItemHwnd

			$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Main Form Request"))
			
			Return True
			
		Case $this.Name & " Main Form Requested"
			$this.ParentHwnd = $event.Form

			$this.ParentWidth = $event.Width

			$this.ParentHeight = $event.Height
			
			$this.Initialized = True
			
			$this.Create()

			Return True
	EndSwitch
	
	Return False
EndFunc

Func TabItemObject_Create(Const ByRef $this)
	#forceref $this

	Print("Must override 'Create' method.")
EndFunc   ;==>TabItemObject_Create

#EndRegion - Embedded Object
