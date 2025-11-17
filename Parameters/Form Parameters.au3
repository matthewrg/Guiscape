
#include-once

#Region ; FormParameters

Func FormParameters()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "FormParameters_Handler")
	$this.AddMethod("Create", "FormParameters_Create")
	$this.AddMethod("Init", "FormParameters_Init")
	$this.AddMethod("PropertiesInit", "FormParameters_PropertiesInit")
	$this.AddMethod("StylesInit", "FormParameters_StylesInit")
	$this.AddMethod("ExStylesInit", "FormParameters_ExStylesInit")
	$this.AddMethod("Show", "FormParameters_Show")
	$this.AddMethod("Hide", "FormParameters_Hide")

	#Region - Properties
	$this.AddProperty("Name", $ELSCOPE_READONLY)
	$this.AddProperty("Title", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY)
	$this.AddProperty("Height", $ELSCOPE_READONLY)
	$this.AddProperty("Left", $ELSCOPE_READONLY)
	$this.AddProperty("Top", $ELSCOPE_READONLY)
	$this.AddProperty("BgColor", $ELSCOPE_READONLY)
	$this.AddProperty("DefBgColor", $ELSCOPE_READONLY)
	$this.AddProperty("DefFgColor", $ELSCOPE_READONLY)
	$this.AddProperty("Cursor", $ELSCOPE_READONLY)
	$this.AddProperty("Font", $ELSCOPE_READONLY)
	$this.AddProperty("Helpfile", $ELSCOPE_READONLY)
	$this.AddProperty("Icon", $ELSCOPE_READONLY)
	#EndRegion - Properties

	#Region - Styles
	$this.AddProperty("SS_DEFAULT_GUI", $ELSCOPE_READONLY)
	$this.AddProperty("WS_BORDER", $ELSCOPE_READONLY)
	$this.AddProperty("WS_POPUP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CAPTION", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CLIPCHILDREN", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CLIPSIBLINGS", $ELSCOPE_READONLY)
	$this.AddProperty("WS_DISABLED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_DLGFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_HSCROLL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_MAXIMIZE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_MAXIMIZEBOX", $ELSCOPE_READONLY)
	$this.AddProperty("WS_OVERLAPPED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_POPUPWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_SIZEBOX", $ELSCOPE_READONLY)
	$this.AddProperty("WS_SYSMENU", $ELSCOPE_READONLY)
	$this.AddProperty("WS_THICKFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_VSCROLL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_VISIBLE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_CHILD", $ELSCOPE_READONLY)
	$this.AddProperty("WS_GROUP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_TABSTOP", $ELSCOPE_READONLY)
	$this.AddProperty("DS_MODALFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("DS_SETFOREGROUND", $ELSCOPE_READONLY)
	$this.AddProperty("DS_CONTEXTHELP", $ELSCOPE_READONLY)
	#EndRegion - Styles

	#Region - Extended Styles
	$this.AddProperty("WS_EX_ACCEPTFILES", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_APPWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CLIENTEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_COMPOSITED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTEXTHELP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTROLPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_DLGMODALFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYERED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYOUTRTL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LTRREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_MDICHILD", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOACTIVATE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOINHERITLAYOUT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOPARENTNOTIFY", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOREDIRECTIONBITMAP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_PALETTEWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RTLREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_STATICEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOOLWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOPMOST", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TRANSPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_WINDOWEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("GUI_WS_EX_PARENTDRAG", $ELSCOPE_READONLY)
	#EndRegion - Extended Styles

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>FormParameters

Func FormParameters_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.Name
			$event.Form.SetName(GUICtrlRead($event.ID))

			Return True

		Case $this.Title
			$event.Form.SetTitle(GUICtrlRead($event.ID))

			Return True

		Case $this.Left
			$event.Form.SetLeft(GUICtrlRead($event.ID))

			Return True

		Case $this.Top
			$event.Form.SetTop(GUICtrlRead($event.ID))

			Return True

		Case $this.Width
			$event.Form.SetWidth(GUICtrlRead($event.ID))

			Return True

		Case $this.Height
			$event.Form.SetHeight(GUICtrlRead($event.ID))

			Return True

		Case $this.BGColor
			Local Const $bgColor = _ChooseColor(2, $event.Form.GetBgColor(), 2, HWnd($this.View.Hwnd))

			$event.Form.SetBGColor($bgColor)

			Return True

		Case $this.DefBgColor
			Local Const $DefBgColor = _ChooseColor(2, $event.Form.GetDefBgColor(), 2, HWnd($this.View.Hwnd))

			$event.Form.SetDefBgColor($DefBgColor)

			Return True

		Case $this.DefFgColor
			Local Const $DefFgColor = _ChooseColor(2, $event.Form.GetDefFgColor(), 2, HWnd($this.View.Hwnd))

			$event.Form.SetDefFGColor($DefFgColor)

			Return True

		Case $this.Cursor
			$event.Form.SetCursor(Eval("MCID_" & GUICtrlRead($event.ID)))

			Return True

		Case $this.Font
			Local Const $font = _ChooseFont(Default, Default, Default, Default, Default, Default, Default, HWnd($this.View.Hwnd))

			$event.Form.SetFont($font)

			Return True

		Case $this.Helpfile
			Local Const $helpfile = FileOpenDialog("Choose a helpfile.", @ScriptDir, "Help (*.chm)", 0, HWnd($this.View.Hwnd))

			$event.Form.SetHelpfile($helpfile)

			Return True

		Case $this.Icon
			Local Const $icon = FileOpenDialog("Choose an icon.", @ScriptDir, "Icon (*.ico)", 0, HWnd($this.View.Hwnd))

			$event.Form.SetIcon($icon)

			Return True
	EndSwitch

	Return False
EndFunc   ;==>FormParameters_Handler

Func FormParameters_Create(ByRef $this, Const $parent)
	$this.Hwnd = $parent.CreateImbeddedWindow("Form Properties")

	GUICtrlCreateTab(5 * $DPIRatio, 5 * $DPIRatio, ($parent.Width - 110) * $DPIRatio, ($parent.Height - 70) * $DPIRatio)

	#Region - Properties
	GUICtrlCreateTabItem("Properties")

	CreateGroup("Name", 15, 30, 300, 45)

	$this.Name = CreateInput('', 20, 45, 290)

	EndGroup()

	CreateGroup("Title", 15, 80, 360, 45)

	$this.Title = CreateInput('', 20, 95, 350)

	EndGroup()

	CreateGroup("Size and Position", 15, 130, 200, 75)

	CreateLabel("Width", 20, 150)

	$this.Width = CreateInput('', 55, 147, 60)

	CreateLabel("Height", 20, 180)

	$this.Height = CreateInput('', 55, 177, 60)

	CreateLabel("Left", 125, 150)

	$this.Left = CreateInput('', 150, 147, 60)

	CreateLabel("Top", 125, 180)

	$this.Top = CreateInput('', 150, 177, 60)

	EndGroup()

	$this.BgColor = CreateButton("Background Color", 15, 215)

	CreateGroup("Control Colors", 10, 250, 80, 80)

	$this.DefBgColor = CreateButton("Background", 15, 270)

	$this.DefFgColor = CreateButton("Foreground", 15, 300)

	EndGroup()

	$this.Cursor = GUICtrlCreateCombo("Cursor", 15, 335, 150)

	GUICtrlSetData($this.Cursor, _
			"HAND|APPSTARTING|ARROW|CROSS|HELP|IBEAM|" & _
			"ICON|NO|SIZE|SIZEALL|SIZENESW|SIZENS|" & _
			"SIZENWSE|SIZEWE|UPARROW|WAIT|NONE")

	$this.Font = CreateButton("Font", 15, 365)

	$this.Helpfile = CreateButton("Helpfile", 15, 395)

	$this.Icon = CreateButton("Icon", 15, 425)

	GUICtrlCreateTabItem('')
	#EndRegion - Properties

	#Region - Styles
	GUICtrlCreateTabItem("Styles")

	$this.SS_DEFAULT_GUI = CreateCheckbox("SS_DEFAULT_GUI", 10, 30)
	$this.WS_BORDER = CreateCheckbox("WS_BORDER", 10, 50)
	$this.WS_POPUP = CreateCheckbox("WS_POPUP", 10, 70)
	$this.WS_CAPTION = CreateCheckbox("WS_CAPTION", 10, 90)
	$this.WS_CLIPCHILDREN = CreateCheckbox("WS_CLIPCHILDREN", 10, 110)
	$this.WS_CLIPSIBLINGS = CreateCheckbox("WS_CLIPSIBLINGS", 10, 130)
	$this.WS_DISABLED = CreateCheckbox("WS_DISABLED", 10, 150)
	$this.WS_DLGFRAME = CreateCheckbox("WS_DLGFRAME", 10, 170)
	$this.WS_HSCROLL = CreateCheckbox("WS_HSCROLL", 10, 190)
	$this.WS_MAXIMIZE = CreateCheckbox("WS_MAXIMIZE", 10, 210)
	$this.WS_MAXIMIZEBOX = CreateCheckbox("WS_MAXIMIZEBOX", 10, 230)
	$this.WS_OVERLAPPED = CreateCheckbox("WS_OVERLAPPED", 10, 250)
	$this.WS_OVERLAPPEDWINDOW = CreateCheckbox("WS_OVERLAPPEDWINDOW", 10, 270)
	$this.WS_POPUPWINDOW = CreateCheckbox("WS_POPUPWINDOW", 10, 290)
	$this.WS_SIZEBOX = CreateCheckbox("WS_SIZEBOX", 10, 310)
	$this.WS_SYSMENU = CreateCheckbox("WS_SYSMENU", 10, 330)
	$this.WS_THICKFRAME = CreateCheckbox("WS_THICKFRAME", 10, 350)
	$this.WS_VSCROLL = CreateCheckbox("WS_VSCROLL", 10, 370)
	$this.WS_VISIBLE = CreateCheckbox("WS_VISIBLE", 10, 390)
	$this.WS_CHILD = CreateCheckbox("WS_CHILD", 10, 410)
	$this.WS_GROUP = CreateCheckbox("WS_GROUP", 10, 430)
	$this.WS_TABSTOP = CreateCheckbox("WS_TABSTOP", 10, 450)
	$this.DS_MODALFRAME = CreateCheckbox("DS_MODALFRAME", 10, 470)
	$this.DS_SETFOREGROUND = CreateCheckbox("DS_SETFOREGROUND", 10, 490)
	$this.DS_CONTEXTHELP = CreateCheckbox("DS_CONTEXTHELP", 10, 510)

	GUICtrlSetState($this.SS_DEFAULT_GUI, $GUI_CHECKED + $GUI_DISABLE)

	GUICtrlCreateTabItem('')
	#EndRegion - Styles

	#Region - Extended Styles
	GUICtrlCreateTabItem("Extended Styles")

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
	$this.WS_EX_RIGHT = CreateCheckbox("WS_EX_RIGHT", 10, 410)
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

	#Region - Menubar
	GUICtrlCreateTabItem("Menubar")

	Local $test1 = GUICtrlCreateTreeView(20 * $DPIRatio, 40 * $DPIRatio, ($parent.Width - 205) * $DPIRatio, ($parent.Height - 125) * $DPIRatio)

	GUICtrlCreateTreeViewItem("Menu Item 1", $test1)
	Local $test1a = GUICtrlCreateTreeViewItem("Menu Item 2", $test1)
	GUICtrlCreateTreeViewItem("Menu Item 2A", $test1a)
	GUICtrlCreateTreeViewItem("Menu Item 3", $test1)
	GUICtrlCreateTreeViewItem('', $test1)
	GUICtrlCreateTreeViewItem("Menu Item 4", $test1)

	GUICtrlCreateTabItem('')
	#EndRegion - Menubar

	#Region - Context Menu
	GUICtrlCreateTabItem("Context Menu")

	Local $test2 = GUICtrlCreateTreeView(20 * $DPIRatio, 40 * $DPIRatio, ($parent.Width - 205) * $DPIRatio, ($parent.Height - 125) * $DPIRatio)

	GUICtrlCreateTreeViewItem("Menu Item 1", $test2)
	Local $test2a = GUICtrlCreateTreeViewItem("Menu Item 2", $test2)
	GUICtrlCreateTreeViewItem("Menu Item 2A", $test2a)
	GUICtrlCreateTreeViewItem("Menu Item 3", $test2)
	GUICtrlCreateTreeViewItem('', $test2)
	GUICtrlCreateTreeViewItem("Menu Item 4", $test2)

	GUICtrlCreateTabItem('')
	#EndRegion - Context Menu
	
	#region - Accelerators
	GUICtrlCreateTabItem("Accelerators")
	
	GUICtrlCreateInput('Hotkey', 320, 50, 200, 25)
	
	GUICtrlCreateCombo('', 320, 80)
	
	GUICtrlSetData(-1, "Button1|Button2|Checkbox1")
;~ 	
;~ 	GUICtrlCreateButton("Add", 300, 110)
	
	Local $test3 = GUICtrlCreateListView("Hotkey                     |Function                   ", 15, 45, 260, 680)
	
	GUICtrlCreateListViewItem("MyHotkey1|MyFunction1", $test3)
	
	GUICtrlCreateTabItem('')	
	#endregion - Accelerators	
EndFunc   ;==>FormParameters_Create

Func FormParameters_Init(ByRef $this, Const ByRef $form)
	$this.PropertiesInit($form)
	$this.StylesInit($form)
	$this.ExStylesInit($form)
EndFunc   ;==>FormParameters_Init

Func FormParameters_PropertiesInit(ByRef $this, $form)	
	Local Const $properties = $form.GetProperties()
	
	GUICtrlSetData($this.Name, $properties.Name)
	GUICtrlSetData($this.Title, $properties.Title)
	GUICtrlSetData($this.Left, $properties.Left)
	GUICtrlSetData($this.Top, $properties.Top)
	GUICtrlSetData($this.Width, $properties.Width)
	GUICtrlSetData($this.Height, $properties.Height)
EndFunc   ;==>FormParameters_PropertiesInit

Func FormParameters_StylesInit(ByRef $this, Const ByRef $form)
	Local Const $allStyles[] = [ _
			$WS_BORDER, _
			$WS_POPUP, _
			$WS_CAPTION, _
			$WS_CLIPCHILDREN, _
			$WS_CLIPSIBLINGS, _
			$WS_DISABLED, _
			$WS_DLGFRAME, _
			$WS_HSCROLL, _
			$WS_MAXIMIZE, _
			$WS_MAXIMIZEBOX, _
			$WS_OVERLAPPED, _
			$WS_OVERLAPPEDWINDOW, _
			$WS_POPUPWINDOW, _
			$WS_SIZEBOX, _
			$WS_SYSMENU, _
			$WS_THICKFRAME, _
			$WS_VSCROLL, _
			$WS_VISIBLE, _
			$WS_CHILD, _
			$WS_GROUP, _
			$WS_TABSTOP, _
			$DS_MODALFRAME, _
			$DS_SETFOREGROUND, _
			$DS_CONTEXTHELP]

	Local Const $vars[] = [ _
			$this.WS_BORDER, _
			$this.WS_POPUP, _
			$this.WS_CAPTION, _
			$this.WS_CLIPCHILDREN, _
			$this.WS_CLIPSIBLINGS, _
			$this.WS_DISABLED, _
			$this.WS_DLGFRAME, _
			$this.WS_HSCROLL, _
			$this.WS_MAXIMIZE, _
			$this.WS_MAXIMIZEBOX, _
			$this.WS_OVERLAPPED, _
			$this.WS_OVERLAPPEDWINDOW, _
			$this.WS_POPUPWINDOW, _
			$this.WS_SIZEBOX, _
			$this.WS_SYSMENU, _
			$this.WS_THICKFRAME, _
			$this.WS_VSCROLL, _
			$this.WS_VISIBLE, _
			$this.WS_CHILD, _
			$this.WS_GROUP, _
			$this.WS_TABSTOP, _
			$this.DS_MODALFRAME, _
			$this.DS_SETFOREGROUND, _
			$this.DS_CONTEXTHELP]

	Local Const $upBound = UBound($allStyles)

	Local Const $styles = $form.GetStyles()

	; This loop just makes the windows that Guiscape creates look like a regular window when
	; looking at the Styles tab under the Properties tab. Not sure yet if this will cause
	; problems down the road!
	For $i = 0 To $upBound - 1
		If BitAND($styles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_MAXIMIZEBOX, $WS_OVERLAPPEDWINDOW, $WS_SIZEBOX, $WS_THICKFRAME, $WS_CHILD, $WS_TABSTOP
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch

		Else
			Switch $allStyles[$i]
				Case $WS_POPUP, $WS_OVERLAPPED
					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormParameters_StylesInit

Func FormParameters_ExStylesInit(ByRef $this, Const ByRef $form)
	Local Const $allStyles[] = [$WS_EX_ACCEPTFILES, _
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

	Local Const $vars[] = [$this.WS_EX_ACCEPTFILES, _
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

	Local Const $exStyles = $form.GetExStyles()

	; This loop just makes the windows that Guiscape creates look like a regular window when
	; looking at the Styles tab under the Properties tab. Not sure yet if this will cause
	; problems down the road!
	For $i = 0 To $upBound - 1
		If BitAND($exStyles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_EX_OVERLAPPEDWINDOW, $WS_EX_PALETTEWINDOW
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch
		Else
			Switch $allStyles[$i]
				Case $WS_EX_LEFT, $WS_EX_LTRREADING, $WS_EX_RIGHTSCROLLBAR
					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormParameters_ExStylesInit

Func FormParameters_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>FormParameters_Show

Func FormParameters_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>FormParameters_Hide

#EndRegion - Accelerators

#endregion - Form Parameters
