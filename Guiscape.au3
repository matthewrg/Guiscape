; *** Start added by AutoIt3Wrapper ***
#include <APIGdiConstants.au3>
#include <APISysConstants.au3>
#include <ButtonConstants.au3>
#include <StructureConstants.au3>
; *** End added by AutoIt3Wrapper ***

#include-once

#Autoit3Wrapper_Testing=n
#AutoIt3Wrapper_Run_Debug_Mode=N
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
#Au3Stripper_Parameters=/mo/rsln
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d
#AutoIt3Wrapper_Run_Au3Check=Y
#AutoIt3Wrapper_Run_Tidy=N

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
;~ Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <WindowsNotifsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>
#include <Misc.au3>
#include <GuiTab.au3>

#include <WindowsSysColorConstants.au3>
#include <guiConstants.au3>
#include <winapi.au3>
#include <guiButton.au3>
#include <guiEdit.au3>
#include <WinAPIvkeysConstants.au3>
#include <BorderConstants.au3>

#include "AutoItObject\AutoItObject.au3"
#include "_WinAPI_DPI\_WinAPI_DPI.au3"
#include "Resources\Extras.au3"
#include "Model.au3"
#include "View.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Canvas\Canvas.au3"
#include "Parameters\Parameters.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Settings\Settings.au3"

Global $NC_CLICKED

#include "GUI Objects\GUI Objects.au3"

_AutoItObject_Startup()

#Region ; Guiscape

Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)

Global $Guiscape = Guiscape()

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

