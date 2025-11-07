;~ #AutoIt3Wrapper_UseX64=N

;TODO: snap always rounds down, so you can't drag all the way right/bottom if you run out of window.
;Need to change the tipping point to 1/2 way between points.

#include <WindowsSysColorConstants.au3>
#include <guiConstants.au3>
#include <winapi.au3>
#include <guiButton.au3>
#include <guiEdit.au3>
#include <WinAPIvkeysConstants.au3>
#include <BorderConstants.au3>

Global Const $tagMINMAXINFO = "long Reserved[2]; long MaxSize[2]; long MaxPosition[2]; long MinTrackSize[2]; long MaxTrackSize[2]"

Global Const $MK_LBUTTON = 0x0001
Global Const $MK_RBUTTON = 0x0002
Global Const $MK_SHIFT = 0x0004
Global Const $MK_CONTROL = 0x0008
Global Const $MK_MBUTTON = 0x0010
Global Const $MK_XBUTTON1 = 0x0020
Global Const $MK_XBUTTON2 = 0x0040

Global $iSnap = 15, $iMinCtrlW = 15, $iMinCtrlH = 15
Global $mh_SelCtrls[]

Global $hCursor_Cross = _WinAPI_LoadCursor(0, $IDC_CROSS)
Global $hGui = GUICreate("", 300, 200, 100, 100, BitOR($WS_SIZEBOX, $WS_MINIMIZEBOX))
GUISetState()

Global $hGui2 = GUICreate("", 200, 300, 450, 100)

Global $idAlignTop = GUICtrlCreateButton("Align Top", 100, 10, 80, 25)
Global $idButton = GUICtrlCreateRadio("Button", 10, 10, 80, 25)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $idCheck = GUICtrlCreateRadio("Checkbox", 10, 40, 80, 25)
Global $idRadio = GUICtrlCreateRadio("Radio", 10, 70, 80, 25)
Global $idEdit = GUICtrlCreateRadio("Edit", 10, 100, 80, 25)
Global $idInput = GUICtrlCreateRadio("Input", 10, 130, 80, 25)
;~ Global $idList = GUICtrlCreateRadio("List", 10, 160, 80, 25)

