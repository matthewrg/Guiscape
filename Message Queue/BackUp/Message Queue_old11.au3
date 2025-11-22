#include-once

#include <Array.au3>

#include "Queue.au3"

#region - Message Queue

Func MessageQueue()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Push", "MessageQueue_Push")
	_AutoItObject_AddMethod($this, "CreateEvent", "MessageQueue_CreateEvent")
	_AutoItObject_AddMethod($this, "Subscribe", "MessageQueue_Subscribe")
	_AutoItObject_AddMethod($this, "Print", "MessageQueue_Print")
	_AutoItObject_AddMethod($this, "DeQueue", "MessageQueue_DeQueue")
	_AutoItObject_AddMethod($this, "Peek", "MessageQueue_Peek")
	
	_AutoItObject_AddMethod($this, "Announce", "MessageQueue_Announce", True)
	
	Local $subscribers[] = []
	
	_AutoItObject_AddProperty($this, "Queue", $ELSCOPE_PRIVATE, Queue())
	_AutoItObject_AddProperty($this, "Subscribers", $ELSCOPE_PRIVATE, $subscribers)
	_AutoItObject_AddProperty($this, "Count", $ELSCOPE_PRIVATE, 0)
	
	Return $this
EndFunc   ;==>MessageQueue

Func MessageQueue_Push(ByRef $this, Const ByRef $event)
	$this.Queue.EnQueue($event)
	
	$this.Announce($this.Peek())
	
	Return True
EndFunc   ;==>MessageQueue_Push

Func MessageQueue_CreateEvent(Const ByRef $this, Const $sender, Const $id, Const $key1 = Null, Const $data1 = Null, Const $key2 = Null, Const $data2 = Null, Const $key3 = Null, Const $data3 = Null, Const $key4 = Null, Const $data4 = Null, Const $key5 = Null, Const $data5 = Null)
	#forceref $this

	Local $eventMap[]

	$eventMap.Sender = $sender

	$eventMap.ID = $id

	If $key1 Then
		$eventMap[$key1] = $data1
	EndIf

	If $key2 Then
		$eventMap[$key2] = $data2
	EndIf

	If $key3 Then
		$eventMap[$key3] = $data3
	EndIf

	If $key4 Then
		$eventMap[$key4] = $data4
	EndIf

	If $key5 Then
		$eventMap[$key5] = $data5
	EndIf

	Return $eventMap
EndFunc   ;==>MessageQueue_CreateEvent

Func MessageQueue_Subscribe(ByRef $this, Const ByRef $subscriber)
	Local $subscribers = $this.Subscribers

	_ArrayAdd($subscribers, $subscriber)

	$this.Subscribers = $subscribers
	
	$this.Count = $this.Count + 1

	Return True
EndFunc

Func MessageQueue_Announce(Const ByRef $this, Const ByRef $event)
	Local Const $subscribers = $this.Subscribers

	Local Const $count = $this.Count

	Local $subscriber

	For $i = 1 To $count
		If IsMap($this.Peek()) Then
			$subscriber = $subscribers[$i]

			$subscriber.Handler($event)
		EndIf
	Next

	Return True
EndFunc   ;==>Guiscape_Announce

Func MessageQueue_Print(Const ByRef $this)
	Local Const $event = $this.Peek()

	ConsoleWrite($event.Sender & @TAB & $event.Message & @CRLF)

	Return True
EndFunc   ;==>MessageQueue_Print

Func MessageQueue_DeQueue(ByRef $this)
	Return $this.Queue.DeQueue()
EndFunc   ;==>MessageQueue_DeQueue

Func MessageQueue_Peek(Const ByRef $this)
	Return $this.Queue.Peek()
EndFunc   ;==>MessageQueue_Peek

#endregion - Message Queue
