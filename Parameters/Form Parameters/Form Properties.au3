
#include-once

Func Properties()
	Local $this = _AutoItObject_Create()
	
	$this.Create()
	
	$this.AddMethod("Show", "Properties_Show")
	$this.AddMethod("Hide", "Properties_Hide")
	
	$this.AddProperty("Styles", $ELSCOPE_READONLY)
	$this.AddProperty("Name", $ELSCOPE_READONLY)
	$this.AddProperty("Title", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY)
	$this.AddProperty("Height", $ELSCOPE_READONLY)
	$this.AddProperty("Left", $ELSCOPE_READONLY)
	$this.AddProperty("Top", $ELSCOPE_READONLY)
	$this.AddProperty("FormBgColor", $ELSCOPE_READONLY)
	$this.AddProperty("CtrlBgColor", $ELSCOPE_READONLY)
	$this.AddProperty("CtrlFgColor", $ELSCOPE_READONLY)
	$this.AddProperty("Cursor", $ELSCOPE_READONLY)
	$this.AddProperty("Font", $ELSCOPE_READONLY)
	$this.AddProperty("Helpfile", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>Properties

Func Properties_Show(ByRef $this)
	$this.Styles = GUICtrlCreateTabItem("Styles")
	
	$this.Name = $this.CreateInputGroup("Name", 15, 30, 300)

	$this.Title = $this.CreateInputGroup("Title", 330, 30, 360)

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

	$this.FormBgColor = $this.CreateButton("Background Color", 15, 165)

	GUICtrlCreateGroup("Control Colors", 10 * $g_iDPI_ratio1, 200 * $g_iDPI_ratio1, 80 * $g_iDPI_ratio1, 80 * $g_iDPI_ratio1)

	$this.CtrlBgColor = $this.CreateButton("Background", 15, 220)

	$this.CtrlFgColor = $this.CreateButton("Foreground", 15, 250)

	GUICtrlCreateGroup('', -99, -99, 1, 1)

	$this.Cursor = $this.CreateButton("Cursor", 15, 285)

	$this.Font = $this.CreateButton("Font", 15, 315)

	$this.Helpfile = $this.CreateButton("Helpfile", 15, 345)

	GUICtrlCreateTabItem('')
EndFunc

Func Properties_Hide(ByRef $this)
	
EndFunc

Func CreateInputGroup(Const $text, Const $left, Const $top, Const $width)	
	GUICtrlCreateGroup($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1, $width * $g_iDPI_ratio1, 45 * $g_iDPI_ratio1)

	Local Const $input = GUICtrlCreateInput('', ($left + 10) * $g_iDPI_ratio1, ($top + 15) * $g_iDPI_ratio1, ($width - 20) * $g_iDPI_ratio1, 20 * $g_iDPI_ratio1)

	GUICtrlCreateGroup('', -99, -99, 1, 1)

	Return $input
EndFunc   ;==>CreateInputGroup

Func CreateButton(Const $text, Const $left, Const $top)
	Return GUICtrlCreateButton($text, $left * $g_iDPI_ratio1, $top * $g_iDPI_ratio1)
EndFunc   ;==>CreateButton