Global $hCtrlProc = DllCallbackRegister("CtrlProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global $pCtrlProc = DllCallbackGetPtr($hCtrlProc)
Global $hWndProc = DllCallbackRegister("WndProc", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr")
Global $pWndProc = DllCallbackGetPtr($hWndProc)

main()

Func main()
	$Guiscape.InitView()

	GUIRegisterMsg($WM_NCLBUTTONDOWN, GUIObjectsEvent)

	$NC_CLICKED = GUICtrlCreateDummy()

	Do
		$Guiscape.Handler()
	Until False
EndFunc   ;==>main

Func GUIObjectsEvent($hwnd, $msg)
	#forceref $msg

	GUICtrlSendToDummy($NC_CLICKED, $hwnd)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIObjectsEvent

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("InitView", "Guiscape_InitView")
	$this.AddMethod("Handler", "Guiscape_Handler")

	$this.AddMethod("ViewHandler", "Guiscape_View_Handler", True)
	$this.AddMethod("MenubarHandler", "Guiscape_Menubar_Handler", True)
	$this.AddMethod("ToolbarHandler", "Guiscape_Toolbar_Handler", True)
	$this.AddMethod("CanvasHandler", "Guiscape_Canvas_Handler", True)
	$this.AddMethod("ParametersHandler", "Guiscape_Parameters_Handler", True)
	$this.AddMethod("ScriptHandler", "Guiscape_Script_Handler", True)
	$this.AddMethod("ObjectExplorerHandler", "Guiscape_ObjectExplorer_Handler", True)
	$this.AddMethod("SettingsHandler", "Guiscape_Settings_Handler", True)
	$this.AddMethod("GUIObjectsHandler", "Guiscape_GUIObjectsHandler")

	$this.AddProperty("Model", $ELSCOPE_READONLY, GuiscapeModel())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, Menubar())
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY, Toolbar())
	$this.AddProperty("GUIObjects", $ELSCOPE_READONLY)
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, Parameters())
	$this.AddProperty("Script", $ELSCOPE_READONLY, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY, ObjectExplorer())
	$this.AddProperty("Settings", $ELSCOPE_READONLY, Settings())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_InitView(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar.Create($this.Model.GetSettings())

	$this.Toolbar.Create($this.Model.ResourcesDir)

	$this.Canvas.Create($this.View)

	$this.Parameters.Create($this.View)

	$this.Script.Create($this.View)

	$this.ObjectExplorer.Create($this.View)

	$this.Settings.Create($this.View)

	$this.GUIObjects = GUIObjects($this.Canvas.Hwnd)

	$this.View.Show()

	$this.Canvas.Show()

	$this.GUIObjectsHandler(CreateMessage("Create Form"))

	Return True
EndFunc   ;==>Guiscape_InitView

Func Guiscape_Handler(ByRef $this)
	Local Const $event = $this.Model.GUIEvent()

	If Not IsMap($event) Then Return False

	Switch $event.ID
		Case $GUI_EVENT_RESIZED
			Switch $event.Form
				Case $this.View.Hwnd
					$this.View.SetSizePos()
					
					$this.Canvas.Resize($event)
					
					Return True
			EndSwitch
			
			Return False

		Case $NC_CLICKED	
			Switch GUICtrlRead($NC_CLICKED)
				Case $this.View.Hwnd
					Print("Guiscape Title Bar")

					Return True
			EndSwitch


		Case $GUI_EVENT_CLOSE
			; Ask if the Designer would like to save their progress before closing the window.

			Switch $event.Form
				Case $this.View.Hwnd
					;_WinAPI_RemoveWindowSubclass($this.View.Hwnd, $pWndProc, 1000)

					_Exit($this, $event)

				Case Else
					$this.Parameters.Hide()
			EndSwitch
	EndSwitch

	If $this.ViewHandler($event) Then Return True

	If $this.MenubarHandler($event) Then Return True

	If $this.ToolbarHandler($event) Then Return True

	If $this.CanvasHandler($event) Then Return True

	If $this.ParametersHandler($event) Then Return True

	If $this.ScriptHandler($event) Then Return True

	If $this.ObjectExplorerHandler($event) Then Return True

	If $this.SettingsHandler($event) Then Return True

	If $this.GUIObjectsHandler($event) Then Return True
EndFunc   ;==>Guiscape_Handler

Func Guiscape_View_Handler(ByRef $this, Const ByRef $event)
	Switch $this.View.Handler($event)
		Case "Canvas Tab"
			$this.Canvas.Show()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()

			Return True

		Case "Parameters Tab"
			$this.Canvas.Hide()
			$this.Parameters.Show()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()

			Return True

		Case "Script Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Show()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()

			Return True

		Case "Object Explorer Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Show()
			$this.Settings.Hide()

			Return True

		Case "Settings Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Show()

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_View_Handler

Func Guiscape_Menubar_Handler(ByRef $this, Const ByRef $event)
	; To-Do: Handle all menu bar items
	Local Const $menubar = $this.Menubar.Handler(CreateMessage($event.ID))

	If IsMap($menubar) Then
		Switch $menubar.Message
			Case "Save"
				Return True

			Case "Load"
				Return True

			Case "Exit"
				_Exit($this, $event)

			Case "Canvas"
;~ 				$this.ShowCanvasTab()

				Return True

			Case "Parameters"
;~ 				$this.ShowParametersTab()

				Return True

			Case "Script"
;~ 				$this.ShowScriptTab()

				Return True

			Case "Object Explorer"
;~ 				$this.ShowObjectExplorerTab()

				Return True

			Case "Settings"
;~ 				$this.ShowSettingsTab()

				Return True

			Case "ShowGrid", "SnapToGrid", "PasteAtMousePosition", "ShowControlWhenMoving", "ShowHiddenControls"
				$this.Model.WriteSetting($menubar.Message, $menubar.Setting)

				Return True
		EndSwitch
	Else
		Return False
	EndIf
EndFunc   ;==>Guiscape_Menubar_Handler

Func Guiscape_Toolbar_Handler(ByRef $this, ByRef $event)
	; Allows the Designer to select from a form or a control to create. If the Designer chooses "Form" then the Canvas is
	; sent into "Create" mode at which point it will wait for the Designer to click on the canvas. At that point a form
	; will be created. Otherwise, if the Designer wishes to place a control on a form then a control is selected in the
	; toolbar and then the form is sent into Create mode and will wait for the designer to click on it.

	Switch $this.Toolbar.Handler($event)
		Case "Form"
			$this.GUIObjectsHandler(CreateMessage("Create Form"))

			Return True

		Case "Group"
			Return True

		Case "Button"
			$clickedTool = "Button"
			Return True

		Case "Checkbox"
			Return True

		Case "Radio"
			Return True

		Case "Edit"
			Return True

		Case "Input"
			Return True

		Case "Label"
			Return True

		Case "UpDown"
			Return True

		Case "List"
			Return True

		Case "Combo"
			Return True

		Case "Date"
			Return True

		Case "Treeview"
			Return True

		Case "Progress"
			Return True

		Case "Avi"
			Return True

		Case "Icon"
			Return True

		Case "Pic"
			Return True

		Case "Slider"
			Return True

		Case "Tab"
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Toolbar_Handler

Func Guiscape_Canvas_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Canvas.Handler($event)
		Case "Erase Canvas"
			; Ask if the Designer would like to save their progress before erasing the canvas.

			Return True

		Case "Create Form"
			$this.GUIObjectsHandler(CreateMessage("Create Form"))

			Return True

		Case "Canvas Clicked"
			$this.ParametersHandler(CreateMessage("Form Deselected"))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Canvas_Handler

Func Guiscape_Parameters_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Parameters.Handler($event)
		Case True
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Parameters_Handler

Func Guiscape_Script_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Script.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Script_Handler

Func Guiscape_ObjectExplorer_Handler(ByRef $this, Const ByRef $event)
	Switch $this.ObjectExplorer.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_ObjectExplorer_Handler

Func Guiscape_Settings_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Settings.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Settings_Handler

Func Guiscape_GUIObjectsHandler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Create Form"
			Local $form = $this.GUIObjects.Create()

			_WinAPI_SetWindowSubclass($form.GetHwnd(), $pWndProc, 1000)

			$this.ParametersHandler(CreateMessage("Initialize Form", $form))

			Return True
	EndSwitch

	Switch $this.GUIObjects.Handler($event)
		Case "Form Selected", $NC_CLICKED
			Print("Form Title Bar")
			
			$form = $this.GUIObjects.GetForm($event.Form)

			_WinAPI_SetWindowSubclass($event.Form, $pWndProc, 1000)

			$this.ParametersHandler(CreateMessage("Initialize Form", $form))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_GUIObjectsHandler

Func CreateMessage(Const ByRef $message, $form = Null)
	Local $event[]

	$event.ID = $message

	$event.Form = $form

	Return $event
EndFunc   ;==>CreateMessage

#EndRegion ; Guiscape

#Region - MattyD

Func WndProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
	#forceref $iIdSubclass, $dwRefData

	Local $iRet, $tPoint

	Local Static $bDrawRect, $tPaintRect = DllStructCreate($tagRect)

	Switch $iMsg
		Case $WM_SETCURSOR
			Local $iSrc = _WinAPI_LoWord($lParam) ;, $iEvent =  _WinAPI_HiWord($lParam)

			If $iSrc = $HTCLIENT Then
				_WinAPI_SetCursor($hCursor_Cross)

				$iRet = 1
			Else
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case $WM_LBUTTONDOWN
			$tPoint = _WinAPI_MakePoints($lParam)

			$tPaintRect.Left = $tPoint.X
			$tPaintRect.Top = $tPoint.Y

			$tPaintRect.Left -= Mod($tPaintRect.Left, $iSnap)
			$tPaintRect.Top -= Mod($tPaintRect.Top, $iSnap)

			$bDrawRect = True

			_WinAPI_TrackMouseEvent($hwnd, $TME_LEAVE)

			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_MOUSEMOVE
			$tPoint = _WinAPI_MakePoints($lParam)

			If BitAND($wParam, $MK_LBUTTON) = $MK_LBUTTON Then
				_WinAPI_InvalidateRect($hwnd, $tPaintRect, True)
				$tPaintRect.Right = $tPoint.X
				$tPaintRect.Bottom = $tPoint.Y
				$tPaintRect.Right -= Mod($tPaintRect.Right, $iSnap)
				$tPaintRect.Bottom -= Mod($tPaintRect.Bottom, $iSnap)

				_WinAPI_InvalidateRect($hwnd, $tPaintRect, True)
				$iRet = 0
			Else
				If $bDrawRect Then _WinAPI_InvalidateRect($hwnd, $tPaintRect, True)
				$bDrawRect = False
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case $WM_PAINT
			If $bDrawRect Then
				Local $tPaintStruct = $tagPAINTSTRUCT
				Local $hDC = _WinAPI_BeginPaint($hwnd, $tPaintStruct)
				Local $hPen = _WinAPI_CreatePen($PS_DOT, 1, _WinAPI_RGB(0, 0, 0))
				Local $hBrush = _WinAPI_GetStockObject($WHITE_BRUSH)
				_WinAPI_SelectObject($hDC, $hPen)
				_WinAPI_SelectObject($hDC, $hBrush)
				_WinAPI_Rectangle($hDC, $tPaintRect)
				_WinAPI_DeleteObject($hPen)
				_WinAPI_DeleteObject($hBrush)
				_WinAPI_EndPaint($hwnd, $tPaintStruct)
				$iRet = 0
			Else
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case $WM_LBUTTONUP
			$tPoint = _WinAPI_MakePoints($lParam)

			If $bDrawRect Then
				$bDrawRect = False

				$tPaintRect.Right = $tPoint.X
				$tPaintRect.Bottom = $tPoint.Y
				$tPaintRect.Right -= Mod($tPaintRect.Right, $iSnap)
				$tPaintRect.Bottom -= Mod($tPaintRect.Bottom, $iSnap)

				_WinAPI_InvalidateRect($hwnd, $tPaintRect, True)

;~ 				If Abs($tPaintRect.Left - $tPaintRect.Right) >= $iMinCtrlW And Abs($tPaintRect.Top - $tPaintRect.Bottom) >= $iMinCtrlH Then
					;Yes, this can be done better - too lazy right now!
					Select
						Case $clickedTool = "Button"
							Print("Button")
							;Need border & clipsiblings to paint custom frame. using UDF for button to avoid any surprises in autoit's default btn proc
							Local $hCtrl = _GUICtrlButton_Create($hwnd, "", _
									($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
									($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
									Abs($tPaintRect.Left - $tPaintRect.Right), _
									Abs($tPaintRect.Top - $tPaintRect.Bottom), _
									BitOR($BS_PUSHLIKE, $WS_BORDER, $WS_CLIPSIBLINGS))

							_WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))
							
							$Guiscape.GUIObjectsHandler("Create Form")

;~ 						Case $clickedTool = "Checkbox"
;~ 							Local $hCtrl = _GUICtrlButton_Create($hwnd, "Checkbox", _
;~ 									($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
;~ 									($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
;~ 									Abs($tPaintRect.Left - $tPaintRect.Right), _
;~ 									Abs($tPaintRect.Top - $tPaintRect.Bottom), _
;~ 									BitOR($BS_AUTOCHECKBOX, $WS_BORDER, $WS_CLIPSIBLINGS))

;~ 							_WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

;~                             Case $clickedTool = "Radio"
;~                                 Local $hCtrl = _GUICtrlButton_Create($hWnd, "Radio", _
;~                                         ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
;~                                         ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
;~                                         Abs($tPaintRect.Left - $tPaintRect.Right), _
;~                                         Abs($tPaintRect.Top - $tPaintRect.Bottom), _
;~                                         BitOR($BS_AUTORADIOBUTTON, $WS_BORDER, $WS_CLIPSIBLINGS))

;~                                 _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

;~                             Case GUICtrlRead($idEdit) = $GUI_CHECKED
;~                                 Local $hCtrl = _GUICtrlEdit_Create($hWnd, "", _
;~                                         ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
;~                                         ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
;~                                         Abs($tPaintRect.Left - $tPaintRect.Right), _
;~                                         Abs($tPaintRect.Top - $tPaintRect.Bottom), _
;~                                         BitOR($ES_WANTRETURN, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS))

;~                                 _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))

;~                             Case GUICtrlRead($idInput) = $GUI_CHECKED
;~                                 Local $hCtrl = _GUICtrlEdit_Create($hWnd, "", _
;~                                         ($tPaintRect.Left < $tPaintRect.Right) ? $tPaintRect.Left : $tPaintRect.Right, _
;~                                         ($tPaintRect.Top < $tPaintRect.Bottom) ? $tPaintRect.Top : $tPaintRect.Bottom, _
;~                                         Abs($tPaintRect.Left - $tPaintRect.Right), _
;~                                         Abs($tPaintRect.Top - $tPaintRect.Bottom), _
;~                                         BitOR($ES_LEFT, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS))

;~                                 _WinAPI_SetWindowSubclass($hCtrl, $pCtrlProc, _WinAPI_GetDlgCtrlID($hCtrl))
					EndSelect
;~ 				EndIf
			EndIf

			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_SIZE
			;This prevents autoit's docking logic from moving controls around on window restore.
			;if we ony use the udf functions to create ctrls this is not needed.
            $iRet = _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)

		Case $WM_MOUSELEAVE ;TODO: trap mouse in window while left button is down.

		Case Else
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
	EndSwitch

	Return $iRet
