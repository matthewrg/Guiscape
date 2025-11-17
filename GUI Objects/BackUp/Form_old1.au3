#include-once

#include "Control.au3"

#Region ; Form

Func Form(Const $parent, Const $title, Const $left = 5, Const $top = 5, Const $width = 400, Const $height = 600)
	Local Const $hwnd = GUICreate( _
			$title, _
			$width * $DPIRatio, _
			$height * $DPIRatio, _
			$left * $DPIRatio, _
			$top * $DPIRatio, _
			BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), _
			 -1, _
			HWnd($parent))
			
	_WinAPI_SetWindowSubclass($hwnd, $pWndProc, 1000)

	Local Const $formStyles = GUIGetStyle($hwnd)
	
	#region - Form Object
	Local $this = _AutoItObject_Class()

	$this.Create()
	
	#region - Public
	$this.AddMethod("Handler", "Form_Handler")
	$this.AddMethod("Show", "Form_Show")
	$this.AddMethod("Hide", "Form_Hide")
	$this.AddMethod("Delete", "Form_Delete")

	$this.AddMethod("GetHwnd", "Form_GetHwnd")
	$this.AddMethod("GetProperties", "Form_GetProperties")
	$this.AddMethod("GetStyle", "Form_GetStyle")
	$this.AddMethod("GetExStyle", "Form_GetExStyle")
	$this.AddMethod("GetStyles", "Form_GetStyles")
	$this.AddMethod("GetExStyles", "Form_GetExStyles")
	$this.AddMethod("GetTitle", "Form_GetTitle")
	$this.AddMethod("GetLeft", "Form_GetLeft")
	$this.AddMethod("GetTop", "Form_GetTop")
	$this.AddMethod("GetWidth", "Form_GetWidth")
	$this.AddMethod("GetHeight", "Form_GetHeight")
	$this.AddMethod("GetBgColor", "Form_GetBgColor")
	$this.AddMethod("GetDefBgColor", "Form_GetDefBgColor")
	$this.AddMethod("GetDefFgColor", "Form_GetDefFgColor")
	$this.AddMethod("GetCursor", "Form_GetCursor")
	$this.AddMethod("GetFont", "Form_GetFont")
	$this.AddMethod("GetHelpfile", "Form_GetHelpfile")

	$this.AddMethod("SetTitle", "Form_SetTitle")
	$this.AddMethod("SetName", "Form_SetName")
	$this.AddMethod("SetLeft", "Form_SetLeft")
	$this.AddMethod("SetTop", "Form_SetTop")
	$this.AddMethod("SetWidth", "Form_SetWidth")
	$this.AddMethod("SetHeight", "Form_SetHeight")
	$this.AddMethod("SetBgColor", "Form_SetBgColor")
	$this.AddMethod("SetDefBgColor", "Form_SetDefBgColor")
	$this.AddMethod("SetDefFgColor", "Form_SetDefFgColor")
	$this.AddMethod("SetCursor", "Form_SetCursor")
	$this.AddMethod("SetFont", "Form_SetFont")
	$this.AddMethod("SetHelpfile", "Form_SetHelpfile")
	$this.AddMethod("SetIcon", "Form_SetIcon")
	$this.AddMethod("SetState", "Form_SetState")
	$this.AddMethod("SetStyle", "Form_SetStyle")
	$this.AddMethod("SetExStyle", "Form_SetExStyle")
	
	GUICtrlCreateContextMenu()

	$this.AddProperty("ChildForm", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Child Form", -1))
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Parameters", -1))
	$this.AddProperty("Styles", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Styles", -1))
	$this.AddProperty("ExStyles", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Extended Styles", -1))
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Context Menu", -1))
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, GUICtrlCreateMenuItem("Menubar", -1))
	#endregion - Public
	
	#region - Private
	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE, $hwnd)
	$this.AddProperty("Title", $ELSCOPE_PRIVATE, $title)
	$this.AddProperty("Name", $ELSCOPE_PRIVATE, StringStripWS($title, $STR_STRIPALL))
	$this.AddProperty("Left", $ELSCOPE_PRIVATE, $left)
	$this.AddProperty("Top", $ELSCOPE_PRIVATE, $top)
	$this.AddProperty("Width", $ELSCOPE_PRIVATE, $width)
	$this.AddProperty("Height", $ELSCOPE_PRIVATE, $height)
	$this.AddProperty("BgColor", $ELSCOPE_PRIVATE, Hex(_WinAPI_GetBkColor(_WinAPI_GetDC($hwnd))))
	$this.AddProperty("DefBgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("DefFgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("Cursor", $ELSCOPE_PRIVATE, $MCID_ARROW)
	$this.AddProperty("Font", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Helpfile", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Style", $ELSCOPE_PRIVATE, $formStyles[0])
	$this.AddProperty("ExStyle", $ELSCOPE_PRIVATE, $formStyles[1])
	#endregion - Private
	
	$this.AddDestructor("Form_Dtor")
	#endregion - Form Object
	
	GUISetState(@SW_SHOW, $hwnd)

	Return $this.Object
EndFunc   ;==>Form

Func Form_Handler(ByRef $this, Const ByRef $event)
	If $event.Form = $this.Hwnd Then
		Switch $event.ID
			Case $this.ChildForm
				Return "Child Form"

			Case $this.Parameters
				Return "Parameters"

			Case $this.Styles
				Return "Styles"

			Case $this.ExStyles
				Return "Extended Styles"

			Case $this.ContextMenu
				Return "Context Menu"

			Case $this.Menubar
				Return "Menubar"

			Case $GUI_EVENT_PRIMARYUP, $NC_CLICKED				
				Return "Form Selected"

			Case $GUI_EVENT_RESIZED
				Local Const $sizePos = WinGetPos(HWnd($this.Hwnd))

				$this.Width = $sizePos[2]

				$this.Height = $sizePos[3]

				Return "Form Resized"

			Case $GUI_EVENT_CLOSE
				Return "Form Close"
		EndSwitch
	EndIf

	Return False
EndFunc   ;==>Form_Handler

Func Form_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Form_Show

Func Form_Hide(Const ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Form_Hide

Func Form_Delete(Const ByRef $this)
	GUIDelete(($this.Hwnd))
EndFunc   ;==>Form_Delete

Func Form_Dtor(Const ByRef $this)
	$this.Delete()
EndFunc   ;==>Form_Dtor

#Region - Getters

Func Form_GetHwnd(Const ByRef $this)
	Return $this.Hwnd
EndFunc   ;==>Form_GetHwnd

Func Form_GetProperties(Const ByRef $this)
	Local $properties[]

	$properties.Title = $this.Title
	$properties.Name = $this.Name
	$properties.Left = $this.Left
	$properties.Top = $this.Top
	$properties.Width = $this.Width
	$properties.Height = $this.Height
	$properties.BgColor = $this.BgColor
	$properties.DefBgColor = $this.DefBgColor
	$properties.DefFgColor = $this.DefFgColor
	$properties.Cursor = $this.Cursor
	$properties.Font = $this.Font
	$properties.Helpfile = $this.Helpfile

	Return $properties
EndFunc   ;==>Form_GetProperties

Func Form_GetStyles(Const ByRef $this)
	Local $styles[]

	$styles.Style = $this.Style

	Return $styles
EndFunc   ;==>Form_GetStyles

Func Form_GetExStyles(Const ByRef $this)
	Local $exStyles[]

	$exStyles.ExStyle = $this.ExStyle

	Return $exStyles
EndFunc   ;==>Form_GetExStyles

Func Form_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetStyle

Func Form_GetExStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetExStyle

Func Form_GetTitle(Const ByRef $this)
	Return WinGetTitle(HWnd($this.Hwnd))
EndFunc   ;==>Form_GetTitle

Func Form_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetLeft

Func Form_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetTop

Func Form_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[2]
EndFunc   ;==>Form_GetWidth

Func Form_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[3]
EndFunc   ;==>Form_GetHeight

Func Form_GetBgColor(Const ByRef $this)
	Return $this.BGColor
EndFunc   ;==>Form_GetBgColor

Func Form_GetDefBgColor(Const ByRef $this)
	Return $this.DefBgColor
EndFunc   ;==>Form_GetDefBgColor

Func Form_GetDefFgColor(Const ByRef $this)
	Return $this.DefFgColor
EndFunc   ;==>Form_GetDefFgColor

Func Form_GetCursor(Const ByRef $this)
	Return $this.Cursor
EndFunc   ;==>Form_GetCursor

Func Form_GetFont(Const ByRef $this)
	Return $this.Font
EndFunc   ;==>Form_GetFont

Func Form_GetHelpfile(Const ByRef $this)
	Return $this.Helpfile
EndFunc   ;==>Form_GetHelpfile

#EndRegion - Getters

#Region - Setters

Func Form_SetTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Hwnd), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>Form_SetTitle

Func Form_SetName(ByRef $this, Const $name)
	$this.Name = $name

	Return True
EndFunc   ;==>Form_SetName

Func Form_SetLeft(ByRef $this, Const $left)
	$this.Left = $left
EndFunc   ;==>Form_SetLeft

Func Form_SetTop(ByRef $this, Const $top)
	$this.Top = $top
EndFunc   ;==>Form_SetTop

Func Form_SetWidth(ByRef $this, Const $width)
	$this.Width = $width

	Return WinMove(HWnd($this.Hwnd), '', 5 * $DPIRatio, 5 * $DPIRatio, $width * $DPIRatio, $this.Height * $DPIRatio)
EndFunc   ;==>Form_SetWidth

Func Form_SetHeight(ByRef $this, Const ByRef $height)
	$this.Height = $height

	Return WinMove(HWnd($this.Hwnd), '', 5 * $DPIRatio, 5 * $DPIRatio, $this.Width * $DPIRatio, $height * $DPIRatio)
EndFunc   ;==>Form_SetHeight

Func Form_SetBGColor(ByRef $this, Const ByRef $bgColor)
	$this.BGColor = $bgColor

	Return GUISetBkColor($bgColor, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetBGColor

Func Form_SetDefBgColor(ByRef $this, Const ByRef $defBgColor)
	$this.DefBgColor = $defBgColor

	Return GUICtrlSetDefBkColor($defBgColor, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetDefBgColor

Func Form_SetDefFgColor(ByRef $this, Const ByRef $defFgColor)
	$this.DefFgColor = $defFgColor

	Return GUICtrlSetDefColor($defFgColor, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetDefFgColor

Func Form_SetCursor(ByRef $this, Const ByRef $cursorID, Const $override = 0)
	$this.CursorID = $cursorID

	Return GUISetCursor($cursorID, $override, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetCursor

Func Form_SetFont(ByRef $this, Const ByRef $fontname, Const $size = 8.5, $weight = 0, $attribute = 0, $quality = 0)
	$this.Font = $fontname

	Return GUISetFont($size * $DPIRatio, $weight, $attribute, $fontname, HWnd($this.Hwnd), $quality)
EndFunc   ;==>Form_SetFont

Func Form_SetHelpfile(ByRef $this, Const ByRef $helpfile)
	$this.Helpfile = $helpfile

	Return GUISetHelp($helpfile, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetHelpfile

Func Form_SetIcon(ByRef $this, Const ByRef $iconfile, Const $iconID = -1)
	Return GUISetIcon($iconfile, $iconID, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetIcon

Func Form_SetState(ByRef $this, Const ByRef $state)
	$this.State = $state

	Return GUISetState($state, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetState

Func Form_SetStyle(ByRef $this, Const ByRef $style)
	$this.Style = $style

	Return GUISetStyle($style, -1, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetStyle

Func Form_SetExStyle(ByRef $this, Const ByRef $exStyle)
	$this.ExStyle = $exStyle

	Return GUISetStyle(-1, $exStyle, HWnd($this.Hwnd))
EndFunc   ;==>Form_SetExStyle

#EndRegion - Setters
