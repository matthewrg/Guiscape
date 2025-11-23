
#include-once

#Region - Main Tab

#include "View.au3"

Func MainTab()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainTab_Handler")

	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_PRIVATE, "Main Tab")
	
	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, MainTab_View())
	
	Return $this
EndFunc   ;==>MainTab

Func MainTab_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = $this.Name Then Return False

	Switch $event.ID
		Case $init
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, $mainFormRequest))

			Return True

		Case Response($this.Name, $mainFormRequest)
			$this.View.ParentHwnd = $event.Form

			$this.View.ParentWidth = $event.Width

			$this.View.ParentHeight = $event.Height
			
			$this.View.ParentLeft = $event.Left

			$this.View.ParentTop = $event.Top
			
			$this.View.Create()

			Return True

		Case $mainFormResized, $mainFormMoved
			$this.View.ParentWidth = $event.Width

			$this.View.ParentHeight = $event.Height

			$this.View.ParentLeft = $event.Left

			$this.View.ParentTop = $event.Top

			$this.View.Resize()

			Return True
			
		Case "Canvas Clicked"
			$this.View.ActiveParametersHwnd = Null

			Return True
		
		Case "Form Object Selected"
			$this.View.ActiveParametersHwnd = $this.View.FormParametersHwnd

			Return True
		
		Case "Canvas " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.CanvasHwnd))

			Return True
			
		Case "Parameters " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.ParametersHwnd))

			Return True
			
		Case "Form Parameters " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.FormParametersHwnd))

			Return True
			
		Case "Script " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.ScriptHwnd))

			Return True
			
		Case "Object Explorer " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.ObjectExplorerHwnd))

			Return True
			
		Case "Settings " & $tabItemHwndRequest
			$messageQueue.Push($messageQueue.CreateEvent($this.Name, Response($event.Sender, $tabItemHwndRequest), "TabItemHwnd", $this.View.SettingsHwnd))

			Return True

		Case $showCanvasRequest
			_GUICtrlTab_ActivateTab($this.View.Tab, $this.View.CanvasIndex)
			
			$this.View.ShowCanvas()

			Return True

		Case $showParametersRequest
			_GUICtrlTab_ActivateTab($this.View.Tab, $this.View.ParametersIndex)
			
			$this.View.ShowParameters()

			Return True

		Case $showScriptRequest
			_GUICtrlTab_ActivateTab($this.View.Tab, $this.View.ScriptIndex)
			
			$this.View.ShowScript()

			Return True

		Case $showObjectExplorerRequest
			_GUICtrlTab_ActivateTab($this.View.Tab, $this.View.ObjectExplorerIndex)
			
			$this.View.ShowObjectExplorer()

			Return True

		Case $showSettingsRequest
			_GUICtrlTab_ActivateTab($this.View.Tab, $this.View.SettingsIndex)
			
			$this.View.ShowSettings()

			Return True

		Case $GUI_EVENT_PRIMARYUP
			Switch _GUICtrlTab_HitTest($this.View.Tab, ((MouseGetPos(0) - $this.View.TabLeft) * $DPIRatio), ((MouseGetPos(1) - $this.View.TabTop)  * $DPIRatio))[0]
				Case $this.View.CanvasIndex
					$this.View.ShowCanvas()

					Return True

				Case $this.View.ParametersIndex
					$this.View.ShowParameters()

					Return True

				Case $this.View.ScriptIndex
					$this.View.ShowScript()

					Return True

				Case $this.View.ObjectExplorerIndex
					$this.View.ShowObjectExplorer()

					Return True

				Case $this.View.SettingsIndex
					$this.View.ShowSettings()

					Return True
			EndSwitch
			
			Return False
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

#EndRegion - Main Tab
