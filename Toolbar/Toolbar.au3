#include-once

#Region - Toolbar

#include "View.au3"

Func Toolbar()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Toolbar_Handler")
	
	_AutoItObject_AddMethod($this, "Create", "Toolbar_Create", True)

	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, Toolbar_View())
	
	_AutoItObject_AddProperty($this, "ResourcesDirectory", $ELSCOPE_PRIVATE, Null)
	
	Return $this
EndFunc   ;==>Toolbar

Func Toolbar_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = "Toolbar" Then Return False

	Switch $event.ID			
		Case "Init"
			$messageQueue.Push($messageQueue.CreateEvent("Toolbar", "Resources Directory Request"))
			
			Return True
			
		Case "Resources Directory Requested"
			$this.ResourcesDirectory = $event.ResourcesDirectory
	
			$this.View.Create($this.ResourcesDirectory)
			
		Case $this.View.Form

			Return "Form"

		Case $this.View.Group

			Return "Group"

		Case $this.View.Button

			Return "Button"

		Case $this.View.Checkbox

			Return "Checkbox"

		Case $this.View.Radio

			Return "Radio"

		Case $this.View.Edit

			Return "Edit"
	EndSwitch

	Return False
EndFunc   ;==>Toolbar_Handler

#EndRegion - Toolbar
