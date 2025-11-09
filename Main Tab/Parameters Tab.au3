
#include-once

Func ParametersTab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "ParametersTab_Create")
	$this.AddMethod("Show", "ParametersTab_Show")
	$this.AddMethod("Hide", "ParametersTab_Hide")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>ParametersTab

Func ParametersTab_Create(ByRef $this, Const ByRef $parent)
	Local Const $left = 90
	Local Const $top = 30
	Local Const $width = ($parent.Width - 100)
	Local Const $height = ($parent.Height - 60)

	$this.Hwnd = GUICreate( _
			'', _
			$width * $g_iDPI_ratio1, _
			$height * $g_iDPI_ratio1, _
			$left * $g_iDPI_ratio1, _
			$top * $g_iDPI_ratio1, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($parent.Hwnd))
EndFunc   ;==>ParametersTab_Create

Func ParametersTab_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ParametersTab_Show

Func ParametersTab_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ParametersTab_Hide
