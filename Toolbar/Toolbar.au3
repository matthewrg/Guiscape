#include-once

#include "View.au3"

Global $clickedTool

#region - Toolbar

Func Toolbar()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Toolbar_Create")
	$this.AddMethod("Handler", "Toolbar_Handler")

	$this.AddProperty("View", $ELSCOPE_PRIVATE, ToolbarView())

	Return $this.Object
EndFunc   ;==>Toolbar

Func Toolbar_Create(Const ByRef $this, Const ByRef $resourcesDir)
	$this.View.Create($resourcesDir)
EndFunc   ;==>Toolbar_Create

Func Toolbar_Handler(Const ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.View.Form
			$clickedTool = "Form"
			
			Return "Form"

		Case $this.View.Button
			$clickedTool = $clickedTool
			
			Return "Button"

		Case $this.View.Checkbox
			$clickedTool = $clickedTool
			
			Return "Checkbox"
	EndSwitch

	Return False
EndFunc   ;==>Toolbar_Handler

#endregion - Toolbar
