
#include-once

#include "Form Parameters.au3"

#Region - Parameters

Func Parameters()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Parameters_Create")
	$this.AddMethod("Handler", "Parameters_Handler")
	$this.AddMethod("Show", "Parameters_Show")
	$this.AddMethod("Hide", "Parameters_Hide")
	
	$this.AddProperty("Form", $ELSCOPE_PRIVATE, FormParameters())
	$this.AddProperty("Active", $ELSCOPE_PRIVATE)
	$this.AddProperty("Group", $ELSCOPE_PRIVATE)
	$this.AddProperty("Button", $ELSCOPE_PRIVATE)
	$this.AddProperty("Checkbox", $ELSCOPE_PRIVATE)
	$this.AddProperty("Radio", $ELSCOPE_PRIVATE)
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)
	
	Return $this.Object
EndFunc   ;==>Parameters

Func Parameters_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Initialize Form"						
			$this.Active = $this.Form

			$this.Active.Init($event.Form)

			Return "Form Initialized"

		Case "Form Deselected"
			$this.Hide()

			Return True

		Case "Initialize Group"
			Return True

		Case "Initialize Button"
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Parameters_Handler

Func Parameters_Create(ByRef $this, Const ByRef $parent)	
	$this.Form.Create($parent)
EndFunc

Func Parameters_Show(Const ByRef $this)
	$this.Active.Show()
EndFunc   ;==>Parameters_Show

Func Parameters_Hide(Const ByRef $this)
	$this.Active.Hide()
EndFunc   ;==>Parameters_Hide

#EndRegion - Parameters
