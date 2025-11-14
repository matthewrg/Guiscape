#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global Enum $GUI_ACTION_LCLIENT, $GUI_ACTION_RCLIENT, $GUI_ACTION_LTITLE ; An enumeration of possible actions.
Global $g_iActionCommand ; Create a single global variable to store a dummy control.
_SetDummyControl(-9999)

Example()

Func Example()
    ; When using WM_MESSAGES users tend to either create a ton of dummy controls and/or global variables that change a state from true to false.
    ; This example demonstrates that everything can be contained in the main function, so it's then easy to keep control of data being passed around.
    ; There is no need for tons of global variables and functions.
    ; It's also a good way of not staying too long in the WM_MESSAGE, which can turn into a huge mess.
    Local $hGUI = GUICreate('GUIEvents', 500, 500)

    GUIRegisterMsg($WM_LBUTTONDOWN, 'WM_LBUTTONDOWN')
    GUIRegisterMsg($WM_NCLBUTTONDOWN, 'WM_NCLBUTTONDOWN')
    GUIRegisterMsg($WM_RBUTTONDOWN, 'WM_RBUTTONDOWN')

    $g_iActionCommand = GUICtrlCreateDummy() ; Assign the global dummy control variable with a dummy control id.

    GUISetState(@SW_SHOW, $hGUI) ; Display the AutoIt GUI.

    While 1
        Switch GUIGetMsg() ; Monitor the gui messages/ids.
            Case $GUI_EVENT_CLOSE
                ExitLoop

            Case _GetDummyControl() ; When a message is sent to the dummy control we have to find out what message was actually sent.
                $iActionCommand = GUICtrlRead(_GetDummyControl()) ; Read the message assigned to the control's "state" parameter e.g. 1001.
                ; As MakeLong() was used in the event function, find the LoWord of the message that was sent. HiWord could be used for an array index or listview item.
                $iAction = _WinAPI_LoWord($iActionCommand)
                Switch $iAction
                    Case $GUI_ACTION_LCLIENT
                        ConsoleWrite('The left button was clicked in the client.' & @CRLF)
                    Case $GUI_ACTION_RCLIENT
                        ConsoleWrite('The right button was clicked in the client.' & @CRLF)
                    Case $GUI_ACTION_LTITLE
                        ConsoleWrite('The left button was clicked in the titlebar.' & @CRLF)

                EndSwitch
        EndSwitch
    WEnd
    GUIDelete($hGUI)
EndFunc   ;==>Example

Func _GetDummyControl() ; Getter for the dummy control.
    Return $g_iActionCommand
EndFunc   ;==>_GetDummyControl

Func _SetDummyControl($iDummy) ; Setter for the dummy control.
    $g_iActionCommand = $iDummy
EndFunc   ;==>_SetDummyControl

Func WM_LBUTTONDOWN($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam, $lParam
    GUICtrlSendToDummy($g_iActionCommand, _WinAPI_MakeLong($GUI_ACTION_LCLIENT, 0)) ; $GUI_ACTION_LCLIENT can be swapped for an integer value, but I use an enum value for ease.
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_LBUTTONDOWN

Func WM_NCLBUTTONDOWN($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam, $lParam
    GUICtrlSendToDummy($g_iActionCommand, _WinAPI_MakeLong($GUI_ACTION_LTITLE, 0))
    ; You don't even need to use MakeLong(). You can just use GUICtrlSendToDummy($g_iActionCommand, $GUI_ACTION_LTITLE), but then the MakeLong() offers the choice to pass
    ; another integer value such as listview item/subitem in a message such as WM_NOTIFY.
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NCLBUTTONDOWN

Func WM_RBUTTONDOWN($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam, $lParam
    GUICtrlSendToDummy($g_iActionCommand, _WinAPI_MakeLong($GUI_ACTION_RCLIENT, 0))
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_RBUTTONDOWN