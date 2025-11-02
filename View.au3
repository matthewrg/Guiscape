
#include-once

Func GuiscapeView()
	Local $this = _AutoitObject_Class()

	$this.Create()

	$this.AddMethod("Create", "GuiscapeView_Create")
	$this.AddMethod("Show", "GuiscapeView_Show")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Width", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Height", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Left", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Top", $ELSCOPE_READONLY, Null)

	Return $this.Object
EndFunc   ;==>GuiscapeView

Func GuiscapeView_Create(ByRef $this, Const $title)
	$this.Width = 815
	$this.Height = 860
	$this.Left = (@DesktopWidth / 2) - ($this.Width / 2)
	$this.Top = (@DesktopHeight / 2) - ($this.Height / 2)

	$this.Hwnd = GUICreate($title, $this.Width, $this.Height, $this.Left, $this.Top)

	GUISetFont(10, -1, -1, "Segoe UI", HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Create

Func GuiscapeView_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Show
