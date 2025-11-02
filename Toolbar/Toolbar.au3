#include-once

#include "..\AutoItObject.au3"
#include "View.au3"

Func Toolbar(Const $resourcesDir)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Toolbar_Create")

	$this.AddMethod("Handler", "Toolbar_Handler")

	$this.AddProperty("View", $ELSCOPE_PRIVATE, ToolbarView($resourcesDir))

	Return $this.Object
EndFunc   ;==>Toolbar

Func Toolbar_Create(ByRef $this)
	$this.View.Create()
EndFunc   ;==>Toolbar_Create

Func Toolbar_Handler(ByRef $this, Const $eventID)
	Switch $eventID
		Case $this.View.Form
			Return "Form"

		Case $this.View.Button
			Return "Button"
	EndSwitch

	Return False
EndFunc   ;==>Toolbar_Handler
