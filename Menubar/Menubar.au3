
#include-once

#include "Model.au3"

#include "View.au3"

Func Menubar(Const $settingsDir)
  Local $this = _AutoItObject_Class()
  
  $this.Create()
  
  $this.AddMethod("Handler", "Menubar_Handler")
  
  $this.AddMethod("Create", "Menubar_Create")
  
  $this.AddMethod("Initialize", "Menubar_Initialize")
  
  $this.AddProperty("Model", $ELSCOPE_READONLY, MenubarModel($settingsDir))
  
  $this.AddProperty("View" , $ELSCOPE_READONLY, MenubarView())  
  
  Return $this.Object
EndFunc

Func Menubar_Handler(ByRef $this, Const $eventID)  
  Switch $eventID	  
	Case $this.View.ShowGrid
	  Local $setting = $this.View.Toggle($this.View.ShowGrid)
	  
	  $this.Model.WriteSetting("ShowGrid", $setting)
	  
	  Return "ShowGrid"
	  
	Case $this.View.GridSnap
	  Local $setting = $this.View.Toggle($this.View.GridSnap)
	  
	  $this.Model.WriteSetting("SnapToGrid", $setting)
	  
	  Return "SnapToGrid"
	  
	Case $this.View.PastePos
	  Local $setting = $this.View.Toggle($this.View.PastePos)
	  
	  $this.Model.WriteSetting("PasteAtMousePosition", $setting)
	  
	  Return "PasteAtMousePosition"
	  
	Case $this.View.ShowControl
	  Local $setting = $this.View.Toggle($this.View.ShowControl)
	  
	  $this.Model.WriteSetting("ShowControlWhenMoving", $setting)
	  
	  Return "ShowControlWhenMoving"
	  
	Case $this.View.ShowHidden
	  Local $setting = $this.View.Toggle($this.View.ShowHidden)
	  
	  $this.Model.WriteSetting("ShowHiddenControls", $setting)
	  
	  Return "ShowHiddenControls"
	  
	Case $this.View.ObjectExplorer
	  Return "ObjectExplorer"
	  
	Case $this.View.ClearAllControls
	  Return "ClearAllControls"
	  
	Case $this.View.About
	  Return "About"
	  
	Case $this.View.Save
	  Return "Save"
	  
	Case $this.View.Load
	  Return "Load"
		
	Case $this.View.Exit
	  Return "Exit"
  EndSwitch
  
  Return False
EndFunc

Func Menubar_Create(ByRef $this)
  $this.View.Create()
EndFunc

Func Menubar_Initialize(ByRef $this)  
  Local Const $settings = $this.Model.GetSettings()
  
  Local Const $menuItems[] = [$this.View.ShowGrid, $this.View.GridSnap, $this.View.PastePos, $this.View.ShowControl, $this.View.ShowHidden]
  
  Local Const $itemCount = UBound($menuItems)
  
  For $i = 1 To $itemCount
	If $settings[$i][1] = 1 Then
	  GUICtrlSetState($menuItems[$i - 1], $GUI_CHECKED)
	Else
	  GUICtrlSetState($menuItems[$i - 1], $GUI_UNCHECKED)
	EndIf
  Next
EndFunc