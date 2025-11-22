
#include-once

#Region - Main Tab

Func MainTab()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainTab_Handler")

	_AutoItObject_AddMethod($this, "Create", "MainTab_Create", True)
	_AutoItObject_AddMethod($this, "TabItem", "MainTab_TabItem", True)
	_AutoItObject_AddMethod($this, "Resize", "MainTab_Resize", True)
	_AutoItObject_AddMethod($this, "Hide", "MainTab_Hide", True)
	_AutoItObject_AddMethod($this, "Show", "MainTab_Show", True)
	_AutoItObject_AddMethod($this, "ShowCanvas", "MainTab_ShowCanvas", True)
	_AutoItObject_AddMethod($this, "ShowParameters", "MainTab_ShowParameters", True)
	_AutoItObject_AddMethod($this, "ShowScript", "MainTab_ShowScript", True)
	_AutoItObject_AddMethod($this, "ShowObjectExplorer", "MainTab_ShowObjectExplorer", True)
	_AutoItObject_AddMethod($this, "ShowSettings", "MainTab_ShowSettings", True)

	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentLeft", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentTop", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "TabItemCount", $ELSCOPE_PRIVATE, 5)
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_PRIVATE, 92 * $DPIRatio)
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_PRIVATE, 5 * $DPIRatio)
	_AutoItObject_AddProperty($this, "CanvasIndex", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParametersIndex", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ScriptIndex", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ObjectExplorerIndex", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "SettingsIndex", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "CanvasHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParametersHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ScriptHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ObjectExplorerHwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "SettingsHwnd", $ELSCOPE_PRIVATE, Null)

	Return $this
EndFunc   ;==>MainTab

Func MainTab_Handler(ByRef $this, Const ByRef $event)
	If $event.Sender = "Main Tab" Then Return False

	Switch $event.ID
		Case "Init"
			$this.Create()

			$messageQueue.Push($messageQueue.CreateEvent("Main Tab", "Main Form Request"))

			Return True

		Case "Main Form Requested"
			$this.ParentHwnd = $event.Form

			$this.ParentWidth = $event.Width

			$this.ParentHeight = $event.Height

		Case "Main Form Resized"
			$this.ParentWidth = $event.Width

			$this.ParentHeight = $event.Height

			$this.Resize()

			Return False

		Case "Main Form Moved"
			$this.ParentLeft = $event.Left

			$this.ParentTop = $event.Top

			$this.Resize()

			Return False
			
		Case "Canvas Show"
					$this.ShowCanvas()

					Return True

		Case $GUI_EVENT_PRIMARYUP
			Switch _GUICtrlTab_HitTest($this.Tab, (MouseGetPos(0) - $this.Left), (MouseGetPos(1) - $this.Top))[0]
				Case $this.CanvasIndex
					$this.ShowCanvas()

					Return True

				Case $this.ParametersIndex
					$this.ShowParameters()

					Return True

				Case $this.ScriptIndex
					$this.ShowScript()

					Return True

				Case $this.ObjectExplorerIndex
					$this.ShowObjectExplorer()

					Return True

				Case $this.SettingsIndex
					$this.ShowSettings()

					Return True
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab($this.Left, $this.Top, 350 * $DPIRatio, 25 * $DPIRatio)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.CanvasIndex = _GUICtrlTab_InsertItem($this.Tab, 0, "Canvas")

	$this.CanvasHwnd = $this.TabItem("Canvas")

	$this.ParametersIndex = _GUICtrlTab_InsertItem($this.Tab, 1, "Parameters")

	$this.ParametersHwnd = $this.TabItem("Parameters")

	$this.ScriptIndex = _GUICtrlTab_InsertItem($this.Tab, 2, "Script")

	$this.ScriptHwnd = $this.TabItem("Script")

	$this.ObjectExplorerIndex = _GUICtrlTab_InsertItem($this.Tab, 3, "Object Explorer")

	$this.ObjectExplorerHwnd = $this.TabItem("Object Explorer")

	$this.SettingsIndex = _GUICtrlTab_InsertItem($this.Tab, 4, "Settings")

	$this.SettingsHwnd = $this.TabItem("Settings")

EndFunc   ;==>MainTab_Create

Func MainTab_TabItem(ByRef $this, Const ByRef $title)
	Return GUICreate( _
			$title, _
			(($this.ParentWidth - 100) * $DPIRatio), _
			(($this.ParentHeight - 60) * $DPIRatio), _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.ParentHwnd))
EndFunc   ;==>MainTab_TabItem

Func MainTab_Resize(Const ByRef $this)
	Local Const $tabItems[] = [$this.CanvasHwnd, $this.ParametersHwnd, $this.ScriptIndex, $this.ObjectExplorerHwnd, $this.SettingsIndex]

	Local Const $tabItemCount = UBound($tabItems) - 1

	Local $hwnd

	For $i = 0 To $tabItemCount
		$hwnd = HWnd($tabItems[$i])

		WinMove($hwnd, _
				WinGetTitle($hwnd), _
				(90 * $DPIRatio), _
				(30 * $DPIRatio), _
				(($this.ParentWidth - 100) * $DPIRatio), _
				(($this.ParentHeight - 60) * $DPIRatio))
	Next
EndFunc   ;==>MainTab_Resize

Func MainTab_ShowCanvas(Const ByRef $this)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.CanvasHwnd)
EndFunc   ;==>MainTab_ShowCanvas

Func MainTab_ShowParameters(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.ParametersHwnd)
EndFunc   ;==>MainTab_ShowParameters

Func MainTab_ShowScript(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.ScriptHwnd)
EndFunc   ;==>MainTab_ShowScript

Func MainTab_ShowObjectExplorer(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.ObjectExplorerHwnd)
EndFunc   ;==>MainTab_ShowObjectExplorer

Func MainTab_ShowSettings(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Show($this.SettingsHwnd)
EndFunc   ;==>MainTab_ShowSettings

Func MainTab_Show(Const ByRef $this, Const ByRef $hwnd)
	#forceref $this

	GUISetState(@SW_SHOW, HWnd($hwnd))
EndFunc   ;==>MainTab_Show

Func MainTab_Hide(Const ByRef $this, Const ByRef $hwnd)
	#forceref $this

	GUISetState(@SW_HIDE, HWnd($hwnd))
EndFunc   ;==>MainTab_Hide

#EndRegion - Main Tab
