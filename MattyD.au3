
; https://www.autoitscript.com/forum/topic/213287-guiscape-a-new-gui-builder-project/page/2/#findComment-1547171
; Here is yesterday's effort - single select button for now.. Double click sets the text, delete removes the control.

#include <WindowsSysColorConstants.au3>
#include <guiConstants.au3>
#include <winapi.au3>
#include <guibutton.au3>
#include <WinAPIvkeysConstants.au3>

Global Const $tagMINMAXINFO = "long Reserved[2]; long MaxSize[2]; long MaxPosition[2]; long MinTrackSize[2]; long MaxTrackSize[2]"

Global Const $MK_LBUTTON = 1

Global Const $iSnap = 15

Global Const $hCursor_Cross = _WinAPI_LoadCursor(0, $IDC_CROSS)

Global $hGui = GUICreate("", 300, 200, 100, 100, BitOR($WS_SIZEBOX, $WS_MINIMIZEBOX))

GUISetState()

Global Const $hBtnProc = DllCallbackRegister("btnProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global Const $pBtnProc = DllCallbackGetPtr($hBtnProc)
Global Const $hWndProc = DllCallbackRegister("WndProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global Const $pWndProc = DllCallbackGetPtr($hWndProc)

_WinAPI_SetWindowSubclass($hGui, $pWndProc, 1000)

GUISetState()

Local $iMsg
While WinExists($hGui)
    $iMsg = GUIGetMsg()
    Switch $iMsg
        Case $GUI_EVENT_CLOSE
            ExitLoop

    EndSwitch
WEnd

_WinAPI_RemoveWindowSubclass($hGui, $pWndProc, 1000)

Func WndProc($hWnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
    Local $iRet
	
    Local Static $bDrawRect, $tPaintRect = DllStructCreate($tagRect)

    Switch $iMsg
        Case $WM_SETCURSOR
            Local $iSrc = _WinAPI_LoWord($lParam), $iEvent =  _WinAPI_HiWord($lParam)
            If $iSrc = $HTCLIENT Then
                _WinAPI_SetCursor($hCursor_Cross)
                $iRet = 1
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_LBUTTONDOWN
            Local $tPoint = _WinAPI_MakePoints($lParam)

            $tPaintRect.Left = $tPoint.X
            $tPaintRect.Top = $tPoint.Y

            $tPaintRect.Left -= Mod($tPaintRect.Left, $iSnap)
            $tPaintRect.Top -= Mod($tPaintRect.Top, $iSnap)

            $bDrawRect = True
;~          _WinAPI_TrackMouseEvent($hWnd, $TME_LEAVE)
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_MOUSEMOVE
            Local $tPoint = _WinAPI_MakePoints($lParam)

            If BitAND($wParam, $MK_LBUTTON) = $MK_LBUTTON Then
                _WinAPI_InvalidateRect($hWnd, $tPaintRect, True)
                $tPaintRect.Right = $tPoint.X
                $tPaintRect.Bottom = $tPoint.Y
                $tPaintRect.Right -= Mod($tPaintRect.Right, $iSnap)
                $tPaintRect.Bottom -= Mod($tPaintRect.Bottom, $iSnap)

                _WinAPI_InvalidateRect($hWnd, $tPaintRect, True)
                $iRet = 0
            Else
                If $bDrawRect Then _WinAPI_InvalidateRect($hWnd, $tPaintRect, True)
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
                _WinAPI_Rectangle($hDC, $tPaintRect)
                _WinAPI_DeleteObject($hPen)
                _WinAPI_DeleteObject($hBrush)
                _WinAPI_EndPaint($hWnd, $tPaintStruct)
                $iRet = 0
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_LBUTTONUP
            Local $tPoint = _WinAPI_MakePoints($lParam)

            If $bDrawRect Then
                $bDrawRect = False

                $tPaintRect.Right = $tPoint.X
                $tPaintRect.Bottom = $tPoint.Y
                $tPaintRect.Right -= Mod($tPaintRect.Right, $iSnap)
                $tPaintRect.Bottom -= Mod($tPaintRect.Bottom, $iSnap)

                _WinAPI_InvalidateRect($hWnd, $tPaintRect, True)

                If Abs($tPaintRect.Left - $tPaintRect.Right) >= $iSnap _  ;MinWidth & Height.
                    And Abs($tPaintRect.Top - $tPaintRect.Bottom) >= $iSnap Then

                    ;Need border & clipsiblings to paint custom frame. using UDF for button to avoid any surprises in autoit's default btn proc
                    Local $hBtn = _GUICtrlButton_Create($hWnd, "Button", _
                            ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                            ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                            Abs($tPaintRect.Left - $tPaintRect.Right), _
                            Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                            BitOR($BS_PUSHLIKE, $WS_BORDER, $WS_CLIPSIBLINGS))
                    _WinAPI_SetWindowSubclass($hBtn, $pBtnProc, _WinAPI_GetDlgCtrlID($hBtn))

                EndIf

            EndIf

            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_SIZE
            ;This prevents autoit's docking logic from moving controls around on window restore.
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

;~      Case $WM_MOUSELEAVE
;~          Local $tPoint = _WinAPI_GetMousePos(True, $hWnd)
;~          If ($tPoint.X < 0) Or ($tPoint.X > _WinAPI_GetWindowWidth($hWnd)) Then
;~          ElseIf ($tPoint.Y < 0) Or ($tPoint.Y > _WinAPI_GetWindowHeight($hWnd)) Then
;~          EndIf

        Case Else
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
    EndSwitch

    Return $iRet
EndFunc   ;==>WndProc


Func btnProc($hWnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
    Local $iRet
	
    Local Static $iXOffset, $iYOffset, $hHasFocus, $hLastFocus;, $tStartPos
	
    Local Static $hDrag

    Switch $iMsg
        Case $WM_NCHITTEST
            Local $tPoint = _WinAPI_MakePoints($lParam)
            Local $tRect = _WinAPI_GetWindowRect($hWnd)
            Local $iMar = 10

            $iRet = $HTCLIENT
            ;only in caption bar if left button is down. (no kb input availabe in caption!)
            Local $iTestKey = _WinAPI_GetSystemMetrics($SM_SWAPBUTTON) ? $VK_RBUTTON : $VK_LBUTTON
            If BitAnd(0x8000, _WinAPI_GetAsyncKeyState($iTestKey)) Then $iRet = $HTCAPTION

            If $tPoint.X - $tRect.Left < $iMar Then $iRet = $HTLEFT
            If $tPoint.X > ($tRect.Right - $iMar) Then $iRet = $HTRIGHT

            If $tPoint.Y - $tRect.Top < $iMar Then
                Switch $iRet
                    Case $HTLEFT
                        $iRet = $HTTOPLEFT
                    Case $HTRIGHT
                        $iRet = $HTTOPRIGHT
                    Case Else
                        $iRet = $HTTOP
                EndSwitch

            ElseIf $tPoint.Y > ($tRect.Bottom - $iMar) Then
                Switch $iRet
                    Case $HTLEFT
                        $iRet = $HTBOTTOMLEFT
                    Case $HTRIGHT
                        $iRet = $HTBOTTOMRIGHT
                    Case Else
                        $iRet = $HTBOTTOM
                EndSwitch
            EndIf

            If $tPoint.X < 0 Then $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            If $tPoint.Y < 0 Then $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            _WinAPI_RedrawWindow($hWnd)

        Case $WM_NCLBUTTONDOWN
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            _WinaPI_SetFocus($hWnd)

        Case $WM_SETFOCUS
            $hHasFocus = $hWnd
            _SendMessage($wParam, $WM_KILLFOCUS, $hWnd)
            $hLastFocus = $hWnd
            _WinAPI_RedrawWindow($hWnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_KILLFOCUS
            _WinAPI_RedrawWindow($hWnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_NCLBUTTONDBLCLK ;Prevent double-click maximizing in "caption" - also now set caption.
            If $wParam = $HTCAPTION Then
                Local $iCaptionLen = _SendMessage($hWnd, $WM_GETTEXTLENGTH)
                Local $tCaption = DllStructCreate(StringFormat("wchar text[%d]", $iCaptionLen + 1))
                _SendMessage($hWnd, $WM_GETTEXT, DllStructGetSize($tCaption), $tCaption, 0, "wparam", "struct*")
                Local $sCaption = InputBox("Edit Caption", " ", $tCaption.Text, "", 150, 60, BitAND($lParam, 0xFFFF), BitShift($lParam, 16))
                If Not @error Then _SendMessage($hWnd, $WM_SETTEXT, 0, $sCaption, 0, "wparam", "wstr")
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_GETMINMAXINFO
            ;Min width jumps to ~150 with WS_BORDER - I guess it gets min window size: SM_CYMINTRACK
            Local $tMinMaxInfo = DllStructCreate($tagMINMAXINFO, $lParam)
            $tMinMaxInfo.MinTrackSize(1) = $iSnap + 1
            $tMinMaxInfo.MinTrackSize(2) = $iSnap + 1
            $iRet = 0

        Case $WM_SIZING
            Local $tRect = DllStructCreate($tagRect, $lParam)
            Local $tRect2 = _WinAPI_GetWindowRect($hWnd)

            $tRect.Left += Mod($tRect2.Left - $tRect.Left, $iSnap)
            $tRect.Top += Mod($tRect2.Top - $tRect.Top, $iSnap)
            $tRect.Right += Mod($tRect2.Right - $tRect.Right, $iSnap)
            $tRect.Bottom += Mod($tRect2.Bottom - $tRect.Bottom, $iSnap)

            $iRet = True

        Case $WM_NCPAINT
            Local $hDC = _WinAPI_GetWindowDC($hWnd)
            Local $tRect = _WinAPI_GetClientRect($hWnd)
            $tRect.Right = _WinAPI_GetWindowWidth($hWnd)
            $tRect.Bottom = _WinAPI_GetWindowHeight($hWnd)
            Local $hPenCol = ($hHasFocus = $hWnd) ?  _WinAPI_RGB(0, 0xAA, 0) : _WinAPI_GetSysColor($COLOR_3DFACE)
            Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $hPenCol)

            _WinAPI_SelectObject($hDC, $hPen)
            _WinAPI_Rectangle($hDC, $tRect)
            _WinAPI_DeleteObject($hPen)
            _WinAPI_ReleaseDC($hWnd, $hDC)
            $iRet = 0

        Case $WM_MOVING
            Local $tRect = DllStructCreate($tagRect, $lParam)
            Local $tRect2 = _WinAPI_GetWindowRect($hWnd)

            $iXOffset += $tRect.Left - $tRect2.Left
            $iYOffset += $tRect.Top - $tRect2.Top
            Local $iSnapH = Floor($iXOffset / $iSnap) * $iSnap
            Local $iSnapV = Floor($iYOffset / $iSnap) * $iSnap
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
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_KEYDOWN
            If $wParam = $VK_DELETE Then
;~              _WinAPI_DestroyWindow($hWnd)
                _WinAPI_PostMessage($hWnd, $WM_DESTROY, 0, 0)
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_DESTROY
            _WinAPI_RemoveWindowSubclass($hWnd, $pBtnProc, $iIdSubclass)
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
            _GUICtrlButton_Destroy($hWnd)

        Case $WM_SETCURSOR
            Local $iSrc = BitAND($lParam, 0xFFFF), $iEvent = BitShift($lParam, 16)
            If $iSrc = $HTCAPTION And $iEvent = $WM_LBUTTONDOWN Then
                _WinAPI_SetCursor($hCursor_Cross)
                $iRet = 1
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case Else
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
    EndSwitch

    Return $iRet
EndFunc   ;==>btnProc

Func _WinAPI_MakePoints($iValue)
    Local $tPoint = DllStructCreate($tagPoint)
    DllStructSetData($tPoint, 1, _WinAPI_WordToShort(_WinAPI_LoWord($iValue)))
    DllStructSetData($tPoint, 2, _WinAPI_WordToShort(_WinAPI_HiWord($iValue)))
    Return $tPoint
EndFunc