EndFunc   ;==>WndProc

Func CtrlProc($hwnd, $iMsg, $wParam, $lParam, $iIdSubclass, $dwRefData)
	#forceref $dwRefData

	Local $iRet
	Local Static $hHasFocus

	Switch $iMsg
		Case $WM_GETMINMAXINFO, $WM_SIZING, $WM_MOVING, $WM_SIZE, $WM_MOVE, $WM_EXITSIZEMOVE
			$iRet = _Ctrl_MoveSizeCtrlProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_NCHITTEST
			$iRet = _Ctrl_MoveSizeCtrlProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_SETCURSOR
			$iRet = _Ctrl_MoveSizeCtrlProc($hwnd, $iMsg, $wParam, $lParam)

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
				$mh_SelCtrls[$hwnd] = True
			Else
				$mh_SelCtrls[$hwnd] = MapExists($mh_SelCtrls, $hwnd) ? Not $mh_SelCtrls[$hwnd] : True
			EndIf
			;NCL_LBUTTONDOWN doesn't retrigger if ctrl already has focus.
			If _WinAPI_GetFocus() = $hwnd Then _WinAPI_RedrawWindow($hwnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_NCLBUTTONDOWN
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			If $mh_SelCtrls[$hwnd] Then _WinAPI_SetFocus($hwnd)

		Case $WM_SETFOCUS
			$hHasFocus = $hwnd
			_SendMessage($wParam, $WM_KILLFOCUS, $hwnd)
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			_WinAPI_RedrawWindow($hwnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))

		Case $WM_KILLFOCUS
			_WinAPI_RedrawWindow($hwnd, 0, 0, BitOR($RDW_FRAME, $RDW_INVALIDATE))
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_NCLBUTTONDBLCLK
;~             ;Prevent double-click maximizing in "caption" - also now set caption.
			If $wParam = $HTCAPTION Then
				;Set text
				If Not BitAND(0x8000, _WinAPI_GetAsyncKeyState($VK_SHIFT)) Then
					Local $iCaptionLen = _SendMessage($hwnd, $WM_GETTEXTLENGTH)
					Local $tCaption = DllStructCreate(StringFormat("wchar text[%d]", $iCaptionLen + 1))
					_SendMessage($hwnd, $WM_GETTEXT, DllStructGetSize($tCaption), $tCaption, 0, "wparam", "struct*")
					Local $sCaption = InputBox("Edit Caption", " ", $tCaption.Text, "", 150, 60, BitAND($lParam, 0xFFFF), BitShift($lParam, 16))
					If Not @error Then _SendMessage($hwnd, $WM_SETTEXT, 0, $sCaption, 0, "wparam", "wstr")
				EndIf
			Else
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case $WM_NCPAINT
			_WinAPI_DefWindowProc($hwnd, $iMsg, $wParam, $lParam)
			Local $hDC = _WinAPI_GetWindowDC($hwnd)
			Local $tRect = _WinAPI_GetWindowRect($hwnd)
			$tRect.Right = $tRect.Right - $tRect.Left
			$tRect.Bottom = $tRect.Bottom - $tRect.Top
			$tRect.Left = 0
			$tRect.Top = 0
			Local $iCol = _WinAPI_GetSysColor($COLOR_3DFACE)
			If MapExists($mh_SelCtrls, $hwnd) Then
				If $mh_SelCtrls[$hwnd] Then _
						$iCol = ($hHasFocus = $hwnd) ? _WinAPI_RGB(0, 0xAA, 0) : _WinAPI_RGB(0, 0xAA, 0xAA)
			EndIf
			Local $hBrush = _WinAPI_CreateSolidBrush($iCol)

			_WinAPI_SelectObject($hDC, $hBrush)
			_WinAPI_FrameRect($hDC, $tRect, $hBrush)
			_WinAPI_DeleteObject($hBrush)
			_WinAPI_ReleaseDC($hwnd, $hDC)
			$iRet = 0

		Case $WM_KEYDOWN
			If $wParam = $VK_DELETE Then
				_WinAPI_PostMessage($hwnd, $WM_DESTROY, 0, 0)
			Else
				$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case $WM_DESTROY
			_WinAPI_RemoveWindowSubclass($hwnd, $pCtrlProc, $iIdSubclass)
			$iRet = _WinAPI_DefWindowProcW($hwnd, $iMsg, $wParam, $lParam)
			Switch _WinAPI_GetClassName($hwnd)
				Case "Button"
					_GUICtrlButton_Destroy($hwnd)
				Case "Edit"
					_GUICtrlEdit_Destroy($hwnd)
			EndSwitch
			MapRemove($mh_SelCtrls, $hwnd)

		Case Else
