
#include-once

#include "Form Styles.au3"
#include "Form ExStyles.au3"

Func Properties()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Properties_Create")
	$this.AddMethod("Show", "Properties_Show")
	$this.AddMethod("Hide", "Properties_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)
	$this.AddProperty("FormStyles", $ELSCOPE_READONLY, FormStyles())
	$this.AddProperty("FormExStyles", $ELSCOPE_READONLY, FormExStyles())
	$this.AddProperty("FormName", $ELSCOPE_READONLY)
	$this.AddProperty("Title", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY)
	$this.AddProperty("Height", $ELSCOPE_READONLY)
	$this.AddProperty("Left", $ELSCOPE_READONLY)
	$this.AddProperty("Top", $ELSCOPE_READONLY)
	$this.AddProperty("FormBgColor", $ELSCOPE_READONLY)
	$this.AddProperty("CtrlBgColor", $ELSCOPE_READONLY)
	$this.AddProperty("CtrlFgColo", $ELSCOPE_READONLY)
	$this.AddProperty("Cursor", $ELSCOPE_READONLY)
	$this.AddProperty("Font", $ELSCOPE_READONLY)
	$this.AddProperty("Helpfile", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>Properties

Func Properties_Create(ByRef $this, Const $parent)
	$this.Hwnd = GUICreate("Properties", ($parent.Width - 100) * $g_iDPI_ratio1, ($parent.Height - 60) * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	GUICtrlCreateTab(5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, ($parent.Width - 110) * $g_iDPI_ratio1, ($parent.Height - 70) * $g_iDPI_ratio1)

	GUICtrlCreateTabItem("Properties")

	$this.Name = CreateInputGroup("Name", 15, 30, 300)

	$this.Title = CreateInputGroup("Title", 330, 30, 360)

	GUICtrlCreateGroup("Size and Position", 15 * $g_iDPI_ratio1, 80 * $g_iDPI_ratio1, 200 * $g_iDPI_ratio1, 75 * $g_iDPI_ratio1)

	GUICtrlCreateLabel("Width", 20 * $g_iDPI_ratio1, 100 * $g_iDPI_ratio1)
	
	$this.Width = GUICtrlCreateInput("", 52 * $g_iDPI_ratio1, 97 * $g_iDPI_ratio1, 60 * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateLabel("Height", 20 * $g_iDPI_ratio1, 130 * $g_iDPI_ratio1)
	
	$this.Height = GUICtrlCreateInput("", 52 * $g_iDPI_ratio1, 127 * $g_iDPI_ratio1, 60 * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateLabel("Left", 125 * $g_iDPI_ratio1, 100 * $g_iDPI_ratio1)
	
	$this.Left = GUICtrlCreateInput("", 147 * $g_iDPI_ratio1, 97 * $g_iDPI_ratio1, 60 * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateLabel("Top", 125 * $g_iDPI_ratio1, 130 * $g_iDPI_ratio1)
	
	$this.Top = GUICtrlCreateInput("", 147 * $g_iDPI_ratio1, 127 * $g_iDPI_ratio1, 60 * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateGroup('', -99, -99, 1, 1)

	$this.FormBgColor = CreateButton("Background Color", 15, 165)

	GUICtrlCreateGroup("Control Colors", 10 * $g_iDPI_ratio1, 200 * $g_iDPI_ratio1, 80 * $g_iDPI_ratio1, 80 * $g_iDPI_ratio1)

	$this.CtrlBgColor = CreateButton("Background", 15, 220)

	$this.CtrlFgColor = CreateButton("Foreground", 15, 250)

	GUICtrlCreateGroup('', -99, -99, 1, 1)

	$this.Cursor = CreateButton("Cursor", 15, 285)

	$this.Font = CreateButton("Font", 15, 315)
	
	$this.Helpfile = CreateButton("Helpfile", 15, 345)

	GUICtrlCreateTabItem('')

	$this.FormStyles.Create()

	$this.FormExStyles.Create()

	GUICtrlCreateTabItem("Context Menu")

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Menubar")

	GUICtrlCreateTabItem('')	

	GUICtrlCreateTabItem("Accelerators")

	GUICtrlCreateTabItem('')	
EndFunc   ;==>Properties_Create

Func Properties_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Show

Func Properties_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Properties_Hide

Func CreateInputGroup(Const $text, Const $left, Const $top, Const $width)
	GUICtrlCreateGroup($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1, $width * $g_iDPI_ratio1, 45 * $g_iDPI_ratio1)

	Local Const $input = GUICtrlCreateInput('', ($left + 10) * $g_iDPI_ratio1, ($top + 15) * $g_iDPI_ratio1, ($width - 20) * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateGroup('', -99, -99, 1, 1)

	Return $input
EndFunc   ;==>CreateInputGroup

Func CreateButton(Const $text, Const $left, Const $top)
	Return GUICtrlCreateButton($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1)
EndFunc   ;==>CreateButton