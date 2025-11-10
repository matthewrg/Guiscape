
#include-once

#Region ; ButtonProperties

Func ButtonProperties(Const $parent)
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Create", "ButtonProperties_Create")
	_AutoItObject_AddMethod($this, "ExStylesInit", "ButtonProperties_ExStylesInit")
	_AutoItObject_AddMethod($this, "Show", "ButtonProperties_Show")
	_AutoItObject_AddMethod($this, "Hide", "ButtonProperties_Hide")

	_AutoItObject_AddProperty($this, "Properties", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Styles", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "ExStyles", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "ContextMenu", $ELSCOPE_READONLY)

	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Text", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Width", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Height", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BgColor", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "TextColor", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Cursor", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Font", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Image", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Tooltip", $ELSCOPE_READONLY)

	_AutoItObject_AddProperty($this, "WS_TABSTOP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_BOTTOM", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_CENTER", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_DEFPUSHBUTTON", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_MULTILINE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_TOP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_VCENTER", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_ICON", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_BITMAP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_FLAT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_NOTIFY", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_RADIOBUTTON", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "BS_OWNERDRAW", $ELSCOPE_READONLY)

	_AutoItObject_AddProperty($this, "WS_EX_ACCEPTFILES", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_APPWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CLIENTEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_COMPOSITED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CONTEXTHELP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_CONTROLPARENT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_DLGMODALFRAME", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LAYERED", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LAYOUTRTL", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LEFT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LEFTSCROLLBAR", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_LTRREADING", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_MDICHILD", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOACTIVATE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOINHERITLAYOUT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOPARENTNOTIFY", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_NOREDIRECTIONBITMAP", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_PALETTEWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RIGHT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RIGHTSCROLLBAR", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_RTLREADING", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_STATICEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TOOLWINDOW", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TOPMOST", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_TRANSPARENT", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "WS_EX_WINDOWEDGE", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "GUI_WS_EX_PARENTDRAG", $ELSCOPE_READONLY)

	_AutoItObject_AddProperty($this, "Hwnd", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Parent", $ELSCOPE_PRIVATE, $parent)

	Return $this
EndFunc   ;==>ButtonProperties

Func ButtonProperties_Create(ByRef $this)
	Local Const $left = 90
	Local Const $top = 30
	Local Const $width = ($this.Parent.Width - 100)
	Local Const $height = ($this.Parent.Height - 60)

	$this.Hwnd = GUICreate( _
			'', _
			$width * $DPIRatio, _
			$height * $DPIRatio, _
			$left * $DPIRatio, _
			$top * $DPIRatio, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.Parent.Hwnd))

	GUICtrlCreateTab(5 * $DPIRatio, 5 * $DPIRatio, ($width - 110) * $DPIRatio, ($height - 70) * $DPIRatio)

	#Region - Properties

	$this.Properties = GUICtrlCreateTabItem("Properties")

	CreateGroup("Name", 10, 30, 300, 45)

	$this.Name = CreateInput('', 15, 45, 290)

	EndGroup()

	CreateGroup("Text", 10, 85, 300, 45)

	$this.Text = CreateInput('', 15, 100, 290)

	EndGroup()

	CreateGroup("Size and Position", 10, 140, 200, 75)

	CreateLabel("Width", 15, 160)

	$this.Width = CreateInput('', 50, 157, 60)

	CreateLabel("Height", 15, 190)

	$this.Height = CreateInput('', 50, 187, 60)

	CreateLabel("Left", 120, 160)

	$this.Left = CreateInput('', 145, 157, 60)

	CreateLabel("Top", 120, 190)

	$this.Top = CreateInput('', 145, 187, 60)

	EndGroup()

	$this.BgColor = CreateButton("Background Color", 10, 225)

	$this.TextColor = CreateButton("Text Color", 10, 260)

	$this.Cursor = CreateButton("Cursor", 10, 295)

	$this.Font = CreateButton("Font", 10, 330)

	$this.Image = CreateButton("Image", 10, 365)

	CreateGroup("Tooltip", 10, 400, 310, 215)

	$this.Tooltip = CreateEdit(15, 420, 300, 190)

	EndGroup()

	GUICtrlCreateTabItem('')

	#EndRegion - Properties

	#Region - Styles

	$this.Styles = GUICtrlCreateTabItem("Styles")

	$this.WS_TABSTOP = CreateCheckbox("WS_TABSTOP", 10, 30)
	$this.BS_BOTTOM = CreateCheckbox("BS_BOTTOM", 10, 50)
	$this.BS_CENTER = CreateCheckbox("BS_CENTER", 10, 70)
	$this.BS_DEFPUSHBUTTON = CreateCheckbox("BS_DEFPUSHBUTTON", 10, 90)
	$this.BS_MULTILINE = CreateCheckbox("BS_MULTILINE", 10, 110)
	$this.BS_TOP = CreateCheckbox("BS_TOP", 10, 130)
	$this.BS_VCENTER = CreateCheckbox("BS_VCENTER", 10, 150)
	$this.BS_ICON = CreateCheckbox("BS_ICON", 10, 170)
	$this.BS_BITMAP = CreateCheckbox("BS_BITMAP", 10, 190)
	$this.BS_FLAT = CreateCheckbox("BS_FLAT", 10, 210)
	$this.BS_NOTIFY = CreateCheckbox("BS_NOTIFY", 10, 230)
	$this.BS_RADIOBUTTON = CreateCheckbox("BS_RADIOBUTTON", 10, 250)
	$this.BS_OWNERDRAW = CreateCheckbox("BS_OWNERDRAW", 10, 270)

	GUICtrlCreateTabItem('')

	#EndRegion - Styles

	#Region - Extended Styles

	$this.ExStyles = GUICtrlCreateTabItem("Extended Styles")

	$this.WS_EX_ACCEPTFILES = CreateCheckbox("WS_EX_ACCEPTFILES", 10, 30)
	$this.WS_EX_APPWINDOW = CreateCheckbox("WS_EX_APPWINDOW", 10, 50)
	$this.WS_EX_CLIENTEDGE = CreateCheckbox("WS_EX_CLIENTEDGE", 10, 70)
	$this.WS_EX_COMPOSITED = CreateCheckbox("WS_EX_COMPOSITED", 10, 90)
	$this.WS_EX_CONTEXTHELP = CreateCheckbox("WS_EX_CONTEXTHELP", 10, 110)
	$this.WS_EX_CONTROLPARENT = CreateCheckbox("WS_EX_CONTROLPARENT", 10, 130)
	$this.WS_EX_DLGMODALFRAME = CreateCheckbox("WS_EX_DLGMODALFRAME", 10, 150)
	$this.WS_EX_LAYERED = CreateCheckbox("WS_EX_LAYERED", 10, 170)
	$this.WS_EX_LAYOUTRTL = CreateCheckbox("WS_EX_LAYOUTRTL", 10, 190)
	$this.WS_EX_LEFT = CreateCheckbox("WS_EX_LEFT", 10, 210)
	$this.WS_EX_LEFTSCROLLBAR = CreateCheckbox("WS_EX_LEFTSCROLLBAR", 10, 230)
	$this.WS_EX_LTRREADING = CreateCheckbox("WS_EX_LTRREADING", 10, 250)
	$this.WS_EX_MDICHILD = CreateCheckbox("WS_EX_MDICHILD", 10, 270)
	$this.WS_EX_NOACTIVATE = CreateCheckbox("WS_EX_NOACTIVATE", 10, 290)
	$this.WS_EX_NOINHERITLAYOUT = CreateCheckbox("WS_EX_NOINHERITLAYOUT", 10, 310)
	$this.WS_EX_NOPARENTNOTIFY = CreateCheckbox("WS_EX_NOPARENTNOTIFY", 10, 330)
	$this.WS_EX_NOREDIRECTIONBITMAP = CreateCheckbox("WS_EX_NOREDIRECTIONBITMAP", 10, 350)
	$this.WS_EX_OVERLAPPEDWINDOW = CreateCheckbox("WS_EX_OVERLAPPEDWINDOW", 10, 370)
	$this.WS_EX_PALETTEWINDOW = CreateCheckbox("WS_EX_PALETTEWINDOW", 10, 390)
	$this.WS_EX_EX_RIGHT = CreateCheckbox("WS_EX_RIGHT", 10, 410)
	$this.WS_EX_RIGHTSCROLLBAR = CreateCheckbox("WS_EX_RIGHTSCROLLBAR", 10, 430)
	$this.WS_EX_RTLREADING = CreateCheckbox("WS_EX_RTLREADING", 10, 450)
	$this.WS_EX_STATICEDGE = CreateCheckbox("WS_EX_STATICEDGE", 10, 470)
	$this.WS_EX_TOOLWINDOW = CreateCheckbox("WS_EX_TOOLWINDOW", 10, 490)
	$this.WS_EX_TOPMOST = CreateCheckbox("WS_EX_TOPMOST", 10, 510)
	$this.WS_EX_TRANSPARENT = CreateCheckbox("WS_EX_TRANSPARENT", 10, 530)
	$this.WS_EX_WINDOWEDGE = CreateCheckbox("WS_EX_WINDOWEDGE", 10, 550)
	$this.GUI_WS_EX_PARENTDRAG = CreateCheckbox("GUI_WS_EX_PARENTDRAG", 10, 570)

	GUICtrlCreateTabItem('')

	#EndRegion - Extended Styles

	#Region - Context Menu

	$this.ContextMenu = GUICtrlCreateTabItem("Context Menu")

	Local $test = GUICtrlCreateTreeView(20 * $DPIRatio, 40 * $DPIRatio, ($width - 205) * $DPIRatio, ($height - 125) * $DPIRatio)

	GUICtrlCreateTreeViewItem("Menu Item 1", $test)
	Local $test2 = GUICtrlCreateTreeViewItem("Menu Item 2", $test)
	GUICtrlCreateTreeViewItem("Menu Item 2A", $test2)
	GUICtrlCreateTreeViewItem("Menu Item 3", $test)
	GUICtrlCreateTreeViewItem('', $test)
	GUICtrlCreateTreeViewItem("Menu Item 4", $test)

	GUICtrlCreateTabItem('')

	#EndRegion - Context Menu
EndFunc   ;==>ButtonProperties_Create

Func ButtonProperties_ExStylesInit(Const ByRef $this, Const ByRef $exStyles)
	Local Const $allStyles[] = [ _
			$WS_EX_ACCEPTFILES, _
			$WS_EX_APPWINDOW, _
			$WS_EX_CLIENTEDGE, _
			$WS_EX_COMPOSITED, _
			$WS_EX_CONTEXTHELP, _
			$WS_EX_CONTROLPARENT, _
			$WS_EX_DLGMODALFRAME, _
			$WS_EX_LAYERED, _
			$WS_EX_LAYOUTRTL, _
			$WS_EX_LEFT, _
			$WS_EX_LEFTSCROLLBAR, _
			$WS_EX_LTRREADING, _
			$WS_EX_MDICHILD, _
			$WS_EX_NOACTIVATE, _
			$WS_EX_NOINHERITLAYOUT, _
			$WS_EX_NOPARENTNOTIFY, _
			$WS_EX_NOREDIRECTIONBITMAP, _
			$WS_EX_OVERLAPPEDWINDOW, _
			$WS_EX_PALETTEWINDOW, _
			$WS_EX_RIGHT, _
			$WS_EX_RIGHTSCROLLBAR, _
			$WS_EX_RTLREADING, _
			$WS_EX_STATICEDGE, _
			$WS_EX_TOOLWINDOW, _
			$WS_EX_TOPMOST, _
			$WS_EX_TRANSPARENT, _
			$WS_EX_WINDOWEDGE, _
			$GUI_WS_EX_PARENTDRAG]

	Local Const $vars[] = [ _
			$this.WS_EX_ACCEPTFILES, _
			$this.WS_EX_APPWINDOW, _
			$this.WS_EX_CLIENTEDGE, _
			$this.WS_EX_COMPOSITED, _
			$this.WS_EX_CONTEXTHELP, _
			$this.WS_EX_CONTROLPARENT, _
			$this.WS_EX_DLGMODALFRAME, _
			$this.WS_EX_LAYERED, _
			$this.WS_EX_LAYOUTRTL, _
			$this.WS_EX_LEFT, _
			$this.WS_EX_LEFTSCROLLBAR, _
			$this.WS_EX_LTRREADING, _
			$this.WS_EX_MDICHILD, _
			$this.WS_EX_NOACTIVATE, _
			$this.WS_EX_NOINHERITLAYOUT, _
			$this.WS_EX_NOPARENTNOTIFY, _
			$this.WS_EX_NOREDIRECTIONBITMAP, _
			$this.WS_EX_OVERLAPPEDWINDOW, _
			$this.WS_EX_PALETTEWINDOW, _
			$this.WS_EX_RIGHT, _
			$this.WS_EX_RIGHTSCROLLBAR, _
			$this.WS_EX_RTLREADING, _
			$this.WS_EX_STATICEDGE, _
			$this.WS_EX_TOOLWINDOW, _
			$this.WS_EX_TOPMOST, _
			$this.WS_EX_TRANSPARENT, _
			$this.WS_EX_WINDOWEDGE, _
			$this.GUI_WS_EX_PARENTDRAG]

	Local Const $upBound = UBound($allStyles)
	
	For $i = 0 To $upBound - 1
		If BitAND($exStyles, $allStyles[$i]) = $allStyles[$i] Then
			GUICtrlSetState($vars[$i], $GUI_CHECKED)
		Else
			GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
		EndIf
	Next
EndFunc   ;==>ButtonProperties_ExStylesInit

Func ButtonProperties_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ButtonProperties_Show

Func ButtonProperties_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ButtonProperties_Hide
