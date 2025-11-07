#include-once

#include "..\AutoItObject.au3"

#include "View.au3"

Func Menubar()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Menubar_Handler")
	$this.AddMethod("Create", "Menubar_Create")

	$this.AddProperty("View", $ELSCOPE_READONLY, MenubarView())

	Return $this.Object
EndFunc   ;==>Menubar

Func Menubar_Handler(ByRef $this, Const $eventID)	
	Local $setting
	
	Switch $eventID
		Case $this.View.Save
			Return "Save"

		Case $this.View.Load
			Return "Load"

		Case $this.View.Exit
			Return "Exit"
			
		Case $this.View.ShowGrid
			$setting = $this.View.Toggle($eventID)

			Return "ShowGrid"

		Case $this.View.GridSnap
			$setting = $this.View.Toggle($eventID)

			$this.Model.WriteSetting("SnapToGrid", $setting)

			Return "SnapToGrid"

		Case $this.View.PastePos
			$setting = $this.View.Toggle($eventID)

			$this.Model.WriteSetting("PasteAtMousePosition", $setting)

			Return "PasteAtMousePosition"

		Case $this.View.ShowControl
			$setting = $this.View.Toggle($eventID)

			$this.Model.WriteSetting("ShowControlWhenMoving", $setting)

			Return "ShowControlWhenMoving"

		Case $this.View.ShowHidden
			$setting = $this.View.Toggle($eventID)

			$this.Model.WriteSetting("ShowHiddenControls", $setting)

			Return "ShowHiddenControls"
		
		Case $this.View.Canvas, $this.View.Properties, $this.View.Script, $this.View.ObjectExplorer
			Return $eventID

		Case $this.View.About
			Return "About"
	EndSwitch

	Return False
EndFunc   ;==>Menubar_Handler

Func Menubar_Create(ByRef $this)
	$this.View.Create()
EndFunc   ;==>Menubar_Create
