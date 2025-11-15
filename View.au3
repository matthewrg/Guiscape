
#include-once

#Region - Guiscape View

Func GuiscapeView()
	Local Const $width = 815
	Local Const $height = 860

	Local $this = _AutoitObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "GuiscapeView_Handler")
	$this.AddMethod("Create", "GuiscapeView_Create")
	$this.AddMethod("Show", "GuiscapeView_Show")
	$this.AddMethod("SetFont", "GuiscapeView_SetFont")
	$this.AddMethod("SetFontSize", "GuiscapeView_SetFontSize")
	$this.AddMethod("SetSizePos", "GuiscapeView_SetSizePos")
	$this.AddMethod("CreateImbeddedWindow", "GuiscapeView_CreateImbeddedWindow")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY, $width)
	$this.AddProperty("Height", $ELSCOPE_READONLY, $height)
	$this.AddProperty("Left", $ELSCOPE_READONLY, (@DesktopWidth / 2) - ($width / 2))
	$this.AddProperty("Top", $ELSCOPE_READONLY, (@DesktopHeight / 2) - ($height / 2))
	$this.AddProperty("FontName", $ELSCOPE_READONLY, "Segoe UI")
	$this.AddProperty("FontSize", $ELSCOPE_READONLY, 10 * $DPIRatio)
	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("TabLeft", $ELSCOPE_READONLY, 92 * $DPIRatio)
	$this.AddProperty("TabTop", $ELSCOPE_READONLY, 5 * $DPIRatio)
	$this.AddProperty("CanvasTab", $ELSCOPE_READONLY)
	$this.AddProperty("ParametersTab", $ELSCOPE_READONLY)
	$this.AddProperty("ScriptTab", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorerTab", $ELSCOPE_READONLY)
	$this.AddProperty("SettingsTab", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>GuiscapeView

Func GuiscapeView_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Switch _GUICtrlTab_HitTest($this.Tab, (MouseGetPos(0) - $this.TabLeft) , (MouseGetPos(1) - $this.TabTop))[0]
				Case $this.CanvasTab
					Return "Canvas Tab"
					
				Case $this.ParametersTab
					Return "Parameters Tab"
					
				Case $this.ScriptTab
					Return "Script Tab"
					
				Case $this.ObjectExplorerTab
					Return "Object Explorer Tab"
					
				Case $this.SettingsTab
					Return "Settings Tab"
			EndSwitch
	EndSwitch
	
	Return False
EndFunc   ;==>GuiscapeView_Handler

Func GuiscapeView_Create(ByRef $this, Const $title)	
	Local Const $hwnd = GUICreate( _
			$title, _
			$this.Width * $DPIRatio, _
			$this.Height * $DPIRatio, _
			$this.Left * $DPIRatio, _
			$this.Top * $DPIRatio, _
			BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_SYSMENU))
			
	$this.Hwnd = $hwnd
	
	$this.Tab = GUICtrlCreateTab($this.TabLeft * $DPIRatio, $this.TabTop * $DPIRatio, 390 * $DPIRatio, 20 * $DPIRatio)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.CanvasTab = _GUICtrlTab_InsertItem($this.Tab, 0, "Canvas")

	$this.ParametersTab = _GUICtrlTab_InsertItem($this.Tab, 1, "Parameters")

	$this.ScriptTab = _GUICtrlTab_InsertItem($this.Tab, 2, "Script")

	$this.ObjectExplorerTab = _GUICtrlTab_InsertItem($this.Tab, 3, "Object Explorer")

	$this.SettingsTab = _GUICtrlTab_InsertItem($this.Tab, 4, "Settings")
EndFunc   ;==>GuiscapeView_Create

Func GuiscapeView_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Func GuiscapeView_Show

Func GuiscapeView_SetFont(ByRef $this, Const ByRef $fontName)
	$this.FontName = $fontName

	GUISetFont($this.FontSize * $DPIRatio, -1, -1, $fontName, HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_SetFont

Func GuiscapeView_SetFontSize(ByRef $this, Const ByRef $fontSize)
	$this.FontSize = $fontSize

	GUISetFont($fontSize * $DPIRatio, -1, -1, $this.FontName, HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_SetFontSize

Func GuiscapeView_SetSizePos(ByRef $this)
	Local Const $sizePos = WinGetPos(HWnd($this.Hwnd))

	$this.Left = $sizePos[0] * $DPIRatio
	$this.Top = $sizePos[1] * $DPIRatio
	$this.Width = ($sizePos[2] - 16) * $DPIRatio
	$this.Height = ($sizePos[3] - 39) * $DPIRatio
EndFunc   ;==>GuiscapeView_SetSizePos

Func GuiscapeView_CreateImbeddedWindow(Const ByRef $this, Const ByRef $title)
	Local Const $hwnd = GUICreate( _
			$title, _
			($this.Width - 100) * $DPIRatio, _
			($this.Height - 60) * $DPIRatio, _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.Hwnd))

	GUISetBkColor($COLOR_WHITE, $hwnd)
	
	GUISetState(@SW_HIDE, $hwnd)

	Return $hwnd
EndFunc   ;==>GuiscapeView_CreateImbeddedWindow

Func Canvas_ActivateTab(Const ByRef $this)
	_GUICtrlTab_ActivateTab($this.Parent.Tab, $this.Tab)
EndFunc   ;==>Canvas_ActivateTab

Func Parameters_ActivateTab(Const ByRef $this)
	_GUICtrlTab_ActivateTab($this.Parent.Tab, $this.Tab)
EndFunc   ;==>Parameters_ActivateTab

Func Script_ActivateTab(Const ByRef $this)
	_GUICtrlTab_ActivateTab($this.Parent.Tab, $this.Tab)
EndFunc   ;==>Script_ActivateTab

Func Settings_ActivateTab(Const ByRef $this)
	_GUICtrlTab_ActivateTab($this.Parent.Tab, $this.Tab)
EndFunc   ;==>Settings_ActivateTab

#EndRegion - Guiscape View
