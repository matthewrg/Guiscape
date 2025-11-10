
#include-once

#include "Form Parameters\Form Properties.au3"
#include "Control Parameters\Button Properties.au3"
;~ #include "Control Parameters\Checkbox Properties.au3"

Func Parameters()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Parameters_Handler")
	$this.AddMethod("Create", "Parameters_Create")
	$this.AddMethod("ShowFormProperties", "Parameters_ShowFormProperties")
	$this.AddMethod("ShowButtonProperties", "Parameters_ShowButtonProperties")
	$this.AddMethod("Show", "Parameters_Show")
	$this.AddMethod("Hide", "Parameters_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)

	$this.AddProperty("Form", $ELSCOPE_READONLY)
	$this.AddProperty("Button", $ELSCOPE_READONLY)
	$this.AddProperty("Checkbox", $ELSCOPE_READONLY)

	$this.AddProperty("Active", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>Parameters

Func Parameters_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event
EndFunc   ;==>Parameters_Handler

Func Parameters_Create(ByRef $this, Const ByRef $parent)
	Local Const $left = 90
	Local Const $top = 30
	Local Const $width = ($parent.Width - 100)
	Local Const $height = ($parent.Height - 60)

	$this.Hwnd = GUICreate( _
			"Parameters", _
			$width * $DPIRatio, _
			$height * $DPIRatio, _
			$left * $DPIRatio, _
			$top * $DPIRatio, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($parent.Hwnd))

	$this.Form = FormProperties($parent)

	$this.Button = ButtonProperties($parent)

	$this.Active = $this.Form

	$this.Form.Create()

	$this.Button.Create()
EndFunc   ;==>Parameters_Create

Func Parameters_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Parameters_Show

Func Parameters_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Parameters_Hide

Func CreateInput(Const $text, Const $left, Const $top, Const $width)
	Return GUICtrlCreateInput($text, $left * $DPIRatio, $top * $DPIRatio, $width * $DPIRatio, 22 * $DPIRatio)
EndFunc   ;==>CreateInput

Func CreateLabel(Const $text, Const $left, Const $top)
	Return GUICtrlCreateLabel($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateLabel

Func CreateGroup(Const $name, Const $left, Const $top, Const $width, Const $height)
	Return GUICtrlCreateGroup($name, $left * $DPIRatio, $top * $DPIRatio, $width * $DPIRatio, $height * $DPIRatio)
EndFunc   ;==>CreateGroup

Func EndGroup()
	GUICtrlCreateGroup('', -99, -99, 1, 1)
EndFunc   ;==>EndGroup

Func CreateButton(Const $text, Const $left, Const $top)
	Return GUICtrlCreateButton($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateButton

Func CreateEdit(Const $left, Const $top, Const $width, Const $height)
	Return GUICtrlCreateEdit('', $left, $top * $DPIRatio, $width * $DPIRatio, $height * $DPIRatio)
EndFunc

Func CreateCheckbox(Const $text, Const $left, Const $top)
	Return GUICtrlCreateCheckbox($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateCheckbox
