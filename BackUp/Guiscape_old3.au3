
#include-once

;~ #Autoit3Wrapper_Testing=Y
;~ #AutoIt3Wrapper_Run_Debug_Mode=Y
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
;~ #Au3Stripper_Parameters=/mo
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! --- (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
;~ Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <APIGdiConstants.au3>
#include <APISysConstants.au3>
#include <ButtonConstants.au3>
#include <StructureConstants.au3>
#include <WindowsNotifsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>
#include <Misc.au3>
#include <GUITab.au3>
#include <WindowsSysColorConstants.au3>
#include <GUIConstants.au3>
#include <WinAPI.au3>
#include <GUIButton.au3>
#include <GUIEdit.au3>
#include <WinAPIvkeysConstants.au3>
#include <BorderConstants.au3>

#include "AutoItObject\AutoItObject.au3"
#include "Message Queue\Message Queue.au3"
#include "_WinAPI_DPI\_WinAPI_DPI.au3"
#include "Declarations.au3"
#include "Main Form\Main Form.au3"
#include "Main Tab\Main Tab.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Canvas\Canvas.au3"
#include "Parameters\Parameters.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Settings\Settings.au3"
#include "File Manager\File Manager.au3"
#include "GUI Objects\WndCtrlProc.au3"
#include "GUI Objects\GUI Objects.au3"

#Region ; Guiscape

main()

Func main()
	_AutoItObject_Startup()

	$messageQueue = MessageQueue()

	Local $Guiscape = Guiscape()

	$Guiscape.Begin()
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Begin", "Guiscape_Begin")
	
	_AutoItObject_AddMethod($this, "Subscribe", "Guiscape_Subscribe", True)
	_AutoItObject_AddMethod($this, "GUIEvent", "Guiscape_GUIEvent", True)
	
	Return $this
EndFunc   ;==>Guiscape

Func Guiscape_Begin(ByRef $this)
	$this.Subscribe(MainForm())
	$this.Subscribe(Menubar())
	$this.Subscribe(Toolbar())
	$this.Subscribe(Maintab())
	$this.Subscribe(Canvas())
	$this.Subscribe(Parameters())
;~ 	$this.Subscribe($script)
;~ 	$this.Subscribe($objectExplorer)
;~ 	$this.Subscribe($settings)
;~ 	$this.Subscribe($guiObjects)

	GUIRegisterMsg($WM_NCLBUTTONDOWN, NCClicked_Event)

	$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Init View"))

	$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Canvas Show"))

	Local $event

	Do
		$event = $this.GUIEvent()

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

			Case Else
				$messageQueue.Push($event)
		EndSwitch
	Until False
EndFunc   ;==>Guiscape_Begin

Func Guiscape_Subscribe(ByRef $this, Const ByRef $subscriber)
	$messageQueue.Subscribe($subscriber)

	Return True
EndFunc   ;==>Guiscape_Subscribe

Func Guiscape_GUIEvent(ByRef $this)
	#forceref $this
	
	Local Const $eventArray = GUIGetMsg($GUI_EVENT_ARRAY)

	Local $event[]

	$event.Sender = "System"
	$event.ID = $eventArray[0]
	$event.Form = HWnd($eventArray[1])
	$event.Control = HWnd($eventArray[2])
	$event.X = $eventArray[3]
	$event.Y = $eventArray[4]

	Return $event
EndFunc   ;==>Guiscape_GUIEvent

#EndRegion ; Guiscape