;~          ConsoleWrite(Hex($iMsg) & @CRLF)
			$iRet = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

	EndSwitch

	Return $iRet
EndFunc   ;==>CtrlProc

Func _Ctrl_MoveSizeCtrlProc($hwnd, $iMsg, $wParam, $lParam)
	Local $iRetVal
	Local $tMsePoints, $tWinRect, $tMinMaxInfo, $tTgtRect
	Local $iSource, $iEvent
	Local $iFrameHitSize = 10
	Local Static $iXOffset, $iYOffset

	Switch $iMsg
		Case $WM_NCHITTEST
			$tMsePoints = _WinAPI_MakePoints($lParam)
			
			$tWinRect = _WinAPI_GetWindowRect($hwnd)

			$iRetVal = $HTCLIENT
			
			;only in caption bar if left button is down. (no kb input availabe in caption!)
			Local $iTestKey = _WinAPI_GetSystemMetrics($SM_SWAPBUTTON) ? $VK_RBUTTON : $VK_LBUTTON
			
			If BitAND(0x8000, _WinAPI_GetAsyncKeyState($iTestKey)) Then $iRetVal = $HTCAPTION

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

			If $tMsePoints.X < 0 Then $iRetVal = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			
			If $tMsePoints.Y < 0 Then $iRetVal = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			
			_WinAPI_RedrawWindow($hwnd)

		Case $WM_GETMINMAXINFO
			;Min width jumps to ~150 with WS_BORDER - I guess it gets min window size: SM_CYMINTRACK
			$tMinMaxInfo = DllStructCreate($tagMINMAXINFO, $lParam)
			$tMinMaxInfo.MinTrackSize(1) = $iMinCtrlW
			$tMinMaxInfo.MinTrackSize(2) = $iMinCtrlH
			$iRetVal = 0

		Case $WM_SIZING
			$tWinRect = _WinAPI_GetWindowRect($hwnd)
			$tTgtRect = DllStructCreate($tagRect, $lParam)

			$tTgtRect.Left += Mod($tWinRect.Left - $tTgtRect.Left, $iSnap)
			$tTgtRect.Top += Mod($tWinRect.Top - $tTgtRect.Top, $iSnap)
			$tTgtRect.Right += Mod($tWinRect.Right - $tTgtRect.Right, $iSnap)
			$tTgtRect.Bottom += Mod($tWinRect.Bottom - $tTgtRect.Bottom, $iSnap)

			$iRetVal = True

		Case $WM_MOVING
			$tWinRect = _WinAPI_GetWindowRect($hwnd)
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
			$iRetVal = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

		Case $WM_SETCURSOR
			$iSource = _WinAPI_WordToShort(_WinAPI_LoWord($lParam))
			
			$iEvent = _WinAPI_HiWord($lParam)

			If $iSource = $HTCAPTION And $iEvent = $WM_LBUTTONDOWN Then
				_WinAPI_SetCursor($hCursor_Cross)
				
				$iRetVal = 1
			Else
				$iRetVal = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)
			EndIf

		Case Else
			$iRetVal = _WinAPI_DefSubclassProc($hwnd, $iMsg, $wParam, $lParam)

	EndSwitch

	Return $iRetVal