Global $hCtrlProc = DllCallbackRegister("CtrlProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global $pCtrlProc = DllCallbackGetPtr($hCtrlProc)
Global $hWndProc = DllCallbackRegister("WndProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global $pWndProc = DllCallbackGetPtr($hWndProc)

_WinAPI_SetWindowSubclass($hGui, $pWndProc, 1000)

GUISetState()

Local $iMsg, $aKeys, $tWinPos, $tParPos, $iTop
While WinExists($hGui)
    $iMsg = GUIGetMsg()
    Switch $iMsg
        Case $GUI_EVENT_CLOSE
            ExitLoop

        Case $idAlignTop
            $tParPos = _WinAPI_GetClientRect($hGui)
            $iTop = $tParPos.Bottom
            $aKeys = MapKeys($mh_SelCtrls)
            For $hWnd In $aKeys
                If $mh_SelCtrls[$hWnd] Then
                    $tWinPos = _WinAPI_GetWindowRect($hWnd)
                    _WinAPI_ScreenToClient($hGUI, $tWinPos)
                    If $tWinPos.Top < $iTop Then  $iTop = $tWinPos.Top
                EndIf
            Next

            For $hWnd In $aKeys
                If $mh_SelCtrls[$hWnd] Then
                    $tWinPos = _WinAPI_GetWindowRect($hWnd)
                    _WinAPI_ScreenToClient($hGUI, $tWinPos)
                    _WinAPI_ScreenToClient($hGUI, DllStructGetPtr($tWinPos, 3))
                    _WinAPI_MoveWindow($hWnd, $tWinPos.Left, $iTop, $tWinPos.Right - $tWinPos.Left, $tWinPos.Bottom - $tWinPos.Top)
                EndIf
            Next
    EndSwitch
WEnd

_WinAPI_RemoveWindowSubclass($hGui, $pWndProc, 1000)

Func WndProc($hWnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
    #forceref $hWnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData

    Local $iRet
    Local Static $bDrawRect, $tPaintRect = DllStructCreate($tagRect)

    Switch $iMsg

        Case $WM_SETCURSOR
            Local $iSrc = _WinAPI_LoWord($lParam);, $iEvent =  _WinAPI_HiWord($lParam)
            If $iSrc = $HTCLIENT Then
                ;_WinAPI_SetCursor($hCursor_Cross)
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

                If Abs($tPaintRect.Left - $tPaintRect.Right) >= $iMinCtrlW _  ;MinWidth & Height.
                    And Abs($tPaintRect.Top - $tPaintRect.Bottom) >= $iMinCtrlH Then

                        ;Yes, this can be done better - too lazy right now!
                        Select
                            Case GUICtrlRead($idButton) = $GUI_CHECKED
                                ;Need border & clipsiblings to paint custom frame. using UDF for button to avoid any surprises in autoit's default btn proc
                                Local $hCtrl = _GUICtrlButton_Create($hWnd, "", _
                                        ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                                        ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                                        Abs($tPaintRect.Left - $tPaintRect.Right), _
                                        Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                                        BitOR($BS_PUSHLIKE, $WS_BORDER, $WS_CLIPSIBLINGS))

                                _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

                            Case GUICtrlRead($idCheck) = $GUI_CHECKED
                                Local $hCtrl = _GUICtrlButton_Create($hWnd, "Checkbox", _
                                        ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                                        ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                                        Abs($tPaintRect.Left - $tPaintRect.Right), _
                                        Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                                        BitOR($BS_AUTOCHECKBOX, $WS_BORDER, $WS_CLIPSIBLINGS))

                                _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

                            Case GUICtrlRead($idRadio) = $GUI_CHECKED
                                Local $hCtrl = _GUICtrlButton_Create($hWnd, "Radio", _
                                        ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                                        ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                                        Abs($tPaintRect.Left - $tPaintRect.Right), _
                                        Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                                        BitOR($BS_AUTORADIOBUTTON, $WS_BORDER, $WS_CLIPSIBLINGS))

                                _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

                            Case GUICtrlRead($idEdit) = $GUI_CHECKED
                                Local $hCtrl = _GUICtrlEdit_Create($hWnd, "", _
                                        ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                                        ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                                        Abs($tPaintRect.Left - $tPaintRect.Right), _
                                        Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                                        BitOR($ES_WANTRETURN, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS))

                                _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))
                            Case GUICtrlRead($idInput) = $GUI_CHECKED
                                Local $hCtrl = _GUICtrlEdit_Create($hWnd, "", _
                                        ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
                                        ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
                                        Abs($tPaintRect.Left - $tPaintRect.Right), _
                                        Abs($tPaintRect.Top - $tPaintRect.Bottom), _
                                        BitOR($ES_LEFT, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS))

                                _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

                        EndSelect
                EndIf
            EndIf

            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)


        Case $WM_SIZE
            ;This prevents autoit's docking logic from moving controls around on window restore.
            ;if we ony use the udf functions to create ctrls this is not needed.
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

;~      Case $WM_MOUSELEAVE ;TODO: trap mouse in window while left button is down.


        Case Else
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

    EndSwitch

    Return $iRet
EndFunc   ;==>WndProc

