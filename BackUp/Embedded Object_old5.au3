
#include-once

#Region - Embedded Object

#include <MsgBoxConstants.au3>

Func TabItemObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "TabItemObject_Create")

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

Func TabItemObject_Create(Const ByRef $this)
	#forceref $this

	Print("Must override 'Create' method.")
EndFunc   ;==>EmbeddedObject_Create

#EndRegion - Embedded Object
