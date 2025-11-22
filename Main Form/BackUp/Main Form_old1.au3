
#include-once

#include "View.au3"

#region - Main Form

Func MainForm()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainForm_Handler")
	
	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, MainForm_View())

	Return $this
EndFunc   ;==>MainForm

Func MainForm_Handler(ByRef $this, Const ByRef $event)
	Switch $event.Sender 
		Case "Main Form"
			Return False
	Switch $event.ID
		Case $GUI_EVENT_RESIZED
			Switch $event.Form
				Case $this.View.Hwnd
					$this.View.SetSizePos()

					Return True
			EndSwitch

		Case $GUI_EVENT_CLOSE, "Exit"
			; Ask if the Designer would like to save their progress before closing the window.
			
			Switch $event.Form
				Case $this.View.Hwnd
					_Exit($event)
			EndSwitch
			
		Case "Init View"	
			$this.View.Create()

			$this.View.Show()
			
			Return True
			
		Case "Hwnd Request"			
			$messageQueue.Push($messageQueue.CreateEvent("Main Form", "Hwnd Requested", "Hwnd", $this.View.Hwnd))	
	EndSwitch
	EndSwitch
	
	Return False
EndFunc   ;==>MainForm_Handler

#endregion - Main Form
