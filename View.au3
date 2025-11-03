
#include-once

#include <GDIPlus.au3>

Func GuiscapeView()
	Local $this = _AutoitObject_Class()

	$this.Create()

	$this.AddMethod("Create", "GuiscapeView_Create")
	$this.AddMethod("Show", "GuiscapeView_Show")

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

	$this.Hwnd = GUICreate($title, $this.Width, $this.Height, $this.Left, $this.Top)

	GUISetFont(10 * _GDIPlus_GraphicsGetDPIRatio()[0], -1, -1, "Segoe UI", HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Create

Func GuiscapeView_Show(Const ByRef $this)
	GUISetState(@SW_SHOWNORMAL, HWnd($this.Hwnd))
EndFunc   ;==>GuiscapeView_Show

;######################################################################################################################################
; #FUNCTION# ====================================================================================================================
; Name ..........: _GDIPlus_GraphicsGetDPIRatio
; Description ...:
; Syntax ........: _GDIPlus_GraphicsGetDPIRatio([$iDPIDef = 96])
; Parameters ....: $iDPIDef             - [optional] An integer value. Default is 96.
; Return values .: None
; Author ........: UEZ
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/topic/159612-dpi-resolution-problem/?hl=%2Bdpi#entry1158317
; Example .......: No
; ===============================================================================================================================
Func _GDIPlus_GraphicsGetDPIRatio($iDPIDef = 96)
    _GDIPlus_Startup()
    Local $hGfx = _GDIPlus_GraphicsCreateFromHWND(0)
    If @error Then Return SetError(1, @extended, 0)
    Local $aResult
    #forcedef $__g_hGDIPDll, $ghGDIPDll

    $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetDpiX", "handle", $hGfx, "float*", 0)

    If @error Then Return SetError(2, @extended, 0)
    Local $iDPI = $aResult[2]
    Local $aresults[2] = [$iDPIDef / $iDPI, $iDPI / $iDPIDef]
    _GDIPlus_GraphicsDispose($hGfx)
    _GDIPlus_Shutdown()
    Return $aresults
EndFunc   ;==>_GDIPlus_GraphicsGetDPIRatio