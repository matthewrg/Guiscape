
#include-once

#Region - Tab Item Object

#include <MsgBoxConstants.au3>

Func TabItemObject()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "TabItemObject_Create")
	_AutoItObject_AddMethod($this, "InitHandler", "TabItemObject_InitHandler")

	_AutoItObject_AddProperty($this, "TabItemName", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabItemHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabLeft", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabTop", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>TabItemObject

Func TabItemObject_InitHandler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $init
			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, Request($this.TabItemName, $tabItemHwndRequest)))

			Return True

		Case Response($this.TabItemName, $tabItemHwndRequest)
			$this.TabItemHwnd = $event.TabItemHwnd

			$messageQueue.Push($messageQueue.CreateEvent($this.TabItemName, $mainFormRequest))

			Return True

		Case Response($this.TabItemName, $mainFormRequest)
			$this.ParentHwnd = $event.Form

			$this.ParentWidth = $event.Width

			$this.ParentHeight = $event.Height

			$this.Create()

			Return True
	EndSwitch

	Return False
EndFunc   ;==>TabItemObject_InitHandler

Func TabItemObject_Create(Const ByRef $this)
	#forceref $this

	Print("Must override 'Create' method.")
EndFunc   ;==>TabItemObject_Create

#EndRegion - Tab Item Object
