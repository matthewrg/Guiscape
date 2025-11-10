
#include-once

Func ObjectExplorer()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "ObjectExplorer_Create")
	$this.AddMethod("Show", "ObjectExplorer_Show")
	$this.AddMethod("Hide", "ObjectExplorer_Hide")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>ObjectExplorer

Func ObjectExplorer_Create(ByRef $this, Const ByRef $parent)
	$this.Hwnd = GUICreate( _
			"Object Explorer", _
			($parent.Width - 105) * $DPIRatio, _
			($parent.Height - 65) * $DPIRatio, _
			90 * $DPIRatio, _
			30 * $DPIRatio, _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($parent.Hwnd))
EndFunc   ;==>ObjectExplorer_Create

Func ObjectExplorer_Show(ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorer_Show

Func ObjectExplorer_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>ObjectExplorer_Hide
