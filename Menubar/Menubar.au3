#include-once

#Region - Menubar

#include "View.au3"

Func Menubar()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Menubar_Handler")

	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, Menubar_View())
	
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PRIVATE, Null)
	
	_AutoItObject_AddProperty($this, "Menubar", $ELSCOPE_PRIVATE, "Menubar")

	Return $this
EndFunc   ;==>Menubar

Func MenuBar_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = $this.Menubar Then Return False

	Switch $event.ID
		Case $init
			$this.View.Create()

			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, $mainFormHwndRequest))

			Return True

		Case Response($this.Menubar, $mainFormHwndRequest)
			$this.ParentHwnd = $event.Hwnd

			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, $settingsRequest))

			Return True
			
		Case Response($this.Menubar, $settingsRequest)
;~ 			$this.View.Initialize($settings) ; uncomment this after Settings is finished

			Return True

		Case $this.View.Open
			Local $selectedAu3 = FileOpenDialog("Choose an .au3", @DesktopCommonDir, "AutoIt (*.au3)", '', '', HWnd($this.ParentHwnd))

			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Selected au3", "au3", $selectedAu3))

			Return True

		Case $this.View.Save
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Save au3"))

			Return True

		Case $this.View.SaveAs
			$selectedAu3 = FileOpenDialog("Choose an .au3", @DesktopCommonDir, "AutoIt (*.au3)", '', '', HWnd($this.ParentHwnd))
			
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Save au3 as", "au3", $selectedAu3))

			Return True

		Case $this.View.Exit
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, $GUI_EVENT_CLOSE))
			
			_Exit($event)

			Return True

		Case $this.View.ShowGrid
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Show Grid " & $this.View.GetState($event.ID)))
			
			$this.View.Toggle($event.ID)

			Return True

		Case $this.View.GridSnap
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Grid Snap " & $this.View.GetState($event.ID)))
			
			$this.View.Toggle($event.ID)

			Return True

		Case $this.View.ShowHidden
			$messageQueue.Push($messageQueue.CreateEvent($this.Menubar, "Show Hidden " & $this.View.GetState($event.ID)))
			
			$this.View.Toggle($event.ID)

			Return True
	EndSwitch

	Return False
EndFunc   ;==>MenuBar_Handler

#EndRegion - Menubar
