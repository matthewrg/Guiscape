
#include-once

#include "View.au3"

#Region - Main Form

Func MainForm()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainForm_Handler")

	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_PRIVATE, "Main Form")
	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, MainForm_View())

	Return $this
EndFunc   ;==>MainForm

Func MainForm_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = $this.Name Then Return False

	Switch $event.ID
		Case $GUI_EVENT_RESIZED
			Switch $event.Form
				Case $this.View.Hwnd
					$this.View.SetSizePos()
					
					$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Resized", "Width", $this.View.Width, "Height", $this.View.Height))

					Return True
			EndSwitch
			
		Case "GUI_NC_CLICKED"
			Switch $event.Form
				Case $this.View.Hwnd
					;
			EndSwitch
			
			Return True

		Case "Init"
			$this.View.Create()
			
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, "Main Form Broadcast", "Form", $this.View.Hwnd, "Width", $this.View.Width, "Height", $this.View.Height))
			
			Return True
			
		Case "Main Form Request"
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $event.Sender & " Main Form Requested", "Form", $this.View.Hwnd, "Width", $this.View.Width, "Height", $this.View.Height))

			Return True
			
		Case "Hwnd Request"
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $event.Sender & " Hwnd Requested", "Hwnd", $this.View.Hwnd))

			Return True
			
		Case "Main Form Show"
			$this.View.Show()

			Return True

		Case $GUI_EVENT_CLOSE
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $GUI_EVENT_CLOSE))
			
			_Exit($event)
	EndSwitch

	Return False
EndFunc   ;==>MainForm_Handler

#EndRegion - Main Form
