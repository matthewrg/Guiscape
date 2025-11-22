
#include-once

#include "View.au3"

#Region - Main Form

Func MainForm()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainForm_Handler")

	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, MainForm_View())
	
	_AutoItObject_AddProperty($this, "ResourcesDir", $ELSCOPE_PRIVATE, @ScriptDir & "\Resources\")

	Return $this
EndFunc   ;==>MainForm

Func MainForm_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = "Main Form" Then Return False

			Switch $event.ID
				Case $GUI_EVENT_RESIZED
					Switch $event.Form
						Case $this.View.Hwnd
							$this.View.SetSizePos()

							Return True
					EndSwitch

				Case $GUI_EVENT_CLOSE
					; Ask if the Designer would like to save their progress before closing the window.

					Switch $event.Form
						Case $this.View.Hwnd, $event.MenubarItem
							_Exit($event)
					EndSwitch
					
				Case "Init View"
					$this.View.Create()

					$this.View.Show()

					Return True

				Case "Hwnd Request"
					$messageQueue.Push($messageQueue.CreateEvent("Main Form", "Hwnd Requested", "Hwnd", $this.View.Hwnd))
					
				Case "Resources Directory Request"					
					$messageQueue.Push($messageQueue.CreateEvent("Main Form", "Resources Directory Requested", "Directory", $this.ResourcesDir))
	EndSwitch

	Return False
EndFunc   ;==>MainForm_Handler

#EndRegion - Main Form