EndFunc   ;==>_Ctrl_MoveSizeCtrlProc

Func _WinAPI_MakePoints($iValue)
	Local $tPoints = DllStructCreate("struct;short X;short Y;endstruct")
	
	DllStructSetData($tPoints, 1, _WinAPI_LoWord($iValue))
	
	DllStructSetData($tPoints, 2, _WinAPI_HiWord($iValue))
	
	Return $tPoints
EndFunc   ;==>_WinAPI_MakePoints

Func _WinAPI_SetCursorPos($iX, $iY)
	Local $aCall = DllCall("user32.dll", "bool", "SetCursorPos", "int", $iX, "int", $iY)

	If @error Then Return SetError(@error, @extended, 0)

	Return $aCall[0]
EndFunc   ;==>_WinAPI_SetCursorPos

Func _WinAPI_MapWindowPoints($hWndFrom, $hWndTo, $pPoints, $iNumPoints)
	Local $aCall = DllCall("user32.dll", "int", "MapWindowPoints", "hwnd", $hWndFrom, "hwnd", $hWndTo, "ptr", $pPoints, "uint", $iNumPoints)
	
	If @error Then Return SetError(@error, @extended, 0)
	
	Return $aCall[0]
EndFunc   ;==>_WinAPI_MapWindowPoints

#EndRegion - MattyD

Func _ErrFunc()
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & @CRLF)
EndFunc   ;==>_ErrFunc
