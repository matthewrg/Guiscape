
#include-once

Func GuiscapeView()
	Local $this = _AutoitObject_Class()

	$this.Create()

	$this.AddMethod("Create", "GuiscapeView_Create")
	$this.AddMethod("Show", "GuiscapeView_Show")
	$this.AddMethod("SetSizePos", "GuiscapeView_SetSizePos")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY)
	$this.AddProperty("Height", $ELSCOPE_READONLY)
	$this.AddProperty("Left", $ELSCOPE_READONLY)
	$this.AddProperty("Top", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>GuiscapeView

Func GuiscapeView_Create(ByRef $this, Const $title)
	$this.Width = 815
	$this.Height = 860
	$this.Left = (@DesktopWidth / 2) - ($this.Width / 2)
	$this.Top = (@DesktopHeight / 2) - ($this.Height / 2)

	$this.Hwnd = GUICreate( _
			$title, _
			$this.Width * $g_iDPI_ratio1, _
			$this.Height * $g_iDPI_ratio1, _
			$this.Left * $g_iDPI_ratio1, _
			$this.Top * $g_iDPI_ratio1, _
			BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_SYSMENU))

	GUISetFont(10 * $g_iDPI_ratio1, -1, -1, "Segoe UI", HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Create

Func GuiscapeView_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Show

Func GuiscapeView_SetSizePos(ByRef $this, Const ByRef $sizePos)
	$this.Left = $sizePos[0]
	$this.Top = $sizePos[1]
	$this.Width = $sizePos[2] - 16
	$this.Height = $sizePos[3] - 39

;~ 	Print("Guiscape: " & $sizePos[2] & " - " & $sizePos[3])
EndFunc   ;==>GuiscapeView_SetSizePos
