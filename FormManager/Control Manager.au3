
#include-once

Global $ctrlManager = ControlManager()

Func ControlManager()
	Local $cursorCross = _WinAPI_LoadCursor(0, $IDC_CROSS)

	Local $hCtrlProc = DllCallbackRegister(CtrlProc, "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")

	Local $hWndProc = DllCallbackRegister(WndProc, "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddProperty("pCtrlProc", $ELSCOPE_READONLY, $hCtrlProc)
	$this.AddProperty("pWndProc", $ELSCOPE_READONLY, $hWndProc)
	$this.AddProperty("CursorCross", $ELSCOPE_READONLY, $cursorCross)
	$this.AddProperty("MKLBUTTON", $ELSCOPE_READONLY, 1)
	$this.AddProperty("Snap", $ELSCOPE_READONLY, 10)
	$this.AddProperty("", $ELSCOPE_READONLY)

	$this.AddMethod("Init", "ControlManager_Init")
	$this.AddMethod("WndProc", "ControlManager_WndProc")
	$this.AddMethod("CtrlProc", "ControlManager_CtrlProc")

	$this.AddDestructor("ControlManager_Dtor")

	Return $this.Object
EndFunc   ;==>ControlManager

Func ControlManager_Init(ByRef $this, Const $hwnd)
	_WinAPI_SetWindowSubclass(HWnd($hwnd), DllCallbackGetPtr($this.pWndProc), 1000)
EndFunc   ;==>ControlManager_Init

Func ControlManager_WndProc(ByRef $this, $hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
    Local $iRet
	
    Local Static $bDrawRect, $tRect = DllStructCreate($tagRect)

    Switch $iMsg
        Case $WM_SETCURSOR
            Local $iSrc = BitAND($lParam, 0xFFFF)
			
            If $iSrc = $HTCLIENT Then
                _WinAPI_SetCursor(Ptr($this.CursorCross))
				
                $iRet = 1
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_LBUTTONDOWN
            $tRect.Left = BitAND($lParam, 0xFFFF)
            $tRect.Top = BitShift($lParam, 16)

            $tRect.Left -= Mod($tRect.Left, $this.Snap)
            $tRect.Top -= Mod($tRect.Top, $this.Snap)

            $bDrawRect = True
			
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_MOUSEMOVE			
			Local $MK_LBUTTON = 1
			
            If BitAND($wParam, $MK_LBUTTON) = $MK_LBUTTON Then
                _WinAPI_InvalidateRect($hWnd, $tRect, True)
                $tRect.Right = BitAND($lParam, 0xFFFF)
                $tRect.Bottom = BitShift($lParam, 16)
                $tRect.Right -= Mod($tRect.Right, $this.Snap)
                $tRect.Bottom -= Mod($tRect.Bottom, $this.Snap)

                _WinAPI_InvalidateRect($hWnd, $tRect, True)
                $iRet = 0
            Else
                $bDrawRect = False
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf


        Case $WM_PAINT
            If $bDrawRect Then
                Local $tPaintStruct = $tagPAINTSTRUCT
                Local $hDC = _WinAPI_BeginPaint($hWnd, $tPaintStruct)
                Local $hPen = _WinAPI_CreatePen($PS_DOT, 1, _WinAPI_RGB(0, 0, 0))
                Local $hBrush = _WinAPI_GetStockObject($WHITE_BRUSH)
                _WinAPI_SelectObject($hDC, $hPen)
                _WinAPI_SelectObject($hDC, $hBrush)

                _WinAPI_Rectangle($hDC, $tRect)

                _WinAPI_DeleteObject($hPen)
                _WinAPI_DeleteObject($hBrush)
                _WinAPI_EndPaint($hWnd, $tPaintStruct)
                $iRet = 0
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_LBUTTONUP
            $bDrawRect = False

            $tRect.Right = BitAND($lParam, 0xFFFF)
            $tRect.Bottom = BitShift($lParam, 16)
            $tRect.Right -= Mod($tRect.Right, $this.Snap)
            $tRect.Bottom -= Mod($tRect.Bottom, $this.Snap)

            _WinAPI_InvalidateRect($hWnd, $tRect, True)

            Local $idBtn = GUICtrlCreateButton("", _
                    ($tRect.Left < $tRect.Right) ? $tRect.Left : $tRect.Right, _
                    ($tRect.Top < $tRect.Bottom) ? $tRect.Top : $tRect.Bottom, _
                    Abs($tRect.Left - $tRect.Right), _
                    Abs($tRect.Top - $tRect.Bottom))
            _WinAPI_SetWindowSubclass(GUICtrlGetHandle($idBtn), DllCallbackGetPtr($this.pCtrlProc), $idBtn)

            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_SIZE
            ;This prevents autoit's docking logic from moving controls around on window restore.
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

        Case Else
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
    EndSwitch

    Return $iRet
EndFunc   ;==>ControlManager_WndProc

Func ControlManager_CtrlProc(ByRef $this, $hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
	Local $iRet

	Local Static $iXOffset, $iYOffset

	Switch $iMsg
	  Case $WM_NCHITTEST
			Local $aPoint[2] = [BitAND($lParam, 0xFFFF), BitShift($lParam, 16)]

			;Mouse coords can be negative on edge cases!
			If BitAND($aPoint[0], 0x8000) Then $aPoint[0] = BitOR(0xFFFF0000, $aPoint[0])
			If BitAND($aPoint[1], 0x8000) Then $aPoint[1] = BitOR(0xFFFF0000, $aPoint[1])

			Local $aPos = WinGetPos($hwnd), $iMar = 10

			$iRet = $HTCAPTION
			If $aPoint[0] - $aPos[0] < $iMar Then $iRet = $HTLEFT
			If $aPoint[0] - $aPos[0] > ($aPos[2] - $iMar) Then $iRet = $HTRIGHT

			If $aPoint[1] - $aPos[1] < $iMar Then
				Switch $iRet
					Case $HTLEFT
						$iRet = $HTTOPLEFT
					Case $HTRIGHT
						$iRet = $HTTOPRIGHT
					Case Else
						$iRet = $HTTOP
				EndSwitch
			
			ConsoleWrite("1" & @CRLF)

			ElseIf $aPoint[1] - $aPos[1] > ($aPos[3] - $iMar) Then
				Switch $iRet
					Case $HTLEFT
						$iRet = $HTBOTTOMLEFT
					Case $HTRIGHT
						$iRet = $HTBOTTOMRIGHT
					Case Else
						$iRet = $HTBOTTOM
				EndSwitch
			
			ConsoleWrite("2" & @CRLF)
			EndIf

			If $aPoint[0] < 0 Then $iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			If $aPoint[1] < 0 Then $iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			_WinAPI_RedrawWindow($hwnd)

		Case $WM_NCLBUTTONDBLCLK ;Prevent double-click maximizing in "caption"
			If $wParam <> $HTCAPTION Then $iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_SIZING
			Local $tRect = DllStructCreate($tagRect, $lParam)
			Local $tRect2 = _WinAPI_GetWindowRect($hwnd)

			$tRect.Left += Mod($tRect2.Left - $tRect.Left, $this.Snap)
			$tRect.Top += Mod($tRect2.Top - $tRect.Top, $this.Snap)
			$tRect.Right += Mod($tRect2.Right - $tRect.Right, $this.Snap)
			$tRect.Bottom += Mod($tRect2.Bottom - $tRect.Bottom, $this.Snap)
			$iRet = True

		Case $WM_MOVING
			Local $tRect = DllStructCreate($tagRect, $lParam)
			Local $tRect2 = _WinAPI_GetWindowRect($hwnd)

			$iXOffset += $tRect.Left - $tRect2.Left
			$iYOffset += $tRect.Top - $tRect2.Top
			Local $iSnapH = Floor($iXOffset / $this.Snap) * $this.Snap
			Local $iSnapV = Floor($iYOffset / $this.Snap) * $this.Snap
			$iXOffset -= $iSnapH
			$iYOffset -= $iSnapV

			$tRect.Left = $tRect2.Left + $iSnapH
			$tRect.Right = $tRect2.Right + $iSnapH
			$tRect.Top = $tRect2.Top + $iSnapV
			$tRect.Bottom = $tRect2.Bottom + $iSnapV

			$iRet = 0

		Case $WM_EXITSIZEMOVE
			$iXOffset = 0
			$iYOffset = 0
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_SETCURSOR
			Local $iSrc = BitAND($lParam, 0xFFFF)

			Local $iEvent = BitShift($lParam, 16)

			If $iSrc = $HTCAPTION And $iEvent = $WM_LBUTTONDOWN Then
				_WinAPI_SetCursor(Ptr($this.CursorCross))
				$iRet = 1
			Else
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case Else
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
	EndSwitch

	Return $iRet
EndFunc   ;==>ControlManager_CtrlProc

Func ControlManager_Dtor(ByRef $this)
	_WinAPI_RemoveWindowSubclass(HWnd($this.Hwnd), $this.pWndProc, 1000)
EndFunc   ;==>ControlManager_Dtor

Func WndProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
	Return $ctrlManager.WndProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
EndFunc   ;==>WndProc

Func CtrlProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
	Return $ctrlManager.CtrlProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
EndFunc   ;==>CtrlProc
