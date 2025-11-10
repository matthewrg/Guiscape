#include-once

#include "View.au3"

Func Menubar()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Menubar_Handler")
	$this.AddMethod("Create", "Menubar_Create")
	$this.AddMethod("Initialize", "Menubar_Initialize")

	$this.AddProperty("View", $ELSCOPE_PRIVATE, MenubarView())

	Return $this.Object
EndFunc   ;==>Menubar

Func Menubar_Handler(Const ByRef $this, Const ByRef $eventID)
	Local $menubar[]

	Switch $eventID
		Case $this.View.Save
			$menubar.Message = "Save"

			Return $menubar

		Case $this.View.Load
			$menubar.Message = "Load"

			Return $menubar

		Case $this.View.Exit
			$menubar.Message = "Exit"

			Return $menubar

		Case $this.View.ShowGrid
			$menubar.Message = "ShowGrid"

			$menubar.Setting = $this.View.Toggle($eventID)

			Return $menubar

		Case $this.View.GridSnap
			$menubar.Message = "SnapToGrid"

			$menubar.Setting = $this.View.Toggle($eventID)

			Return $menubar

		Case $this.View.PastePos
			$menubar.Message = "PasteAtMousePosition"

			$menubar.Setting = $this.View.Toggle($eventID)

			Return $menubar

		Case $this.View.ShowControl
			$menubar.Message = "ShowControlWhenMoving"

			$menubar.Setting = $this.View.Toggle($eventID)

			Return $menubar

		Case $this.View.ShowHidden
			$menubar.Message = "ShowHiddenControls"

			$menubar.Setting = $this.View.Toggle($eventID)

			Return $menubar

		Case $this.View.Canvas
			$menubar.Message = "Canvas"

			Return $menubar

		Case $this.View.Parameters
			$menubar.Message = "Parameters"

			Return $menubar

		Case $this.View.Script
			$menubar.Message = "Script"

			Return $menubar

		Case $this.View.ObjectExplorer
			$menubar.Message = "Object Explorer"

			Return $menubar

		Case $this.View.About
			$menubar.Message = "About"

			Return $menubar
	EndSwitch

	Return False
EndFunc   ;==>Menubar_Handler

Func Menubar_Create(Const ByRef $this)
	$this.View.Create()
EndFunc   ;==>Menubar_Create

Func Menubar_Initialize(Const ByRef $this, Const ByRef $settings)
	$this.View.Initialize($settings)
EndFunc   ;==>Menubar_Initialize
