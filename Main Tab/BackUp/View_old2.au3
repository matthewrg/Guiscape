
#include-once

#Region - Main Tab View

Func MainTab_View()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "MainTab_View_Create")
	_AutoItObject_AddMethod($this, "TabItem", "MainTab_View_TabItem")
	_AutoItObject_AddMethod($this, "Resize", "MainTab_View_Resize")
	_AutoItObject_AddMethod($this, "Hide", "MainTab_View_Hide")
	_AutoItObject_AddMethod($this, "Show", "MainTab_View_Show")
	_AutoItObject_AddMethod($this, "ShowCanvas", "MainTab_View_ShowCanvas")
	_AutoItObject_AddMethod($this, "ShowParameters", "MainTab_View_ShowParameters")
	_AutoItObject_AddMethod($this, "ShowScript", "MainTab_View_ShowScript")
	_AutoItObject_AddMethod($this, "ShowObjectExplorer", "MainTab_View_ShowObjectExplorer")
	_AutoItObject_AddMethod($this, "ShowSettings", "MainTab_View_ShowSettings")
	
	_AutoItObject_AddProperty($this, "Tab", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "TabLeft", $ELSCOPE_PUBLIC, 92)
	_AutoItObject_AddProperty($this, "TabTop", $ELSCOPE_PUBLIC, 5)
	_AutoItObject_AddProperty($this, "CanvasIndex", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParametersIndex", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ScriptIndex", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ObjectExplorerIndex", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "SettingsIndex", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentLeft", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParentTop", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "CanvasHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ParametersHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "FormParametersHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ActiveParametersHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ScriptHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "ObjectExplorerHwnd", $ELSCOPE_PUBLIC, Null)
	_AutoItObject_AddProperty($this, "SettingsHwnd", $ELSCOPE_PUBLIC, Null)

	Return $this
EndFunc   ;==>MainTab_View

Func MainTab_View_Create(ByRef $this)
	$this.Tab = CreateTab($this.TabLeft, $this.TabTop, 350, 25)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.CanvasIndex = _GUICtrlTab_InsertItem($this.Tab, 0, "Canvas")

	$this.CanvasHwnd = $this.TabItem("Canvas")

	$this.ParametersIndex = _GUICtrlTab_InsertItem($this.Tab, 1, "Parameters")

	$this.ParametersHwnd = $this.TabItem("Parameters")
	
	$this.FormParametersHwnd = $this.TabItem("Form Parameters")

	$this.ScriptIndex = _GUICtrlTab_InsertItem($this.Tab, 2, "Script")

	$this.ScriptHwnd = $this.TabItem("Script")

	$this.ObjectExplorerIndex = _GUICtrlTab_InsertItem($this.Tab, 3, "Object Explorer")

	$this.ObjectExplorerHwnd = $this.TabItem("Object Explorer")

	$this.SettingsIndex = _GUICtrlTab_InsertItem($this.Tab, 4, "Settings")

	$this.SettingsHwnd = $this.TabItem("Settings")
EndFunc   ;==>MainTab_View_Create

Func MainTab_View_TabItem(ByRef $this, Const $title)	
	Local Const $hwnd = GUICreate( _
			$title, _
			(($this.ParentWidth - 100) * $DPIRatio), _
			(($this.ParentHeight - 60) * $DPIRatio), _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.ParentHwnd))

	GUISetBkColor($COLOR_WHITE, $hwnd)

	Return $hwnd
EndFunc   ;==>MainTab_View_TabItem

Func MainTab_View_Resize(Const ByRef $this)
	Local Const $tabItems[] = [$this.CanvasHwnd, $this.ParametersHwnd, $this.FormParametersHwnd, $this.ScriptHwnd, $this.ObjectExplorerHwnd, $this.SettingsHwnd]

	Local Const $tabItemCount = UBound($tabItems) - 1

	Local $hwnd

	For $i = 0 To $tabItemCount
		$hwnd = HWnd($tabItems[$i])

		WinMove($hwnd, _
				WinGetTitle($hwnd), _
				(90 * $DPIRatio), _
				(30 * $DPIRatio), _
				(($this.ParentWidth - 95) * $DPIRatio), _
				(($this.ParentHeight - 55) * $DPIRatio))
	Next
EndFunc   ;==>MainTab_View_Resize

Func MainTab_View_ShowCanvas(Const ByRef $this)
	$this.Hide(Hwnd($this.ParametersHwnd)     )
	$this.Hide(Hwnd($this.FormParametersHwnd) )
	$this.Hide(Hwnd($this.ScriptHwnd)         )
	$this.Hide(Hwnd($this.ObjectExplorerHwnd) )
	$this.Hide(Hwnd($this.SettingsHwnd)       )
	$this.Show(HWnd($this.CanvasHwnd)         )
EndFunc   ;==>MainTab_View_ShowCanvas

Func MainTab_View_ShowParameters(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)	
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Hide($this.SettingsHwnd)
	
	If $this.ActiveParametersHwnd Then
		$this.Show($this.FormParametersHwnd)
		$this.Hide($this.ParametersHwnd)
	Else
		$this.Hide($this.FormParametersHwnd)
		$this.Show($this.ParametersHwnd)
	EndIf
EndFunc   ;==>MainTab_View_ShowParameters

Func MainTab_View_ShowScript(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.FormParametersHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.ScriptHwnd)
EndFunc   ;==>MainTab_View_ShowScript

Func MainTab_View_ShowObjectExplorer(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.FormParametersHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.SettingsHwnd)
	$this.Show($this.ObjectExplorerHwnd)
EndFunc   ;==>MainTab_View_ShowObjectExplorer

Func MainTab_View_ShowSettings(Const ByRef $this)
	$this.Hide($this.CanvasHwnd)
	$this.Hide($this.ParametersHwnd)
	$this.Hide($this.FormParametersHwnd)
	$this.Hide($this.ScriptHwnd)
	$this.Hide($this.ObjectExplorerHwnd)
	$this.Show($this.SettingsHwnd)
EndFunc   ;==>MainTab_View_ShowSettings

Func MainTab_View_Show(Const ByRef $this, Const ByRef $hwnd)
	#forceref $this

	GUISetState(@SW_SHOW, HWnd($hwnd))
EndFunc   ;==>MainTab_View_Show

Func MainTab_View_Hide(Const ByRef $this, Const ByRef $hwnd)
	#forceref $this

	GUISetState(@SW_HIDE, HWnd($hwnd))
EndFunc   ;==>MainTab_View_Hide

#EndRegion - Main Tab View
