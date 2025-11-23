
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
					
					$messageQueue.Push($messageQueue.CreateEvent($this.Name, $mainFormResized, "Width", $this.View.Width, "Height", $this.View.Height, "Left", $this.View.Left, "Top", $this.View.Top))

					Return True
			EndSwitch
			
		Case $GUI_NC_CLICKED
			Switch $event.Form
				Case $this.View.Hwnd
					;
			EndSwitch
			
			Return True

		Case $init
			$this.View.Create()
			
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $mainFormBroadcast, "Form", $this.View.Hwnd, "Width", $this.View.Width, "Height", $this.View.Height, "Left", $this.View.Left, "Top", $this.View.Top))
			
			Return True
			
		Case $mainFormRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $mainFormRequest), "Form", $this.View.Hwnd, "Width", $this.View.Width, "Height", $this.View.Height, "Left", $this.View.Left, "Top", $this.View.Top))

			Return True
			
		Case $mainFormHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $mainFormHwndRequest), "Hwnd", $this.View.Hwnd))

			Return True
			
		Case $mainFormShowRequest
			$this.View.Show()

			Return True

		Case $GUI_EVENT_CLOSE
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $GUI_EVENT_CLOSE))
			
			_Exit($event)
	EndSwitch

	Return False
EndFunc   ;==>MainForm_Handler

#EndRegion - Main Form
