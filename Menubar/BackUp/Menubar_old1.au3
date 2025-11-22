#include-once

#include "View.au3"

#Region - Menubar

Func Menubar()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Menubar_Handler")

	_AutoItObject_AddMethod($this, "ChangeState", "Menubar_ChangeState")
	
	_AutoItObject_AddProperty($this, "State", $ELSCOPE_PUBLIC, Null)
	
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)
	
	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PUBLIC, MenubarView())	
	
	$this.State = Menubar_InitView_State($this)
	
	Return $this
EndFunc   ;==>Menubar

Func MenuBar_Handler($this, Const $event)
	If $event.Sender = "Menubar" Then Return False
	
	$this.State.Handler($event)
	
	Return True
EndFunc   ;==>MenuBar_Handler

Func Menubar_ChangeState($this, Const ByRef $state)	
	$this.State = $state
	
	Return True
EndFunc   ;==>Menubar_ChangeState

#Region - Main State

Func Menubar_Main_State($menubar)	
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Menubar_Main_Handler")
	
	_AutoItObject_AddProperty($this, "Menubar", $ELSCOPE_PUBLIC, $menubar)

	Return $this
EndFunc   ;==>Menubar_Main_State

Func Menubar_Main_Handler($this, Const $event)	
			Switch $event.ID
				Case $this.Menubar.View.Canvas
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Canvas Menu Item Selected"))
					
					Return True
					
				Case $this.Menubar.View.Parameters
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Parameters Menu Item Selected"))
					
					Return True
					
				Case $this.Menubar.View.Script
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Script Menu Item Selected"))
					
					Return True
					
				Case $this.Menubar.View.ObjectExplorer
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Object Explorer Menu Item Selected"))
					
					Return True
					
				Case $this.Menubar.View.Settings
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Settings Menu Item Selected"))
					
					Return True
					
				Case $this.Menubar.View.New
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "New au3"))
					
					Return True
					
				Case $this.Menubar.View.Open
					Local Const $selectedAu3 = FileOpenDialog("Choose an .au3", @DesktopCommonDir, "AutoIt (*.au3)", '', '', HWnd($this.Menubar.ParentHwnd))
					
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Selected au3", "au3", $selectedAu3))
				
					Return True
					
				Case $this.Menubar.View.Save					
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Save au3", "au3", $selectedAu3))
					
					Return True
					
				Case $this.Menubar.View.SaveAs			
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Save as", "au3", $selectedAu3))
					
					Return True
					
				Case $this.Menubar.View.Exit						
					$messageQueue.Push($messageQueue.CreateEvent("Menubar", $GUI_EVENT_CLOSE, "Form", $this.Menubar.ParentHwnd, "Control", $event.ID))
					
					Return True		
					
				Case $this.Menubar.View.ShowGrid, $this.Menubar.View.GridSnap, $this.Menubar.View.ShowHidden		
					
					$this.Menubar.View.Toggle($event.ID)

					Return True			
			EndSwitch

	Return False
EndFunc   ;==>Menubar_Main_Handler

#EndRegion - Main State

#Region - Init View State

Func Menubar_InitView_State($menubar)
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Menubar_InitView_Handler")
	
	_AutoItObject_AddProperty($this, "Menubar", $ELSCOPE_PUBLIC, $menubar)
	
	Return $this
EndFunc   ;==>Menubar_InitView_State

Func Menubar_InitView_Handler($this, Const $event)		
	If $event.Sender = "Menubar" Then Return False

	Switch $event.ID
		Case "Init"
			$this.Menubar.View.Create()
			
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Hwnd Request"))
			
			$messageQueue.Push($messageQueue.CreateEvent("Menubar", "Settings Request"))

			$this.Menubar.ChangeState(Menubar_Main_State($this.Menubar)) ; remove this after Settings is finished

			Return True
			
		Case "Hwnd Requested"						
			$this.Menubar.ParentHwnd = $event.Hwnd

		Case "Settings Requested"
			Print("Menubar_InitView_Handler: Settings Requested")

;~ 			$this.Menubar.View.Initialize($settings) ; uncomment this after Settings is finished

			$this.Menubar.ChangeState(Menubar_Main_State($this.Menubar))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Menubar_InitView_Handler

#EndRegion - Init View State

#EndRegion - Menubar