Func CtrlProc($hWnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
    Local $iRet
    Local Static $hHasFocus

    Switch $iMsg

        Case $WM_GETMINMAXINFO, $WM_SIZING, $WM_MOVING, $WM_SIZE, $WM_MOVE, $WM_EXITSIZEMOVE
            $iRet = _Ctrl_MoveSizeCtrlProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_NCHITTEST
            $iRet = _Ctrl_MoveSizeCtrlProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_SETCURSOR
            $iRet = _Ctrl_MoveSizeCtrlProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_MOUSEACTIVATE
            ;"Selected" control logic.
            If Not BitAND(0x8000, _WinAPI_GetAsyncKeyState($VK_SHIFT)) Then
                Local $aKeys = MapKeys($mh_SelCtrls)
                For $i = 0 To UBound($aKeys) - 1
                    If $aKeys[$i] Then
                        $mh_SelCtrls[$aKeys[$i]] = False
                        _WinAPI_RedrawWindow($aKeys[$i], 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
                    EndIf
                Next
                $mh_SelCtrls[$hWnd] = True
            Else
                $mh_SelCtrls[$hWnd] = MapExists($mh_SelCtrls, $hWnd) ? Not $mh_SelCtrls[$hWnd] : True
            EndIf
            ;NCL_LBUTTONDOWN doesn't retrigger if ctrl already has focus.
            If _WinAPI_GetFocus() = $hWnd Then _WinAPI_RedrawWindow($hWnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_NCLBUTTONDOWN
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            If $mh_SelCtrls[$hWnd] Then _WinAPI_SetFocus($hWnd)

        Case $WM_SETFOCUS
            $hHasFocus = $hWnd
            _SendMessage($wParam, $WM_KILLFOCUS, $hWnd)
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            _WinAPI_RedrawWindow($hWnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))

        Case $WM_KILLFOCUS
            _WinAPI_RedrawWindow($hWnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_NCLBUTTONDBLCLK
            ;Prevent double-click maximizing in "caption" - also now set caption.
            If $wParam = $HTCAPTION Then
                ;Set text
                If Not BitAND(0x8000, _WinAPI_GetAsyncKeyState($VK_SHIFT)) Then
                    Local $iCaptionLen = _SendMessage($hWnd, $WM_GETTEXTLENGTH)
                    Local $tCaption = DllStructCreate(StringFormat("wchar text[%d]", $iCaptionLen + 1))
                    _SendMessage($hWnd, $WM_GETTEXT, DllStructGetSize($tCaption), $tCaption, 0, "wparam", "struct*")
                    Local $sCaption = InputBox("Edit Caption", " ", $tCaption.Text, "", 150, 60, BitAND($lParam, 0xFFFF), BitShift($lParam, 16))
                    If Not @error Then _SendMessage($hWnd, $WM_SETTEXT, 0, $sCaption, 0, "wparam", "wstr")
                EndIf
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_NCPAINT
            _WinAPI_DefWindowProc($hWnd, $iMsg, $wParam, $lParam)
            Local $hDC = _WinAPI_GetWindowDC($hWnd)
            Local $tRect = _WinAPI_GetWindowRect($hWnd)
            $tRect.Right = $tRect.Right - $tRect.Left
            $tRect.Bottom = $tRect.Bottom - $tRect.Top
            $tRect.Left = 0
            $tRect.Top = 0
            Local $iCol = _WinAPI_GetSysColor($COLOR_3DFACE)
            If MapExists($mh_SelCtrls, $hWnd) Then
                If $mh_SelCtrls[$hWnd] Then _
                    $iCol = ($hHasFocus = $hWnd) ? _WinAPI_RGB(0, 0xAA, 0) : _WinAPI_RGB(0, 0xAA, 0xAA)
            EndIf
            Local $hBrush = _WinAPI_CreateSolidBrush($iCol)

            _WinAPI_SelectObject($hDC, $hBrush)
            _WinAPI_FrameRect($hDC, $tRect, $hBrush)
            _WinAPI_DeleteObject($hBrush)
            _WinAPI_ReleaseDC($hWnd, $hDC)
            $iRet = 0

        Case $WM_KEYDOWN
            If $wParam = $VK_DELETE Then
                _WinAPI_PostMessage($hWnd, $WM_DESTROY, 0, 0)
            Else
                $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case $WM_DESTROY
            _WinAPI_RemoveWindowSubclass($hWnd, $pCtrlProc, $iIdSubclass)
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
            Switch _WinAPI_GetClassName($hWnd)
                Case "Button"
                    _GUICtrlButton_Destroy($hWnd)
                Case "Edit"
                    _GUICtrlEdit_Destroy($hWnd)
            EndSwitch
            MapRemove($mh_SelCtrls, $hWnd)

        Case Else
;~          ConsoleWrite(Hex($iMsg) & @CRLF)
            $iRet = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

    EndSwitch

    Return $iRet
EndFunc   ;==>CtrlProc

Func _Ctrl_MoveSizeCtrlProc($hWnd, $iMsg, $wParam, $lParam)
    Local $iRetVal
    Local $tMsePoints, $tWinRect, $tMinMaxInfo, $tTgtRect
    Local $iSource, $iEvent
    Local $iFrameHitSize = 10
    Local Static $iXOffset, $iYOffset

    Switch $iMsg
        Case $WM_NCHITTEST
            $tMsePoints = _WinAPI_MakePoints($lParam)
            $tWinRect = _WinAPI_GetWindowRect($hWnd)

            $iRetVal = $HTCLIENT
            ;only in caption bar if left button is down. (no kb input availabe in caption!)
            Local $iTestKey = _WinAPI_GetSystemMetrics($SM_SWAPBUTTON) ? $VK_RBUTTON : $VK_LBUTTON
            If BitAnd(0x8000, _WinAPI_GetAsyncKeyState($iTestKey)) Then $iRetVal = $HTCAPTION

            If $tMsePoints.X - $tWinRect.Left < $iFrameHitSize Then $iRetVal = $HTLEFT
            If $tMsePoints.X > ($tWinRect.Right - $iFrameHitSize) Then $iRetVal = $HTRIGHT

            If $tMsePoints.Y - $tWinRect.Top < $iFrameHitSize Then
                Switch $iRetVal
                    Case $HTLEFT
                        $iRetVal = $HTTOPLEFT
                    Case $HTRIGHT
                        $iRetVal = $HTTOPRIGHT
                    Case Else
                        $iRetVal = $HTTOP
                EndSwitch

            ElseIf $tMsePoints.Y > ($tWinRect.Bottom - $iFrameHitSize) Then
                Switch $iRetVal
                    Case $HTLEFT
                        $iRetVal = $HTBOTTOMLEFT
                    Case $HTRIGHT
                        $iRetVal = $HTBOTTOMRIGHT
                    Case Else
                        $iRetVal = $HTBOTTOM
                EndSwitch
            EndIf

            If $tMsePoints.X < 0 Then $iRetVal = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            If $tMsePoints.Y < 0 Then $iRetVal = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            _WinAPI_RedrawWindow($hWnd)

        Case $WM_GETMINMAXINFO
            ;Min width jumps to ~150 with WS_BORDER - I guess it gets min window size: SM_CYMINTRACK
            $tMinMaxInfo = DllStructCreate($tagMINMAXINFO, $lParam)
            $tMinMaxInfo.MinTrackSize(1) = $iMinCtrlW
            $tMinMaxInfo.MinTrackSize(2) = $iMinCtrlH
            $iRetVal = 0

        Case $WM_SIZING
            $tWinRect = _WinAPI_GetWindowRect($hWnd)
            $tTgtRect = DllStructCreate($tagRect, $lParam)

            $tTgtRect.Left += Mod($tWinRect.Left - $tTgtRect.Left, $iSnap)
            $tTgtRect.Top += Mod($tWinRect.Top - $tTgtRect.Top, $iSnap)
            $tTgtRect.Right += Mod($tWinRect.Right - $tTgtRect.Right, $iSnap)
            $tTgtRect.Bottom += Mod($tWinRect.Bottom - $tTgtRect.Bottom, $iSnap)

            $iRetVal = True

        Case $WM_MOVING
            $tWinRect = _WinAPI_GetWindowRect($hWnd)
            $tTgtRect = DllStructCreate($tagRect, $lParam)

            $iXOffset += $tTgtRect.Left - $tWinRect.Left
            $iYOffset += $tTgtRect.Top - $tWinRect.Top
            Local $iSnapH = Floor($iXOffset / $iSnap) * $iSnap
            Local $iSnapV = Floor($iYOffset / $iSnap) * $iSnap
            $iXOffset -= $iSnapH
            $iYOffset -= $iSnapV

            $tTgtRect.Left = $tWinRect.Left + $iSnapH
            $tTgtRect.Right = $tWinRect.Right + $iSnapH
            $tTgtRect.Top = $tWinRect.Top + $iSnapV
            $tTgtRect.Bottom = $tWinRect.Bottom + $iSnapV

            $iRetVal = 0

        Case $WM_EXITSIZEMOVE
            $iXOffset = 0
            $iYOffset = 0
            $iRetVal = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

        Case $WM_SETCURSOR
            $iSource =  _WinAPI_WordToShort(_WinAPI_LoWord($lParam))
            $iEvent = _WinAPI_HiWord($lParam)

            If $iSource = $HTCAPTION And $iEvent = $WM_LBUTTONDOWN Then
                _WinAPI_SetCursor($hCursor_Cross)
                $iRetVal = 1
            Else
                $iRetVal = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
            EndIf

        Case Else
            $iRetVal = _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)

    EndSwitch

    Return $iRetVal
EndFunc

Func _WinAPI_MakePoints($iValue)
    Local $tPoints = DllStructCreate("struct;short X;short Y;endstruct")
    DllStructSetData($tPoints, 1, _WinAPI_LoWord($iValue))
    DllStructSetData($tPoints, 2, _WinAPI_HiWord($iValue))
    Return $tPoints
EndFunc

Func _WinAPI_SetCursorPos($iX, $iY)
    Local $aCall = DllCall("user32.dll", "bool", "SetCursorPos", "int", $iX, "int", $iY)
    If @error Then Return SetError(@error, @extended, 0)
    Return $aCall[0]
EndFunc

Func _WinAPI_MapWindowPoints($hWndFrom, $hWndTo, $pPoints, $iNumPoints)
    Local $aCall = DllCall("user32.dll", "int", "MapWindowPoints", "hwnd", $hWndFrom, "hwnd", $hWndTo, "ptr", $pPoints, "uint", $iNumPoints)
    If @error Then Return SetError(@error, @extended, 0)
    Return $aCall[0]
EndFunc