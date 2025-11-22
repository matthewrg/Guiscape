
#include-once

#include "Form Parameters.au3"

#Region - Parameters

Func Parameters()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Parameters_Handler")
	
	_AutoItObject_AddMethod($this, "Create", "Parameters_Create", True)
	_AutoItObject_AddMethod($this, "Show", "Parameters_Show", True)
	_AutoItObject_AddMethod($this, "Hide", "Parameters_Hide", True)
	
	_AutoItObject_AddProperty($this, "Hwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Active", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Form", $ELSCOPE_PRIVATE, FormParameters())
	_AutoItObject_AddProperty($this, "Group", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Button", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Checkbox", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Radio", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Visible", $ELSCOPE_PRIVATE, False)
	
	Return $this
EndFunc   ;==>Parameters

Func Parameters_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Init View"			
			$messageQueue.Push($messageQueue.CreateEvent("Parameters", "Size Request"))

			Return True
			
		Case "Size Requested"
			$this.ParentWidth = $event.Width
			
			$this.ParentHeight = $event.Height
			
			$messageQueue.Push($messageQueue.CreateEvent("Parameters", "Hwnd Request"))

			Return True
			
		Case "Hwnd Requested"
			$this.ParentHwnd = $event.Form
			
			$this.Create()

			Return True

		Case "Parameters Hide"
			$this.Hide()

			Return True
			
		Case "Parameters Show"
			$this.Show()
				
			Return True
			
		Case "Form Selected"
			$this.Active.Init($event.Form)
				
			Return True
		
		Case "Canvas Selected"
				Switch $this.Active
		Case "Form Parameters"
			$messageQueue.Push($messageQueue.CreateEvent("Parameters", "Form Parameters Hide"))
	EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>Parameters_Handler

Func Parameters_Create(ByRef $this)		
	$this.Hwnd = GUICreate( _
			"Parameters", _
			(($this.ParentWidth - 100) * $DPIRatio), _
			(($this.ParentHeight - 60) * $DPIRatio), _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.ParentHwnd))

	GUISwitch(HWnd($this.Hwnd))
EndFunc

Func Parameters_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
	

EndFunc   ;==>Parameters_Show

Func Parameters_Hide(Const ByRef $this)	
	Switch $this.Active
		Case "Form Parameters"
			$messageQueue.Push($messageQueue.CreateEvent("Parameters", "Form Parameters Show"))
	EndSwitch
	
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Parameters_Hide

#EndRegion - Parameters
