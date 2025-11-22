#include-once

#Region - Menubar

#include "View.au3"

Func Menubar()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Menubar_Handler")

	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PRIVATE, Null)

	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, MenubarView())

	Return $this
EndFunc   ;==>Menubar

Func MenuBar_Handler($this, Const $event)
	If $event.Sender = "Menubar" Then Return False

	Switch $event.ID
		Case "Init"
			$this.View.Create()

			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Hwnd Request"))

			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Settings Request"))

			Return True

		Case "Hwnd Requested"
			$this.ParentHwnd = $event.Hwnd

		Case "Settings Requested"
			Print("Menubar_InitView_Handler: Settings Requested")

;~ 			$this.View.Initialize($settings) ; uncomment this after Settings is finished

			Return True
			
		Case $this.View.Canvas
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Canvas Menu Item Selected"))

			Return True

		Case $this.View.Parameters
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Parameters Menu Item Selected"))

			Return True

		Case $this.View.Script
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Script Menu Item Selected"))

			Return True

		Case $this.View.ObjectExplorer
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Object Explorer Menu Item Selected"))

			Return True

		Case $this.View.Settings
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Settings Menu Item Selected"))

			Return True

		Case $this.View.New
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "New au3"))

			Return True

		Case $this.View.Open
			Local Const $selectedAu3 = FileOpenDialog("Choose an .au3", @DesktopCommonDir, "AutoIt (*.au3)", '', '', HWnd($this.ParentHwnd))

			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Selected au3", "au3", $selectedAu3))

			Return True

		Case $this.View.Save
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Save au3"))

			Return True

		Case $this.View.SaveAs
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Save as"))

			Return True

		Case $this.View.Exit
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", $GUI_EVENT_CLOSE))
			
			_Exit($event)

			Return True

		Case $this.View.ShowGrid, $this.View.GridSnap, $this.View.ShowHidden

			$this.View.Toggle($event.ID)

			Return True
	EndSwitch

	Return False
EndFunc   ;==>MenuBar_Handler

#EndRegion - Menubar
