
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

Global $Guiscape = Guiscape()

$Guiscape.Begin()
EndFunc

Func Guiscape()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddProperty($this, "Subscribers", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "Count", $ELSCOPE_PRIVATE, 0)
	_AutoItObject_AddProperty($this, "", $ELSCOPE_PRIVATE, Null)

	_AutoItObject_AddMethod($this, "Begin", "Guiscape_Begin" True)
	_AutoItObject_AddMethod($this, "Announce", "Guiscape_Announce" True)
	_AutoItObject_AddMethod($this, "Subscribe", "Guiscape_Subscribe" True)
	_AutoItObject_AddMethod($this, "CreateEvent", "Guiscape_CreateEvent" True)
	_AutoItObject_AddMethod($this, "GUIEvent", "Guiscape_GUIEvent" True)
	_AutoItObject_AddMethod($this, "", "Guiscape_" True)
	
	Return $this
EndFunc   ;==>

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
EndFunc

Func Guiscape_Annoounce(ByRef $this, Const ByRef $event)
	Local Const $subscribers = $this.Subscribers

	Local Const $count = $this.Count

	Local $subscriber, $peek

	For $i = 1 To $count
		$peek = $this.Peek()

		If IsMap($peek) Then			
			$subscriber = $subscribers[$i]

			$subscriber.Handler($event)
		EndIf
	Next
EndFunc

Func Guiscape_Subscribe(ByRef $this, Const ByRef $subscriber)
	Local $subscribers = $this.Subscribers

	_ArrayAdd($subscribers, $subscriber)

	$this.Subscribers = $subscribers

	$this.Count = $this.Count + 1

	Return True
EndFunc

Func Guiscape_CreateEvent(Const ByRef $this, Const $sender, Const $id, Const $key1 = Null, Const $data1 = Null, Const $key2 = Null, Const $data2 = Null, Const $key3 = Null, Const $data3 = Null, Const $key4 = Null, Const $data4 = Null, Const $key5 = Null, Const $data5 = Null)
	#forceref $this

	Local $messageMap[]

	$messageMap.Sender = $sender

	$messageMap.ID = $id

	If $key1 Then
		$messageMap[$key1] = $data1
	EndIf

	If $key2 Then
		$messageMap[$key2] = $data2
	EndIf

	If $key3 Then
		$messageMap[$key3] = $data3
	EndIf

	If $key4 Then
		$messageMap[$key4] = $data4
	EndIf

	If $key5 Then
		$messageMap[$key5] = $data5
	EndIf

	Return $messageMap
EndFunc   ;==>MessageQueue_CreateEvent

Func Guiscape_GUIEvent()
	Local Const $eventArray = GUIGetMsg($GUI_EVENT_ARRAY)

	Local $event[]
	
	$event.Sender = "System"
	$event.ID = $eventArray[0]
	$event.Form = HWnd($eventArray[1])
	$event.Control = HWnd($eventArray[2])
	$event.X = $eventArray[3]
	$event.Y = $eventArray[4]

	Return $event
EndFunc   ;==>GUIEvent

#EndRegion ; Guiscape
