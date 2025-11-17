#include-once

#include "View.au3"

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
			
		Case $this.View.Group
			$clickedTool = "Group"
			
			Return "Group"

		Case $this.View.Button
			$clickedTool = "Button"
			
			Return "Button"

		Case $this.View.Checkbox
			$clickedTool = "Checkbox"
			
			Return "Checkbox"

		Case $this.View.Radio
			$clickedTool = "Radio"
			
			Return "Radio"

		Case $this.View.Edit
			$clickedTool = "Edit"
			
			Return "Edit"
	EndSwitch

	Return False
EndFunc   ;==>Toolbar_Handler

#endregion - Toolbar
